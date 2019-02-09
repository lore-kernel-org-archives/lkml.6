Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4950C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9660A20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdqJH5dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIAdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46436 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBIAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so2269290pgp.13;
        Fri, 08 Feb 2019 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BivFvmV3c30k+UgJ9J2DVi/oCYbtYBfA6Or0DIYBZvk=;
        b=kdqJH5dYUXkNE/wDnYp8u2HbXrDFbHhBYyjXrGnFh7jxGX96J3vesF4Psq72NVX/28
         n8YE7GHtrHK9vMY3jY4MIyBQvdY48H1lUXyWu3GEDGz6hjrJqkFYYVYHHAbAtC5EqBgW
         nKMIculyDVkeBGBbaFGLMYTX1s3oFZF8wamZ2H51fhF7W6p+7xbVJwoKhO645o0wsaN5
         uN/Xtd0f5hMjeRWKlt+oaliaSRF65H3k9JKpT+X1zSkPywkWlyvoSaHnlPa54Q/QR21d
         Hc9O7sx0mMxTtXpy3J2e50ZYd5T7VEKmGlXDlovD9xYRbDzzcxyoXeH1I2+E2o5DtkVA
         6DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BivFvmV3c30k+UgJ9J2DVi/oCYbtYBfA6Or0DIYBZvk=;
        b=XZ6gd2cA+u4nb1oG5hr6bShtYQNCB4XvmekAQZDs4vs4mGYOkRKzf159yTmuxH+a8Q
         TMTjXe207YNvfLyrAhU24rlsyMozfPelKWIC1o7cFl8+2kDgTFJ1GbISnvPtkjLToS3l
         xpD1s0dIg1g+675rpixCQnndvEH/PyGTfVia/9GSfHIaSfa9UWlBoR2Vyqr6qaTE/lWS
         PqB6VyRFOtpl+thCf75QphdPFIlHMgpNR9pwWFI1ZJnsh2gxYRmGkz/eWw1tfsi884Fy
         lp8+45HP1/bHtDpd45eNgF9UCGvdk8xb7GP3P52c3OOMLSQHeo/xelbrmXKjoIhtLi1e
         Z6Vw==
X-Gm-Message-State: AHQUAuaW5XVSXJn5SZgmp9isD7rDsgkZeXjhGTqFE01eHBohKzKiE7GF
        wLPaTU8mOQfc7VbkW067YiEQeiZM
X-Google-Smtp-Source: AHgI3IYMGHgJTbsF10jhb5ux6SnbhsFWGFoTueyAvzy7Gr1HPJUvUSykSZQNhDhG/GCKOc6og3vONQ==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr24721437pfm.63.1549672396595;
        Fri, 08 Feb 2019 16:33:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 02/16] mlxsw: spectrum: Check bridge flags during prepare phase
Date:   Fri,  8 Feb 2019 16:32:34 -0800
Message-Id: <20190209003248.31088-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..468a6d513074 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -623,8 +623,11 @@ static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->bridge,
 						orig_dev);
-- 
2.17.1

