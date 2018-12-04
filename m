Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6019DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25863214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzcjniMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25863214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeLDK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeLDK6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4930F214DE;
        Tue,  4 Dec 2018 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921104;
        bh=6ydHGgUWknbFDSEdyAj1VlBCto798R62PRFTkjmn/gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzcjniMCQBU+VlLois4mKc3ayUpM4vgfK8YCwCyyLa9NlJ5NuK2C7lkfrsLA2Lj0D
         cJae/+XUV0Kf6wSmVuZTlZGHmDRq7irNeZU93+e+XST0dMcZm6hkF5CMwqXiCZ2m8M
         h/T+9mQZd+VR/YL5jYowIMfZiOuHXWiPV/NeKxTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        John Clemens <clemej@gmail.com>, Borislav Petkov <bp@suse.de>,
        John Clemens <john@deater.net>,
        Aravind Gopalakrishnan <aravindksg.lkml@gmail.com>,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH 4.19 083/139] x86/MCE/AMD: Fix the thresholding machinery initialization order
Date:   Tue,  4 Dec 2018 11:49:24 +0100
Message-Id: <20181204103653.672596104@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 60c8144afc287ef09ce8c1230c6aa972659ba1bb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -56,7 +56,7 @@
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
-static bool thresholding_en;
+static bool thresholding_irq_en;
 
 static const char * const th_names[] = {
 	"load_store",
@@ -534,9 +534,8 @@ prepare_threshold_block(unsigned int ban
 
 set_offset:
 	offset = setup_APIC_mce_threshold(offset, new);
-
-	if ((offset == new) && (mce_threshold_vector != amd_threshold_interrupt))
-		mce_threshold_vector = amd_threshold_interrupt;
+	if (offset == new)
+		thresholding_irq_en = true;
 
 done:
 	mce_threshold_block_init(&b, offset);
@@ -1357,9 +1356,6 @@ int mce_threshold_remove_device(unsigned
 {
 	unsigned int bank;
 
-	if (!thresholding_en)
-		return 0;
-
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
@@ -1377,9 +1373,6 @@ int mce_threshold_create_device(unsigned
 	struct threshold_bank **bp;
 	int err = 0;
 
-	if (!thresholding_en)
-		return 0;
-
 	bp = per_cpu(threshold_banks, cpu);
 	if (bp)
 		return 0;
@@ -1408,9 +1401,6 @@ static __init int threshold_init_device(
 {
 	unsigned lcpu = 0;
 
-	if (mce_threshold_vector == amd_threshold_interrupt)
-		thresholding_en = true;
-
 	/* to hit CPUs online before the notifier is up */
 	for_each_online_cpu(lcpu) {
 		int err = mce_threshold_create_device(lcpu);
@@ -1419,6 +1409,9 @@ static __init int threshold_init_device(
 			return err;
 	}
 
+	if (thresholding_irq_en)
+		mce_threshold_vector = amd_threshold_interrupt;
+
 	return 0;
 }
 /*


