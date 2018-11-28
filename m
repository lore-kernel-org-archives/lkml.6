Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D96C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B659F208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B659F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeK1UXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:23:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeK1UXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:23:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAS9LpsV2233961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 01:21:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAS9Loh02233958;
        Wed, 28 Nov 2018 01:21:50 -0800
Date:   Wed, 28 Nov 2018 01:21:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-60c8144afc287ef09ce8c1230c6aa972659ba1bb@git.kernel.org>
Cc:     aravindksg.lkml@gmail.com, tony.luck@intel.com, john@deater.net,
        hpa@zytor.com, Yazen.Ghannam@amd.com, clemej@gmail.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        tglx@linutronix.de, rafal@milecki.pl
Reply-To: clemej@gmail.com, Yazen.Ghannam@amd.com,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
          rafal@milecki.pl, tglx@linutronix.de, john@deater.net,
          tony.luck@intel.com, aravindksg.lkml@gmail.com, hpa@zytor.com
In-Reply-To: <20181127101700.2964-1-zajec5@gmail.com>
References: <20181127101700.2964-1-zajec5@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/MCE/AMD: Fix the thresholding machinery
 initialization order
Git-Commit-ID: 60c8144afc287ef09ce8c1230c6aa972659ba1bb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  60c8144afc287ef09ce8c1230c6aa972659ba1bb
Gitweb:     https://git.kernel.org/tip/60c8144afc287ef09ce8c1230c6aa972659ba1bb
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 27 Nov 2018 14:41:37 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 28 Nov 2018 10:10:36 +0100

x86/MCE/AMD: Fix the thresholding machinery initialization order

Currently, the code sets up the thresholding interrupt vector and only
then goes about initializing the thresholding banks. Which is wrong,
because an early thresholding interrupt would cause a NULL pointer
dereference when accessing those banks and prevent the machine from
booting.

Therefore, set the thresholding interrupt vector only *after* having
initialized the banks successfully.

Fixes: 18807ddb7f88 ("x86/mce/AMD: Reset Threshold Limit after logging error")
Reported-by: Rafał Miłecki <rafal@milecki.pl>
Reported-by: John Clemens <clemej@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
Tested-by: John Clemens <john@deater.net>
Cc: Aravind Gopalakrishnan <aravindksg.lkml@gmail.com>
Cc: linux-edac@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20181127101700.2964-1-zajec5@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201291
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..e12454e21b8a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -56,7 +56,7 @@
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
-static bool thresholding_en;
+static bool thresholding_irq_en;
 
 static const char * const th_names[] = {
 	"load_store",
@@ -534,9 +534,8 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 set_offset:
 	offset = setup_APIC_mce_threshold(offset, new);
-
-	if ((offset == new) && (mce_threshold_vector != amd_threshold_interrupt))
-		mce_threshold_vector = amd_threshold_interrupt;
+	if (offset == new)
+		thresholding_irq_en = true;
 
 done:
 	mce_threshold_block_init(&b, offset);
@@ -1357,9 +1356,6 @@ int mce_threshold_remove_device(unsigned int cpu)
 {
 	unsigned int bank;
 
-	if (!thresholding_en)
-		return 0;
-
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
@@ -1377,9 +1373,6 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err = 0;
 
-	if (!thresholding_en)
-		return 0;
-
 	bp = per_cpu(threshold_banks, cpu);
 	if (bp)
 		return 0;
@@ -1408,9 +1401,6 @@ static __init int threshold_init_device(void)
 {
 	unsigned lcpu = 0;
 
-	if (mce_threshold_vector == amd_threshold_interrupt)
-		thresholding_en = true;
-
 	/* to hit CPUs online before the notifier is up */
 	for_each_online_cpu(lcpu) {
 		int err = mce_threshold_create_device(lcpu);
@@ -1419,6 +1409,9 @@ static __init int threshold_init_device(void)
 			return err;
 	}
 
+	if (thresholding_irq_en)
+		mce_threshold_vector = amd_threshold_interrupt;
+
 	return 0;
 }
 /*
