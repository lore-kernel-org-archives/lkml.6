Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeEaLQi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:16:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754441AbeEaLQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:16:32 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Subject: [PATCH] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Date: Thu, 31 May 2018 13:16:29 +0200
Message-Id: <20180531111629.13394-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.

This has lead to several reports of users of that SSD where LPM
was working fine and who know have a significantly increased idle
power consumption on their laptops.

Likely there is another problem on the T450s from the original
reporter which gets exposed by the uncore reaching deeper sleep
states (higher PC-states) due to LPM being enabled. The problem as
reported, a hardfreeze about once a day, already did not sound like
it would be caused by LPM and the reports of the SSD working fine
confirm this. The original reporter is ok with dropping the quirk.

A X250 user has reported the same hard freeze problem and for him
the problem went away after unrelated updates, I suspect some GPU
driver stack changes fixed things.

TL;DR: The original reporters problem were triggered by LPM but not
an LPM issue, so drop the quirk for the SSD in question.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 68596bd4cf06..6e400ff2b5db 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4552,9 +4552,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* This specific Samsung model/firmware-rev does not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 
-	/* Sandisk devices which are known to not handle LPM well */
-	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.17.0
