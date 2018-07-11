Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD0C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3920C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PISyeDrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3920C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbeGKUqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:46:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35467 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeGKUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:46:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id f18-v6so6246170lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xcyc7q7iauyr2omfiWzf/M0owoAEG/OfzhQKHllGEc=;
        b=PISyeDrOZrw0TdTPvHq1o9G4Z//OmBTI7IecZnRW2fVyi+dTriSNcweiawunmdaO4G
         V9/K/Tvj1UJAOtPpVIISyQ+fxbUTN78PufD4W0cqHDwVJ9StvRTXwtyoXzKhWp2OvOGU
         v5zW2VGOBTIMni4DcBNxOkvcEl4CuzGjjmeZuZayU1nU/xvVjWQq/5CNCvaDEpUhPhWh
         +TMPn84De31MXSRU/JTWgozD6XtWRmNiGJYh567KJ57QRiGN5frqyuYb8J53L7YorDf5
         WQ4eIRu/sEuKbkYwWa3IO+/qQ+HvBnDurfBAesYDhCqTKZo4jSTF7fyV6auaklTnZ0Oy
         li1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xcyc7q7iauyr2omfiWzf/M0owoAEG/OfzhQKHllGEc=;
        b=I6pQ9yML74PZ2MuKjOyEeHpUywbAgoLjWfgMDxop5sEe9GDkXdP/ldlFq66laOL0fZ
         vmLEu0ed1VWIBFrQTiaHjgODhForh6jMXMf47NeO7+JHJ54+90Z6kaRPYHa+aCXupsMi
         W0GMnQgJH7MvDoY9Vro0vUUsPnUnJ4ZcbsxjoaNAc97jHzJAmku4m9Kz874Ed2Hq/Cj+
         damHYrBrwpO1brJ0x8Gukad8CLrBwzweunjC+3jj++eGXPjjhjnueFXcZDi/nSweDQvK
         PBIb8PnzgNNTZEU09hvS4oMqlVzddNBQ1DUyCh4s6ZQr9OpaD2htuNVmAzgxxVUJmToj
         MNaA==
X-Gm-Message-State: AOUpUlGh4O8bdox1Wauqokx04bqWQzOVwl5LchYJVY3Mfs39ydjpWMIH
        HYlWDcNtrr76pqVkvTxxJFo=
X-Google-Smtp-Source: AAOMgpfk6HAYc+hpHjYR5bpZhBfGGswP3KUFmCPzxf4IpzpJMR3hNP8D/BvGDPCCDSVBLEAp5kgXdQ==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr87366lfc.59.1531341611584;
        Wed, 11 Jul 2018 13:40:11 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5744746lfq.7.2018.07.11.13.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 13:40:10 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2] ntb: idt: Set PCIe bus address to BARLIMITx
Date:   Wed, 11 Jul 2018 23:40:51 +0300
Message-Id: <20180711204051.26139-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180711163224.30892-1-fancer.lancer@gmail.com>
References: <20180711163224.30892-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT NTB driver sets the upper limit of actual translation address
being written to the corresponding memory window setup. It is achieved
by BARLIMITx register initialization. Needless to say, that the register
works within PCIe bus address space.

In general CPU and PCIe address spaces are different. It means,
that addresses used for Memory TLPs routine can be different from
CPU addresses. While in most of cases they are the same, there are
exceptions when the proper mapping must be performed to have the
portable driver code. There used to be a virt_to_bus()/bus_to_virt()
interface for this purpose. But it's deprecated now. It was also a
mistake to use pci_resource_start() since the return address of the
method is at the CPU address space. In order to achieve the desired
purpose we need to use pci_bus_address() helper. This method shall
return a PCIe bus base address of the corresponding BAR resource.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Replace pcibios_resource_to_bus() with pci_bus_address() helper.

 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dbe72f116017..fb2c44ac9c69 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1320,7 +1320,7 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 		idt_nt_write(ndev, bar->ltbase, (u32)addr);
 		idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
 		/* Set the custom BAR aperture limit */
-		limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
+		limit = pci_bus_address(ntb->pdev, mw_cfg->bar) + size;
 		idt_nt_write(ndev, bar->limit, (u32)limit);
 		if (IS_FLD_SET(BARSETUP_TYPE, data, 64))
 			idt_nt_write(ndev, (bar + 1)->limit, (limit >> 32));
-- 
2.12.0

