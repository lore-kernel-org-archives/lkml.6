Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91040208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aujge1nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91040208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbeG0SRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:17:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35319 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeG0SRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:17:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so4996079ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WefzQjHmu9TxAhfWBP6EovtIO8laSdhs66en4L/Gh/c=;
        b=aujge1nwfR1yJI4srajHmfDfl3lrgGhyjbWCWChyUgSagNfurTGuNqGjcz7Q1WcUZR
         Vk9PkqshwTLpfx/tITPMLeUhO9BTecmzfk//ZoeCRyZ295xevgivugNheDhEcXsTcS7o
         7JxbqiduI5suavRDuBRjP9lbcf9b+JGM8XU4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WefzQjHmu9TxAhfWBP6EovtIO8laSdhs66en4L/Gh/c=;
        b=IkjfwYq87e/h5+CB8pA0stJVd167p1Z3IqDKTbcemZXmpJN2Ox0eLH86t8+Axs97yp
         Iw9/rEHoq1V/T4sYi9/NsS+ejSlNNC1kNhIHJSfCb3l+lT7rZpCgNULMy7fB8oSWHg3T
         VLwYF//qcGqZu39wB+pKUWo3IvP6x3925YjAMM4rRBDOJB3NIce9+wX7I7xZwhGgsb6Z
         fuG0p77bC6CAf5SvWC+lSvmD3riP7JGcRLgbNZ4bsRG4aGGoCNX/ZwDBc27Z1CMWQkKO
         diWoGBz07VbioBMIGBJKcdrUECRAUo4yd1DjMoORGhLz/j/OXUWOEhVxFvUaggtRmOfV
         h3tg==
X-Gm-Message-State: AOUpUlHMUA4wgvuVcNI9CcywvRaxVdaJEUVnJM8/bTnUndOvUDmFbQ+m
        /e+qqD+PsNBmPogmGC2BjyMUHQ==
X-Google-Smtp-Source: AAOMgpeJ0Ixwl4wJR1hYuWABSi1nkXVAmjoCxfUbuhZjWR6gvs0eHiAfJrcY8KBjxC3Zl/V6CRrDCQ==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr3852866ljc.25.1532710485968;
        Fri, 27 Jul 2018 09:54:45 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id l1-v6sm753478lji.41.2018.07.27.09.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:54:45 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: add missed RX_CTAG feature for second slave
Date:   Fri, 27 Jul 2018 19:54:39 +0300
Message-Id: <20180727165439.16933-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems it was missed while adding for first net dev in dual-emac mode.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 171abcfb6184..1b54c26c2bec 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3287,7 +3287,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1

