Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8284D21508
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8284D21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeIZVlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:41:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZVlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:41:17 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZsclDkjV1Snl; Wed, 26 Sep 2018 17:27:48 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA1F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:1f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D3411EC0347;
        Wed, 26 Sep 2018 17:27:48 +0200 (CEST)
Date:   Wed, 26 Sep 2018 17:27:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926152752.GG5584@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926093510.GA5584@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:35:11AM +0200, Borislav Petkov wrote:
> * or Greg coming and saying, you're using bus_type all wrong and you
> shouldn't and you should remove it completely! :-)

Yap, and so he did! :-)

It looks like we can remove the whole per-MC bus thing, see below. Patch
seems to work here and grepping sysfs hierarchy before and after:

find /sys/ | grep -i edac > ...

doesn't show any differences.

Tony, I'd appreciate running this on one of your big boxes to check
nothing is missing in sysfs...

Thx.

---
 drivers/edac/edac_mc.c       |  9 +--------
 drivers/edac/edac_mc_sysfs.c | 30 ++----------------------------
 include/linux/edac.h         |  6 ------
 3 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7d3edd713932..13594ffadcb3 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -55,8 +55,6 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
 
-static struct bus_type mc_bus[EDAC_MAX_MCS];
-
 int edac_get_report_status(void)
 {
 	return edac_report;
@@ -716,11 +714,6 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	int ret = -EINVAL;
 	edac_dbg(0, "\n");
 
-	if (mci->mc_idx >= EDAC_MAX_MCS) {
-		pr_warn_once("Too many memory controllers: %d\n", mci->mc_idx);
-		return -ENODEV;
-	}
-
 #ifdef CONFIG_EDAC_DEBUG
 	if (edac_debug_level >= 3)
 		edac_mc_dump_mci(mci);
@@ -760,7 +753,7 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
-	mci->bus = &mc_bus[mci->mc_idx];
+	mci->bus = edac_get_sysfs_subsys();
 
 	if (edac_create_sysfs_mci_device(mci, groups)) {
 		edac_mc_printk(mci, KERN_WARNING,
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 20374b8248f0..2ca2012f2857 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -914,27 +914,8 @@ static const struct device_type mci_attr_type = {
 int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 				 const struct attribute_group **groups)
 {
-	char *name;
 	int i, err;
 
-	/*
-	 * The memory controller needs its own bus, in order to avoid
-	 * namespace conflicts at /sys/bus/edac.
-	 */
-	name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
-	if (!name)
-		return -ENOMEM;
-
-	mci->bus->name = name;
-
-	edac_dbg(0, "creating bus %s\n", mci->bus->name);
-
-	err = bus_register(mci->bus);
-	if (err < 0) {
-		kfree(name);
-		return err;
-	}
-
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type = &mci_attr_type;
 	device_initialize(&mci->dev);
@@ -950,7 +931,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
-		goto fail_unregister_bus;
+		goto out;
 	}
 
 	/*
@@ -998,10 +979,8 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 		device_unregister(&dimm->dev);
 	}
 	device_unregister(&mci->dev);
-fail_unregister_bus:
-	bus_unregister(mci->bus);
-	kfree(name);
 
+out:
 	return err;
 }
 
@@ -1032,13 +1011,8 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 
 void edac_unregister_sysfs(struct mem_ctl_info *mci)
 {
-	struct bus_type *bus = mci->bus;
-	const char *name = mci->bus->name;
-
 	edac_dbg(1, "Unregistering device %s\n", dev_name(&mci->dev));
 	device_unregister(&mci->dev);
-	bus_unregister(bus);
-	kfree(name);
 }
 
 static void mc_attr_release(struct device *dev)
diff --git a/include/linux/edac.h b/include/linux/edac.h
index a45ce1f84bfc..dd8d006f1837 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -668,10 +668,4 @@ struct mem_ctl_info {
 	bool fake_inject_ue;
 	u16 fake_inject_count;
 };
-
-/*
- * Maximum number of memory controllers in the coherent fabric.
- */
-#define EDAC_MAX_MCS	16
-
 #endif
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
