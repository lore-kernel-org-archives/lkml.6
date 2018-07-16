Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F620864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48F620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeGPIDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A11BCA0;
        Mon, 16 Jul 2018 07:37:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.17 22/67] ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS
Date:   Mon, 16 Jul 2018 09:34:51 +0200
Message-Id: <20180716073446.476946296@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 240630e61870e62e39a97225048f9945848fa5f5 upstream.

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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c        |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |    3 ++
 include/linux/libata.h    |    1 
 3 files changed, 63 insertions(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1281,6 +1281,59 @@ static bool ahci_broken_suspend(struct p
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
@@ -1695,6 +1748,12 @@ static int ahci_init_one(struct pci_dev
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
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2502,6 +2502,9 @@ int ata_dev_configure(struct ata_device
 	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
 		dev->horkage |= ATA_HORKAGE_NOLPM;
 
+	if (ap->flags & ATA_FLAG_NO_LPM)
+		dev->horkage |= ATA_HORKAGE_NOLPM;
+
 	if (dev->horkage & ATA_HORKAGE_NOLPM) {
 		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
 		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -211,6 +211,7 @@ enum {
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
+	ATA_FLAG_NO_LPM		= (1 << 2), /* host not happy with LPM */
 	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */


