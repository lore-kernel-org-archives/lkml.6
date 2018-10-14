Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED3AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2E020644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJNXLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36018 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbeJNXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:54 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cJ-IA; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000jl-Ia; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.25880149@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 339/366] libata: blacklist Micron 500IT SSD with MU01
 firmware
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 136d769e0b3475d71350aa3648a116a6ee7a8f6c upstream.

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[bwh: Backported to 3.16: Drop ATA_HORKAGE_ZERO_AFTER_TRIM flag]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4247,6 +4247,7 @@ static const struct ata_blacklist_entry
 	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M5[15]0_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

