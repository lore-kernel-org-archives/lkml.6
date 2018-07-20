Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757CECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8720833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeGTBWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:22:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:58272 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbeGTBWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:22:52 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9DA44C009; Fri, 20 Jul 2018 02:37:10 +0200 (CEST)
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
Subject: [PATCH v3] coccinelle: suggest replacing strncpy+truncation by strscpy
Date:   Fri, 20 Jul 2018 02:36:58 +0200
Message-Id: <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using strscpy instead of strncpy+truncation is simpler and fixes part
of the following class of new gcc warnings:

    drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
    drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals
    destination size [-Werror=stringop-truncation]
       strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Note that this is not a proper fix for this warning. The warning was
intended to have developers check the return code of strncpy and
act in case of truncation (print a warning, abort the function or
something similar if the original string was not nul terminated);
the change to strscpy only works because gcc does not handle the
function the same way.

A previous version of this patch suggested to use strlcpy instead,
but strscpy is preferred because it does not read more than the given
length of the source string unlike strlcpy, which could read after the
end of the buffer in case of unterminated string.

strscpy does however not clear the end of the destination buffer, so
there is a risk of information leak if the full buffer is copied as is
out of the kernel - this needs manual checking.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v2:
 - Use strscpy instead of strlcpy, as strlcpy can read after the number
of requested bytes in the source string, and none of the replaced users
want to know the source string size length 
 - Add longer semantic patch information, warning in particular for
information leak
 - Lowered Confidence level to medium because of the possibility of
information leak, that needs manual checking
 - Fix spacing of the diff section and removed unused virtual context

v3:
 - Add license/copyright
 - Rewording of commit message

I didn't see many other remarks, but kept SUGGESTION as discussed.
I didn't move all virtuals in a single line because none of the other
kernel patch do it, and still do not see any advantage of moving the
string to not use a variable so kept that as well.

This should hopefully be the last version :)

 .../coccinelle/misc/strncpy_truncation.cocci  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci

diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
new file mode 100644
index 000000000000..7732cde23a85
--- /dev/null
+++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
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
+// Copyright: (C) 2018  Dominique Martinet
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

