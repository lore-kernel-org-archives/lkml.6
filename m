Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBTS4T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:56:19 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeBTS4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:56:17 -0500
Date: Tue, 20 Feb 2018 13:56:16 -0500 (EST)
Message-Id: <20180220.135616.822494587891051955.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dpaa_eth: fix SG mapping
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180219161044.30279-2-madalin.bucur@nxp.com>
References: <20180219161044.30279-1-madalin.bucur@nxp.com>
        <20180219161044.30279-2-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Mon, 19 Feb 2018 10:10:41 -0600

> An issue in the code mapping the skb fragments into
> scatter-gather frames was evidentiated by netperf
> TCP_SENDFILE tests. This patch addresses the issue.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

This is a poorly worded commit message.

You have to say exactly what "the issue" is.

Reading your patch:

> @@ -1916,8 +1916,10 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
>  		goto csum_failed;
>  	}
>  
> +	/* SGT[0] is used by the linear part */
>  	sgt = (struct qm_sg_entry *)(sgt_buf + priv->tx_headroom);
> -	qm_sg_entry_set_len(&sgt[0], skb_headlen(skb));
> +	buff_len = skb_headlen(skb);
> +	qm_sg_entry_set_len(&sgt[0], buff_len);
>  	sgt[0].bpid = FSL_DPAA_BPID_INV;
>  	sgt[0].offset = 0;
>  	addr = dma_map_single(dev, skb->data,

This change has no effect and is unrelated.  Please do not mix
unrelated changes with the main change, because this makes it
hard to review your work.

> @@ -1930,27 +1932,28 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
>  	qm_sg_entry_set64(&sgt[0], addr);
>  
>  	/* populate the rest of SGT entries */
> -	frag = &skb_shinfo(skb)->frags[0];
> -	frag_len = frag->size;
> -	for (i = 1; i <= nr_frags; i++, frag++) {
> +	for (i = 0; i < nr_frags; i++) {
> +		frag = &skb_shinfo(skb)->frags[i];
> +		buff_len = frag->size;
>  		WARN_ON(!skb_frag_page(frag));
>  		addr = skb_frag_dma_map(dev, frag, 0,
> -					frag_len, dma_dir);
> +					buff_len, dma_dir);

And clearly the bug you are fixing is simply that frag_len was only
being set for the first fragment.

Please just fix that bug and remove all of these other completely
unrelated changes.
