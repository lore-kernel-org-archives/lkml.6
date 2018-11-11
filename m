Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11763C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B5A20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B5A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeKLG3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:29:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49502 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729906AbeKLFsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:06 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000lF-BF; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Ux-Os; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Lorenzo Dalrio" <lorenzo.dalrio@gmail.com>,
        "Richard W.M. Jones" <rjones@redhat.com>,
        "Hans de Goede" <hdegoede@redhat.com>, "Tejun Heo" <tj@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.694595954@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/366] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2cfce3a86b64b53f0a70e92a6a659c720c319b45 upstream.

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
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: "Richard W.M. Jones" <rjones@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4243,9 +4243,6 @@ static const struct ata_blacklist_entry
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
-	/* Sandisk devices which are known to not handle LPM well */
-	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },

