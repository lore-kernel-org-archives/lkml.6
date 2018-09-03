Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680820856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8cVEYyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7680820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeICWYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38310 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so2252199oix.5;
        Mon, 03 Sep 2018 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=od+FfEhfZ2c4L0WVWY/ZAmVtThCFnh9arWHU9+Uiz+s=;
        b=W8cVEYyyRcTk6UAfP6KB4nwVa+GxHzJMwwozVrkD0k5xF5dXd/J6/C899Sm8ZUJvF1
         LLjPyFcq19xUqQqqGgPPFJt4RzMOaOBDv1pmEceRFHW9bBc5/SF0mYnWt4wrDo6ULRCw
         O3k2xH1OnGwIOSRzaevRlr9/xhQ/iwuOzGY1xG5j+xHC8MvEPRQOSayiJfX0JZNlKDYw
         iosmVZfA5LD7g25Xhzi2r1UhGPQ3WvUkp1A174sb801OQbZxdjb0TmXpOaO0KuyEr/Yq
         VdWZCnY9kieJFZYXUdPrW9toFwZqHMcZVNEQ6kKYroH5wboUnMNScIAwgLNW7CNp5GpQ
         O/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=od+FfEhfZ2c4L0WVWY/ZAmVtThCFnh9arWHU9+Uiz+s=;
        b=tWp+phQ1RwiUkETmmzW0W9cQw6hWL8ejszI9zt9A56Rtxj40tvynJA4osiQzptiNRe
         18zzwBC2jiwPy2r3YjNJyPowCHR10XkdZwo4/2M7FiKlVXDOYRptydlR76zatO3yi22J
         PybEVWQKoxsqACiH+FY7o8WoEu5asBliKvl3bI9EH1I+DTvcMa6lh/y4TGfixNCWst+1
         zrJ4Xq/c6m8BYejlfEeUrwGkY6yDP/+e99Fcbf91Ira8w028ek29z1KSS//5dZ9HBaBn
         0ZFmsond526xk3hOXSXSxeV9onUwXysLbIgbshwf0WH5c8zpvx/cQ3zV71PA+aFbOJGG
         S/OA==
X-Gm-Message-State: APzg51DEa3++F5AFSWBwWbE01bG/5+tJXolSXbsjZM18w1C3Otc/BTqC
        6C9W7gPQKJstSINsaXeWyQTX6Lj/1Mc=
X-Google-Smtp-Source: ANB0VdbQHYS/neIj1baACG1VOSsbiJVtsTcha+gOVQvhtOxz2rEqLRTQGqTTh3ezCDx+aOurnNuqNg==
X-Received: by 2002:aca:b985:: with SMTP id j127-v6mr19741517oif.257.1535997811674;
        Mon, 03 Sep 2018 11:03:31 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:31 -0700 (PDT)
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
Subject: [PATCH 6/9] ixgbe: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:33 -0500
Message-Id: <20180903180242.14504-7-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9a23d33a47ed..9663419e0ceb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -241,28 +241,6 @@ static inline bool ixgbe_pcie_from_parent(struct ixgbe_hw *hw)
 	}
 }
 
-static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
-				     int expected_gts)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	struct pci_dev *pdev;
-
-	/* Some devices are not connected over PCIe and thus do not negotiate
-	 * speed. These devices do not have valid bus info, and thus any report
-	 * we generate may not be correct.
-	 */
-	if (hw->bus.type == ixgbe_bus_type_internal)
-		return;
-
-	/* determine whether to use the parent device */
-	if (ixgbe_pcie_from_parent(&adapter->hw))
-		pdev = adapter->pdev->bus->parent->self;
-	else
-		pdev = adapter->pdev;
-
-	pcie_print_link_status(pdev);
-}
-
 static void ixgbe_service_event_schedule(struct ixgbe_adapter *adapter)
 {
 	if (!test_bit(__IXGBE_DOWN, &adapter->state) &&
@@ -10792,10 +10770,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	/* don't check link if we failed to enumerate functions */
-	if (expected_gts > 0)
-		ixgbe_check_minimum_link(adapter, expected_gts);
-
 	err = ixgbe_read_pba_string_generic(hw, part_str, sizeof(part_str));
 	if (err)
 		strlcpy(part_str, "Unknown", sizeof(part_str));
-- 
2.17.1

