Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0798CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C8A21A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOk4W9Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C8A21A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbeHGBig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:36 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45296 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHGBif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so25217821oic.12;
        Mon, 06 Aug 2018 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/X5lGKWH77cyPJBOOmZPH/w7I6UAHHh4sZCzwZv18W0=;
        b=YOk4W9IjxiLVZkHPnCsVCW6pZQTlqCsPM3piMt++EZLeB1xyr7EHr0N6RBwh5mK/GE
         A1uuW77ZWCKJFsRmoncRcjJLm4L8QY8JByRFXvsepLQQ+QcLF7/MqwMPGHzdVWP6VbVP
         KbOqPr7yaHTBfGwCxr1H5CjlAct/PEmiDiCG3uwzUb10Czo2gZDpEiRN+qO6DkcNZrgA
         JsVysaJ3v/OF9h40p9Sp01SOKZhK+H5qG26qx2Z45mK7b2NCpaioPQx4MLJajDgb4ulp
         Cwnu6aTKIA8n+UlyjyAKdbpjSgttOUHJFPWEJldjffPE+1mh+1CDmz1bg6wzLFsBNAK/
         q8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/X5lGKWH77cyPJBOOmZPH/w7I6UAHHh4sZCzwZv18W0=;
        b=V0YUnno89auKj1BsJKk6R04EPheV0J/XrD0eOqni6SvxpHtNuq0xkbCNW6n3Hrmktu
         8SchCDoYVPcB4RQzz3/qN2H+9xTO99RPjUBr48NRz8JYxXfSVlbFkko4ZKKbp/aiza7o
         q2kukY7Vn09Tvi6Vnc+pU8rSjpWxa1a3co3kKmuJGq1eh2lB7e9PpdLi3fa+YjdlfjG3
         IQbgaSmMvhcIZpsMaqpN2Xi6/lfhSwceL7bRPC/aJfhN612zTDh0rpSyvSbIqitV1R5w
         rLV1gooovA6Lw+2yM+y6b7glF4u2/HyLMneOVbK5MWgkT91o/XQUwlwqmF1WOi7rkyP3
         wqYg==
X-Gm-Message-State: AOUpUlF69VmmhYYkyf9ysQykqgaI/aNnIHVpijtf+qvyCTpg90Z2w0HI
        N/z5ju+broEYDaKaqAq+W/j4HS4AR9E=
X-Google-Smtp-Source: AA+uWPyqepO3ACjQR+JzgMAiiErDXisUOThTd206MbmgwkSaf+BQ+HDjA/D/CYTgGPuwEQ1pJTCjcQ==
X-Received: by 2002:aca:cd84:: with SMTP id d126-v6mr17851662oig.325.1533598030946;
        Mon, 06 Aug 2018 16:27:10 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:27:10 -0700 (PDT)
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
Subject: [PATCH v6 9/9] nfp: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:43 -0500
Message-Id: <20180806232600.25694-9-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 749655c329b2..0324f99bd1a7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -1324,7 +1324,6 @@ struct nfp_cpp *nfp_cpp_from_nfp6000_pcie(struct pci_dev *pdev)
 	/*  Finished with card initialization. */
 	dev_info(&pdev->dev,
 		 "Netronome Flow Processor NFP4000/NFP6000 PCIe Card Probe\n");
-	pcie_print_link_status(pdev);
 
 	nfp = kzalloc(sizeof(*nfp), GFP_KERNEL);
 	if (!nfp) {
-- 
2.17.1

