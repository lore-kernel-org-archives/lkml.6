Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD3C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9779214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQjm4358"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9779214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLCSkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:40:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34274 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeLCSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so12395724ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMUy68ozbX3Wxgvgf/jAbwoq/KidBtnHdd2vBeUgHpA=;
        b=LQjm4358MjGTaaGg//Tuy/jwJ+OddA7BeHOLQ8fFAOX1ze4lUXIJIv4tU3EEqSSils
         N9vIzcTBnZ1SSsiMtHZAT4RPM9u2qUVc91TSXADw8AI/XLVDgzb5yBk8+bkI897OFAvb
         U9MV+A7+OpoeHtwnvfvNclTFr/4hfMYyWahEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AMUy68ozbX3Wxgvgf/jAbwoq/KidBtnHdd2vBeUgHpA=;
        b=q1tBGDcgmaTUnuStpfCoVjQdfFjzxYQLn4yDcIzkRPPE9oyv6lbf6RrpojmpDQyQFr
         pWpOh15FgAb6wiq2frvqfI9Wj4zgFgzWlhGxz3Us8Gued4bbMtZsv8y7gUAauWJjYHmA
         poUofCrT30RB+jqfuXdMHla+bIaVXNrFUS8XarLpYetqgwVJoHqAKpfPLiVmD7u8Z3qn
         x7hKGIZBsUBBaZaaN5MAYwrkdEUZEKJuHzhgmwhhSGQ+GSTK/1IhU91F1mfu7E/xRdCR
         4/lESLKjur0p5ZDR4FOPog7v7JejXlKzloBIVwPZi+8qELAGMmvzgLLY6eqxn3urDclU
         RjUQ==
X-Gm-Message-State: AA+aEWZ11HEJyDUACmC1NAW+qmmSpBHrORuWp0KvTlZiOFf0gSQlbZvh
        u9NnJjaT9l2UViO5gJFGOZLLdg==
X-Google-Smtp-Source: AFSGD/U4vMd8Cmf2BwsYaRjQNLCQAA7f2Kbr1+VQV0mFCRi1BTEnY/4+oh1GRreoyAnU9BiFAzflGw==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr169890ljc.84.1543862428988;
        Mon, 03 Dec 2018 10:40:28 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:28 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 1/5] net: core: dev_addr_lists: add VID to device address space
Date:   Mon,  3 Dec 2018 20:40:19 +0200
Message-Id: <20181203184023.3430-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds VID tag at the end of each address. For Ethernet
addresses with 6 bytes long, when actual reserved address size is
32 bytes, that's possible to add tag w/o increasing maximum address
length. Thus each address for the case has 32 - 6 = 26 bytes to hold
additional info, say VID for virtual device address.

Therefore, when addresses are synched to the address list of parent
device the address list of latter can contain separate addresses for
virtual devices. It allows contain separate address tables for virtual
devices if they present and vlan be placed on any place of device
chain as the address is propagated to to the end real device thru
*_sync APIs.

If parent device doesn't want to have virtual addresses in its address
space the vid_len has to be 0, thus its address space is "shrunk" to
the state as before this patch.

The end real device, if it's allowed, can retrieve VID tag from an
address and set it for given vlan only. By default vid 0 is used
for real devices to distinguish it from virtual addresses (0xffff
should be used, but for RFC is Ok). Similar approach can be used for
passing additional information for virtual devices as allmulti flag
or/and promisc flag, but this is separate story and could be added
as a continuation.

