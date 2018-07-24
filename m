Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCkfwlmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0640520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbeGXUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:10:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39090 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbeGXUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:10:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so5229724qtp.6;
        Tue, 24 Jul 2018 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ue7cw4iJYGtSvAcbffVanrrxMYEef3dzMSmzxrnAOSs=;
        b=LCkfwlmEVS3OejBes8gBw22+iTSD2KJuRLPnWujpUmkiRcVG2uFuW60GN5P92fKErQ
         cNAsxtbZaGS9RLtA21zX7uuIcxHti9+Ey/Dqr+eFCBJ7d/27WFhmF6S3IoH3D8gX4+8w
         vTgV0w/evBI199xGWOzCIK3z20c2OKNtXzDQWGvJTilb/l0ET0UriuiiwdR+V3t6U9Kf
         2tFAV0BNj7JLNgfDX/VmsUzcnwDOE16+1D8KkiV8CTXky1DYE3a93oGAQM9LPkGV7KTf
         GFBl9v4dOFrm+EwoYf0vlbUqhYLvR9VEQYNHokO5KIxbh3UfGMqElGZ0mCCTvS/8FmNb
         LdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ue7cw4iJYGtSvAcbffVanrrxMYEef3dzMSmzxrnAOSs=;
        b=MANxOxfBMHT2cMJ4OlfADg4VfJeXENc4MoBejJhe4eMn96R97zEYUGlCMA+uKYg1Yf
         Gkgbn7BO5EI8+WUx3exnd11p31vigb8m82cNl7hFdnKzeNmRaadTPHkOdMo2hcI98P18
         l2vDcedFr8h06WH7YQFj6nazEukc4zgaYOCVsYEL1VOyFf7eleV7Yh0jg/FKmaHugchA
         HJ2E7rS8jrAEv0ZIUZ2/HdF3sT00wRin7mITtlu0A+pgrtUTbm8xkn9VBZ/YTCrxwFKm
         0/zUF9LaCCrftiWfQAaeYUmvnXf70Qzk2T6mQ9sMFdt5oeKkYeH/ayesHmyMivJTzFzQ
         CtEg==
X-Gm-Message-State: AOUpUlFIN5ucC1lmqwRDY1tCGeAAWqwQlNgjFJcRBq9AE+tUc5sdNIFb
        4Sruzmc1t6XmIozf9hwi5w==
X-Google-Smtp-Source: AAOMgpdvZ38Nyry7sL+sD5vnrYgW9vxhIm/XHzw0pRQExznwoKF2/qAQZrrFnQAEa93CohLrMEDVrA==
X-Received: by 2002:aed:3bb7:: with SMTP id r52-v6mr17286001qte.77.1532458948643;
        Tue, 24 Jul 2018 12:02:28 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o68-v6sm8085181qkf.9.2018.07.24.12.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 12:02:28 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2] EDAC, sb_edac: Add support for systems with segmented PCI buses
Date:   Tue, 24 Jul 2018 15:02:13 -0400
Message-Id: <20180724190213.26359-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Currently, sb_edac driver does not support systems which has
multi PCI segments. If the driver is loaded to such system,
a slab-out-bounds happens [*].

This patch extends sb_edac driver to check whether segment number
and bus number matches when deciding how to group memory controller
PCI devices to CPU sockets. 

[*] KASAN report is as follows.
==================================================================
BUG: KASAN: slab-out-of-bounds in sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
Read of size 8 at addr ffff8c0d44dfe850 by task modprobe/4221

CPU: 19 PID: 4221 Comm: modprobe Not tainted 4.18.0-rc5 #2
Call Trace:
 dump_stack+0xc2/0x16b
 ? show_regs_print_info+0x5/0x5
 ? kmsg_dump_rewind_nolock+0xd9/0xd9
 ? pci_get_dev_by_id+0x57/0x70
 ? pci_get_device+0x155/0x210
 print_address_description+0x6a/0x270
 kasan_report+0x258/0x380
 ? sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
 sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
...
==================================================================

Fixes: e2f747b1f42a ("EDAC, sb_edac: Assign EDAC memory controller per h/w controller")

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/sb_edac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4a89c80..07726fb 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -352,6 +352,7 @@ struct pci_id_table {
 
 struct sbridge_dev {
 	struct list_head	list;
+	int			seg;
 	u8			bus, mc;
 	u8			node_id, source_id;
 	struct pci_dev		**pdev;
@@ -729,7 +730,8 @@ static inline int numcol(u32 mtr)
 	return 1 << cols;
 }
 
-static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bus,
+static struct sbridge_dev *get_sbridge_dev(int seg, u8 bus, enum domain dom,
+					   int multi_bus,
 					   struct sbridge_dev *prev)
 {
 	struct sbridge_dev *sbridge_dev;
@@ -747,14 +749,15 @@ static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bu
 				      : sbridge_edac_list.next, struct sbridge_dev, list);
 
 	list_for_each_entry_from(sbridge_dev, &sbridge_edac_list, list) {
-		if (sbridge_dev->bus == bus && (dom == SOCK || dom == sbridge_dev->dom))
+		if ((sbridge_dev->seg == seg) && (sbridge_dev->bus == bus) &&
+				(dom == SOCK || dom == sbridge_dev->dom))
 			return sbridge_dev;
 	}
 
 	return NULL;
 }
 
-static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
+static struct sbridge_dev *alloc_sbridge_dev(int seg, u8 bus, enum domain dom,
 					     const struct pci_id_table *table)
 {
 	struct sbridge_dev *sbridge_dev;
@@ -771,6 +774,7 @@ static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
 		return NULL;
 	}
 
+	sbridge_dev->seg = seg;
 	sbridge_dev->bus = bus;
 	sbridge_dev->dom = dom;
 	sbridge_dev->n_devs = table->n_devs_per_imc;
@@ -2246,6 +2250,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 	struct sbridge_dev *sbridge_dev = NULL;
 	const struct pci_id_descr *dev_descr = &table->descr[devno];
 	struct pci_dev *pdev = NULL;
+	int seg = 0;
 	u8 bus = 0;
 	int i = 0;
 
@@ -2276,10 +2281,12 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 		/* End of list, leave */
 		return -ENODEV;
 	}
+	seg = pci_domain_nr(pdev->bus);
 	bus = pdev->bus->number;
 
 next_imc:
-	sbridge_dev = get_sbridge_dev(bus, dev_descr->dom, multi_bus, sbridge_dev);
+	sbridge_dev = get_sbridge_dev(seg, bus, dev_descr->dom,
+				      multi_bus, sbridge_dev);
 	if (!sbridge_dev) {
 		/* If the HA1 wasn't found, don't create EDAC second memory controller */
 		if (dev_descr->dom == IMC1 && devno != 1) {
@@ -2292,7 +2299,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 		if (dev_descr->dom == SOCK)
 			goto out_imc;
 
-		sbridge_dev = alloc_sbridge_dev(bus, dev_descr->dom, table);
+		sbridge_dev = alloc_sbridge_dev(seg, bus, dev_descr->dom, table);
 		if (!sbridge_dev) {
 			pci_dev_put(pdev);
 			return -ENOMEM;
-- 
2.18.0

