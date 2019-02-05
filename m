Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C112183E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xht0mrjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfBEX4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:56:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44879 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfBEXz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so2244520pfh.11;
        Tue, 05 Feb 2019 15:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+GrH69au9gNQJGXuWwx46YWKRJ0rC1zNpRUoiH8JEA4=;
        b=Xht0mrjE4RZAEbXqtwYN0fmdY53RfdD5GMo2Th5SBw7bGVGSXEwopYdOvJH6oEp79W
         rarYYkH3v579aqm9Mff9cR9L0hh8suaBaqBKddzu4gck+NVEpy1emZ29/qEFB2HpnD6z
         SO6JrjhDJwuBCcRhqYidd8ancjcebAyQuXCV5O40oOUZmlQYYpVJ0OpdPV+oqMw+uqel
         6IDSJqJwH0X9MBpsuLA7fvFaGp0nqjVmomRJz/AYoX5bG5/3KxsTX/4d1T2L6z5+TAVu
         nndDxCIAIvyyxqsFSg2EFNy9N23vG8nerQRGPJU3jrqibKjZ/+HhTmVW34Qxl5NEJPIN
         fQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+GrH69au9gNQJGXuWwx46YWKRJ0rC1zNpRUoiH8JEA4=;
        b=CEcxMn9PgLJFc07zBMza27UtzVDRr4aUfOE7zE+/PrHGPiGht5c+6DFiE+kzvZ/Gtb
         sjeVe+oi+V9OcxP1Vn70aB5b/cm0lceOhMkWfM5HvYFDdehX2ZLRkt9X/GevixOdGZ6S
         21/aO4g70y0X+Lm86H6GqqzIOdwbAQhBzPM0IfqAj1mtKwXx+BzCOT5A9DR30BiRtew1
         +AmyHwAnQessGZZrwbgNXXdnjT8Ck1ALh9KpArdCTc+Ecl+0T8zRuWLCTnoxYZH08XVZ
         0ebA7okQvcndQzQ6nRQ4NWLQcq6mqYn8GH7imd0T4xQ7S3QBgeSRQdzUHD1coAxvQ1YC
         kZ4w==
X-Gm-Message-State: AHQUAuZqfqqQqSBPCWvQVl0UAWNxZsx2iCRap1u+/bdmY3936OkEOV+9
        2z+zPZ1DJCnFjU/QxfqbGVGCjglk
X-Google-Smtp-Source: AHgI3Ibpv17asGSJmSPDerM9F44eWkUJgh09HCwLEeJ+tydJtoo7Ca1SxXphkytat78m96cczb+FzQ==
X-Received: by 2002:a63:1766:: with SMTP id 38mr2026377pgx.299.1549410958406;
        Tue, 05 Feb 2019 15:55:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v3 11/12] net: dsa: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:25 -0800
Message-Id: <20190205235326.14600-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSA implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 91de3a663226..70395a0ae52e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -362,18 +362,23 @@ static int dsa_slave_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static int dsa_slave_port_attr_get(struct net_device *dev,
-				   struct switchdev_attr *attr)
+static int dsa_slave_get_port_parent_id(struct net_device *dev,
+					struct netdev_phys_item_id *ppid)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_switch_tree *dst = ds->dst;
 
+	ppid->id_len = sizeof(dst->index);
+	memcpy(&ppid->id, &dst->index, ppid->id_len);
+
+	return 0;
+}
+
+static int dsa_slave_port_attr_get(struct net_device *dev,
+				   struct switchdev_attr *attr)
+{
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(dst->index);
-		memcpy(&attr->u.ppid.id, &dst->index, attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = 0;
 		break;
@@ -1046,6 +1051,7 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_phys_port_name	= dsa_slave_get_phys_port_name,
 	.ndo_setup_tc		= dsa_slave_setup_tc,
 	.ndo_get_stats64	= dsa_slave_get_stats64,
+	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-- 
2.17.1

