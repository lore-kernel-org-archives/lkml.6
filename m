Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866A721A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuUdyovG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866A721A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeHGBiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:25 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41827 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHGBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so25234080oiw.8;
        Mon, 06 Aug 2018 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2bZ3Se4cgyGCiwuPr3El/TGVU5z5CMKd0ds0GHiAfTw=;
        b=GuUdyovGPckoK8zDcbACzemz3VMUxYLJ4C8kkYY2IvYBB/q9CLbiHBQwwLpnA5uYvc
         608LeCsU3olh0nPqNFfdnKFArd655QmiT+oDi7GvfuQCh/RrXPGK5cI2anlc6pUC+feW
         Mi3Pms71GszwJMcY3uuLewF3iBRjwKjsWit6BcLHqATJlgNSwzFr/t5gK4dhkp/w5mNu
         d7FdJpVQ2CgXhWfvGjPtKNHUTtXIQU8CVIhz/eSUsdyTvb1mSvb/GXReoggjQTK7D+0t
         8y6njYZyCnRh3clmTbvqBCHIAgCczr7AlPaFhzrOU7vo/Rs6snCCb274UbX0hxjd/I21
         Y3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2bZ3Se4cgyGCiwuPr3El/TGVU5z5CMKd0ds0GHiAfTw=;
        b=ZVhohLDg5wVEsYZh9Sks99gz+JIN16aBR4Y5EyP8LwWxsLHPY0OjAHR/sXpu09zTSv
         AsSV4KiPs6yVeF767BPZIg2RhBnb1IFL+mrHKlza1hc0/qvH62DCXCIB8rw+VHTjkInR
         IB+4QrzNAn7T3kblcfshUX7/el3KmJ8NL06f4Qp2UfR7Cn4FF09/RDeUwbk3VnIXWcwm
         s3uC7RtDP9D8kG+QpykAsKS0eVlC7QcXeDJZrSAjQBgqmd2ZPGcqzhvjwQM9JE/h2+/D
         lamc1U5KLvRKcLwCYnQEBObOycG57NPvyg/DNHY2EU5ZGK5ycoF+uiZ6m6k4BM6FofRr
         BMPw==
X-Gm-Message-State: AOUpUlF6z7YPtGI/UtJL4ppF/9r+VdUlpQ3a34ZJfKG7RUrcl+ihWrGJ
        U3Jnjt3Y25L1mOGsxFil+82LL6gmZwM=
X-Google-Smtp-Source: AAOMgpeGISPLlKhVIqJgDC21UC9nd5l+l/0Kp71SpYw3ac98GEdfCzo3mejCOWHDqAXHXDcJZ1eivA==
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr15426647oia.242.1533598020198;
        Mon, 06 Aug 2018 16:27:00 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:59 -0700 (PDT)
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
Subject: [PATCH v6 7/9] net/mlx4: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:41 -0500
Message-Id: <20180806232600.25694-7-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 872014702fc1..da4d54195853 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3398,13 +3398,6 @@ static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
 		}
 	}
 
-	/* check if the device is functioning at its maximum possible speed.
-	 * No return code for this call, just warn the user in case of PCI
-	 * express device capabilities are under-satisfied by the bus.
-	 */
-	if (!mlx4_is_slave(dev))
-		pcie_print_link_status(dev->persist->pdev);
-
 	/* In master functions, the communication channel must be initialized
 	 * after obtaining its address from fw */
 	if (mlx4_is_master(dev)) {
-- 
2.17.1

