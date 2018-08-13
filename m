Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33199C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE7A21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE7A21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeHMFpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:45:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbeHMFpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F37FF40241C5;
        Mon, 13 Aug 2018 03:05:28 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 410A92156712;
        Mon, 13 Aug 2018 03:05:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 2/5] net: core: introduce XDP rx handler
Date:   Mon, 13 Aug 2018 11:05:10 +0800
Message-Id: <1534129513-4845-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
References: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 03:05:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 03:05:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to introduce XDP rx handler. This will be used by
stacked device that depends on rx handler for having a fast packet
processing path based on XDP.

This idea is simple, when XDP program returns XDP_PASS, instead of
building skb immediately, driver will call xdp_do_pass() to check
whether or not there's a XDP rx handler, if yes, it will pass XDP
buffer to XDP rx handler first.

There are two main tasks for XDP rx handler, the first is check
whether or not the setup or packet could be processed through XDP buff
directly. The second task is to run XDP program. An XDP rx handler can
return several different results which was defined by enum
rx_xdp_handler_result_t:

RX_XDP_HANDLER_CONSUMED: This means the XDP buff were consumed.
RX_XDP_HANDLER_DROP: This means XDP rx handler ask to drop the packet.
RX_XDP_HANDLER_PASS_FALLBACK: This means XDP rx handler can not
process the packet (e.g cloning), and we need to fall back to normal
skb path to deal with the packet.

Consider we have the following configuration, Level 0 device which has
a rx handler for Level 1 device which has a rx handler for L2 device.

L2 device
    |
L1 device
    |
L0 device

With the help of XDP rx handler, we can attach XDP program on each of
the layer or even run native XDP handler for L2 without XDP prog
attached to L1 device:

(XDP prog for L2 device)
    |
L2 XDP rx handler for L1
    |
(XDP prog for L1 device)
    |
L1 XDP rx hanlder for L0
    |
XDP prog for L0 device

It works like: When the XDP program for L0 device returns XDP_PASS, we
will first try to check and pass XDP buff to its XDP rx handler if
there's one. Then the L1 XDP rx handler will be called and to run XDP
program for L1. When L1 XDP program returns XDP_PASS or there's no XDP
program attached to L1, we will try to call xdp_do_pass() to pass it
to XDP rx hanlder for L1. Then XDP buff will be passed to L2 XDP rx
handler etc. And it will try to run L2 XDP program if any. And if
there's no L2 XDP program or XDP program returns XDP_PASS. The handler
usually will build skb and call netif_rx() for a local receive. If any
of the XDP rx handlers returns XDP_RX_HANDLER_FALLBACK, the code will
return to L0 device and L0 device will try to build skb and go through
normal rx handler path for skb.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/filter.h    |  1 +
 include/linux/netdevice.h | 12 ++++++++++++
 net/core/dev.c            | 29 +++++++++++++++++++++++++++++
 net/core/filter.c         | 28 ++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index c73dd73..7cc8e69 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -791,6 +791,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
 		    struct bpf_prog *prog);
