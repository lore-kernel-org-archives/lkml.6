Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D7BC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E520821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T47o4gfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBIAeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:34:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so2296979pgs.2;
        Fri, 08 Feb 2019 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5Wza09lwagQfRnQV7Xn0kooRaDHeJGguwZMzzJI+6A=;
        b=T47o4gfwg/6+cC3OGgZ7LtlEjV6SktjRZlUDR9DmAVjrkX9zaFY1yOTuvAA7BVORGx
         aBKsevRgz2je8/aT1K3P9wOHq0640eIJvNcDoKOvv0WeEmpqvpiT6RYE33QHM/lGdDJq
         udOYQ10hL4J8DMJn88fkPwfvui3u8r43GAWeWBiT0do2gdTi1fuwm66ifkK01Yqjaihi
         PtyxXu+hWeuQAoI7bBhf+HE0vJduszEs8nUsKPj96xGBu8yGZT/Rqd/6TQS1UeL37IqH
         2OsKpvUeUOecjaZlGOdkTR4F9DbgGPeFdh7gSE9hQbEDfGfw/6/UxlPECpdwCBy/xfpU
         izQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5Wza09lwagQfRnQV7Xn0kooRaDHeJGguwZMzzJI+6A=;
        b=ROce92J5mVCy/SbibgHk+MH3v81qERR6v0dKUfh81mc0LG2GtphUxIASWbQ27UoF2Z
         ZcABTcwGZClUQ5qr6ogWPbbsAdZvnbyLxStSBN0nLazLiVyxiXHzII0J7bTDN17PBMLy
         L29+xgtmIKwVkZG7Juknmfk5o0b7EjmhkQopJknPc+j9MCmvQYtXWju9drAYQlO2L50K
         kYSmb9J7kZRsmh44Enp5Sn2ZE221NrnUHUPQyciELaJq6Dupz7cGT04TXhZGO9BWw7oR
         inH3gtDt1Kt9sFQxAalbpOabTungowdAVd5hBgjpy8AhXLQ5v4Kme5Vw0HsKLFnK+8n2
         Egsg==
X-Gm-Message-State: AHQUAubZuilLhO5UWRSHBSkxqbz/1+f59wnovUjyPIKsfnKlo8W8WB0D
        NzpL7HEE1AONyf0bKWBTIA8SqVF1
X-Google-Smtp-Source: AHgI3IYu9kbP/iRDE2jquF6iFQihlteqUQfFY1Jfr2Ea0NhdO/lvE2zPuuYFZ2QcGuvkdNdnNET9xQ==
X-Received: by 2002:a62:5182:: with SMTP id f124mr15232899pfb.238.1549672449885;
        Fri, 08 Feb 2019 16:34:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:34:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 14/16] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:46 -0800
Message-Id: <20190209003248.31088-15-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b195b09e0d1d..d40bdcadd569 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1092,6 +1092,24 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = swdev_port_attr_set(netdev, port_attr_info->attr,
+					  port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1104,6 +1122,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

