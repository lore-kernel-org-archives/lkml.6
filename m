Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9759A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeGYKdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:33:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbeGYKdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:33:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id USzqQeWCuLEg; Wed, 25 Jul 2018 11:23:03 +0200 (CEST)
Received: from nazgul.tnic (77-85-109-49.ip.btc-net.bg [77.85.109.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14FB01EC00E4;
        Wed, 25 Jul 2018 11:23:03 +0200 (CEST)
Date:   Wed, 25 Jul 2018 11:22:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v2] EDAC, sb_edac: Add support for systems with segmented
 PCI buses
Message-ID: <20180725092258.GA14113@nazgul.tnic>
References: <20180724190213.26359-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724190213.26359-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 03:02:13PM -0400, Masayoshi Mizuma wrote:
> [*] KASAN report is as follows.

That KASAN report is an arbitrary side-effect from the missing segmented
support so I ripped it out from the commit message and ended up
committing this:

---
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Date: Tue, 24 Jul 2018 15:02:13 -0400
Subject: [PATCH] EDAC, sb_edac: Add support for systems with segmented PCI buses

Extend the driver to check whether segment number and bus number matches
when deciding how to group memory controller PCI devices to CPU sockets.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180724190213.26359-1-msys.mizuma@gmail.com
[ Cleanup commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/sb_edac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4a89c8093307..07726fb00321 100644
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
2.14.0.rc0

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
