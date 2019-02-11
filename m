Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0491121B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spoQsBYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfBKTK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37967 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfBKTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3932pfi.5;
        Mon, 11 Feb 2019 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PtphDvmR0qKeN+UBu36HCt3kNK/VogT0oyGt8UI1w80=;
        b=spoQsBYLruAe2gNmZRBItcN0oBivyr230rVfYZef/4xvMbtFpvaXVMAExm23wgPjBb
         xaDR0Cds6Oir/q543dy+ipROwGpyQVbzhKEb0X0lGkd8anKb4DILSpbj3S/HtHO+1lyU
         1tuX1SiZdXw/flJUVgymW2hj80PRENHW2afbomAb+h3o2chkqtxkxYGDd2BSa9mguiNg
         ApMUNKE5oMhNb9RUaCXvbLVZMCaufsMn2EUqgMVtbiFN0Pv6kAg/Yd4T0sNsM7it1rYx
         O4ARjF6WzumFJdLbv7WJhIeZCmd9pgntejakNtJyZcYU3BW8V6iIJ/OLz5SsvYmOU6ey
         bvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PtphDvmR0qKeN+UBu36HCt3kNK/VogT0oyGt8UI1w80=;
        b=i+wnPWxv/e3Wu/pw1U4gcdMyuipq2GQdJkBk7/VVtM9O+Mu+iwZyUjXGE+qNtm1Qmo
         yQ+NlFAeT//eJsTEZNQqSFXYZe3QRU4kNy1xeTkphNr0KIevoGVj7hmMkbVSFeCD71w7
         J8uWXX99oCgUbSLGXHnPhaU8SHJnYAnBHlU9FqAxAVOObX2YSPJT3IpOPSWvfQNbctkQ
         rBHfskgB6wB3Dl11tsQp1qWbtfvZXp9jLxWz4VTLamV+eQ07h6raW7HrnbMOTzK+5BFW
         EdNkJS68fq81fRRcdtN3xqfXB8wsUKsazirrYtkkMf2jHJB3E4RUKaXlX8Y9S9c4Ac5r
         4wVA==
X-Gm-Message-State: AHQUAuZSWlWFMX5a9Nn2c7demIz08sHgMlBY74P5S6KiHcIefcGkmYAl
        ioGFeJRicceaAp06Yi0tnzV9Fu+z
X-Google-Smtp-Source: AHgI3IZiDFGGoA6/CFFNyBEGs+nk4D0ltjldTClH6j/AfwsjfEVXKPb8Pr+uDdMTLUiMkMeEu0fBgw==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr3409661pgb.393.1549912253454;
        Mon, 11 Feb 2019 11:10:53 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:52 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 6/9] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Mon, 11 Feb 2019 11:09:58 -0800
Message-Id: <20190211191001.8623-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
swdev_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..7c77fb43233e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1111,6 +1111,27 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
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
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = swdev_port_attr_get(netdev, port_attr_info->attr);
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
@@ -1123,6 +1144,9 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return ethsw_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

