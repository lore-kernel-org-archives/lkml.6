Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77731C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F9421B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUA1fDbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfBKTKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43499 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfBKTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so5500399plb.10;
        Mon, 11 Feb 2019 11:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bcLXrvybRxvEpRiDWi/DGfWF7hfDDl3K/0VgbGIyK88=;
        b=OUA1fDbKWOlIw6c+sWhOFHCM49ft0PxF5Fh7j/6krgbsrXP2V5Bi0pkEfrE8OBSkbB
         UpMWf+GXGgm6DBnt73I7sX4cpb28DRCmRUoqiT9b4Jk879+3mWJCEMg1jgToaAracHOJ
         0KQfVQ/nhHpqsStdlQiPFvwJ1A4OgE7V6Xu0wmc2RuEomd78io3O4Ha608P3pR8DfeGj
         VaBu1hXJ9LVf95/ClrRbDE+3iqq//vBFyleOIy07uxpTEGKAi2MW7H+25SNXb5SYYLuf
         0rtx1JUPUHMM0/mGmCJzBa0b6f8GnzkuSo2zfJJKpxn7RzlzaPDMo8IWkS5lp1b9JFZ9
         5Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bcLXrvybRxvEpRiDWi/DGfWF7hfDDl3K/0VgbGIyK88=;
        b=ik9puLNijiiwoOYoUsGHz5Ww6eGqUJPfJwef687ke0LQXX3kwPdw2mnsz+tEBFy+yY
         AcD0fQsg1kZajLreBR4AMcwlAiUmS6sC82dtsBrvKzmQuA+De//JgOJSDrTQ7agVIwQz
         +ltODo1AncCNHkd+kFEGv/QANZpoEQOlGXmAD15gmGhvcNBOXNEBf3+2GRFetTzyOAyZ
         L5QCI6T3nvFDDKtLTTnuZ2ZTN0ipI4IUXCxu/OycQZm9jpCvX46Q/9Gt3VLvjKOEq3QJ
         9pATQ57kukpcSohen/Jfkn++KApMQrgpSR1HX9HvoqXAHaO74U1dqmaTXrJEJSS6TnOa
         caXg==
X-Gm-Message-State: AHQUAubWMFqDgt0d3xCJdp+KCn2IgjGF8EYlel3lr/ekHOUZPzDB8+yt
        fCE6iytLYze13zZN8kg3+0LSfHL5
X-Google-Smtp-Source: AHgI3IafEEQYU+vr6b1WmVV/fyI6apUNCNhqFoyTzQa0MChwbbTiA2wCWPgVuOdFyInHPbXkoB7oNw==
X-Received: by 2002:a17:902:c23:: with SMTP id 32mr22750767pls.183.1549912239291;
        Mon, 11 Feb 2019 11:10:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 3/9] rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Mon, 11 Feb 2019 11:09:55 -0800
Message-Id: <20190211191001.8623-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
rocker_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..9a8fe49e32b6 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2835,6 +2835,27 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
+				 struct switchdev_notifier_port_attr_info
+				 *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = rocker_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = rocker_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2847,6 +2868,9 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

