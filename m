Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D786C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3240B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeLQRCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeLQRCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:02:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8721C068BF9;
        Mon, 17 Dec 2018 17:02:43 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-29.rdu2.redhat.com [10.10.121.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAABE5D9C5;
        Mon, 17 Dec 2018 17:02:42 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:02:41 -0500
From:   Neil Horman <nhorman@redhat.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, wulike1@huawei.com, chiqijun@huawei.com,
        fy.wang@huawei.com, tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic:optmize rx refill buffer mechanism
Message-ID: <20181217170241.GD15181@hmswarspite.think-freely.org>
References: <20181216223234.24031-1-xuechaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216223234.24031-1-xuechaojing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Dec 2018 17:02:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:32:34PM +0000, Xue Chaojing wrote:
> In rx_alloc_pkts(), there is no need to schedule a different tasklet for
> refill and it will cause some extra overhead. this patch remove it.
> 
> Suggested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_rx.c | 23 +++++---------------
>  drivers/net/ethernet/huawei/hinic/hinic_rx.h |  2 --
>  2 files changed, 5 insertions(+), 20 deletions(-)
> 
I thought I had responded to this already, but this still looks like the same
patch.  While I'm supportive of the removal of the second tasklet (as its not
needed), this patch still doesn't address the holes that can result in your rx
ring buffer.  By always receiving a frame , and then just filling as many of the
remaining buffers as possible, you open yourself to the possibility that, in low
memory conditions, you will wind up with an empty rx ring that will result in
hanging your NIC.  You need to, for every recevied frame, pre-allocate a
replacement buffer, and, should that allocation fail, return the received frame,
to the ring, recording a drop in the process.  That way your ring buffer will
never have holes in it.

Neil
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
> index f86f2e693224..0098b206e7e9 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
> @@ -43,6 +43,7 @@
>  #define RX_IRQ_NO_LLI_TIMER             0
>  #define RX_IRQ_NO_CREDIT                0
>  #define RX_IRQ_NO_RESEND_TIMER          0
> +#define HINIC_RX_BUFFER_WRITE           16
>  
>  /**
>   * hinic_rxq_clean_stats - Clean the statistics of specific queue
> @@ -229,7 +230,6 @@ static int rx_alloc_pkts(struct hinic_rxq *rxq)
>  		wmb();  /* write all the wqes before update PI */
>  
>  		hinic_rq_update(rxq->rq, prod_idx);
> -		tasklet_schedule(&rxq->rx_task);
>  	}
>  
>  	return i;
> @@ -258,17 +258,6 @@ static void free_all_rx_skbs(struct hinic_rxq *rxq)
>  	}
>  }
>  
> -/**
> - * rx_alloc_task - tasklet for queue allocation
> - * @data: rx queue
> - **/
> -static void rx_alloc_task(unsigned long data)
> -{
> -	struct hinic_rxq *rxq = (struct hinic_rxq *)data;
> -
> -	(void)rx_alloc_pkts(rxq);
> -}
> -
>  /**
>   * rx_recv_jumbo_pkt - Rx handler for jumbo pkt
>   * @rxq: rx queue
> @@ -333,6 +322,7 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
>  	struct hinic_qp *qp = container_of(rxq->rq, struct hinic_qp, rq);
>  	u64 pkt_len = 0, rx_bytes = 0;
>  	struct hinic_rq_wqe *rq_wqe;
> +	unsigned int free_wqebbs;
>  	int num_wqes, pkts = 0;
>  	struct hinic_sge sge;
>  	struct sk_buff *skb;
> @@ -376,8 +366,9 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
>  		rx_bytes += pkt_len;
>  	}
>  
> -	if (pkts)
> -		tasklet_schedule(&rxq->rx_task); /* rx_alloc_pkts */
> +	free_wqebbs = hinic_get_rq_free_wqebbs(rxq->rq);
> +	if (free_wqebbs > HINIC_RX_BUFFER_WRITE)
> +		rx_alloc_pkts(rxq);
>  
>  	u64_stats_update_begin(&rxq->rxq_stats.syncp);
>  	rxq->rxq_stats.pkts += pkts;
> @@ -494,8 +485,6 @@ int hinic_init_rxq(struct hinic_rxq *rxq, struct hinic_rq *rq,
>  
>  	sprintf(rxq->irq_name, "hinic_rxq%d", qp->q_id);
>  
> -	tasklet_init(&rxq->rx_task, rx_alloc_task, (unsigned long)rxq);
> -
>  	pkts = rx_alloc_pkts(rxq);
>  	if (!pkts) {
>  		err = -ENOMEM;
> @@ -512,7 +501,6 @@ int hinic_init_rxq(struct hinic_rxq *rxq, struct hinic_rq *rq,
>  
>  err_req_rx_irq:
>  err_rx_pkts:
> -	tasklet_kill(&rxq->rx_task);
>  	free_all_rx_skbs(rxq);
>  	devm_kfree(&netdev->dev, rxq->irq_name);
>  	return err;
> @@ -528,7 +516,6 @@ void hinic_clean_rxq(struct hinic_rxq *rxq)
>  
>  	rx_free_irq(rxq);
>  
> -	tasklet_kill(&rxq->rx_task);
>  	free_all_rx_skbs(rxq);
>  	devm_kfree(&netdev->dev, rxq->irq_name);
>  }
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.h b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
> index ab3fabab91b2..f8ed3fa6c8ee 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_rx.h
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
> @@ -42,8 +42,6 @@ struct hinic_rxq {
>  
>  	char                    *irq_name;
>  
> -	struct tasklet_struct   rx_task;
> -
>  	struct napi_struct      napi;
>  };
>  
> -- 
> 2.17.1
> 
