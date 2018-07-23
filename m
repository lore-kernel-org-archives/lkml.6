Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A993CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7D20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeGWECF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:02:05 -0400
Received: from nautica.notk.org ([91.121.71.147]:52507 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeGWECF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:02:05 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 67A91C009; Mon, 23 Jul 2018 05:03:06 +0200 (CEST)
Date:   Mon, 23 Jul 2018 05:02:51 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] net/9p/trans_fd.c: fix double list_del() and race in
 access
Message-ID: <20180723030251.GB24608@nautica>
References: <20180720132801.22749-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720132801.22749-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Fri, Jul 20, 2018:
> This patch uses list_del_init() instead of list_del() to eliminate
> "req_list". This to prevent double list_del()'s calls to the same list
> from provoking a GPF. Furthermore, this patch fixes an access to
> "req_list" that was made without getting the relative lock.

Please see comment about locking.

As for list_del to list_del_init, it feels a little wrong to me, but I
don't have a better idea so let's go with that.
Do you know what happened to trigger this? one thread running
p9_conn_cancel then the other thread doing p9_fd_cancel ?

> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
> ---
> 
>  net/9p/trans_fd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index a64b01c56e30..131bb1f059e6 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -223,7 +223,9 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  
>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
> -		list_del(&req->req_list);
> +		spin_lock_irqsave(&m->client->lock, flags);
> +		list_del_init(&req->req_list);
> +		spin_unlock_irqrestore(&m->client->lock, flags);

Just locking around one item if you're afraid it might change won't be
enough - list_for_each_entry_safe is only "safe" from removing the
current element from the list yourself, not from other threads messing
with it, so you'd need to lock around the whole loop if that's what
you're protecting against.

(Also, since I've taken the other patchs to change spin locks on
client->lock to spin_lock instead of spin_lock_irqsave, please use that
function for new locking of that variable - in general just basing your
patchs off linux-next's master branch is a good idea.)

>  		if (!req->t_err)
>  			req->t_err = err;
>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
> @@ -369,7 +371,7 @@ static void p9_read_work(struct work_struct *work)
>  		spin_lock(&m->client->lock);
>  		if (m->req->status != REQ_STATUS_ERROR)
>  			status = REQ_STATUS_RCVD;
> -		list_del(&m->req->req_list);
> +		list_del_init(&m->req->req_list);
>  		spin_unlock(&m->client->lock);
>  		p9_client_cb(m->client, m->req, status);
>  		m->rc.sdata = NULL;
> @@ -684,7 +686,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>  	spin_lock(&client->lock);
>  
>  	if (req->status == REQ_STATUS_UNSENT) {
> -		list_del(&req->req_list);
> +		list_del_init(&req->req_list);
>  		req->status = REQ_STATUS_FLSHD;
>  		ret = 0;
>  	}
> @@ -701,7 +703,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>  	 * remove it from the list.
>  	 */
>  	spin_lock(&client->lock);
> -	list_del(&req->req_list);
> +	list_del_init(&req->req_list);
>  	spin_unlock(&client->lock);
>  
>  	return 0;
