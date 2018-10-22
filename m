Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF4C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4384C20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUquArPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4384C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJWDLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:11:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40444 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeJWDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:11:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id n3-v6so4389937lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eA8Rg59dDQxH06VYFGu93+Pi57FUmhMP1ESgTyENeQo=;
        b=KUquArPMYpNiss6HPj1hWxBYtlUv8jdH18zIu1S/bXjyQ1ZMn0UfMjO3YzqWHT1NoW
         FmPriiRAfZOsPg6EMl9FNA4rYj/+3IbjcfIwile8pjIzluVZl8ow/vvn2WKZJn2eWXlL
         BP2kSTEUNi0F8GXrtHyffuNYFlct+KwUbpd5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eA8Rg59dDQxH06VYFGu93+Pi57FUmhMP1ESgTyENeQo=;
        b=K9LBPFH179DGEqcYrSgoq3GtytwTiwo4S7Y6jiigYH1Rx0/BLA9XRxEvCtYrGRn47n
         GsYCfNQ2RMB6sAV/u3BJyF2fXuMiB6j4FdC1d/5qYuwIujvEMVHHTwWK+5X3/JuO2x43
         lYB10gy6BjflCIBpWqjw5h/QarFJ9ywhvcCJx0RKqP13IxlvsIyWFsvjAEZiw0dNPPcw
         quX3kI+bqDh3Afk0Nme8OQSx8aWRTTxe9dxtGxZ8dhhwchkdF75vZ5wO1r/q91oVugs/
         feOTEyAyuNFx3vVMUMEPJma1Pl6qp7AKjE3fVPp4VSqe9GZ7JNbpAMuc5GTIvs3rG91B
         fgxw==
X-Gm-Message-State: ABuFfohpRkRRzycfgIya6s/W7OmfkP0OxxekUQwbpgH/GyQZfiTIz8IC
        ysGqSWYOERWe3geTPdZlK3It9w==
X-Google-Smtp-Source: ACcGV61ZlXrOG6WmwEQYikK+gXc+24D3hnVMe547uL5CAZBpnxCwaGN1+HSmBbx9C03yQya8ZvzFxA==
X-Received: by 2002:a19:945b:: with SMTP id w88mr9978835lfd.15.1540234330907;
        Mon, 22 Oct 2018 11:52:10 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1431377lje.91.2018.10.22.11.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 11:52:09 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next] net: ethernet: ti: cpsw: unsync mcast entries while switch promisc mode
Date:   Mon, 22 Oct 2018 21:51:36 +0300
Message-Id: <20181022185136.8215-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After flushing all mcast entries from the table, the ones contained in
mc list of ndev are not restored when promisc mode is toggled off,
because they are considered as synched with ALE, thus, in order to
restore them after promisc mode - reset syncing info. This fix
touches only switch mode devices, including single port boards
like Beagle Bone.

Fixes: commit 5da1948969bc
("net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 226be2a56c1f..f7753b240ced 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -640,6 +640,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
+			__dev_mc_unsync(ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
-- 
2.17.1

