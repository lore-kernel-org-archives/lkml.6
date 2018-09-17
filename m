Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4122ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271F214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A271F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeIREbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:31:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:31:41 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53061CB2;
        Mon, 17 Sep 2018 23:02:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, sironi@amazon.de
Subject: [PATCH 4.14 016/126] x86/microcode: Make sure boot_cpu_data.microcode is up-to-date
Date:   Tue, 18 Sep 2018 00:41:04 +0200
Message-Id: <20180917211705.763389040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prarit Bhargava <prarit@redhat.com>

commit 370a132bb2227ff76278f98370e0e701d86ff752 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/amd.c   |    4 ++++
 arch/x86/kernel/cpu/microcode/intel.c |    4 ++++
 2 files changed, 8 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = mc_amd->hdr.patch_id;
+
 	return UCODE_UPDATED;
 }
 
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
+
 	return UCODE_UPDATED;
 }
 


