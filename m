Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CF721852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyW6Njck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfBZSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:46:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbfBZSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id d24so11436863ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qB7J+KCADCQzZLQm80I7bfN1GrVDWJdsN+dYvepcy/4=;
        b=JyW6NjckmfTIek2crj1TZFYSEWIWmDKBFP8RbxlN+YSoxxhE4TDRGon3l5dfEJ54lo
         nocr1m6QLAeTaKuCI+0mX3zlacFZ1WFTAu7aB1v0uruTvz8YsLbwHKGTKKJSe0O/17yn
         5wJW31P1WyW7hhzWPdK+k2/iSpbgNhk2cyVioYnOqAg5aW3O+J74PZ8MnvEEjyP5ged8
         VgD0wa5Mjf9LYrkvOd/ISQqgkv6/+snyuN2p2TARZCI9ocTpQtFh7a0uMC626EZ5NZjV
         EzoUY9Zj96PUDO0dz4IHjZge6uo4A28X253NiNYhsvv7eEEKqN/qGkN3a1+gXtkbzzKb
         WWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qB7J+KCADCQzZLQm80I7bfN1GrVDWJdsN+dYvepcy/4=;
        b=hVbDhzeJuP+IVjvxbPUj82SAOQUHRg2gNgX+BgzHrrx0WRfjeOA37MwUs/veqiijoo
         Pvps7Ut/vL8MsPYbOg3A2pzkU+7CF2Ku/qiBAfHzp38CJD2XnM9HIu13IC7zECmyHwmd
         8S7055Y3SisZCdp9h4AODtUjHd2A+239OemjmAxKMr0xkaFm/v99CeZEiqcsAaKqk0lu
         BB6DD2kz10kUmVonu6o0YhJ+6rdqDjmpzrxFPcEKH9XzGR4eV81qS4DJPPL7mAkwfZ9H
         voaYFVtl+k8k1xNrSedD1yiih0vQU8ufjEYkLDSnKcxPrAKKhDs9ytgI5oXEutqvn+jO
         OKsQ==
X-Gm-Message-State: AHQUAuYeydcZpdxLkuiZRQ0GdVhwiwvnljxlZBq+SJqxWf8UvZbLFwim
        qCEc3H06oh1HI58CW58neP++Uw==
X-Google-Smtp-Source: AHgI3IYUeZthj+h1pUyn18jFgcqE+0skY/3PJmOKzRMjBKod5zboSkzIE1G7MMn8JbAsyXkPpMXxKg==
X-Received: by 2002:a2e:6309:: with SMTP id x9mr13764811ljb.75.1551206792934;
        Tue, 26 Feb 2019 10:46:32 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:32 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 4/6] ethernet: eth: add default vid len for all ehternet kind devices
Date:   Tue, 26 Feb 2019 20:45:54 +0200
Message-Id: <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IVDF - individual virtual device filtering. Allows to set per vlan
l2 address filters on end real network device (for unicast and for
multicast) and drop redundant not expected packet income.

If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
applied, and only for ethernet network devices.

By default every ethernet netdev needs vid len = 2 bytes to be able to
hold up to 4096 vids. So set it for every eth device to be correct,
except vlan devs.

In order to shrink all addresses of devices above vlan, the vid_len
for vlan dev = 0, as result all suckers sync their addresses to common
base not taking in to account vid part (vid_len of "to" devices is
important only). And only vlan device is the source of addresses with
actual its vid set, propagating it to parent devices while rx_mode().

Also, don't bother those ethernet devices that at this moment are not
moved to vlan addressing scheme, so while end ethernet device is
created - set vid_len to 0, thus, while syncing, its address space is
concatenated to one dimensional like usual, and who needs IVDF - set
it to NET_8021Q_VID_TSIZE.

There is another decision - is to inherit vid_len or some feature flag
from end root device in order to all upper devices have vlan extended
address space only if exact end real device have such capability. But
I didn't, because it requires more changes and probably I'm not
familiar with all places where it should be inherited, I would
appreciate if someone can guid where it's applicable, then it could
become a little bit more limited.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h |  1 +
 net/8021q/Kconfig       | 12 ++++++++++++
 net/8021q/vlan_core.c   | 12 ++++++++++++
 net/8021q/vlan_dev.c    |  1 +
 net/ethernet/eth.c      | 10 ++++++++--
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 94657f3c483a..9c914b31d208 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -137,6 +137,7 @@ extern int vlan_for_each(struct net_device *dev,
 			 int (*action)(struct net_device *dev, int vid,
 				       void *arg), void *arg);
 extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
+extern void vlan_dev_ivdf_set(struct net_device *dev, int enable);
 extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
 extern u16 vlan_dev_vlan_id(const struct net_device *dev);
 extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
diff --git a/net/8021q/Kconfig b/net/8021q/Kconfig
index 42320180967f..3e843045739c 100644
--- a/net/8021q/Kconfig
+++ b/net/8021q/Kconfig
@@ -38,3 +38,15 @@ config VLAN_8021Q_MVRP
 	  supersedes GVRP and is not backwards-compatible.
 
 	  If unsure, say N.
+
+config VLAN_8021Q_IVDF
+	bool "IVDF (Individual Virtual Device Filtering) support"
+	depends on VLAN_8021Q
+	help
+	  Select this to enable IVDF addressing scheme support. IVDF is used
+	  for automatic propagation of registered VLANs addresses to real end
+	  devices. If no device supporting IVDF then disable this as it can
+	  consume some memory in configuration with complex network device
+	  structures to hold vlan addresses.
+
+	  If unsure, say N.
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index fe2ac64c13f8..310b6cd39f22 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -454,6 +454,18 @@ bool vlan_uses_dev(const struct net_device *dev)
 }
 EXPORT_SYMBOL(vlan_uses_dev);
 
+void vlan_dev_ivdf_set(struct net_device *dev, int enable)
+{
+#ifdef CONFIG_VLAN_8021Q_IVDF
+	if (enable) {
+		dev->vid_len = NET_8021Q_VID_TSIZE;
+		return;
+	}
+#endif
+	dev->vid_len = 0;
+}
+EXPORT_SYMBOL(vlan_dev_ivdf_set);
+
 u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
 {
 	u16 vid = 0;
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 634436e780f1..e4120aca4b9b 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -896,5 +896,6 @@ void vlan_setup(struct net_device *dev)
 	dev->min_mtu		= 0;
 	dev->max_mtu		= ETH_MAX_MTU;
 
+	vlan_dev_ivdf_set(dev, 0);
 	eth_zero_addr(dev->broadcast);
 }
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index f7a3d7a171c7..95497cac24eb 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -381,6 +381,7 @@ void ether_setup(struct net_device *dev)
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	dev->priv_flags		|= IFF_TX_SKB_SHARING;
 
+	vlan_dev_ivdf_set(dev, 1);
 	eth_broadcast_addr(dev->broadcast);
 
 }
@@ -404,8 +405,13 @@ EXPORT_SYMBOL(ether_setup);
 struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
 				      unsigned int rxqs)
 {
-	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
-				ether_setup, txqs, rxqs);
+	struct net_device *dev;
+
+	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
+			       ether_setup, txqs, rxqs);
+
+	vlan_dev_ivdf_set(dev, 0);
+	return dev;
 }
 EXPORT_SYMBOL(alloc_etherdev_mqs);
 
-- 
2.17.1

