Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C26C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048F2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIH2QmCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfBZSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:46:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfBZSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so11692717ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3cbNscAmta6sWyhidSJIEH4Xvw9ViTv0Lvbf9jCIz4=;
        b=CIH2QmCCZCCs32qNTeyozptPDcP9BRXpEMVOjiLuUu3k8YFfSlZYZvS3DjcZCiF6PU
         VLBikrm6rnmhVevf1eqgvGfW5LIN3D2PfbRPKwZeNdgGu25YUA4JI3Gst2lzwvEnhhvp
         Mn9qYARtk1C3EAJncK9anGk2BO421bRs46Q2kCWvffs5U6VrAZ54VuiZY4JGPD4rUv0I
         4Ccc/2tSOjtjoMTmki9siTm/Ohtpf/xbLzfJYCbALe61AC8vvyvU1eEEbrzNaz4tFwXl
         Rz9LMYbNIykuJFCCKDRr3miheT8c5m+qqprnnrgIiXpYvhBTC0L4oF8FVW7nFQIC0s2u
         ausg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d3cbNscAmta6sWyhidSJIEH4Xvw9ViTv0Lvbf9jCIz4=;
        b=BSnkcccufTtGCKYK7rMN6q+uoh/q0c1W2gVROdKQkQwjirGEYG9zvWF5PVRBRzhubh
         0IaMfYNRolSc2F0w1w0zHopMkZDUoVp+dVK/y6eTCezh/WchE1cHuVyL3MBA7CnARWQF
         DJJg3E3anECFLLjE0pj0f+MqdFDyhBuhhZMGiLLAGOT6m8C1XebeKxoJ92B4yCZrjGyF
         SWieJWdgwlucJySm1wOJbl5VPwBAJqBPubJ6S4zVm7a9ovrkxAZAjqXWg6ZkY3PAR1TU
         AWj9COII9fhvgxoG9v5TiTowR1sCvwebOd5duc0YNP2cgfMCOMLEkPx0duF80N48QyQj
         6aQA==
X-Gm-Message-State: AHQUAuYgNYqj8JWoS0vYEU3CGvj0AYqx9i3afAKqmCceGWkLHyBsi7YD
        Z0I6OCnoG2ldwLRS6ox5EYLTWA==
X-Google-Smtp-Source: AHgI3IbnWE5M1mBdRq6irXftYOyuGKDcP+MkzG1oggdhZkp2SGSauOgxZ2bhHPYvpvd4D/72GmKU9A==
X-Received: by 2002:a2e:8949:: with SMTP id b9mr14427888ljk.173.1551206790534;
        Tue, 26 Feb 2019 10:46:30 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:30 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to addresses of uc and mc lists
Date:   Tue, 26 Feb 2019 20:45:52 +0200
Message-Id: <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update vlan mc and uc addresses with VID tag while propagating
addresses to lower devices, do this only if address is not synced.
It allows at end driver level to distinguish addresses belonging
to vlan devices.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h |  1 +
 net/8021q/vlan.h        |  2 ++
 net/8021q/vlan_core.c   | 13 +++++++++++++
 net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

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
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index c46daf09a501..f083c43c508f 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -6,6 +6,8 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/list.h>
 
+#define NET_8021Q_VID_TSIZE	2
+
 /* if this changes, algorithm will have to be reworked because this
  * depends on completely exhausting the VLAN identifier space.  Thus
  * it gives constant time look-up, but in many cases it wastes memory.
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index a313165e7a67..fe2ac64c13f8 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -454,6 +454,19 @@ bool vlan_uses_dev(const struct net_device *dev)
 }
 EXPORT_SYMBOL(vlan_uses_dev);
 
+u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
+{
+	u16 vid = 0;
+
+	if (dev->vid_len != NET_8021Q_VID_TSIZE)
+		return vid;
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
index 15293c2a5dd8..93d20b1f4916 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -249,6 +249,14 @@ void vlan_dev_get_realdev_name(const struct net_device *dev, char *result)
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
@@ -480,8 +488,26 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
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

