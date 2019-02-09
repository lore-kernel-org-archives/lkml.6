Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4626C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F2C21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds1cgo2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBIAdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43081 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBIAdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so2429547pfk.10;
        Fri, 08 Feb 2019 16:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33kk5S35E4b328f8vXqo4LKpo2Z5ZPT3Y6kFb640bVo=;
        b=ds1cgo2iCYBWm6Cr+ZtQVCrU1lUdjl4DdnRf47CsrsS7lKxG6+CqmEYNb+UwnjyiEb
         vNFrwL+t/iNRr37Xp6ssDjtzdATTya7BC+0BuH3MVBq8/AZAb5HIpPUlKy+9175rOSKk
         OqUEJrhG58MSkw7OXIIESlaa8fnHjE2SemIM3u9HBNqdNDQfyAkaniHRIAXX+4w45Bsj
         ndijfSkd9TGTgffO03RAOjYUaUcwnzwEGGyFdcBSN0gagYOmc7wwpFDuuuIflF27l8vg
         HUNRasl6vnMKzp6LeIqWtl9TB5bBhi9mUOJ++eCisW9SkcTiQpP4q8x4pUt7Val9w7pi
         e9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33kk5S35E4b328f8vXqo4LKpo2Z5ZPT3Y6kFb640bVo=;
        b=AcvOkK4ehHDGlyXFoJTegp51/K6MP0fPeRvONKu+4lEdK2K9IYZ3Dd1Kob9lW51EOO
         20M0PyD8sC4EDGBEpiPUocU1E0lSWJjsFQDkK0DQ8bswOPG+VrAc/aJzOk3eD7R1SZS1
         q5hN7LzWiUI5U8ki1aoOcsgDECNoO+ogRUPIqa+O3r/4okhEotejWeBGQokjj08Q24Y5
         KJophf70Le+IvCgE5Lmneut1VShp8iKxGQMMScNDdLPFDCLjPO3VhtKoJHa8RaKeafOR
         i80X1+3s4iTIT/t6uQG4w4lXV23rdeMzTPL4yxkiEHWIT4GTu/B/5PaY/T98z/mODb4L
         COjA==
X-Gm-Message-State: AHQUAuZ5OPnP/g2VqNG6IbAfecCG266xwbqjdqx3/AnhSiFh9dUgEm8y
        vS8jWWwgWexm/8nzzr5brJIoaLNW
X-Google-Smtp-Source: AHgI3IbD3XHnO5LzRtKQEUeam0hszLuYEFCj5HUDx6qDF8CXlDXgT1nUetmtcAH5GD962sqXAsZC6w==
X-Received: by 2002:a62:d005:: with SMTP id p5mr25078617pfg.175.1549672400979;
        Fri, 08 Feb 2019 16:33:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 03/16] staging: fsl-dpaa2: ethsw: Check bridge port flags during set
Date:   Fri,  8 Feb 2019 16:32:35 -0800
Message-Id: <20190209003248.31088-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
have ethsw check that the bridge port flags that are being set are
supported.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..6228c4375835 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -680,8 +680,11 @@ static int port_attr_br_flags_set(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		if (flags & ~(BR_LEARNING | BR_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	/* Learning is enabled per switch */
 	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
-- 
2.17.1

