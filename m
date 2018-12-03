Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F41C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47C32146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dl7feYKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47C32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLCSlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:41:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38451 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLCSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so9954235lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1E86stckhUJo7da4us/DFsrz1EGMsvbFJsbqAY8mK7A=;
        b=dl7feYKdeaM+O8AnqZ1Nb8PutI4XBUzUWe4OjNJU5cMiolmF+HMTsuIN1Uq31gspUz
         gPV/Biqk8jkzwkmvEY9Q3zx1bSs1akAQsFoxcBrJDyPZUpaJ+eUQHE34EY/q8Dr75G0L
         zz6r4pHOzUT6eYSKQkTQz61/xglQ8c13Wfb9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1E86stckhUJo7da4us/DFsrz1EGMsvbFJsbqAY8mK7A=;
        b=BmQmobXMtXxOS5Mee+QoeXEOgzATTDCs+9lTObA8+zgIWXTK0+v8UTciPQ4XZgAX5d
         xMizf4JAWIrRWZsWHui/Swa48EZlssAbIpw/txPbRRr0xqImHhkVunfW2jfNAYXZoC4F
         3pXanM9U26eqfd8am33DLOdWZSyDG/+ELPL9/JjGn/m94JZe2V9BYoRRQHqN5ZmN7J0d
         fQ9uH2e3LPk6Kt8VDgcsni7FQ5R+4/RpWFVn32Hsc8TcJly29X49zz1CPcus6F8iCSHX
         HvyoJPobHI5MM9h5aabfO9VpDKJLYf6SpQCUklAon18bmoWp70X3sgzxK5XXwCAVbdso
         mh+Q==
X-Gm-Message-State: AA+aEWbTVH3DKcOk9Xtz26iLrZ/+3UoPFIFcWOw91OABEEbvsCw0vLtX
        2hHa/8UxN7H/rzZidloQuWSskQ==
X-Google-Smtp-Source: AFSGD/V9o/EnPu/jS21sRLzC9rVzv3Ae9fU+4D6Ndx+QLN4B5fnprorFaxpOIqfwIKVJdvRIR9dkNQ==
X-Received: by 2002:a19:f510:: with SMTP id j16mr9345394lfb.35.1543862430451;
        Mon, 03 Dec 2018 10:40:30 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:29 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc and mc address lists
Date:   Mon,  3 Dec 2018 20:40:20 +0200
Message-Id: <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update vlan mc and uc addresses with VID tag while propagating address
set to lower devices, do this only if address is not synched. It allows
on end driver level to distinguish address belonging to vlans.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h |  1 +
 net/8021q/vlan_core.c   | 10 ++++++++++
 net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4cca4da7a6de..94657f3c483a 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -136,6 +136,7 @@ extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
 extern int vlan_for_each(struct net_device *dev,
 			 int (*action)(struct net_device *dev, int vid,
 				       void *arg), void *arg);
+extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
 extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
 extern u16 vlan_dev_vlan_id(const struct net_device *dev);
 extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index a313165e7a67..5d17947d6988 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -454,6 +454,16 @@ bool vlan_uses_dev(const struct net_device *dev)
 }
 EXPORT_SYMBOL(vlan_uses_dev);
 
+u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
+{
+	u16 vid = 0;
+
+	vid = addr[dev->addr_len];
+	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
+	return vid;
+}
+EXPORT_SYMBOL(vlan_dev_get_addr_vid);
+
 static struct sk_buff *vlan_gro_receive(struct list_head *head,
 					struct sk_buff *skb)
 {
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b2d9c8f27cd7..c05b313314b7 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -250,6 +250,14 @@ void vlan_dev_get_realdev_name(const struct net_device *dev, char *result)
 	strncpy(result, vlan_dev_priv(dev)->real_dev->name, 23);
 }
 
+static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
+{
+	u16 vid = vlan_dev_vlan_id(vlan_dev);
+
+	addr[vlan_dev->addr_len] = vid & 0xff;
+	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
+}
+
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev)
 {
@@ -481,8 +489,26 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 	}
 }
 
+static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
+	struct netdev_hw_addr *ha;
+
+	if (!real_dev->vid_len)
+		return;
+
+	netdev_for_each_mc_addr(ha, vlan_dev)
+		if (!ha->sync_cnt)
+			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
+
+	netdev_for_each_uc_addr(ha, vlan_dev)
+		if (!ha->sync_cnt)
+			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
+}
+
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
 {
+	vlan_dev_align_addr_vid(vlan_dev);
 	dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
 	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
 }
-- 
2.17.1

