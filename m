Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64011C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E1D20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E1D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeIBQbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:31:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:31:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w82CFoQP2914411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Sep 2018 05:15:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w82CFoCI2914408;
        Sun, 2 Sep 2018 05:15:50 -0700
Date:   Sun, 2 Sep 2018 05:15:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Prarit Bhargava <tipbot@zytor.com>
Message-ID: <tip-370a132bb2227ff76278f98370e0e701d86ff752@git.kernel.org>
Cc:     tglx@linutronix.de, bp@suse.de, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, prarit@redhat.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, prarit@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tony.luck@intel.com,
          bp@suse.de
In-Reply-To: <20180731112739.32338-1-prarit@redhat.com>
References: <20180731112739.32338-1-prarit@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode: Make sure boot_cpu_data.microcode
 is up-to-date
Git-Commit-ID: 370a132bb2227ff76278f98370e0e701d86ff752
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

Commit-ID:  370a132bb2227ff76278f98370e0e701d86ff752
Gitweb:     https://git.kernel.org/tip/370a132bb2227ff76278f98370e0e701d86ff752
Author:     Prarit Bhargava <prarit@redhat.com>
AuthorDate: Tue, 31 Jul 2018 07:27:39 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 2 Sep 2018 14:10:54 +0200

x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

When preparing an MCE record for logging, boot_cpu_data.microcode is used
to read out the microcode revision on the box.

However, on systems where late microcode update has happened, the microcode
revision output in a MCE log record is wrong because
boot_cpu_data.microcode is not updated when the microcode gets updated.

But, the microcode revision saved in boot_cpu_data's microcode member
should be kept up-to-date, regardless, for consistency.

Make it so.

Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: sironi@amazon.de
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180731112739.32338-1-prarit@redhat.com
---
 arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..602f17134103 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = mc_amd->hdr.patch_id;
+
 	return UCODE_UPDATED;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 97ccf4c3b45b..256d336cbc04 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
+
 	return UCODE_UPDATED;
 }
 
