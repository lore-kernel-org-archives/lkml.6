Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76751C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA70222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5Txl0w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394194AbfBOWyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:54:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394098AbfBOWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so5522501pfe.1;
        Fri, 15 Feb 2019 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=s5Txl0w08kvB8rj/qhwE8TSWEgp5Pv+gpFpYiLq9AcCIsSRkIp7AGb227mXMKAmEvQ
         oEwl6VcefRBKfq/AONU9fLscQIEHODKVXT31KnnZU4wOpjJutyoqlnt7ir4MREEcM2zY
         757a2pxH49+RWT3hlwxCN/UOKaoUyKK3iNf0iSAl/TcW9Zruf7LW5UMsg5V+zopNdFCs
         Ge5z/WxPQQMOQ1Z3mCROh4RTMGnvNZWpKKQMXvfWw3mgjNcu/euCHtGhPZ6PtVvBkIVz
         W15vz7lS9lY8xt1oxpHAJeT+OszxemQQjKr2Ssbh1wHXLvFRS1L7aly2rQYc7u9r2SxQ
         a3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=i8K5llg7dvHsINVdD1aDR+t+inCtn3xgLeWpFmID5OYqokdXQV1xYYlkvaKXpnWxjg
         z/IlDSnbc2zuYLsukhY6WrWW7T9WEadRsIKQAUGMcRGi51Cdica4wAy05Vrg3JMbwPEA
         w+zKhhzGyBW77eiMN0W4rf9i5bPMnvXEI0O5OgaJafnlMCLygjHtvcP24jPGWCj0lBVs
         B2mMsr/pm1TXsZvR/reKzMnDjka3h2zzKaEkPg8BFtvVCGgA7BeMusROm7QfxcZCtKts
         AmoXur3uIQ57RK+X2Use/g8nufWBdDR1qNfOpZYQmim93/actWdWPzrC0lNLp9l6J2IS
         9xsQ==
X-Gm-Message-State: AHQUAuYYeV1p880hlrL1g9osZVTXJwCz4Ta+GW6zIn80Z5+MzfvuvKla
        u2SydMbtCiq8RvH0N/KwUqRphjrj
X-Google-Smtp-Source: AHgI3IYBfnsMDyH9khWQY2kSPHbFcDsEfonNacKv1F0B/vz+BQ1ns1JAgsYflwhgh3oJv7BKqvnZ/g==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr7188341pgc.22.1550271201323;
        Fri, 15 Feb 2019 14:53:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 2/9] net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
Date:   Fri, 15 Feb 2019 14:53:06 -0800
Message-Id: <20190215225313.32303-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing switchdev_port_attr_get(), introduce
PORT_PRE_BRIDGE_FLAGS which will be called through
switchdev_port_attr_set(), in the caller's context (possibly atomic) and
which must be checked by the switchdev driver in order to return whether
the operation is supported or not.

This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
except it goes through a set() instead of get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..de72b0a3867f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -46,6 +46,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -61,7 +62,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
-		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
+		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
 		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
-- 
2.17.1

