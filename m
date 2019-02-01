Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E9C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6B218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grqUg/Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBAWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBAWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so3567493pgb.4;
        Fri, 01 Feb 2019 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tivljFOS893zZmUss1AVjf+i1kweQ2vQNLirRIESz1o=;
        b=grqUg/HuLwUO9b1Sjll2jaggLwu4Jh8KL9FlDzkr5JkdKC/QbEayWQQgTiOPC8Mrwo
         vlOlOLsxCHMlsNxfOfB6KWHsvFv6dzqvrN7nB59vdK0ixcmsfozpMuOZJ7zYM5Kd7a9M
         cZUKWtLQ/V9TnKBZctnE29cvSpFueo7IYMmltfDAD7iD1yHc/zLrHMvCPpVuY8DNbaza
         ifYcYOXo79jhtvLK+VpPaNaztdfZKGZC34MROPbx/FA32PeJoPGS7Hh9/RxYNKUWjWgj
         O6BY4AfCDvZXudJdX1Foj6/BIOeZQMGAXOHQdK0txUjZxWBeydhkmPKMaWKBY3rWZKfr
         h2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tivljFOS893zZmUss1AVjf+i1kweQ2vQNLirRIESz1o=;
        b=IBiMRxsHUJ08Ner+QggH9yamZnmJVWvV4DeDRzl84zjpllimGPRyIHtFSM+p5PwIYn
         pZ9rkME3vOt4hqZ15BcZxVWTOAk9609/BnQ7bmPLYuMrfbPsIgW+GDc9MefFo6R2+RMP
         t6MgLolISpHfWuxthoVNLrJx/I+CFgFn2mrEcd+43fQNaRUVYRe5iVfn5Bkbm2rFXtch
         /PXZhkgBHe/p/NTgVZ9+OYk49Wm4ruKwlVRYt2iAYY3oAbHnIiwPbEH4ke3ok9VfaJRu
         DmR7WW3h/++MldYXzGUBIHgZDHb5DIiSU2isTlp1OS1+OkvuutZlkNrzSjq1hrOo5i09
         w5cA==
X-Gm-Message-State: AHQUAubCE2dhT9FHZgwZo4nesGpVRbpJbIv229gTCop+8RTgd9eqnAIJ
        wk+vf/nTKu7uZlQYBHJt0oEwb7AH
X-Google-Smtp-Source: AHgI3IbR9i5uG9whlGG/K7jeaJuS+eNly5PVbFi97tkN8wsH7NnnJg+fW6pHwQwFWOht72h4fi/VmA==
X-Received: by 2002:a65:49c9:: with SMTP id t9mr3843831pgs.184.1549058892085;
        Fri, 01 Feb 2019 14:08:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:11 -0800 (PST)
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
Subject: [RFC net-next 05/13] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri,  1 Feb 2019 14:06:49 -0800
Message-Id: <20190201220657.30170-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
ocelot_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c6a575eb0ff5..8043347a1ed4 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1589,6 +1589,27 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = ocelot_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1607,6 +1628,9 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

