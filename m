Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D62C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B68421104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stdujP7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B68421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeKTEVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbeKTEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so3698247plo.0;
        Mon, 19 Nov 2018 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQqOfbzz6IvXfwosZ6bkrG7vMl/SUPlFBBt1H3AvhNQ=;
        b=stdujP7wpGc95xjaFnVyazbmhemdp1t9RVIhsQOLPgVe64ITIXF3syxbSeSgIpRqFM
         /biibPmqfMsvgYlUFxXv6ex7vV+eo0XvJ7IEnfkBfjjEhnt4uDoGfZESbq4cGgo+jpzj
         zUbfnJejtzZH5PY977+bAfZnBIEjPnNMBbirPu45VjR+CJ2nC4Cz1akn96ee0XZk35Ui
         U6nTL7CPedKE6LD6Aim32GzPuWqbSbt5wDNAJsL8X5hGClNaqrhRWRVlHXClVi9TEU5S
         ubovE68aDB5tpVtIoLNbmu37ejqwG5q1++yo4bV7fbiNsk48p2pjMbaJAsMZ/p/7oqZx
         GA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQqOfbzz6IvXfwosZ6bkrG7vMl/SUPlFBBt1H3AvhNQ=;
        b=JNwEMggk3WAEE6PFka7vR4WK+nSdKEFvDzWsxNTZOd2raj1l/+myyLY3n9WlXpuUjR
         gnnYZMbPz1MxMZhfTA3u7UVkPUdj8AvM/hcRDGreic1YpLJXmEWVTPA8qYAvbZt4Yu7v
         I4keCIyM6b6vwtrIjvT9BbTtE0fWQefbwrM4ZA5sg4mfBauioBXNH0ZsS2Kkyb/bwCUp
         5Of3IJzKBaBKt7GnFBX9gvQg/J2p+jhN3/QZdq5Y28zeMiy46UlLNESNGWXaMFJKzkWX
         Pa+arqMHlGy1bL5u0XicJlml/odDOxU7w6V9F58TX1ZEWrzTkDYt1jnYl/CoIaV8d8TM
         Z04w==
X-Gm-Message-State: AGRZ1gJ5NiGERtHo1afiWHP7kwVaV/lbK5LPcvU5YUyR/kQ9Gy9oaB1G
        HyVimDjewklC2Qt7Koq045g=
X-Google-Smtp-Source: AJdET5chS1HmDYDJ4+vIeFfPnJ1/L4+2oyR705C2PZQ58iExwLfPQLMTXsEqHethG2E3ZRiQ7JgfwA==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7-v6mr23440867plb.79.1542650198024;
        Mon, 19 Nov 2018 09:56:38 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x123-v6sm56159846pfb.124.2018.11.19.09.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 09:56:37 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <doug.berger@broadcom.com>
Subject: [PATCH net-next v2 2/2] net: bcmgenet: abort suspend on error
Date:   Mon, 19 Nov 2018 09:56:02 -0800
Message-Id: <1542650162-9229-3-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
References: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <doug.berger@broadcom.com>

If an error occurs during suspension of the driver the driver should
restore the hardware configuration and return an error to force the
system to resume.

Fixes: 0db55093b566 ("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
Signed-off-by: Doug Berger <doug.berger@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 3 +++
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 01c8499fd87f..983245c0867c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3717,6 +3717,9 @@ static int bcmgenet_suspend(struct device *d)
 	/* Turn off the clocks */
 	clk_disable_unprepare(priv->clk);
 
+	if (ret)
+		bcmgenet_resume(d);
+
 	return ret;
 }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 2fbd027f0148..57582efa362d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -186,6 +186,8 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
+	if (!(reg & MPD_EN))
+		return;	/* already powered up so skip the rest */
 	reg &= ~MPD_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 
-- 
2.7.4

