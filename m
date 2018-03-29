Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48o0z8eOv4CLEvTosgWTEn8RZu+FhOwtgjKt2n326VPubHNYomktfCJgw58GBByL4LxxYh8
ARC-Seal: i=1; a=rsa-sha256; t=1522346828; cv=none;
        d=google.com; s=arc-20160816;
        b=DkgZPRGBBtoke8h73qczIqatohA8BDxbwxMK/DOBEz40kYpxUXO7ACVMpDUsMi5GWr
         gFu9vtcsF6mPIHmKBf0qg6mmSazDcRcTHFaeCEzwVJQJTBvgo53qaicvPBSopFvKFAL0
         DrODi9WteoO1n0bmvYD+PaUL68r7lxQmmnWsFtpBYG3SdqoAuzILrrWNDMjTpLezi6ja
         tmFsPGmXFlPDhUbJVgX7DSt0r8PBsznCBrCUuywf48dlqVkodGQ71BwvZZ3ooZbr0Y+m
         +WJIZLWKqL2HSxbRC5ohBedZy95YqsowwbMFs6BMl4dfWxHBLkANJ1VaKj2KMaIJjrYg
         AFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N4HaH4CpMpqgKMWAqPccc9XKw82Qtxa1rDQv1tDNgA0=;
        b=IZ86ffwSBLAIEXd1bN4VBY/4E8/Ap5XL3zwwTDtu03nSF43m/yKS//MuRen8TtGEZ0
         vSYqV+dId+NHwM0zb7MnLPnP/yXYL/mklnQZX5vnsM8a3kraJtyz8J2taJUQlQ4XbTvF
         abn26/m62nhaEPRDYt5ru6yY7K+VozleGujyKw2XQ6CT4yNk3O2XheXOO29GVrKH4jlH
         UXByn7be3DpTn+n2HvBK8M8MwHf7W8vww7kHcawhPDgaTCpVtgeqiSkOv8Kh10SMFY2M
         4XHO+hnjx4Z/YyVBdc10p8w6TE2nYPah10aAUZgsL8Zwjb8oyjbvFpqomBM3P3+dS5pt
         UBOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	lipeng <lipeng321@huawei.com>,
	Jun He <hjat2005@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Erick Reyes <erickreyes@google.com>
Subject: [PATCH 4.9 28/28] net: hns: Fix a skb used after free bug
Date: Thu, 29 Mar 2018 20:00:47 +0200
Message-Id: <20180329175736.812183587@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296347320331744?=
X-GMAIL-MSGID: =?utf-8?q?1596296347320331744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunsheng Lin <linyunsheng@huawei.com>

commit 27463ad99f738ed93c7c8b3e2e5bc8c4853a2ff2 upstream.

skb maybe freed in hns_nic_net_xmit_hw() and return NETDEV_TX_OK,
which cause hns_nic_net_xmit to use a freed skb.

