Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CAC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C620844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xY54e+dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeKIIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbeKIHdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A078021104;
        Thu,  8 Nov 2018 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714186;
        bh=uI47qzz8nfT+pObBbIgGkLME6cxdqzwg9re/ceNXYEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xY54e+dR0DmyXwJ1akHl9uKIWuGpHdqVPqAukobJn99aH/LnI6Q1AITYn0rDZVDUr
         aF+MLmgvtx6qq1Ip+xVdkzrBTulpcf5UR2ZtsX0YPezX7nY9HtEiu+LqAOnIHGMeGP
         6DOOz7EQ4+Wj+BEr+veYBuflajAb8QA/n/bR9Bbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 111/144] libata: blacklist Micron 500IT SSD with MU01 firmware
Date:   Thu,  8 Nov 2018 13:51:22 -0800
Message-Id: <20181108215105.905321571@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 136d769e0b3475d71350aa3648a116a6ee7a8f6c ]

While whitelisting Micron M500DC drives, the tweaked blacklist entry
enabled queued TRIM from M500IT variants also. But these do not support
queued TRIM. And while using those SSDs with the latest kernel we have
seen errors and even the partition table getting corrupted.

Some part from the dmesg:
[    6.727384] ata1.00: ATA-9: Micron_M500IT_MTFDDAK060MBD, MU01, max UDMA/133
[    6.727390] ata1.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.741026] ata1.00: supports DRM functions and may not be fully accessible
[    6.759887] ata1.00: configured for UDMA/133
[    6.762256] scsi 0:0:0:0: Direct-Access     ATA      Micron_M500IT_MT MU01 PQ: 0 ANSI: 5

and then for the error:
[  120.860334] ata1.00: exception Emask 0x1 SAct 0x7ffc0007 SErr 0x0 action 0x6 frozen
[  120.860338] ata1.00: irq_stat 0x40000008
[  120.860342] ata1.00: failed command: SEND FPDMA QUEUED
[  120.860351] ata1.00: cmd 64/01:00:00:00:00/00:00:00:00:00/a0 tag 0 ncq dma 512 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x5 (timeout)
[  120.860353] ata1.00: status: { DRDY }
[  120.860543] ata1: hard resetting link
[  121.166128] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  121.166376] ata1.00: supports DRM functions and may not be fully accessible
[  121.186238] ata1.00: supports DRM functions and may not be fully accessible
[  121.204445] ata1.00: configured for UDMA/133
[  121.204454] ata1.00: device reported invalid CHS sector 0
[  121.204541] sd 0:0:0:0: [sda] tag#18 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[  121.204546] sd 0:0:0:0: [sda] tag#18 Sense Key : 0x5 [current]
[  121.204550] sd 0:0:0:0: [sda] tag#18 ASC=0x21 ASCQ=0x4
[  121.204555] sd 0:0:0:0: [sda] tag#18 CDB: opcode=0x93 93 08 00 00 00 00 00 04 28 80 00 00 00 30 00 00
[  121.204559] print_req_error: I/O error, dev sda, sector 272512

After few reboots with these errors, and the SSD is corrupted.
After blacklisting it, the errors are not seen and the SSD does not get
corrupted any more.

Fixes: 243918be6393 ("libata: Do not blacklist Micron M500DC")
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cd589d012ef1..6629a5deccbd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4249,6 +4249,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.17.1



