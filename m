Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32BF21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVqy4Nkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfBKTKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44828 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfBKTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so5720220plq.11;
        Mon, 11 Feb 2019 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KF6AlsLZoN04sGHp2NFAD11lVXn/Fy4kJgdzP9H47YA=;
        b=uVqy4Nkvmt3Zd+BDUCRaRjJyPd3UW3yj9gXDuzghFhNImFuBE6egjrdFsKy87mlK2F
         kwpYWQM++R81qfhI/4V0qq5Pa3YbZduQr6WQE8dm5pCfTwetPj6a+hhUNqsfukLjC1pQ
         u7/V8AsYn4VxnD8BsnzWjP8C9bfH8Tm+JsIAnsIHpMkPcpGhsgrcFhFCd98Udov6Gm9Q
         EHkcWRRe0Chx0ZUsujD+UkWORgMJmzIHRWLgMdRAvzgsbTW4vWSOm/Cbk2wohPIU9NAr
         hIssQAGhcSEAsZ6rL39eVeiwGuKUIV6ELb6cJuHKQnKENVqiNZspJhEPKPkg6Nhf2/V7
         tjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KF6AlsLZoN04sGHp2NFAD11lVXn/Fy4kJgdzP9H47YA=;
        b=KKsyVnJ7ehbhc59IPZv8z6/PTDtobylStRnUuOc0QGe457TARipfNkrsk2jrxrO5WC
         /jMcGY7jaPbLLSt5drRLm2zMZu5OBQdAPle78pv7PwGaeuUTKdkr6mJeJsWX6FN16Jwx
         5iVx+GH6fZQ3Esz318rbVsPF/vdUE7XWgPWYxjeDZYNCo43mHuYi1XEtAYtvfb7L3pDZ
         PpGnp+Q2EdhA8fP6aTQeNpxOqnOYTUtfI/VRPE37pATZnmlNPwtB+vrQgoCPURfv/PYM
         Hpzo8ZysLNJJXO19uvKOtZjwoFikq8ROiWV2PpIw69+kFEovuAqzqKKmQpBY6BrI7VrO
         0icQ==
X-Gm-Message-State: AHQUAuYgijZfF2U7Y6wccSwgEEwaQ7OoOregH6HzyEumLtolLMqOoQSM
        oG4zpQtSJ28g9z7M4tv/AJknrrfn
X-Google-Smtp-Source: AHgI3Ibxos7bufAZTYDQyfYe9rJzA3QByVByFGfqC5P8tWwEsSiXvdJoSlEH0EFpCESeirH/XqjhvQ==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr39081096pls.259.1549912243989;
        Mon, 11 Feb 2019 11:10:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:43 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 4/9] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Mon, 11 Feb 2019 11:09:56 -0800
Message-Id: <20190211191001.8623-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
mlxsw_sp_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..88d4994309a7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3443,6 +3443,26 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
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
@@ -3466,6 +3486,9 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

