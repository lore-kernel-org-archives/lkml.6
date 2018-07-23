Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF80E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF80E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeGWX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:57:48 -0400
Received: from nautica.notk.org ([91.121.71.147]:38420 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGWX5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:57:48 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 61FF7C009; Tue, 24 Jul 2018 00:54:19 +0200 (CEST)
Date:   Tue, 24 Jul 2018 00:54:04 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] net/9p/trans_fd.c: fix race by holding the lock
Message-ID: <20180723225404.GA17214@nautica>
References: <20180723184253.6682-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723184253.6682-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 23, 2018:
> It may be possible to run p9_fd_cancel() with a deleted req->req_list
> and incur in a double del. To fix hold the client->lock while changing
> the status, so the other threads will be synchronized.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com

OK, taking this one.

> ---
>  net/9p/trans_fd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 588bf88c3305..f9f96d50d96d 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -197,15 +197,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
>  static void p9_conn_cancel(struct p9_conn *m, int err)
>  {
>  	struct p9_req_t *req, *rtmp;
> -	unsigned long flags;
>  	LIST_HEAD(cancel_list);
> 
>  	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
> 
> -	spin_lock_irqsave(&m->client->lock, flags);
> +	spin_lock(&m->client->lock);
> 
>  	if (m->err) {
> -		spin_unlock_irqrestore(&m->client->lock, flags);
> +		spin_unlock(&m->client->lock);
>  		return;
>  	}
> 
> @@ -217,7 +216,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
>  		list_move(&req->req_list, &cancel_list);
>  	}
> -	spin_unlock_irqrestore(&m->client->lock, flags);
> 
>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
> @@ -226,6 +224,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  			req->t_err = err;
>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>  	}
> +	spin_unlock(&m->client->lock);
>  }
> 
>  static __poll_t
> @@ -373,8 +372,9 @@ static void p9_read_work(struct work_struct *work)
>  		if (m->req->status != REQ_STATUS_ERROR)
>  			status = REQ_STATUS_RCVD;
>  		list_del(&m->req->req_list);
> -		spin_unlock(&m->client->lock);
> +		/* update req->status while holding client->lock  */
>  		p9_client_cb(m->client, m->req, status);
> +		spin_unlock(&m->client->lock);
>  		m->rc.sdata = NULL;
>  		m->rc.offset = 0;
>  		m->rc.capacity = 0;
