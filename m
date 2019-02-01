Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4352146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhVihm7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBAWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43176 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBAWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so3878801plb.10;
        Fri, 01 Feb 2019 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WmijFqzuqz1KotgSCwjHOSZrSkpByjh6pj33/dW9ug=;
        b=fhVihm7cJ7mJIdfoZZqjirUZ/PmWZ0q9xHlFia/0EYWqZZzSXcfOHppUWIL380lfhM
         lQkhrkwWy8t7vpkSl39ti9X5YxbkVN6Wxq2mePHHpClph8a/iV6egW4PrGkjlsgcDUQe
         UjimpNZbvNo017806FzlHeIVdeMCqZXopiosWO9qgBLpR5TS3lZAZfRisCPwItuvw1Uq
         XG7F9hnud39qasi6KIT4m81pXOduo/tNMdV7Rc25SGFY/AG/agDABw/LnD8FKWj12evp
         ntkPf+gAwK1Ybw3PuOuIQ8hgCmm9Xo9dxNELc1kmJyJ39LQp+YSYphqP7r7y+nArnCoC
         4JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WmijFqzuqz1KotgSCwjHOSZrSkpByjh6pj33/dW9ug=;
        b=sfoltEfNFG26TQjHNl64fzwDPBTCIfefm5935StMvZUKlryPHB0tYP3Das+Qr0UwaH
         HOFqnX0rcf1rQIyJf0oZeIWBzo3qfYaXxLjA5h5i9MQde+AiIVd/7najetlbCIeblFRU
         OY9SFMnrzOtsGaBnTyWn/kaATse0+TUEfWndYshnRi7k/FcMDNbI5ZD2m9SqCwUY+Vz4
         kyu2IcOPq7HgzyjLriTocfODbT/8pnxiXq6RZ9cUetH9K813si5mjr7NlsChJi3NdoZr
         RkJomd8h6vzoYLKaICcOpwhdCMKpi47UG5Ko3BSIL6v0r8iAbpdeaTYyPe8eN+Rv/wft
         71iw==
X-Gm-Message-State: AJcUukeRbkXSL37XynPx20gQAUCBc5i+vTN9pML0eDjxr050DuSkduAh
        N6ckAB4Wem+0VWs1CVkBU7jNLgPN
X-Google-Smtp-Source: ALg8bN7TkQCvIb8E6M29Z4CG2Fs+aEvvtqQTH+cgPe9s20nCLfx+vxssmR1cJb+lM9WxbcOlcdSqvg==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr40371951plt.148.1549058889563;
        Fri, 01 Feb 2019 14:08:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [RFC net-next 04/13] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri,  1 Feb 2019 14:06:48 -0800
Message-Id: <20190201220657.30170-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
mlxsw_sp_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 0f4e68d31cc3..7c0df736587c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3442,6 +3442,26 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_port_attr_event(unsigned long event, struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
+					     port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = mlxsw_sp_port_attr_get(dev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 					     unsigned long event, void *ptr)
 {
@@ -3465,6 +3485,9 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

