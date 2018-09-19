Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E7B2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E7B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeISQMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:12:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731025AbeISQMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:12:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13960F47301C6;
        Wed, 19 Sep 2018 18:35:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:35:22 +0800
Subject: Re: [PATCH net-next] net: toshiba: fix return type of ndo_start_xmit
 function
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <anirudh@xilinx.com>, <John.Linn@xilinx.com>
References: <20180919103240.27708-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ac711ea2-b201-3621-9229-059925b5cc7e@huawei.com>
Date:   Wed, 19 Sep 2018 18:35:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180919103240.27708-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, this is a duplicated patch，Pls ignore it.

On 2018/9/19 18:32, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 4 ++--
>  drivers/net/ethernet/toshiba/ps3_gelic_net.h | 2 +-
>  drivers/net/ethernet/toshiba/spider_net.c    | 4 ++--
>  drivers/net/ethernet/toshiba/tc35815.c       | 6 ++++--
>  4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 88d74ae..75237c8 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -845,9 +845,9 @@ static int gelic_card_kick_txdma(struct gelic_card *card,
>   * @skb: packet to send out
>   * @netdev: interface device structure
>   *
> - * returns 0 on success, <0 on failure
> + * returns NETDEV_TX_OK on success, NETDEV_TX_BUSY on failure
>   */
> -int gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
> +netdev_tx_t gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	struct gelic_card *card = netdev_card(netdev);
>  	struct gelic_descr *descr;
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> index 003d045..fbbf9b5 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> @@ -370,7 +370,7 @@ static inline void udbg_shutdown_ps3gelic(void) {}
>  void gelic_card_down(struct gelic_card *card);
>  int gelic_net_open(struct net_device *netdev);
>  int gelic_net_stop(struct net_device *netdev);
> -int gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev);
> +netdev_tx_t gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev);
>  void gelic_net_set_multi(struct net_device *netdev);
>  void gelic_net_tx_timeout(struct net_device *netdev);
>  int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card);
> diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
> index d925b82..2341726 100644
> --- a/drivers/net/ethernet/toshiba/spider_net.c
> +++ b/drivers/net/ethernet/toshiba/spider_net.c
> @@ -880,9 +880,9 @@
>   * @skb: packet to send out
>   * @netdev: interface device structure
>   *
> - * returns 0 on success, !0 on failure
> + * returns NETDEV_TX_OK on success, NETDEV_TX_BUSY on failure
>   */
> -static int
> +static netdev_tx_t
>  spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	int cnt;
> diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
> index 7163a8d..6a71c2c 100644
> --- a/drivers/net/ethernet/toshiba/tc35815.c
> +++ b/drivers/net/ethernet/toshiba/tc35815.c
> @@ -474,7 +474,8 @@ static void free_rxbuf_skb(struct pci_dev *hwdev, struct sk_buff *skb, dma_addr_
>  /* Index to functions, as function prototypes. */
>  
>  static int	tc35815_open(struct net_device *dev);
> -static int	tc35815_send_packet(struct sk_buff *skb, struct net_device *dev);
> +static netdev_tx_t	tc35815_send_packet(struct sk_buff *skb,
> +					    struct net_device *dev);
>  static irqreturn_t	tc35815_interrupt(int irq, void *dev_id);
>  static int	tc35815_rx(struct net_device *dev, int limit);
>  static int	tc35815_poll(struct napi_struct *napi, int budget);
> @@ -1248,7 +1249,8 @@ static void tc35815_tx_timeout(struct net_device *dev)
>   * invariant will hold if you make sure that the netif_*_queue()
>   * calls are done at the proper times.
>   */
> -static int tc35815_send_packet(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t
> +tc35815_send_packet(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct tc35815_local *lp = netdev_priv(dev);
>  	struct TxFD *txfd;
> 

