Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA06C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F3320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeIHAxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:53:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeIHAxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:53:30 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ABDh9RRsQgly; Fri,  7 Sep 2018 22:10:57 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC4300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:4300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E9341EC0322;
        Fri,  7 Sep 2018 22:10:57 +0200 (CEST)
Date:   Fri, 7 Sep 2018 22:10:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] x86/paravirt: Get rid of patch_site and patch_default
 labels
Message-ID: <20180907201050.GF12849@zn.tnic>
References: <20180907104917.12502-1-bp@alien8.de>
 <20180907105112.GD12849@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907105112.GD12849@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:51:12PM +0200, Borislav Petkov wrote:
> Whoops, no, it is still being used. Lemme see if I can remove all the
> labels in that function.

Ok, I think I've gotten rid of them all, in both 32- and 64-bit
versions. It boots here and a bunch of all*config builds pass.

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 7 Sep 2018 12:47:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_PARAVIRT_SPINLOCKS=n, it fires

  arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
  arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
   patch_site:

but those labels can simply be removed by directly calling the
respective functions there.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org
---
 arch/x86/kernel/paravirt_patch_32.c | 21 ++++++++++-----------
 arch/x86/kernel/paravirt_patch_64.c | 20 +++++++++-----------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d460cbcabcfe..af57f0d0789f 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -34,14 +34,16 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
+	const unsigned char *start __maybe_unused, *end __maybe_unused;
 	unsigned ret;
 
 #define PATCH_SITE(ops, x)					\
 		case PARAVIRT_PATCH(ops.x):			\
 			start = start_##ops##_##x;		\
 			end = end_##ops##_##x;			\
-			goto patch_site
+								\
+			return paravirt_patch_insns(ibuf, len, start, end);
+
 	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, irq_disable);
@@ -58,27 +60,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			if (pv_is_native_spin_unlock()) {
 				start = start_lock_queued_spin_unlock;
 				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
+
+				return paravirt_patch_insns(ibuf, len, start, end);
 			}
-			goto patch_default;
+			return paravirt_patch_default(type, ibuf, addr, len);
 
 		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
 				start = start_lock_vcpu_is_preempted;
 				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
+
+				return paravirt_patch_insns(ibuf, len, start, end);
 			}
-			goto patch_default;
+			return paravirt_patch_default(type, ibuf, addr, len);
 #endif
 
 	default:
-patch_default: __maybe_unused
 		ret = paravirt_patch_default(type, ibuf, addr, len);
 		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
-		break;
 	}
 #undef PATCH_SITE
 	return ret;
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 5ad5bcda9dc6..2db6c615932f 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -42,14 +42,15 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
+	const unsigned char *start __maybe_unused, *end __maybe_unused;
 	unsigned ret;
 
 #define PATCH_SITE(ops, x)					\
 		case PARAVIRT_PATCH(ops.x):			\
 			start = start_##ops##_##x;		\
 			end = end_##ops##_##x;			\
-			goto patch_site
+								\
+			return paravirt_patch_insns(ibuf, len, start, end);
 	switch(type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, restore_fl);
@@ -68,27 +69,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			if (pv_is_native_spin_unlock()) {
 				start = start_lock_queued_spin_unlock;
 				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
+
+				return paravirt_patch_insns(ibuf, len, start, end);
 			}
-			goto patch_default;
+			return paravirt_patch_default(type, ibuf, addr, len);
 
 		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
 				start = start_lock_vcpu_is_preempted;
 				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
+
+				return paravirt_patch_insns(ibuf, len, start, end);
 			}
-			goto patch_default;
+			return paravirt_patch_default(type, ibuf, addr, len);
 #endif
 
 	default:
-patch_default: __maybe_unused
 		ret = paravirt_patch_default(type, ibuf, addr, len);
 		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
-		break;
 	}
 #undef PATCH_SITE
 	return ret;
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
