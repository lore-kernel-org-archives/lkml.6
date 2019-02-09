Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BEC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABCE21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH89cUZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBIAey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41732 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBIAds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id k15so2454778pls.8;
        Fri, 08 Feb 2019 16:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JhDTjxL1DiADnRINxWwGqeDyEJSQNB5R03NAiQttvxw=;
        b=TH89cUZ81+yuazGUKZhe2pJ3nQu6GyAnfvwRidjVxgZsMcfaQ3rbfpoNVAVbqXL07l
         /n45ffeRhMs8AqJxqBqYhKI1ZYmq0h9kgM5FOmeLMZ8So+qXj6hUTegn3d2N2VvQhQbK
         BnsB4sAzaxWDRX+LAK/z/fD6YrCJuUG7nOkD5bC4dGwTuAftPMZipVufeFjd/Ohyn9Cf
         UCaII5KQ8k031GvIsg4/kKG10oBvhF54kh42IiFCZMwGpuhZ+r2+Rb3MZMAixWWkOOnp
         CQs+P1j9MTVummWS2mRJbNjiMbgN4er8xvKP4MF6YTBrBiRw5j8rEqUTKxIn1chfkL2V
         Q3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JhDTjxL1DiADnRINxWwGqeDyEJSQNB5R03NAiQttvxw=;
        b=dp2Gcj8M93m/gBdSuUkmWQ6kVHgzaXbn1H+KoaQshETbT7KKzEp6Z9R414s+T2GkMN
         vI5afhSdm1P6UTF9EdaZq13hZ5TvcxKQ79PMyb4bmtufX/U2eJO6hrZryGET54dzLfjT
         8JSlL9fDJoUcxLsRH1SKSstjEviXeUT3544akCZX9KbBoRqDw4EIud/ABrX9R+9+DF+l
         +lif3LII8Nz95bhhnwxKIFKNf6ZMOzV5ON2I8galLzkAp3dFJ6IIG9R4+wPKrsOQPuPU
         py9zbN/oGM53hSg+/l0u8DnnNPn0ZY8YCtfSNzqTCui9c4bMOJIeS2PfZVxysJk+P5+t
         76XQ==
X-Gm-Message-State: AHQUAua47So2sCPn7JMpi7YrWbsJOZvdAnBNlLzTnJH8FOXWbwE5YRyG
        SD2MRmb6CAnroRd3h6iOUfGre8g+
X-Google-Smtp-Source: AHgI3IbgtcPaxQrR7IRXwjbD5hp1P1nlyN60yyrJgb56PlEKa90H3Yi7+uQi6K88UnrahkGeEWQnlQ==
X-Received: by 2002:a17:902:241:: with SMTP id 59mr25339500plc.72.1549672427617;
        Fri, 08 Feb 2019 16:33:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 09/16] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:41 -0800
Message-Id: <20190209003248.31088-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 96cd3e795f7f..4c5f7e5430cf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -141,6 +141,8 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -163,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.17.1

