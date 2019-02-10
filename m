Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C81C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758320874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAKdtfqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBJRxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:44 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39784 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfBJRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so13893754otl.6;
        Sun, 10 Feb 2019 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HuMzAPZm6+87r82yhdOiGKCalKhABoswLiokllJuxQ=;
        b=FAKdtfqkzU6mcofBLDh/nrL7z0qgbYcuIx8tRoRxa3ramBXLMo73cuNaalSbYcBRcL
         MAiwUxIgr4LWhjJr5M+TX8dm6T+z8p4nCv4JwUgq6CmelZzqCACO+ToN0oR+YsqmD2MJ
         J+BO3C/loMWgryavP/TiEfRYdD6Ne8uVn0mO8ylOJx/erZIdAKmgMuFmcruAcBBuJJja
         mcARog7bNWQJY6SwRwurYweE3UeMjDBOobTkZQ9D2DOA/zraifN2Sbato6iB3Ro/n7AU
         r3Lg6IszkrmXuvNbLlLMOVqaMXNEbOrRgC49CvGcrxiMXCaP6WgMv7zbX+79sVqX7tby
         vgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HuMzAPZm6+87r82yhdOiGKCalKhABoswLiokllJuxQ=;
        b=noRuWhS67SZFl0E2Q9gW/eSb9UGrDZaIO4gUa1zkMr46k+v7AD3Cd4ZbjWP1Utmmb1
         UkzUBmhTHsahGeQkCqre6XbEdSrVaVJUpjgIR7hllzAKPnOuIV/kxAvoAen1P23VI7jT
         IUvNFMlYimfqagTVbCpiHY3L26sKk7iIFNdmqc7xKfsCftNb2H9tCZImf1glWGLnTJRI
         uE6Dqv2JuUG97TwVpCWzsks+SQucQg/CtAMrL95jU7diqb9YlvyQV/C9SsV+bvXaH0di
         NcJXGNEcOGHlO00gvCicNLTJm6kSSJkT0Zb17ozuAYMYK4QhQksLQMKvbRIlW6K4C1bH
         lmTA==
X-Gm-Message-State: AHQUAuappIKHHK9MITRqW/jvbxwGMMJP11/GonumcKqB05rquUZ7jwaj
        pmbWSFJCGkBV+BbOX6gkbbPb5UV+
X-Google-Smtp-Source: AHgI3IZZGCSgl9zk1qWx5a4yTVOkXFIwX6GRDfFlsB8DZak+alh4MI4N1M1fn5pYS8Vip9hWohW/8Q==
X-Received: by 2002:a9d:491e:: with SMTP id e30mr24800038otf.131.1549821219165;
        Sun, 10 Feb 2019 09:53:39 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 13/16] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:51:02 -0800
Message-Id: <20190210175105.31629-14-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
ocelot_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..1dda4dd4c073 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,20 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1614,8 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ocelot_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

