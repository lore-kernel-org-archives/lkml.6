Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F1D218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBCNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53752 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9l-0003w8-7P; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007Bk-MN; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans de Goede" <hdegoede@redhat.com>, "Tejun Heo" <tj@kernel.org>,
        "=?UTF-8?q?Fran=C3=A7ois=20Cami?=" <fcami@fedoraproject.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.90321604@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 192/305] libata: Apply NOLPM quirk for SAMSUNG PM830
 CXM13D1Q.
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

From: François Cami <fcami@fedoraproject.org>

commit 76936e9a6df17b89481bd2655c8684291afbe656 upstream.

Without this patch the drive errors out regularly:

[    1.090154] ata1.00: ATA-8: SAMSUNG SSD PM830 mSATA 256GB,
CXM13D1Q, max UDMA/133
(...)
[  345.154996] ata1.00: exception Emask 0x40 SAct 0x0 SErr 0xc0800 action 0x6
[  345.155006] ata1.00: irq_stat 0x40000001
[  345.155013] ata1: SError: { HostInt CommWake 10B8B }
[  345.155018] ata1.00: failed command: SET FEATURES
[  345.155032] ata1.00: cmd ef/05:e1:00:00:00/00:00:00:00:00/40 tag 7
                        res 51/04:e1:00:00:00/00:00:00:00:00/40 Emask 0x41 (internal error)
[  345.155038] ata1.00: status: { DRDY ERR }
[  345.155042] ata1.00: error: { ABRT }
[  345.155051] ata1: hard resetting link
[  345.465661] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  345.466955] ata1.00: configured for UDMA/133
[  345.467085] ata1: EH complete

Signed-off-by: François Cami <fcami@fedoraproject.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4246,8 +4246,9 @@ static const struct ata_blacklist_entry
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
-	/* This specific Samsung model/firmware-rev does not handle LPM well */
+	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

