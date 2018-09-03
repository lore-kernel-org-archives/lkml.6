Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C920843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUVH1QzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108C920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeICWY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46399 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so2185598oie.13;
        Mon, 03 Sep 2018 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fg2A3DvOXX8NgTgO2joawBOfX3jENRiRELhCGPGFnmQ=;
        b=FUVH1QzPclM7FuFFutpHbB8g6/ZDBvlTSRivruOhDh/cl50fkuxEvCZaAR6CdL6n4i
         z55fEilhKZUAT82/nPe8xBi889/2AhyqQpmE3eUlWJjAsh2XdzSZ/P9z/nPwloeheU9o
         VubQYGgFZfmg19l9ZSFJhkVvTBMMh1iZenAmLpCs3hNWKuOuWXGE/K8+/DLgThgWAsZU
         r4fxUcy6ZT/HwZ/+WTNm6YlLhtaDA+Zpp3/wmPwtfcQLZ144UNKfID8UjQcDJUGOCmuv
         hScBgdT/ZMFnYl/MJL/6Y5XE6LUPh+JYOmcvYst+AxoOuBDENNDJE1Zxh4F6oNdZ9cUN
         Ozgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fg2A3DvOXX8NgTgO2joawBOfX3jENRiRELhCGPGFnmQ=;
        b=f9V5RGWBK6RB2IAVV2Cf7pORdLQDnKMOGkSriP2a6L3w3ja5Dufyv0PYF8yWrZzx/Z
         DdxG0hNaNFmHulJTYeVUC63u2DQKbsYHDnvXpCirn7H+8qHZEN848jjcOHBV+8JnW6jI
         ZbVjFHwzaOo0cEpNZRszCWXvFiRVbLwoLNifRRlRHhanIbwebzsnDuYct94nYdhtTc2M
         1s/xDOBBHQMVInyZxMA2rr4p7KygqslwPi4rxSpepJYEuZV4wIfL3RfSO05L8/cyMppl
         FroENW7LsahmJp0h6BtCzLJ32wi524RbOdO4DPyxPyWu2CG4y1n3qlzTWxOAQkSlIV54
         zx3A==
X-Gm-Message-State: APzg51DWLInMR0PrMTJo+EEfvkS11izkuGsDdXVvMYyarH0hOA4XYK2d
        ar2BvX31GuRyEdWw05vuE0nS+XO9HNE=
X-Google-Smtp-Source: ANB0VdYtc/2GklzEV/Fv5McahDTZEEyTiC2FkM0CbLsEMnKOgM3MmJnvGFINCb8jnz1cj9r0kcTsQw==
X-Received: by 2002:aca:4dca:: with SMTP id a193-v6mr19653879oib.343.1535997787495;
        Mon, 03 Sep 2018 11:03:07 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:07 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH 2/9] bnx2x: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:29 -0500
Message-Id: <20180903180242.14504-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180242.14504-1-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 71362b7f6040..9bd0852d9a66 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14100,7 +14100,6 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	       board_info[ent->driver_data].name,
 	       (CHIP_REV(bp) >> 12) + 'A', (CHIP_METAL(bp) >> 4),
 	       dev->base_addr, bp->pdev->irq, dev->dev_addr);
-	pcie_print_link_status(bp->pdev);
 
 	bnx2x_register_phc(bp);
 
-- 
2.17.1

