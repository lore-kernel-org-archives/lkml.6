Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D2022503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0W2187I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D2022503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeKLXyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:54:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45456 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbeKLXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:54:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so7669297ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rZTyv24PfvDa0ThzLaZLU5MGIq0YKhyiUqNpDEImNKg=;
        b=h0W2187IgJZ40vpMO7oE1l5ITxBgj/yfZJLiei2mWlUjb6ZzaPrG6wOekEtoXnZCWN
         8NFByo8sRuLIQDH82chbq6DpvaSK7tJEX84Ms9P4JAFBRDViSx4t3KfGyNbGB6koP+XB
         xa7skDRzZT2J+a/Tzl9HyYJk31rJQ6HEL5n7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rZTyv24PfvDa0ThzLaZLU5MGIq0YKhyiUqNpDEImNKg=;
        b=HqKVLELiBCT9oQG9C5WjJX2yDOgUpFUHTZ7W326tn9TIrDC6UmeUONPgKel6bEONaM
         IqUyOHwQH4gJr0cbvi/l/Ghxv8Y4K/ncIAXG1aZSuLXk/RbPE1F58XZcRxUkbMeosc+n
         t6yoNYzv3f6TVuYO+T7n/ijX5AhXxSGb2cNrhiElMBMxUGtm5AIrnO2XRRPDAm7YXG5Y
         J/xh4R5puaFKsZ0lhn46ZoNgyml6rH1obB5pgoizLmHyoGtQYA1pIla3Y/BmH6nz+TVR
         zY6j/9CGwh33EIMwR8VZv8iBlBRb/ot1Zw7aV31KHfTEgIhkyvpOahs9o/DhKHXRqIAL
         kJkA==
X-Gm-Message-State: AGRZ1gKzxUmdqRo2TDgeB2NKbekKjNc2MC5SCB/WnLNPujq7JhWOyTnK
        /Lx9EnzyT5XlPPaJBoRmf/rHfg==
X-Google-Smtp-Source: AJdET5f/lMTsJdkr1BoGqkBwdMn4Vn7SHr8wH4trZRksJt6P+22uTeKRCwQkP3ItOg8kX7auDkuWHg==
X-Received: by 2002:a2e:6a13:: with SMTP id f19-v6mr820394ljc.41.1542031236526;
        Mon, 12 Nov 2018 06:00:36 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 26-v6sm3546387lje.18.2018.11.12.06.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:00:36 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 4/4] net: ethernet: ti: cpsw: allow vlan tagged packets to be timestamped
Date:   Mon, 12 Nov 2018 16:00:23 +0200
Message-Id: <20181112140023.12407-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow vlan tagged packets to be timestamped, as no any restrictions
for this.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 48ea21e7e0cb..e4aa030f1726 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -283,7 +283,7 @@ struct cpsw_ss_regs {
 
 #define CTRL_V2_TS_BITS \
 	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
-	 TS_TTL_NONZERO  | TS_ANNEX_D_EN | TS_LTYPE1_EN)
+	 TS_TTL_NONZERO  | TS_ANNEX_D_EN | TS_LTYPE1_EN | VLAN_LTYPE1_EN)
 
 #define CTRL_V2_ALL_TS_MASK (CTRL_V2_TS_BITS | TS_TX_EN | TS_RX_EN)
 #define CTRL_V2_TX_TS_BITS  (CTRL_V2_TS_BITS | TS_TX_EN)
@@ -293,7 +293,7 @@ struct cpsw_ss_regs {
 #define CTRL_V3_TS_BITS \
 	(TS_107 | TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
 	 TS_TTL_NONZERO | TS_ANNEX_F_EN | TS_ANNEX_D_EN |\
-	 TS_LTYPE1_EN)
+	 TS_LTYPE1_EN | VLAN_LTYPE1_EN)
 
 #define CTRL_V3_ALL_TS_MASK (CTRL_V3_TS_BITS | TS_TX_EN | TS_RX_EN)
 #define CTRL_V3_TX_TS_BITS  (CTRL_V3_TS_BITS | TS_TX_EN)
@@ -2235,6 +2235,7 @@ static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
 	slave_write(slave, mtype, CPSW2_TS_SEQ_MTYPE);
 	slave_write(slave, ctrl, CPSW2_CONTROL);
 	writel_relaxed(ETH_P_1588, &cpsw->regs->ts_ltype);
+	writel_relaxed(ETH_P_8021Q, &cpsw->regs->vlan_ltype);
 }
 
 static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
-- 
2.17.1

