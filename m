Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13821C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A836520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A836520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeGXFCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:02:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:50563 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388131AbeGXFCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:02:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 62342C009; Tue, 24 Jul 2018 05:57:51 +0200 (CEST)
Date:   Tue, 24 Jul 2018 05:57:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: validate PDU length
Message-ID: <20180724035736.GA25060@nautica>
References: <20180723154404.2406-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723154404.2406-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 23, 2018:
> This commit adds length check for the PDU size.
> The size contained in the header has to match the actual size,
> except for TCP (trans_fd.c) where actual length is not known ahead
> and the header's length will be checked only against the validity
> range.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com

Ok, I've run some more in-depth testing this time and all appear in
order.
Like I said last time, I cannot test the xen transport - if someone can
point me to how to set it up or run some tests semi-regularily it'd be
great.

Meanwhile, code looks good and appears to work, so I'll take this
patch unless someone yells

> ---
>  net/9p/client.c       | 25 ++++++++++++++++---------
>  net/9p/trans_fd.c     |  5 ++++-
>  net/9p/trans_rdma.c   |  1 +
>  net/9p/trans_virtio.c |  4 +++-
>  4 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 18c5271910dc..92240ccf476b 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -477,20 +477,11 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
>  	int err;
>  
>  	pdu->offset = 0;
> -	if (pdu->size == 0)
> -		pdu->size = 7;
>  
>  	err = p9pdu_readf(pdu, 0, "dbw", &r_size, &r_type, &r_tag);
>  	if (err)
>  		goto rewind_and_exit;
>  
> -	pdu->size = r_size;
> -	pdu->id = r_type;
> -	pdu->tag = r_tag;
> -
> -	p9_debug(P9_DEBUG_9P, "<<< size=%d type: %d tag: %d\n",
> -		 pdu->size, pdu->id, pdu->tag);
> -
>  	if (type)
>  		*type = r_type;
>  	if (tag)
> @@ -498,6 +489,16 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
>  	if (size)
>  		*size = r_size;
>  
> +	if (pdu->size != r_size || r_size < 7) {
> +		err = -EINVAL;
> +		goto rewind_and_exit;
> +	}
> +
> +	pdu->id = r_type;
> +	pdu->tag = r_tag;
> +
> +	p9_debug(P9_DEBUG_9P, "<<< size=%d type: %d tag: %d\n",
> +		pdu->size, pdu->id, pdu->tag);
>  
>  rewind_and_exit:
>  	if (rewind)
> @@ -524,6 +525,12 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  	int ecode;
>  
>  	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
> +	if (req->rc->size >= c->msize) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			"requested packet size too big: %d\n",
> +			req->rc->size);
> +			return -EIO;

Indentation here looks wrong, I took the liberty of deindenting that
return in my tree.

> +	}
>  	/*
>  	 * dump the response from server
>  	 * This should be after check errors which poplulate pdu_fcall.
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 588bf88c3305..65533c437b7f 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -324,7 +324,9 @@ static void p9_read_work(struct work_struct *work)
>  	if ((!m->req) && (m->rc.offset == m->rc.capacity)) {
>  		p9_debug(P9_DEBUG_TRANS, "got new header\n");
>  
> -		err = p9_parse_header(&m->rc, NULL, NULL, NULL, 0);
> +		/* Header size */
> +		m->rc.size = 7;
> +		err = p9_parse_header(&m->rc, &m->rc.size, NULL, NULL, 0);
>  		if (err) {
>  			p9_debug(P9_DEBUG_ERROR,
>  				 "error parsing header: %d\n", err);
> @@ -369,6 +371,7 @@ static void p9_read_work(struct work_struct *work)
>  	 */
>  	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
>  		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
> +		m->req->rc->size = m->rc.offset;
>  		spin_lock(&m->client->lock);
>  		if (m->req->status != REQ_STATUS_ERROR)
>  			status = REQ_STATUS_RCVD;
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 3d414acb7015..2649b2ebf961 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -320,6 +320,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  	if (wc->status != IB_WC_SUCCESS)
>  		goto err_out;
>  
> +	c->rc->size = wc->byte_len;
>  	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
>  	if (err)
>  		goto err_out;
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 05006cbb3361..fc6dc9ca86a4 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -159,8 +159,10 @@ static void req_done(struct virtqueue *vq)
>  		spin_unlock_irqrestore(&chan->lock, flags);
>  		/* Wakeup if anyone waiting for VirtIO ring space. */
>  		wake_up(chan->vc_wq);
> -		if (len)
> +		if (len) {
> +			req->rc->size = len;
>  			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
> +		}
>  	}
>  }
>  

-- 
Dominique Martinet
