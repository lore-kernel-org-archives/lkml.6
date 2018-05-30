Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeE3LiN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60759 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752152AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans de Goede" <hdegoede@redhat.com>,
        "Tejun Heo" <tj@kernel.org>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.20858444@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 132/153] libata: Apply NOLPM quirk to Crucial M500 480
 and 960GB SSDs
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 62ac3f7305470e3f52f159de448bc1a771717e88 upstream.

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has not been tested with medium_power, but that typically has no
measurable power-savings.

Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
and there is a MU05 update available, but that update does not mention any
LPM fixes in its changelog, so the quirk matches all firmware versions.

In my experience the LPM problems with (older) Crucial SSDs seem to be
limited to higher capacity versions of the SSDs (different firmware?),
so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
M500, to avoid LPM causing issues with these SSDs.

Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[bwh: Backported to 3.2: Drop the TRIM quirk flags, which aren't supported]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4161,6 +4161,10 @@ static const struct ata_blacklist_entry
 	/* The 512GB version of the MX100 has LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NOLPM, },
 
+	/* 480GB+ M500 SSDs have LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
 
