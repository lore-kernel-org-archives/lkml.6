Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAE20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3c60FRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAAE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJLXjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:39:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34074 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbeJLXjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:39:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id j17-v6so11854765lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ugxvMaHgww4tCznq8+Zrv/s/hrVuJo2pMgDC2pw469c=;
        b=e3c60FRuz9kFhciQ50JNXUyVX20s+6Ko3fG3Yf22hDiQFSW9jh45eXxzinMPhsssJ3
         hVZp5dYePoqVFQR9Stgl6hm42IoiSPrqXFwJBzBZqmqmeOy0Cd8rsVJ74oYmQLBE2ijr
         aU7ZZV+kmHTMX9gUSGfYOzIbjGygcLCOHISZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ugxvMaHgww4tCznq8+Zrv/s/hrVuJo2pMgDC2pw469c=;
        b=TCDp8kc3GmHzyI89PhvdEHgKiPfmfeMyZnO5dgJRrDq5paDWUfuCg+PIC6qUncOb8q
         fcw9eXsM6/35jVAQDp/vyIkTfV64RQJjWTsDPErRHk/AFiNYjpKsW13fz014/FMXQN88
         NIPuYN9ix7CsZ1Px9AddeGhsMSyirNJ2ZCYOZvUX8UIvFxa1TB6wHvrwyR6Wxd39eERN
         khVL3fVDw0ignyC6ZOoszSqGr8qT2Fmm4myKjyzjMjB0c49CWZezsucLs00++IjGDHuw
         Y8M0/V1XqKR/OIpH+RwiR4hrc05475dbl6dL2FzPn/LBYNDTd+GyM6h+E/7Gnw+mi0Qr
         OTzQ==
X-Gm-Message-State: ABuFfoiwd6W+zRgs1GQbqk4j05YPIPzy/KuVC7jMimEJy6WSs4UlYpPI
        lHZFQwjojejdGbN57pNL8pu28A==
X-Google-Smtp-Source: ACcGV624cMIkou0wSOgsBbna8p5rzKisy4eMxrnQa980e5B6uMTYfcQbNVSSKGCMnNPZp0wds2RMng==
X-Received: by 2002:a2e:98c2:: with SMTP id s2-v6mr4474534ljj.19.1539360393130;
        Fri, 12 Oct 2018 09:06:33 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id b10-v6sm335622lje.47.2018.10.12.09.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 09:06:32 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast entries only host port
Date:   Fri, 12 Oct 2018 19:06:29 +0300
Message-Id: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dual-emac mode the cpsw driver sends directed packets, that means
that packets go to the directed port, but an ALE lookup is performed
to determine untagged egress only. It means that on tx side no need
to add port bit for ALE mcast entry mask, and basically ALE entry
for port identification is needed only on rx side.

So, add only host port in dual_emac mode as used directed
transmission, and no need in one more port. For single port boards
and switch mode all ports used, as usual, so no changes for them.
Also it simplifies farther changes.

In other words, mcast entries for dual-emac should behave exactly
like unicast. It also can help avoid leaking packets between ports
with same vlan on h/w level if ports could became members of same vid.

So now, for instance, if mcast address 33:33:00:00:00:01 is added then
entries in ALE table:

vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1

Instead of:
vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x3
vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x5

With the same considerations, set only host port for unregistered
mcast for dual-emac mode in case of IFF_ALLMULTI is set, exactly like
it's done in cpsw_ale_set_allmulti().

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 16dcbf36f8cc..7bfb7ee3a261 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -576,10 +576,8 @@ static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
 
 	if (cpsw->data.dual_emac) {
 		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
-		int slave_port = cpsw_get_slave_port(slave->slave_num);
 
-		cpsw_ale_add_mcast(cpsw->ale, addr,
-				   1 << slave_port | ALE_PORT_HOST,
+		cpsw_ale_add_mcast(cpsw->ale, addr, ALE_PORT_HOST,
 				   ALE_VLAN, slave->port_vlan, 0);
 		return;
 	}
@@ -1410,7 +1408,7 @@ static inline void cpsw_add_dual_emac_def_ale_entries(
 	cpsw_ale_add_vlan(cpsw->ale, slave->port_vlan, port_mask,
 			  port_mask, port_mask, 0);
 	cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
-			   port_mask, ALE_VLAN, slave->port_vlan, 0);
+			   ALE_PORT_HOST, ALE_VLAN, slave->port_vlan, 0);
 	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
 			   HOST_PORT_NUM, ALE_VLAN |
 			   ALE_SECURE, slave->port_vlan);
@@ -2293,16 +2291,19 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 {
 	int ret;
 	int unreg_mcast_mask = 0;
+	int mcast_mask;
 	u32 port_mask;
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	if (cpsw->data.dual_emac) {
 		port_mask = (1 << (priv->emac_port + 1)) | ALE_PORT_HOST;
 
+		mcast_mask = ALE_PORT_HOST;
 		if (priv->ndev->flags & IFF_ALLMULTI)
-			unreg_mcast_mask = port_mask;
+			unreg_mcast_mask = mcast_mask;
 	} else {
 		port_mask = ALE_ALL_PORTS;
+		mcast_mask = port_mask;
 
 		if (priv->ndev->flags & IFF_ALLMULTI)
 			unreg_mcast_mask = ALE_ALL_PORTS;
@@ -2321,7 +2322,7 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 		goto clean_vid;
 
 	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
-				 port_mask, ALE_VLAN, vid, 0);
+				 mcast_mask, ALE_VLAN, vid, 0);
 	if (ret != 0)
 		goto clean_vlan_ucast;
 	return 0;
-- 
2.17.1

