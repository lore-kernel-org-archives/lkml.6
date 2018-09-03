Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C192C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137F120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqDJUMKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137F120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeICWZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:25:08 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45196 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:25:07 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so2196370oie.12;
        Mon, 03 Sep 2018 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Al/mS7lVdpKUEvF7vrO6otIVTS22X8nx5MPa3QEsinE=;
        b=pqDJUMKlIxmP5dge09YgTMfYlrmN1CCUu2haOOpBk8yMriwXVh6KJn+TSalBAy+gsK
         KrH2v7cS1T9ax+7jChmVoo/Awa7yOEeEgSdS9ndP3EIzXXQP83L1+sWGSQLth102Y2rb
         DhFauLkYo3CfzTCOvpfkas/tLLxE1nJqucPmsteW6kPOf6y4xGtpbPBHp+h8HYY0jPvu
         6P7tVzBpY9Nsze9YBpOyv/9+OHgSJrqiNDH2OAIAbIe4zlMnX4zpTIUvWIcM10axTw+5
         M/6xuB7d7rPh4xDZnwld3F2+NT9qlwuZJpi98tqVoZYlrxqrSmOxfCnykW/Wm2RytFa0
         OlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Al/mS7lVdpKUEvF7vrO6otIVTS22X8nx5MPa3QEsinE=;
        b=mlj9nG/RvX+bxCCsw7bDdRAGxn5bfmX5WrZJtIWTAc95vAdzgZK43zv9iPif9RnmrI
         ALsdK/lT9nai5KU8rn6h6dyDpXP7Yst4JJ05iGNXVFDgr5i414NWUNjfCLnU7kRntGpD
         6lEfkRobOkARivO+QfL4DQH0AY9ixpFZA7tsFU9q5mmEALVOtYwnFJT5js7FSpnJiM08
         Kx6qGil8N5phumbbCDM9lNZW2l2u/c+y5fyNL+mMlOsHvlBP3NkFn7coPjUcJ8h4EqqM
         ibRXdnBhNBTNP+Vr3oBUh9xIw97HW3X+AwlwG9OCYyrALlSqVarlCoV6ZzUOLz49fCjc
         yNYg==
X-Gm-Message-State: APzg51DDaBRHFo2mKacNMl8zoKNc+9IwA+KbkMPb6MO8xW3eiprWzx1u
        NepeeDvvhm9khNywr9tr49pC3MdwfAE=
X-Google-Smtp-Source: ANB0VdYUe8YdRqBExTmFv2cu7Z49WuQSObxS3S3uob1OSWgR0YiOX2Z5uiM0ObM4AB0X6T4VPLVhvA==
X-Received: by 2002:aca:470b:: with SMTP id u11-v6mr19564879oia.197.1535997828586;
        Mon, 03 Sep 2018 11:03:48 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:48 -0700 (PDT)
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
Subject: [PATCH 9/9] nfp: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:36 -0500
Message-Id: <20180903180242.14504-10-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index c8d0b1016a64..87dde0f787e9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -1328,7 +1328,6 @@ struct nfp_cpp *nfp_cpp_from_nfp6000_pcie(struct pci_dev *pdev)
 	/*  Finished with card initialization. */
 	dev_info(&pdev->dev,
 		 "Netronome Flow Processor NFP4000/NFP6000 PCIe Card Probe\n");
-	pcie_print_link_status(pdev);
 
 	nfp = kzalloc(sizeof(*nfp), GFP_KERNEL);
 	if (!nfp) {
-- 
2.17.1

