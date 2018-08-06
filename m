Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E397DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4721A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8sdHqYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA4721A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbeHGBiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34321 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbeHGBiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so25306603ois.1;
        Mon, 06 Aug 2018 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dr6bD/jWDLVzyDzhBEQSjBVlycw+s4X4ei2OzivsGgY=;
        b=n8sdHqYAskbg7CtaoFIf/aRhbfv6sCO1+02+aW1s19U38v3nTSZMJzJC3ziw4IzRGp
         SsZAJ4+mYocxH6PNi3ZyYy/CHok1SZ1sMjAA3zpZk+L+BLilc0veqytXofjxLRFQPJG+
         ysWAoQAgnms00rq2XfkbVMTbGrQBEo6fKzdxGmTQ+Kb20HMwaMjb8H3N2/Qoy9yKFHpa
         e0jysm4TAsQMkmHo+BBK4nDsEaV7iZiEaSUxb7w9XlCj5fygYlEkKPrXqHgnqWkb5wBL
         ZCthrWPN8sfrT7kPo8QUXpbsBZ/0p4Fsr83OTNBbqkpDJhnTNtiXkifwoIUHRWq6dnG6
         OgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dr6bD/jWDLVzyDzhBEQSjBVlycw+s4X4ei2OzivsGgY=;
        b=gz+UV3tHwghaEdenAcYJrUV1i0Dk1aauXMMUt2OBHMdQgd9ky4K73rrbPNzePMOAn/
         I6UOFRCjdTKDbF8YEF4qtqjKSdh7iOBYxxDgGn5NZGO5RX+kTaSLVpdkKBb54rajn6VE
         9jQDvE4Xy0gvrkSAT+3MNSMji2eTxn5dScVeCJyynmnWkSX/pjo7ZbEawgnAkcC8jkl2
         WSBN1MEkqI+9680uyJjPvtkeRZBzAlU2O+UzaXGXIPVVwVdHGzd+UBWK6ZPXX+oY6ov4
         c+9NZJ1ig2mg0ME1QOQHx7A7W8sK1xO+IfQVET6iUXnJ9unn1XIQ0UDSMpI+MaQ9XsMT
         Jdow==
X-Gm-Message-State: AOUpUlEoJ+x77DAhjAoug50fTuzgxCUYW71hafxZ/b46d3M5Dk0cJrT3
        j/SfL4r92wiu8chGxAH3WbKQjreijaQ=
X-Google-Smtp-Source: AAOMgpeNTL+cRNAu8Zdz1+IUcwIa2wgZRxCGTZYNzLJLv3i0coa8OkRSkrx+LlQWL9pd9Wh5l/8prA==
X-Received: by 2002:a54:4f94:: with SMTP id g20-v6mr17342767oiy.130.1533597996617;
        Mon, 06 Aug 2018 16:26:36 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:36 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
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
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH v6 3/9] bnxt_en: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:37 -0500
Message-Id: <20180806232600.25694-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
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
index 4394c1162be4..4b3928c89076 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8909,7 +8909,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev_info(dev, "%s found at mem %lx, node addr %pM\n",
 		    board_info[ent->driver_data].name,
 		    (long)pci_resource_start(pdev, 0), dev->dev_addr);
-	pcie_print_link_status(pdev);
 
 	return 0;
 
-- 
2.17.1

