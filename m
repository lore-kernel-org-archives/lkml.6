Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D0120856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6mlmfty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D0120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeICWYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44031 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so2210256oib.10;
        Mon, 03 Sep 2018 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2rUDCjn6Un8uQ3UH5Wl+sVjayMg0FP/H65oHDzFkYLI=;
        b=Y6mlmftytGWcArgfLjvCYn18LzaWx7ey9Jnil/5Rca8XNVU1nPxGr3nqbRzqUSHhWD
         SUz7+c1OIKf4yxD4SIfkQZdgCFRBDAnc6e0OE4hPoHBUygWWAYAUXeNwEULd/YW/PQwa
         isx5wbrhp6dPhXWaYH+a96i4LEHDfnP+CpVSL0823wx1YGiT+Bzz1CP39V8FDqmezhC+
         kTAJBw0cza+PBqqynDbwifELtUP/u6ZMvKxF4gOKXEH8zM2gsoxHlXb2w1nEB5TeN/20
         txLESNR0kmxITEOOHZ/p1szfnoewMREfnd+yeSH3XJr7lGZRxlR7Gt3OkqeU9OV/aoA+
         u2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2rUDCjn6Un8uQ3UH5Wl+sVjayMg0FP/H65oHDzFkYLI=;
        b=OZuAXTeHhOwlN9ZztYgNDjuDXOVUB16N8M8pQrnziQneaMgKssHAU+zWekWW3TDWcq
         5YCoaXQ9ruJv68VGUFtKN1TpISb2iubpuNu8N+1TJO0EpdFVvJF4YYR2kJNYsIouu7FT
         RBitYoAphov/1hxJKjiM6x7K6BEQicF6+uR26vSSJlZda3dGrGVVdyuO3yO6AanD1633
         JNLRCODHhgkuB5Es7HaooAjDJ1/4mxg+fHUZn3O9qYUeD4tA8c696IYJFYBnSC3llKr8
         NfW45B1iljuft317QqZj4VIuSsXkG+T5HwCMiayj5FjGspfvLoI541r24b4KSdZOCpSy
         6Bfg==
X-Gm-Message-State: APzg51Dup5rbBfue8nb4gs+zDCQbRuc5mLw3N/7dya+5HRrwpK47TiLV
        60X0BiH4gYrhZ1+mde1hJtp5WbZ6j8k=
X-Google-Smtp-Source: ANB0VdaUzvMqWdaVmCDorcwjwyyFVEUSzY5P1g3ks5wsUZp0UDJky+aB0o8h6rKdqqwbww28OKr6cw==
X-Received: by 2002:aca:68d8:: with SMTP id o85-v6mr19516302oik.96.1535997794788;
        Mon, 03 Sep 2018 11:03:14 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:14 -0700 (PDT)
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
Subject: [PATCH 3/9] bnxt_en: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:30 -0500
Message-Id: <20180903180242.14504-4-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8bb1e38b1681..246f33d2cc9c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9046,7 +9046,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev_info(dev, "%s found at mem %lx, node addr %pM\n",
 		    board_info[ent->driver_data].name,
 		    (long)pci_resource_start(pdev, 0), dev->dev_addr);
-	pcie_print_link_status(pdev);
 
 	return 0;
 
-- 
2.17.1