+rx_handler_result_t xdp_do_pass(struct xdp_buff *xdp);
 void xdp_do_flush_map(void);
 
 void bpf_warn_invalid_xdp_action(u32 act);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 282e2e9..21f0a9e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -421,6 +421,14 @@ enum rx_handler_result {
 typedef enum rx_handler_result rx_handler_result_t;
 typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
 
+enum rx_xdp_handler_result {
+	RX_XDP_HANDLER_CONSUMED,
+	RX_XDP_HANDLER_DROP,
+	RX_XDP_HANDLER_FALLBACK,
+};
+typedef enum rx_xdp_handler_result rx_xdp_handler_result_t;
+typedef rx_xdp_handler_result_t rx_xdp_handler_func_t(struct net_device *dev,
+						      struct xdp_buff *xdp);
 void __napi_schedule(struct napi_struct *n);
 void __napi_schedule_irqoff(struct napi_struct *n);
 
@@ -1898,6 +1906,7 @@ struct net_device {
 	struct bpf_prog __rcu	*xdp_prog;
 	unsigned long		gro_flush_timeout;
 	rx_handler_func_t __rcu	*rx_handler;
+	rx_xdp_handler_func_t __rcu *rx_xdp_handler;
 	void __rcu		*rx_handler_data;
 
 #ifdef CONFIG_NET_CLS_ACT
@@ -3530,7 +3539,10 @@ bool netdev_is_rx_handler_busy(struct net_device *dev);
 int netdev_rx_handler_register(struct net_device *dev,
 			       rx_handler_func_t *rx_handler,
 			       void *rx_handler_data);
+int netdev_rx_xdp_handler_register(struct net_device *dev,
+				   rx_xdp_handler_func_t *rx_xdp_handler);
 void netdev_rx_handler_unregister(struct net_device *dev);
+void netdev_rx_xdp_handler_unregister(struct net_device *dev);
 
 bool dev_valid_name(const char *name);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
diff --git a/net/core/dev.c b/net/core/dev.c
index a77ce08..b4e8949 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4638,6 +4638,12 @@ bool netdev_is_rx_handler_busy(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(netdev_is_rx_handler_busy);
 
+static bool netdev_is_rx_xdp_handler_busy(struct net_device *dev)
+{
+	ASSERT_RTNL();
+	return dev && rtnl_dereference(dev->rx_xdp_handler);
+}
+
 /**
  *	netdev_rx_handler_register - register receive handler
  *	@dev: device to register a handler for
@@ -4670,6 +4676,22 @@ int netdev_rx_handler_register(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(netdev_rx_handler_register);
 
+int netdev_rx_xdp_handler_register(struct net_device *dev,
+				   rx_xdp_handler_func_t *rx_xdp_handler)
+{
+	if (netdev_is_rx_xdp_handler_busy(dev))
+		return -EBUSY;
+
+	if (dev->priv_flags & IFF_NO_RX_HANDLER)
+		return -EINVAL;
+
+	rcu_assign_pointer(dev->rx_xdp_handler, rx_xdp_handler);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(netdev_rx_xdp_handler_register);
+
+
 /**
  *	netdev_rx_handler_unregister - unregister receive handler
  *	@dev: device to unregister a handler from
@@ -4692,6 +4714,13 @@ void netdev_rx_handler_unregister(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(netdev_rx_handler_unregister);
 
+void netdev_rx_xdp_handler_unregister(struct net_device *dev)
+{
+	ASSERT_RTNL();
+	RCU_INIT_POINTER(dev->rx_xdp_handler, NULL);
+}
+EXPORT_SYMBOL_GPL(netdev_rx_xdp_handler_unregister);
+
 /*
  * Limit the use of PFMEMALLOC reserves to those protocols that implement
  * the special handling of PFMEMALLOC skbs.
diff --git a/net/core/filter.c b/net/core/filter.c
index 587bbfb..9ea3797 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3312,6 +3312,34 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 }
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
+rx_handler_result_t xdp_do_pass(struct xdp_buff *xdp)
+{
+	rx_xdp_handler_result_t ret;
+	rx_xdp_handler_func_t *rx_xdp_handler;
+	struct net_device *dev = xdp->rxq->dev;
+
+	ret = RX_XDP_HANDLER_FALLBACK;
+	rx_xdp_handler = rcu_dereference(dev->rx_xdp_handler);
+
+	if (rx_xdp_handler) {
+		ret = rx_xdp_handler(dev, xdp);
+		switch (ret) {
+		case RX_XDP_HANDLER_CONSUMED:
+			/* Fall through */
+		case RX_XDP_HANDLER_DROP:
+			/* Fall through */
+		case RX_XDP_HANDLER_FALLBACK:
+			break;
+		default:
+			BUG();
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xdp_do_pass);
+
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-- 
2.7.4

