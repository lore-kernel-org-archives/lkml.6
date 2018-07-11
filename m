Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35620846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ED475D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbeGKQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:36:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34608 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeGKQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:36:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so2164533ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jtwV8KVCZsHXLAEsji/x1/pO/+nSkurqRqs+VlLPvU8=;
        b=Z+ED475DD8NyzCFgkm09TG2pJWMJf3pqvzIaxrilytWNKkRGXUyUGvf1ajQlQU5y94
         EoeetLQ/ELNws+KTQnYttrdPD93Pg/sY19QXssrFHxbddyNNkkUDi47mSR2ysbzPGU/o
         de9eZnr4Xal/Ich9ueRjXxKISUEOJUGz2t+VdMKpm875KdUUX7apiSf4xrAgUwfnimv0
         rOPEszMNQs3aMGepn6D/x50tWgtHLmmuRyBSiygq3cRtkkoM1ezr8J2v+z1g3LqQG2/J
         yV4pSWjj6gqCTHCSHz2yH+AeWgH63ZQhmCR/DKq1f24cnFfY5nandv/DS908xkUYZHv+
         2MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jtwV8KVCZsHXLAEsji/x1/pO/+nSkurqRqs+VlLPvU8=;
        b=l8zSt+mdjCgg0Zb/llsGpyHqPrGpWINa+4gRWhFXjGKbVPYZ8QhNrfz8y5YrZ03mSU
         /0gmbfnPT9Hfg+e89G8xthV7nVM2Y0nf1/YK85kDZSrG++9ytp+LYqVCLQQlgsHGNKO5
         wNNnRe9fsfLl99QFqF1b5mrsvbKSYi/4hUQ8Ec+dTcPmd7fZSS82Cv1jSpcpjdPjwzkH
         +EDTagYYjxC9kGhv/JKmuavsMiMd8SBdedmQSxIHQWtS7TYdyxB1GCRNbsZMK7jYiZCL
         BwxebpKkANyAK5bSl702n6Cc+KtIcWSro+D/wI4NRf9uMwYT/HolxGHyurvzAEdGLZUS
         z0pQ==
X-Gm-Message-State: APt69E0zSFVBwBq+K0/X5jOIAGCZS6SGM4EWfY1cmh+5I9kq87epqEcx
        OEvnZd136OkKpylDxHCS6VI=
X-Google-Smtp-Source: AAOMgpePEnyzTXF9bSR4IvbHDK8v0BAwcSKU59p/VNzD61GN9IWApTueNSfP8R6Zq3Jd0QhL18pZtg==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr8217160ljt.56.1531326707867;
        Wed, 11 Jul 2018 09:31:47 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id q72-v6sm2941lja.6.2018.07.11.09.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 09:31:46 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH] ntb: idt: Set PCIe bus address to BARLIMITx
Date:   Wed, 11 Jul 2018 19:32:24 +0300
Message-Id: <20180711163224.30892-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT NTB driver sets the upper limit of actual translation address
being set to the corresponding memory window. It is achieved by
BARLIMITx register initialization. Needless to say, that the register
works within PCIe bus address space.

In general CPU and PCIe address spaces are different. It means,
that addresses used for Memory TLPs routine can be different from
CPU addresses. While in most of cases they are the same, there are
exceptions when the proper mapping must be performed to have the
portable driver code. There used to be a virt_to_bus()/bus_to_virt()
interface for this purpose. But it's deprecated now. It was also a
mistake to use pci_resource_start() since the return address of the
method is at the CPU address space. In order to achieve the desired
purpose we need to use pcibios_resource_to_bus(). This method shall
return a PCIe bus address region of the corresponding BAR resources.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dbe72f116017..0f4f5e7e4ff8 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1311,6 +1311,7 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	/* DIR and LUT based translations are initialized differently */
 	if (mw_cfg->type == IDT_MW_DIR) {
 		const struct idt_ntb_bar *bar = &ntdata_tbl.bars[mw_cfg->bar];
+		struct pci_bus_region region;
 		u64 limit;
 		/* Set destination partition of translation */
 		data = idt_nt_read(ndev, bar->setup);
@@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 		idt_nt_write(ndev, bar->ltbase, (u32)addr);
 		idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
 		/* Set the custom BAR aperture limit */
-		limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
+		pcibios_resource_to_bus(ntb->pdev->bus, &region,
+					&ntb->pdev->resource[mw_cfg->bar]);
+		limit = region.start + size;
 		idt_nt_write(ndev, bar->limit, (u32)limit);
 		if (IS_FLD_SET(BARSETUP_TYPE, data, 64))
 			idt_nt_write(ndev, (bar + 1)->limit, (limit >> 32));
-- 
2.12.0

