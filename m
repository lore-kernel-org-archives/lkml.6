Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55009C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADF62150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADF62150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeHBLb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:31:56 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:36096 "EHLO
        4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:31:55 -0400
Received: from player697.ha.ovh.net (unknown [10.109.143.216])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9CDD514828F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 11:23:12 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id 270354800CF;
        Thu,  2 Aug 2018 11:23:03 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:23:01 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Matthew Wilcox <willy@infradead.org>,
        Jun Piao <piaojun@huawei.com>
Subject: Re: [PATCH v2 1/2] net/9p: embed fcall in req to round down buffer
 allocs
Message-ID: <20180802112301.6b581f1c@bahia.lan>
In-Reply-To: <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
References: <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
        <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14807835577272670464
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrleeggdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 04:37:31 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> From: Dominique Martinet <dominique.martinet@cea.fr>
> 
> 'msize' is often a power of two, or at least page-aligned, so avoiding
> an overhead of two dozen bytes for each allocation will help the
> allocator do its work and reduce memory fragmentation.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Jun Piao <piaojun@huawei.com>
> ---
> 
> v2:
>  - Add extra label to not free uninitialized memory on alloc failure
>  - Rename p9_fcall_alloc to 9p_fcall_init
>  - Add a p9_fcall_fini function to echo to init
> 
[...]
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 2ab4574183c9..c5cac97df7f7 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -122,7 +122,7 @@ struct p9_rdma_context {
>  	dma_addr_t busa;
>  	union {
>  		struct p9_req_t *req;
> -		struct p9_fcall *rc;
> +		struct p9_fcall rc;
>  	};
>  };
>  
> @@ -320,8 +320,8 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  	if (wc->status != IB_WC_SUCCESS)
>  		goto err_out;
>  
> -	c->rc->size = wc->byte_len;
> -	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
> +	c->rc.size = wc->byte_len;
> +	err = p9_parse_header(&c->rc, NULL, NULL, &tag, 1);
>  	if (err)
>  		goto err_out;
>  
> @@ -331,12 +331,13 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  
>  	/* Check that we have not yet received a reply for this request.
>  	 */
> -	if (unlikely(req->rc)) {
> +	if (unlikely(req->rc.sdata)) {
>  		pr_err("Duplicate reply for request %d", tag);
>  		goto err_out;
>  	}
>  
> -	req->rc = c->rc;
> +	req->rc.size = c->rc.size;
> +	req->rc.sdata = c->rc.sdata;
>  	p9_client_cb(client, req, REQ_STATUS_RCVD);
>  
>   out:
> @@ -361,7 +362,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
>  		container_of(wc->wr_cqe, struct p9_rdma_context, cqe);
>  
>  	ib_dma_unmap_single(rdma->cm_id->device,
> -			    c->busa, c->req->tc->size,
> +			    c->busa, c->req->tc.size,
>  			    DMA_TO_DEVICE);
>  	up(&rdma->sq_sem);
>  	kfree(c);
> @@ -401,7 +402,7 @@ post_recv(struct p9_client *client, struct p9_rdma_context *c)
>  	struct ib_sge sge;
>  
>  	c->busa = ib_dma_map_single(rdma->cm_id->device,
> -				    c->rc->sdata, client->msize,
> +				    c->rc.sdata, client->msize,
>  				    DMA_FROM_DEVICE);
>  	if (ib_dma_mapping_error(rdma->cm_id->device, c->busa))
>  		goto error;
> @@ -443,9 +444,9 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
>  	 **/
>  	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
>  		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
> -			/* Got one ! */
> -			kfree(req->rc);
> -			req->rc = NULL;
> +			/* Got one! */
> +			kfree(req->rc.sdata);

Shouldn't this be p9_fcall_fini(&req->rc) ?

The rest looks good, so, with that fixed, you can add:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +			req->rc.sdata = NULL;
>  			goto dont_need_post_recv;
>  		} else {
>  			/* We raced and lost. */
