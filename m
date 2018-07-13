Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819702087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819702087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbeGMB1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:27:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:53546 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732813AbeGMB1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:27:04 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BA777C009; Fri, 13 Jul 2018 03:14:52 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] coccinelle: change strncpy+truncation to strlcpy
Date:   Fri, 13 Jul 2018 03:14:43 +0200
Message-Id: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides being simpler, using strlcpy instead of strncpy+truncation
fixes part of the following class of new gcc warnings:

    drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
    drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals
    destination size [-Werror=stringop-truncation]
       strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Note that this is not a proper fix for this warning (and not all of the
occurences give the warning either - the strings are not always static).
The warning was intended to have developers check the return code of
strncpy and act in case of truncation (print a warning, abort the
function or something similar if the original string was not nul
terminated); the change to strlcpy only works because gcc does not
handle the function the same way.

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Running this fixes 30 occurences of the problem in 17 different
components of the kernel, and while the produced patches are fairly
straight-forward I'm not sure who I should expect to pick this up as
it is sent as a series.
I expect each maintainer will pick their share of the patchs if they
agree with it and the rest will just be dropped?

 .../coccinelle/misc/strncpy_truncation.cocci  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci

diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
new file mode 100644
index 000000000000..28b5c2a290ac
--- /dev/null
+++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
@@ -0,0 +1,41 @@
+/// Use strlcpy rather than strncpy(dest,..,sz) + dest[sz-1] = '\0'
+///
+// Confidence: High
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
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
+cocci.print_main("strncpy followed by truncation can be strlcpy",p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "SUGGESTION: strncpy followed by truncation can be strlcpy"
+coccilib.report.print_report(p[0],msg)
+
+@ok depends on patch@
+expression r.dest, r.src, r.sz;
+position r.p;
+@@
+
+-strncpy@p(
++strlcpy(
+  dest, src, sz);
+-dest[sz - 1] = '\0';
-- 
2.17.1

