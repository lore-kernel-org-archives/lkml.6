Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937108AbeE3DuG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:50:06 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42518 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935420AbeE3DuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:50:02 -0400
X-Google-Smtp-Source: ADUXVKJPkBzc2Avc1u+MXUVOunYm82VHa6n17x6DIqjIgkGw3lv3GPg/vzcjtd/mFgeCKCZMinrg5w==
Subject: Re: [PATCH V4] mlx4_core: allocate ICM memory in page size chunks
To: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, qing.huang@oracle.com
Cc: tariqt@mellanox.com, haakon.bugge@oracle.com, yanjun.zhu@oracle.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180523232246.20445-1-qing.huang@oracle.com>
 <20180525.102321.858995452200286788.davem@davemloft.net>
 <7a353b65-6b7f-1aee-1c48-e83c8e02f693@gmail.com>
 <0e11e0fc-6ccf-aa93-9c4f-b9eae1b90643@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <cdf0d1a9-378a-8b09-544e-a4918acb57fe@gmail.com>
Date: Tue, 29 May 2018 23:49:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0e11e0fc-6ccf-aa93-9c4f-b9eae1b90643@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 11:44 PM, Eric Dumazet wrote:

> 
> And I will add this simple fix, this really should address your initial concern much better.
> 
> @@ -99,6 +100,8 @@ static int mlx4_alloc_icm_pages(struct scatterlist *mem, int order,
>  {
>         struct page *page;
>  
> +       if (order)
> +               gfp_mask |= __GFP_NORETRY;

    and also      gfp_mask &= ~__GFP_DIRECT_RECLAIM


>         page = alloc_pages_node(node, gfp_mask, order);
>         if (!page) {
>                 page = alloc_pages(gfp_mask, order);
> 
