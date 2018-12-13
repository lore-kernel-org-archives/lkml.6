Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD76C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DC520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DC520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeLMObc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeLMOb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:31:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2FA3082DDC;
        Thu, 13 Dec 2018 14:31:29 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-109.rdu2.redhat.com [10.10.121.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EB6B607C5;
        Thu, 13 Dec 2018 14:31:27 +0000 (UTC)
Date:   Thu, 13 Dec 2018 09:31:21 -0500
From:   Neil Horman <nhorman@redhat.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, wulike1@huawei.com, chiqijun@huawei.com,
        fy.wang@huawei.com, tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic:optmize rx refill buffer mechanism
Message-ID: <20181213143121.GA5562@hmswarspite.think-freely.org>
References: <20181212174023.20416-1-xuechaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212174023.20416-1-xuechaojing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Dec 2018 14:31:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:40:23PM +0000, Xue Chaojing wrote:
> There is no need to schedule a different tasklet for refill,
> This patch remove it.
> 
> Suggested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_rx.c | 23 +++++---------------
>  drivers/net/ethernet/huawei/hinic/hinic_rx.h |  2 --
>  2 files changed, 5 insertions(+), 20 deletions(-)
> 
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
I like that you're getting rid of the extra tasklet, but the other part of this
is properly refilling your rx ring.  The way you have this coded, you always
blindly just receive the incomming frame, even if your refill operation fails.
If you get a long enough period in which you are memory constrained, you will
wind up with an empty rx ring, which isn't good.  With this patch, if your ring
becomes empty, then you will stop receiving frames (no buffers to put them in),
which in turn will prevent further attempts to refill the ring.  The result is
effectively a hang in traffic reception that is only solveable by a NIC reset.

Common practice is to, for each skb that you intend to receive:

1) Allocate a replacement buffer/skb
2a) If allocation succedes, receive the buffer currently on the ring, and
replace it with the buffer from (1)
2b) If allocation fails, record a frame drop, mark the existing buffer as clean,
and move on

This process ensures that the ring never has any gaps in it, preventing the
above hang condition.

Neil
 


