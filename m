Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A694222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pza6dnJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404666AbfBOWxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46519 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfBOWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5452206pgp.13;
        Fri, 15 Feb 2019 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2/1JGLjz3gI0i0km/VMbftbaECrLXWDDsdiVS5YC7k=;
        b=Pza6dnJZmj4HZD8QFkaW8X3wWci5bwclZAeF4EWR3Po9m2NBomOZP3HPj7WfsMdUjz
         W1nyIulcOWb9eEZvavsBcS2pR6lj0lyeHOTzsFgfS/XrGCYJyiit8+f3Fin+y9OvsrrC
         hVBGMjEdjqKOxbPfcaol2CJw4BzFOD2UMfnxn46hUybTn1guv1w+iU9KFCMQn5ZWSc1/
         vLuFIV3r97/F5emOVrrzcM+279Ts7olbXGIBqHsMTA9FY9gwU3Iue/viyiLwl1fGXbcL
         yfhgl2bnHw8NR3QBTrS6nkUpKWMpDYtDEaxzaFBCava3fhWZ2U1o3hyUk7r+O4ulqU52
         i+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2/1JGLjz3gI0i0km/VMbftbaECrLXWDDsdiVS5YC7k=;
        b=HB4WQE7idoZHgFALP4KSiW/47IhaFri2uIkHN0Itrn3p9QUe8ndCVrVDCyAYxv7TXA
         0lXsd8wUndr4NO2W++5JyEC/e2DrhSDna16dGkjOisjuDv2gCReIOLJAKtyqYywNjjZv
         tBG2614hufOTYBNdlEzU+BFseDifUQQCQjgSgNHCtVU2V9QGpBYyyOEUi+6v0XhsJ7zf
         sSWMC+wiiLKXQqPmYKEq2K4T6/U8kmXXg731S5IBSr07suHK3PyeebT/t9OfIcD7gtrS
         RczyHBNgrG8cqNQSw7lKSekbrVlNfPHkkQYvDRLrB72ceKe5+iJMxxv4lakBIVbOFIEW
         zbEw==
X-Gm-Message-State: AHQUAuZPSnAUZAtwv21uriPq98xkF3CIJ69591qiKi8V37w8fGXkAY2y
        ncCSBjM9O2gk+GmLA2yxt1i4I172
X-Google-Smtp-Source: AHgI3IYxSkOSYcOsWKJDcm/tKw3MDioGWTpIcvXOCQ+0KjW2QAh9PG3b+jDPJIO6IAnWE++VCiBs2A==
X-Received: by 2002:a63:1544:: with SMTP id 4mr7684735pgv.290.1550271204302;
        Fri, 15 Feb 2019 14:53:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 4/9] staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
Date:   Fri, 15 Feb 2019 14:53:08 -0800
Message-Id: <20190215225313.32303-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
handle the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute and check
that the bridge port flags being configured are supported.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..640fd6834be1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -666,6 +666,19 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 	return ethsw_port_set_stp_state(port_priv, state);
 }
 
+static int port_attr_br_flags_pre_set(struct net_device *netdev,
+				      struct switchdev_trans *trans,
+				      unsigned long flags)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (flags & ~(BR_LEARNING | BR_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
 				  unsigned long flags)
@@ -698,6 +711,10 @@ static int swdev_port_attr_set(struct net_device *netdev,
 		err = port_attr_stp_state_set(netdev, trans,
 					      attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = port_attr_br_flags_pre_set(netdev, trans,
+						 attr->u.brport_flags);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = port_attr_br_flags_set(netdev, trans,
 					     attr->u.brport_flags);
-- 
2.17.1

