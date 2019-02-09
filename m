Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C8C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95120821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klgiwKIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBIAd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43109 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so2429983pfk.10;
        Fri, 08 Feb 2019 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ozeBXy6nfKya+joDPY2gdugzbAN3jVvbagODiMNokh0=;
        b=klgiwKIWFHw1VM/2CKFY33/DFcmNInpNdmc7DDlEWfQoH0yq+9/TU0rydfVq6qDNwG
         hRupc095nNiXZzohGQu+r3fsthEfgtRMZvfqRbP/VKEscdORQ5uBpivVl6/mM4AVpqAE
         g9MD38L3tuFTprn43QSi9Golhc5mvpG72XX8ZleXgiIFFTwmABDsvonyrC7LpPyPfLw8
         5T5NLP7oqdKjzNSkTUK/PEGghNQbB6kjRE9JXjQ5oxngbBnygfJUfLdrjAK2MsCoIzLT
         IVQHhRUCLobpsiRGZ11Bj4kIW1BkUTBM59bO/6GwcK/CZpw2D+Q0oc+9OECqmGS2VQEx
         T0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ozeBXy6nfKya+joDPY2gdugzbAN3jVvbagODiMNokh0=;
        b=lUTarOfhhqd9w3dV4lg4/zAqR/aBtEXJNyIgYUHS5u1GWxAXFoTmGcQCIU4NyWWzCP
         qwlFzmSkiZn/66tRr4XgTVYvJ4yc7nRTYPqM4RavNR+ajbKuZpUuJh3jD2y2sX35s1CJ
         10o3ZtqglqwNj3k07VPk+9Sxzsls9XyUG+q8gZbc/uLj7Raxhdst0FAIbCRmlN2MFaIN
         WRx0VRqRmNzgD5sYZq4eQTdwVRbLYlK+fvX6bJGRMjOhSxAMC5SW7y0jz1tmr3RlXuyQ
         kwVxshpj1qkHugE3KXosFqpNITZ0XOrTAgf2kvJMhxTSSVUvk9Gg6HSFQpaxPUqWXFHj
         eLOw==
X-Gm-Message-State: AHQUAuZccxk69Q9fjEHLWmI/LKn+u/PkvGpqNLhpUblPPKyFWE3g1pN8
        lIZL22ESgaHuj5vmh2qYJqycNvqz
X-Google-Smtp-Source: AHgI3IYadV7dfMHNzKu4EOPuU+ej4yEOnRAkVnqTsTAyjr/E56Jdcv0AXF4K59ON0VYYHTTKv4nffg==
X-Received: by 2002:a63:6604:: with SMTP id a4mr23155030pgc.118.1549672432188;
        Fri, 08 Feb 2019 16:33:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 10/16] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:42 -0800
Message-Id: <20190209003248.31088-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
rocker_port_attr_set call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index ff3f14504f4f..f10e4888ecff 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2811,6 +2811,24 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
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
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2823,6 +2841,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

