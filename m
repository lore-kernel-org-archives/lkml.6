Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeDFPGJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:06:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43304 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754754AbeDFPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:06:07 -0400
Date: Fri, 06 Apr 2018 11:06:03 -0400 (EDT)
Message-Id: <20180406.110603.978796669734920248.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com,
        gustavo@embeddedor.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64
 array
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri,  6 Apr 2018 04:14:25 -0700

> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 5fc46c5a4f36..448d1fafc827 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic.h
> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
>  
>  struct cavium_ptp;
>  
> -struct xcast_addr {
> -	struct list_head list;
> -	u64              addr;
> -};
> -
>  struct xcast_addr_list {
> -	struct list_head list;
>  	int              count;
> +	u64              mc[];
>  };
>  
>  struct nicvf_work {
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31fef729..a26d8bc92e01 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  						  work.work);
>  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
>  	union nic_mbx mbx = {};
> -	struct xcast_addr *xaddr, *next;
> +	u8 idx = 0;
        ^^^^^^^^^^^

>  
>  	if (!vf_work)
>  		return;
> @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  	/* check if we have any specific MACs to be added to PF DMAC filter */
>  	if (vf_work->mc) {
>  		/* now go through kernel list of MACs and add them one by one */
> -		list_for_each_entry_safe(xaddr, next,
> -					 &vf_work->mc->list, list) {
> +		for (idx = 0; idx < vf_work->mc->count; idx++) {

vf_work->mx->count is an 'int' therefore 'idx' should be declared 'int' as well,
not a 'u8'.