See next patches to see how it works.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h |   5 ++
 net/core/dev_addr_lists.c | 124 +++++++++++++++++++++++++++++++-------
 2 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 94fb2e12f117..1b0f9c322b01 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1635,6 +1635,8 @@ enum netdev_priv_flags {
  * 	@perm_addr:		Permanent hw address
  * 	@addr_assign_type:	Hw address assignment type
  * 	@addr_len:		Hardware address length
+ *	@vid_len:		Virtual ID length, set only if virtual address
+ *				filtering is supported
  *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
@@ -1864,6 +1866,7 @@ struct net_device {
 	unsigned char		perm_addr[MAX_ADDR_LEN];
 	unsigned char		addr_assign_type;
 	unsigned char		addr_len;
+	unsigned char		vid_len;
 	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;
 	unsigned short          dev_port;
@@ -4092,8 +4095,10 @@ int dev_addr_init(struct net_device *dev);
 
 /* Functions used for unicast addresses handling */
 int dev_uc_add(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
 int dev_uc_del(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
 int dev_uc_sync(struct net_device *to, struct net_device *from);
 int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
 void dev_uc_unsync(struct net_device *to, struct net_device *from);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 81a8cd4ea3bd..82c9c347f338 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -542,6 +542,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
 }
 EXPORT_SYMBOL(dev_addr_del);
 
+static int get_addr_len(struct net_device *dev)
+{
+	return dev->addr_len + dev->vid_len;
+}
+
+static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
+			unsigned char *naddr)
+{
+	int i;
+
+	if (!dev->vid_len)
+		return dev->addr_len;
+
+	memcpy(naddr, addr, dev->addr_len);
+	for (i = 0; i < dev->vid_len; i++)
+		naddr[dev->addr_len + i] = 0;
+
+	return get_addr_len(dev);
+}
+
 /*
  * Unicast list handling functions
  */
@@ -553,18 +573,22 @@ EXPORT_SYMBOL(dev_addr_del);
  */
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->uc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_UNICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->uc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_UNICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -575,47 +599,89 @@ int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 EXPORT_SYMBOL(dev_uc_add_excl);
 
 /**
- *	dev_uc_add - Add a secondary unicast address
+ *	dev_vid_uc_add - Add a secondary unicast address with tag
  *	@dev: device
- *	@addr: address to add
+ *	@addr: address to add, includes vid tag already
  *
  *	Add a secondary unicast address to the device or increase
  *	the reference count if it already exists.
  */
-int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_add(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_add);
+
+/**
+ *	dev_uc_add - Add a secondary unicast address
+ *	@dev: device
+ *	@addr: address to add
+ *
+ *	Add a secondary unicast address to the device or increase
+ *	the reference count if it already exists.
+ */
+int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_add(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_add);
 
 /**
  *	dev_uc_del - Release secondary unicast address.
  *	@dev: device
- *	@addr: address to delete
+ *	@addr: address to delete, includes vid tag already
  *
  *	Release reference to a secondary unicast address and remove it
  *	from the device if the reference count drops to zero.
  */
-int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_del(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_del);
+
+/**
+ *	dev_uc_del - Release secondary unicast address.
+ *	@dev: device
+ *	@addr: address to delete
+ *
+ *	Release reference to a secondary unicast address and remove it
+ *	from the device if the reference count drops to zero.
+ */
+int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_del(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_del);
 
 /**
@@ -639,7 +705,7 @@ int dev_uc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -669,7 +735,7 @@ int dev_uc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -693,7 +759,7 @@ void dev_uc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->uc, &from->uc, to->addr_len);
+	__hw_addr_unsync(&to->uc, &from->uc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
@@ -737,18 +803,22 @@ EXPORT_SYMBOL(dev_uc_init);
  */
 int dev_mc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->mc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_MULTICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->mc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_MULTICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -761,10 +831,14 @@ EXPORT_SYMBOL(dev_mc_add_excl);
 static int __dev_mc_add(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_add_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false, 0);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -801,10 +875,14 @@ EXPORT_SYMBOL(dev_mc_add_global);
 static int __dev_mc_del(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_del_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -860,7 +938,7 @@ int dev_mc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -890,7 +968,7 @@ int dev_mc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -914,7 +992,7 @@ void dev_mc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->mc, &from->mc, to->addr_len);
+	__hw_addr_unsync(&to->mc, &from->mc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
-- 
2.17.1

