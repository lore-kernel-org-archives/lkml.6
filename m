Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE159C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F82064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWNvb5AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51F82064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeJIB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJIB5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9CF214C2;
        Mon,  8 Oct 2018 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024280;
        bh=wfo4ZAnTB820yZs+DKaAxi93gwcFHSu0P+S1KHDUP5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWNvb5AREPzu0NjTLQMuIUAlEoDgRkRSB53fridbz+23csY/nd0DaPhIJshJW+o7n
         RWLE7iaSSA2xWVZDtv5za8P8jzy0RSXbb9vcH1tb8kvVPbhIxIiKgyvv4lmCSPRBAb
         p1RAEggqTSzAsESNZ18c2jgFsr1y7PDKVCjP7JX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Aviv Heller <avivh@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 58/94] net/mlx5: Consider PCI domain in search for next dev
Date:   Mon,  8 Oct 2018 20:31:39 +0200
Message-Id: <20181008175608.840981569@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Jurgens <danielj@mellanox.com>

[ Upstream commit df7ddb2396cd162e64aaff9401be05e31e438961 ]

The PCI BDF is not unique. PCI domain must also be considered when
searching for the next physical device during lag setup. Example below:

mlx5_core 0000:01:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0000:01:00.1: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0001:01:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0001:01:00.1: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Aviv Heller <avivh@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -388,16 +388,17 @@ void mlx5_remove_dev_by_protocol(struct
 		}
 }
 
-static u16 mlx5_gen_pci_id(struct mlx5_core_dev *dev)
+static u32 mlx5_gen_pci_id(struct mlx5_core_dev *dev)
 {
-	return (u16)((dev->pdev->bus->number << 8) |
+	return (u32)((pci_domain_nr(dev->pdev->bus) << 16) |
+		     (dev->pdev->bus->number << 8) |
 		     PCI_SLOT(dev->pdev->devfn));
 }
 
 /* Must be called with intf_mutex held */
 struct mlx5_core_dev *mlx5_get_next_phys_dev(struct mlx5_core_dev *dev)
 {
-	u16 pci_id = mlx5_gen_pci_id(dev);
+	u32 pci_id = mlx5_gen_pci_id(dev);
 	struct mlx5_core_dev *res = NULL;
 	struct mlx5_core_dev *tmp_dev;
 	struct mlx5_priv *priv;