BUG: KASAN: use-after-free in hns_nic_net_xmit_hw+0x62c/0x940...
	[17659.112635]      alloc_debug_processing+0x18c/0x1a0
	[17659.117208]      __slab_alloc+0x52c/0x560
	[17659.120909]      kmem_cache_alloc_node+0xac/0x2c0
	[17659.125309]      __alloc_skb+0x6c/0x260
	[17659.128837]      tcp_send_ack+0x8c/0x280
	[17659.132449]      __tcp_ack_snd_check+0x9c/0xf0
	[17659.136587]      tcp_rcv_established+0x5a4/0xa70
	[17659.140899]      tcp_v4_do_rcv+0x27c/0x620
	[17659.144687]      tcp_prequeue_process+0x108/0x170
	[17659.149085]      tcp_recvmsg+0x940/0x1020
	[17659.152787]      inet_recvmsg+0x124/0x180
	[17659.156488]      sock_recvmsg+0x64/0x80
	[17659.160012]      SyS_recvfrom+0xd8/0x180
	[17659.163626]      __sys_trace_return+0x0/0x4
	[17659.167506] INFO: Freed in kfree_skbmem+0xa0/0xb0 age=23 cpu=1 pid=13
	[17659.174000]      free_debug_processing+0x1d4/0x2c0
	[17659.178486]      __slab_free+0x240/0x390
	[17659.182100]      kmem_cache_free+0x24c/0x270
	[17659.186062]      kfree_skbmem+0xa0/0xb0
	[17659.189587]      __kfree_skb+0x28/0x40
	[17659.193025]      napi_gro_receive+0x168/0x1c0
	[17659.197074]      hns_nic_rx_up_pro+0x58/0x90
	[17659.201038]      hns_nic_rx_poll_one+0x518/0xbc0
	[17659.205352]      hns_nic_common_poll+0x94/0x140
	[17659.209576]      net_rx_action+0x458/0x5e0
	[17659.213363]      __do_softirq+0x1b8/0x480
	[17659.217062]      run_ksoftirqd+0x64/0x80
	[17659.220679]      smpboot_thread_fn+0x224/0x310
	[17659.224821]      kthread+0x150/0x170
	[17659.228084]      ret_from_fork+0x10/0x40

	BUG: KASAN: use-after-free in hns_nic_net_xmit+0x8c/0xc0...
	[17751.080490]      __slab_alloc+0x52c/0x560
	[17751.084188]      kmem_cache_alloc+0x244/0x280
	[17751.088238]      __build_skb+0x40/0x150
	[17751.091764]      build_skb+0x28/0x100
	[17751.095115]      __alloc_rx_skb+0x94/0x150
	[17751.098900]      __napi_alloc_skb+0x34/0x90
	[17751.102776]      hns_nic_rx_poll_one+0x180/0xbc0
	[17751.107097]      hns_nic_common_poll+0x94/0x140
	[17751.111333]      net_rx_action+0x458/0x5e0
	[17751.115123]      __do_softirq+0x1b8/0x480
	[17751.118823]      run_ksoftirqd+0x64/0x80
	[17751.122437]      smpboot_thread_fn+0x224/0x310
	[17751.126575]      kthread+0x150/0x170
	[17751.129838]      ret_from_fork+0x10/0x40
	[17751.133454] INFO: Freed in kfree_skbmem+0xa0/0xb0 age=19 cpu=7 pid=43
	[17751.139951]      free_debug_processing+0x1d4/0x2c0
	[17751.144436]      __slab_free+0x240/0x390
	[17751.148051]      kmem_cache_free+0x24c/0x270
	[17751.152014]      kfree_skbmem+0xa0/0xb0
	[17751.155543]      __kfree_skb+0x28/0x40
	[17751.159022]      napi_gro_receive+0x168/0x1c0
	[17751.163074]      hns_nic_rx_up_pro+0x58/0x90
	[17751.167041]      hns_nic_rx_poll_one+0x518/0xbc0
	[17751.171358]      hns_nic_common_poll+0x94/0x140
	[17751.175585]      net_rx_action+0x458/0x5e0
	[17751.179373]      __do_softirq+0x1b8/0x480
	[17751.183076]      run_ksoftirqd+0x64/0x80
	[17751.186691]      smpboot_thread_fn+0x224/0x310
	[17751.190826]      kthread+0x150/0x170
	[17751.194093]      ret_from_fork+0x10/0x40

Fixes: 13ac695e7ea1 ("net:hns: Add support of Hip06 SoC to the Hislicon Network Subsystem")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: lipeng <lipeng321@huawei.com>
Reported-by: Jun He <hjat2005@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Erick Reyes <erickreyes@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   22 ++++++++++------------
 drivers/net/ethernet/hisilicon/hns/hns_enet.h |    6 +++---
 2 files changed, 13 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -299,9 +299,9 @@ static void fill_tso_desc(struct hnae_ri
 			     mtu);
 }
 
-int hns_nic_net_xmit_hw(struct net_device *ndev,
-			struct sk_buff *skb,
-			struct hns_nic_ring_data *ring_data)
+netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
+				struct sk_buff *skb,
+				struct hns_nic_ring_data *ring_data)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 	struct hnae_ring *ring = ring_data->ring;
@@ -360,6 +360,10 @@ int hns_nic_net_xmit_hw(struct net_devic
 	dev_queue = netdev_get_tx_queue(ndev, skb->queue_mapping);
 	netdev_tx_sent_queue(dev_queue, skb->len);
 
+	netif_trans_update(ndev);
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+
 	wmb(); /* commit all data before submit */
 	assert(skb->queue_mapping < priv->ae_handle->q_num);
 	hnae_queue_xmit(priv->ae_handle->qs[skb->queue_mapping], buf_num);
@@ -1408,17 +1412,11 @@ static netdev_tx_t hns_nic_net_xmit(stru
 				    struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
-	int ret;
 
 	assert(skb->queue_mapping < ndev->ae_handle->q_num);
-	ret = hns_nic_net_xmit_hw(ndev, skb,
-				  &tx_ring_data(priv, skb->queue_mapping));
-	if (ret == NETDEV_TX_OK) {
-		netif_trans_update(ndev);
-		ndev->stats.tx_bytes += skb->len;
-		ndev->stats.tx_packets++;
-	}
-	return (netdev_tx_t)ret;
+
+	return hns_nic_net_xmit_hw(ndev, skb,
+				   &tx_ring_data(priv, skb->queue_mapping));
 }
 
 static int hns_nic_change_mtu(struct net_device *ndev, int new_mtu)
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.h
@@ -91,8 +91,8 @@ void hns_ethtool_set_ops(struct net_devi
 void hns_nic_net_reset(struct net_device *ndev);
 void hns_nic_net_reinit(struct net_device *netdev);
 int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h);
-int hns_nic_net_xmit_hw(struct net_device *ndev,
-			struct sk_buff *skb,
-			struct hns_nic_ring_data *ring_data);
+netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
+				struct sk_buff *skb,
+				struct hns_nic_ring_data *ring_data);
 
 #endif	/**__HNS_ENET_H */
