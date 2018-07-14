Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DFECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC3120873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC3120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeGNIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:30:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:34005 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbeGNIa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:30:58 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7992CC009; Sat, 14 Jul 2018 10:12:39 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: strncpy+truncation by strscpy
Date:   Sat, 14 Jul 2018 10:12:31 +0200
Message-Id: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides being simpler, using strscpy instead of strncpy+truncation
fixes part of the following class of new gcc warnings:

    drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
    drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals
    destination size [-Werror=stringop-truncation]
       strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Note that this is note a proper fix for this warning. The warning was
intended to have developers check the return code of strncpy and
act in case of truncation (print a warning, abort the function or
something similar if the original string was not nul terminated);
the change to strscpy only works because gcc does not handle the
function the same way.

v2:
 - Use strscpy instead of strlcpy, as strlcpy can read after the number
of requested bytes in the source string, and none of the replaced users
want to know the source string size length
 - Add longer semantic patch information, warning in particular for
information leak
 - Lowered Confidence level to medium because of the possibility of
information leak, that needs manual checking
 - Fix spacing of the diff section and removed unused virtual context

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Thanks for the many feedback I received; I hope I didn't miss any.
In particular, I have conciously not removed the intermediate msg
variable; as I made the message longer I actually added one more of
these for the org mode section.
I also have decided to let spatch remove the second comment, given the
confidence level has been lowered, the user should be able to manually
adjust the result if required.

I will resend the other patchs of the series a much smaller number at
a time after doing all the appropriate checks and giving them a better
comment, after this has been merged.

 .../coccinelle/misc/strncpy_truncation.cocci  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci

diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
new file mode 100644
index 000000000000..dd157fc8ec5f
--- /dev/null
+++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
@@ -0,0 +1,50 @@
+/// Use strscpy rather than strncpy(dest,..,sz) + dest[sz-1] = '\0'
+///
+//# This makes an effort to find occurences of strncpy followed by forced
+//# truncation, which can generate gcc stringop-truncation warnings when
+//# source and destination buffers are the same size.
+//# Using strscpy will always do that nul-termination for us and not read
+//# more than the maximum bytes requested in src, use that instead.
+//#
+//# The result needs checking that the destination buffer does not need
+//# its tail zeroed (either cleared beforehand or will never leave the
+//# kernel) so as not to leak information
+//
+// Confidence: Medium
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual report
+virtual org
+
+@r@
+expression dest, src, sz;
+position p;
+@@
+
+strncpy@p(dest, src, sz);
+dest[sz - 1] = '\0';
+
+@script:python depends on org@
+p << r.p;
+@@
+
+msg = "strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
+cocci.print_main(msg, p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
+coccilib.report.print_report(p[0], msg)
+
+@ok depends on patch@
+expression r.dest, r.src, r.sz;
+@@
+
+- strncpy
++ strscpy
+   (dest, src, sz);
+- dest[sz - 1] = '\0';
-- 
2.17.1

