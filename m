Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE82C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B25208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B25208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeGaLmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:42:19 -0400
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:59999 "EHLO
        tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:42:19 -0400
Received: from vc2.ecl.ntt.co.jp (vc2.ecl.ntt.co.jp [129.60.86.154])
        by tama500.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id w6VA2gl6018260;
        Tue, 31 Jul 2018 19:02:42 +0900
Received: from vc2.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id 1B4F1639062;
        Tue, 31 Jul 2018 19:02:42 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id 0FAA9639124;
        Tue, 31 Jul 2018 19:02:42 +0900 (JST)
Received: from [IPv6:::1] (unknown [129.60.241.146])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id 09460400D1E;
        Tue, 31 Jul 2018 19:02:42 +0900 (JST)
Subject: Re: [PATCH net-next 2/2] virtio-net: get rid of unnecessary container
 of rq stats
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
 <1533030219-9904-2-git-send-email-jasowang@redhat.com>
From:   Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <da012c13-e438-f45e-5c41-2f159e791f00@lab.ntt.co.jp>
Date:   Tue, 31 Jul 2018 19:02:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533030219-9904-2-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/31 18:43, Jason Wang wrote:
> We don't maintain tx counters in rx stats any more. There's no need
> for an extra container of rq stats.
> 
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 80 ++++++++++++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d3f68..14f661c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,8 @@ struct virtnet_sq_stats {
>  	u64 kicks;
>  };
>  
> -struct virtnet_rq_stat_items {
> +struct virtnet_rq_stats {
> +	struct u64_stats_sync syncp;
>  	u64 packets;
>  	u64 bytes;
>  	u64 drops;
> @@ -98,17 +99,8 @@ struct virtnet_rq_stat_items {
>  	u64 kicks;
>  };
>  
> -struct virtnet_rq_stats {
> -	struct u64_stats_sync syncp;
> -	struct virtnet_rq_stat_items items;
> -};

I'm not thinking removing sq stat is needed but even if it is I want to
keep virtnet_rq_stats to avoid allocating unnecessary u64_stats_syncp on
stack in virtnet_receive. I would just remove virtnet_rx_stats if necessary.

> -
> -struct virtnet_rx_stats {
> -	struct virtnet_rq_stat_items rx;
> -};
> -

-- 
Toshiaki Makita

