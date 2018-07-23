Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03668ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6820875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD6820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeGWN6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:58:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:59933 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387847AbeGWN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:58:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1B6C8C009; Mon, 23 Jul 2018 14:57:16 +0200 (CEST)
Date:   Mon, 23 Jul 2018 14:57:01 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
Message-ID: <20180723125701.GA17971@nautica>
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723121902.20201-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 23, 2018:
> A double list_del(&req->req_list) is possible in p9_fd_cancel() as
> shown by Syzbot. To prevent it we have to ensure that we have the
> client->lock when deleting the list. Furthermore, we have to update
> the status of the request before releasing the lock, to prevent the
> race.

Nice, so no need to change the list_del to list_del_init!

I still have a nitpick on the last moved unlock, but it's mostly
aesthetic - the change looks much better to me now.

(Since that will require a v2 I'll be evil and go further than Yiwen
about the commit message: let it breathe a bit! :) I think a line break
before "furthermore" for example will make it easier to read)

> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
> ---
>  net/9p/trans_fd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index a64b01c56e30..370c6c69a05c 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
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
> @@ -219,7 +218,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
>  		list_move(&req->req_list, &cancel_list);
>  	}
> -	spin_unlock_irqrestore(&m->client->lock, flags);
>  
>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
> @@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  			req->t_err = err;
>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>  	}
> +	spin_unlock(&m->client->lock);
>  }
>  
>  static __poll_t
> @@ -370,12 +369,12 @@ static void p9_read_work(struct work_struct *work)
>  		if (m->req->status != REQ_STATUS_ERROR)
>  			status = REQ_STATUS_RCVD;
>  		list_del(&m->req->req_list);
> -		spin_unlock(&m->client->lock);
>  		p9_client_cb(m->client, m->req, status);
>  		m->rc.sdata = NULL;
>  		m->rc.offset = 0;
>  		m->rc.capacity = 0;
>  		m->req = NULL;
> +		spin_unlock(&m->client->lock);

It took me a while to understand why you extended this lock despite
having just read the commit message, I'd suggest:
 - moving the spin_unlock to right after p9_client_cb (afterall that's
what we want, the m->rc and m->req don't need to be protected)
 - add a comment before p9_client_cb saying something like 'updates
req->status' or try to explain why it needs to be locked here but other
transports don't need such a lock (they're not dependant on req->status
like this)

-- 
Dominique
