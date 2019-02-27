Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B5E2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dns55YKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfB0Tpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0Tpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so8466673pgl.0;
        Wed, 27 Feb 2019 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXLoJyaM+nWCTir3dTIl2DNxp5dFc2q2mcYDzYeV1os=;
        b=dns55YKCRzYyoy2hsBXEqFX9J290fpHHmlIDVGXiDcC67CDj713/8vGWbG755liJCL
         PYALguwgIyDM7tNoP2IwgDWXeF4ToB6f6JdHlIzXSw+vY7sGFq8NAorQCnFBTzrufcST
         PeE0W1w74DLbOeIeNPesLAA1EM91P5sABSJLFn3JM5usz0L/p2SIVrD+Iob+MElWfCPg
         R3o+20DxEb9Ur9nMW1bD1vQ5Q5QC+2oJp7CDyo598v7gKUskQWJUGdN1zPgykXwhyH1+
         k47IraLMmzTXsXLITwTHz1y4x7qFqy6xNaxBZcmwr6yb5O1fZhGTHJczFESdRiQXCvEE
         Hylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXLoJyaM+nWCTir3dTIl2DNxp5dFc2q2mcYDzYeV1os=;
        b=OgrqoJMYBoCNAOsGrom+qbRZeYij0wtKRAccWu9kRWPNA1hoihnOylF1CqoejR9Uc7
         /Rk1fx+0lnn3RvkA55tk/IWOk67fJoVJ+X3j4AV8+Hsi0yS+chiPcFLCvI/s7FOgVQAg
         toADp9xkQ6gRiS/CvEN+bBlpamKT986S0avzriLh6Ev9fdbsh6sJanNm/Zl1AYp5v0Os
         sxRruJj/oMNcDRyIE3jmICATzJ1yUhXvUYaGE1wjlJwrejlzPSLA1MqsTA2GJm673gau
         YhIISYR/A9dWYQGFJfpLAAT6pspxJAQwkgEz9e4we5oW3ISPXckEgwinmE2tZ64leapt
         y93Q==
X-Gm-Message-State: AHQUAubKl81FnyhdRK6g2sGNsvffToQuCD1uLZ2XfqHamBURhiWBelYP
        6U155ins4pMdG+3PHBfwa9CjqywK
X-Google-Smtp-Source: AHgI3IbglK9ku9WIv0vZ87gr0QtMIst9Cxw+1A5c+GL50ro2FSv769baqDs/YA8r/nK+FJ6BfLOqwA==
X-Received: by 2002:a62:b608:: with SMTP id j8mr3437900pff.183.1551296732061;
        Wed, 27 Feb 2019 11:45:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 4/8] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Wed, 27 Feb 2019 11:44:28 -0800
Message-Id: <20190227194432.725-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
to handle stacking of devices.

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 766f5b5f1cf5..c1aedfea3a31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *br_dev;
 	int err;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (!br_dev)
@@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

