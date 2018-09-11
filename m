Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DBC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9051E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9051E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeIKONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:13:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeIKONn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:13:43 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FJOxBibI4Vkj; Tue, 11 Sep 2018 11:15:17 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1CA661EC02D1;
        Tue, 11 Sep 2018 11:15:17 +0200 (CEST)
Date:   Tue, 11 Sep 2018 11:15:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] x86/paravirt: Cleanup native_patch()
Message-ID: <20180911091510.GA12094@zn.tnic>
References: <20180907104917.12502-1-bp@alien8.de>
 <20180907105112.GD12849@zn.tnic>
 <20180907201050.GF12849@zn.tnic>
 <65bb69fa-855f-9efc-19ba-c0fab69f468c@suse.com>
 <20180908152800.GA8286@zn.tnic>
 <229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
 <20180910070108.GA21406@zn.tnic>
 <dfe856d6-a4db-b406-ef18-dba3b6b8c342@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfe856d6-a4db-b406-ef18-dba3b6b8c342@suse.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PARAVIRT_SPINLOCKS=n, it fires

  arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
  arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
   patch_site:

but those labels can simply be removed by directly calling the
respective functions there.

Get rid of local variables too, while at it. Also, simplify function
flow for better readability.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org
---

Here it is, rebased ontop of rc3+tip/master.


 arch/x86/kernel/paravirt_patch_32.c | 44 ++++++++++-----------------
 arch/x86/kernel/paravirt_patch_64.c | 46 +++++++++++------------------
 2 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d460cbcabcfe..6368c22fa1fa 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -34,14 +34,10 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
-	unsigned ret;
-
 #define PATCH_SITE(ops, x)					\
-		case PARAVIRT_PATCH(ops.x):			\
-			start = start_##ops##_##x;		\
-			end = end_##ops##_##x;			\
-			goto patch_site
+	case PARAVIRT_PATCH(ops.x):				\
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+
 	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, irq_disable);
@@ -54,32 +50,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(mmu, write_cr3);
 #endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(lock.queued_spin_unlock):
-			if (pv_is_native_spin_unlock()) {
-				start = start_lock_queued_spin_unlock;
-				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+		if (pv_is_native_spin_unlock())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_queued_spin_unlock,
+						    end_lock_queued_spin_unlock);
+		break;
 
-		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_lock_vcpu_is_preempted;
-				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_vcpu_is_preempted,
+						    end_lock_vcpu_is_preempted);
+		break;
 #endif
 
 	default:
-patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, ibuf, addr, len);
-		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
 		break;
 	}
 #undef PATCH_SITE
-	return ret;
+	return paravirt_patch_default(type, ibuf, addr, len);
 }
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 5ad5bcda9dc6..7ca9cb726f4d 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -42,15 +42,11 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-	const unsigned char *start, *end;
-	unsigned ret;
-
 #define PATCH_SITE(ops, x)					\
-		case PARAVIRT_PATCH(ops.x):			\
-			start = start_##ops##_##x;		\
-			end = end_##ops##_##x;			\
-			goto patch_site
-	switch(type) {
+	case PARAVIRT_PATCH(ops.x):				\
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+
+	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
@@ -64,32 +60,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(mmu, write_cr3);
 #endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(lock.queued_spin_unlock):
-			if (pv_is_native_spin_unlock()) {
-				start = start_lock_queued_spin_unlock;
-				end   = end_lock_queued_spin_unlock;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+		if (pv_is_native_spin_unlock())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_queued_spin_unlock,
+						    end_lock_queued_spin_unlock);
+		break;
 
-		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_lock_vcpu_is_preempted;
-				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_vcpu_is_preempted,
+						    end_lock_vcpu_is_preempted);
+		break;
 #endif
 
 	default:
-patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, ibuf, addr, len);
-		break;
-
-patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
 		break;
 	}
 #undef PATCH_SITE
-	return ret;
+	return paravirt_patch_default(type, ibuf, addr, len);
 }
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
