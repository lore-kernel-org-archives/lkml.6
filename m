Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0236A25097
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0236A25097
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeGAKPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 06:15:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751890AbeGAKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 06:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7EF24000B8A;
        Sun,  1 Jul 2018 10:15:48 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-57.ams2.redhat.com [10.36.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E645F2026D66;
        Sun,  1 Jul 2018 10:15:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS
Date:   Sun,  1 Jul 2018 12:15:46 +0200
Message-Id: <20180701101546.10319-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 01 Jul 2018 10:15:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 01 Jul 2018 10:15:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been several reports of LPM related hard freezes about once
a day on multiple Lenovo 50 series models. Strange enough these reports
where not disk model specific as LPM issues usually are and some users
with the exact same disk + laptop where seeing them while other users
where not seeing these issues.

It turns out that enabling LPM triggers a firmware bug somewhere, which
has been fixed in later BIOS versions.

This commit adds a new ahci_broken_lpm() function and a new ATA_FLAG_NO_LPM
for dealing with this.

The ahci_broken_lpm() function contains DMI match info for the 4 models
which are known to be affected by this and the DMI BIOS date field for
known good BIOS versions. If the BIOS date is older then the one in the
table LPM will be disabled and a warning will be printed.

Note the BIOS dates are for known good versions, some older versions may
work too, but we don't know for sure, the table is using dates from BIOS
versions for which users have confirmed that upgrading to that version
makes the problem go away.

Unfortunately I've been unable to get hold of the reporter who reported
that BIOS version 2.35 fixed the problems on the W541 for him. I've been
able to verify the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION from an older
dmidecode, but I don't know the exact BIOS date as reported in the DMI.
Lenovo keeps a changelog with dates in their release notes, but the
dates there are the release dates not the build dates which are in DMI.
So I've chosen to set the date to which we compare to one day past the
release date of the 2.34 BIOS. I plan to fix this with a follow up
commit once I've the necessary info.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci.c        | 59 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |  3 ++
 include/linux/libata.h    |  1 +
 3 files changed, 63 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 738fb22978dd..fdeb3b4d0f4a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1280,6 +1280,59 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 	return strcmp(buf, dmi->driver_data) < 0;
 }
 
+static bool ahci_broken_lpm(struct pci_dev *pdev)
+{
+	static const struct dmi_system_id sysids[] = {
+		/* Various Lenovo 50 series have LPM issues with older BIOSen */
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X250"),
+			},
+			.driver_data = "20180406", /* 1.31 */
+		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L450"),
+			},
+			.driver_data = "20180420", /* 1.28 */
+		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T450s"),
+			},
+			.driver_data = "20180315", /* 1.33 */
+		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
+			},
+			/*
+			 * Note date based on release notes, 2.35 has been
+			 * reported to be good, but I've been unable to get
+			 * a hold of the reporter to get the DMI BIOS date.
+			 * TODO: fix this.
+			 */
+			.driver_data = "20180310", /* 2.35 */
+		},
+		{ }	/* terminate list */
+	};
+	const struct dmi_system_id *dmi = dmi_first_match(sysids);
+	int year, month, date;
+	char buf[9];
+
+	if (!dmi)
+		return false;
+
+	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
+	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
+
+	return strcmp(buf, dmi->driver_data) < 0;
+}
+
 static bool ahci_broken_online(struct pci_dev *pdev)
 {
 #define ENCODE_BUSDEVFN(bus, slot, func)			\
@@ -1694,6 +1747,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			"quirky BIOS, skipping spindown on poweroff\n");
 	}
 
+	if (ahci_broken_lpm(pdev)) {
+		pi.flags |= ATA_FLAG_NO_LPM;
+		dev_warn(&pdev->dev,
+			 "BIOS update required for Link Power Management support\n");
+	}
+
 	if (ahci_broken_suspend(pdev)) {
 		hpriv->flags |= AHCI_HFLAG_NO_SUSPEND;
 		dev_warn(&pdev->dev,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 27d15ed7fa3d..cc71c63df381 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2493,6 +2493,9 @@ int ata_dev_configure(struct ata_device *dev)
 	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
 		dev->horkage |= ATA_HORKAGE_NOLPM;
 
+	if (ap->flags & ATA_FLAG_NO_LPM)
+		dev->horkage |= ATA_HORKAGE_NOLPM;
+
 	if (dev->horkage & ATA_HORKAGE_NOLPM) {
 		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
 		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8b8946dd63b9..26719233a5b1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -210,6 +210,7 @@ enum {
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
+	ATA_FLAG_NO_LPM		= (1 << 2), /* host not happy with LPM */
 	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-- 
2.17.1

