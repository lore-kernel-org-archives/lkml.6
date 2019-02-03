Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98788C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E38218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfBCN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9l-0003ts-7D; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007Bf-JE; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Kevin Shanahan" <kevin@shanahan.id.au>,
        "Tejun Heo" <tj@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.977760193@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 191/305] libata: Apply NOLPM quirk for SAMSUNG
 MZMPC128HBFU-000MV SSD
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit b5b4d3a52c8fd6e3fc6469c5a64ca0139c07229e upstream.

Kevin Shanahan reports the following repeating errors when using LPM,
causing long delays accessing the disk:

  Apr 23 10:21:43 link kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x50000 action 0x6 frozen
  Apr 23 10:21:43 link kernel: ata1: SError: { PHYRdyChg CommWake }
  Apr 23 10:21:43 link kernel: ata1.00: failed command: WRITE DMA
  Apr 23 10:21:43 link kernel: ata1.00: cmd ca/00:08:60:5d:cd/00:00:00:00:00/e1 tag 9 dma 4096 out
                                        res 50/01:01:01:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  Apr 23 10:21:43 link kernel: ata1.00: status: { DRDY }
  Apr 23 10:21:43 link kernel: ata1.00: error: { AMNF }
  Apr 23 10:21:43 link kernel: ata1: hard resetting link
  Apr 23 10:21:43 link kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  Apr 23 10:21:43 link kernel: ata1.00: configured for UDMA/133
  Apr 23 10:21:43 link kernel: ata1: EH complete

These go away when switching from med_power_with_dipm to medium_power.

This is somewhat weird as the PM830 datasheet explicitly mentions DIPM
being supported and the idle power-consumption is specified with DIPM
enabled.

There are many OEM customized firmware versions for the PM830, so for now
lets assume this is firmware version specific and blacklist LPM based on
the firmware version.

Cc: Kevin Shanahan <kevin@shanahan.id.au>
Reported-by: Kevin Shanahan <kevin@shanahan.id.au>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4246,6 +4246,9 @@ static const struct ata_blacklist_entry
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* This specific Samsung model/firmware-rev does not handle LPM well */
+	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },

