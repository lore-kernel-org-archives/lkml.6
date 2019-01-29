Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE312C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0F52183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762090;
	bh=GFyEy3qdfanLfz89btRBQok/27pUNqqcDsIsQ9mxwn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w933ts7PZnAHDFwhHZBmjGPPl1j/V7ft6ZEI2rGfYOwqN2T6fiMLNbl0t6Cq/nnxG
	 slxMmuWusp7U+uRKc4eTQ3/T5Klb1y7XP8ydCYLs7hTrLyDBuxmh6Y0dXc5PT7bHXT
	 oFFlXNorYiqaWytwAHwriih85aicUQDKysY5NZNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfA2Ll3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbfA2LlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A471220882;
        Tue, 29 Jan 2019 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762084;
        bh=GFyEy3qdfanLfz89btRBQok/27pUNqqcDsIsQ9mxwn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18FtY++HnLwNPBh2fihdZ5mz8HMuX3rbkbNVWADTMrjP4Xh0HE655mv+EjjIwMnWO
         kE3AhHCqlIWlktfZGAiUBwU8mQ1v1vkKiSswFAX6QgjgrRDWdGy46v2CnkCYfPcqpP
         w8TzA/ZE9AKgwTSyxyDKrJWqRBiX8YmpydoE5w4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 071/117] scsi: ufs: Use explicit access size in ufshcd_dump_regs
Date:   Tue, 29 Jan 2019 12:35:22 +0100
Message-Id: <20190129113211.092021461@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

commit d67247566450cf89a693307c9bc9f05a32d96cea upstream.

memcpy_fromio() doesn't provide any control over access size.  For example,
on arm64, it is implemented using readb and readq.  This may trigger a
synchronous external abort:

[    3.729943] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[    3.737000] Modules linked in:
[    3.744371] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #16
[    3.747413] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
[    3.755295] pstate: 00000005 (nzcv daif -PAN -UAO)
[    3.761978] pc : __memcpy_fromio+0x68/0x80
[    3.766718] lr : ufshcd_dump_regs+0x50/0xb0
[    3.770767] sp : ffff00000807ba00
[    3.774830] x29: ffff00000807ba00 x28: 00000000fffffffb
[    3.778344] x27: ffff0000089db068 x26: ffff8000f6e58000
[    3.783728] x25: 000000000000000e x24: 0000000000000800
[    3.789023] x23: ffff8000f6e587c8 x22: 0000000000000800
[    3.794319] x21: ffff000008908368 x20: ffff8000f6e1ab80
[    3.799615] x19: 000000000000006c x18: ffffffffffffffff
[    3.804910] x17: 0000000000000000 x16: 0000000000000000
[    3.810206] x15: ffff000009199648 x14: ffff000089244187
[    3.815502] x13: ffff000009244195 x12: ffff0000091ab000
[    3.820797] x11: 0000000005f5e0ff x10: ffff0000091998a0
[    3.826093] x9 : 0000000000000000 x8 : ffff8000f6e1ac00
[    3.831389] x7 : 0000000000000000 x6 : 0000000000000068
[    3.836676] x5 : ffff8000f6e1abe8 x4 : 0000000000000000
[    3.841971] x3 : ffff00000928c868 x2 : ffff8000f6e1abec
[    3.847267] x1 : ffff00000928c868 x0 : ffff8000f6e1abe8
[    3.852567] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    3.857900] Call trace:
[    3.864473]  __memcpy_fromio+0x68/0x80
[    3.866683]  ufs_qcom_dump_dbg_regs+0x1c0/0x370
[    3.870522]  ufshcd_print_host_regs+0x168/0x190
[    3.874946]  ufshcd_init+0xd4c/0xde0
[    3.879459]  ufshcd_pltfrm_init+0x3c8/0x550
[    3.883264]  ufs_qcom_probe+0x24/0x60
[    3.887188]  platform_drv_probe+0x50/0xa0

Assuming aligned 32-bit registers, let's use readl, after making sure
that 'offset' and 'len' are indeed multiples of 4.

Fixes: ba80917d9932d ("scsi: ufs: ufshcd_dump_regs to use memcpy_fromio")
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -110,13 +110,19 @@
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix)
 {
-	u8 *regs;
+	u32 *regs;
+	size_t pos;
+
+	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
+		return -EINVAL;
 
 	regs = kzalloc(len, GFP_KERNEL);
 	if (!regs)
 		return -ENOMEM;
 
-	memcpy_fromio(regs, hba->mmio_base + offset, len);
+	for (pos = 0; pos < len; pos += 4)
+		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
+
 	ufshcd_hex_dump(prefix, regs, len);
 	kfree(regs);
 


