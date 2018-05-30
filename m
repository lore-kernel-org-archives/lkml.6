Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeE3Dom (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:44:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40183 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeE3Doj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:44:39 -0400
X-Google-Smtp-Source: ADUXVKJEUa9vsGyNvS6l/nWiCwJo0CORVg/cINIt/zRAL3//WhZeplUvHxR82iz80acgW9hxz4W4EQ==
Subject: Re: [PATCH V4] mlx4_core: allocate ICM memory in page size chunks
To: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, qing.huang@oracle.com
Cc: tariqt@mellanox.com, haakon.bugge@oracle.com, yanjun.zhu@oracle.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180523232246.20445-1-qing.huang@oracle.com>
 <20180525.102321.858995452200286788.davem@davemloft.net>
 <7a353b65-6b7f-1aee-1c48-e83c8e02f693@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0e11e0fc-6ccf-aa93-9c4f-b9eae1b90643@gmail.com>
Date: Tue, 29 May 2018 23:44:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7a353b65-6b7f-1aee-1c48-e83c8e02f693@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 11:34 PM, Eric Dumazet wrote:

> I will test :
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
> index 685337d58276fc91baeeb64387c52985e1bc6dda..4d2a71381acb739585d662175e86caef72338097 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/icm.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
> @@ -43,12 +43,13 @@
>  #include "fw.h"
>  
>  /*
> - * We allocate in page size (default 4KB on many archs) chunks to avoid high
> - * order memory allocations in fragmented/high usage memory situation.
> + * We allocate in as big chunks as we can, up to a maximum of 256 KB
> + * per chunk. Note that the chunks are not necessarily in contiguous
> + * physical memory.
>   */
>  enum {
> -       MLX4_ICM_ALLOC_SIZE     = PAGE_SIZE,
> -       MLX4_TABLE_CHUNK_SIZE   = PAGE_SIZE,
> +       MLX4_ICM_ALLOC_SIZE     = 1 << 18,
> +       MLX4_TABLE_CHUNK_SIZE   = 1 << 18
>  };
>  
>  static void mlx4_free_icm_pages(struct mlx4_dev *dev, struct mlx4_icm_chunk *chunk)
> 

And I will add this simple fix, this really should address your initial concern much better.

@@ -99,6 +100,8 @@ static int mlx4_alloc_icm_pages(struct scatterlist *mem, int order,
 {
        struct page *page;
 
+       if (order)
+               gfp_mask |= __GFP_NORETRY;
        page = alloc_pages_node(node, gfp_mask, order);
        if (!page) {
                page = alloc_pages(gfp_mask, order);
