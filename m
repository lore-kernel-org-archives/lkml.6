Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB36F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB36F20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbeGWDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:23:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730798AbeGWDXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:23:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34F0873995312;
        Mon, 23 Jul 2018 10:24:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 10:24:34 +0800
Subject: Re: [PATCH] net/9p/trans_fd.c: fix double list_del() and race in
 access
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180720132801.22749-1-tomasbortoli@gmail.com>
CC:     <davem@davemloft.net>, <v9fs-developer@lists.sourceforge.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B553C5E.4000200@huawei.com>
Date:   Mon, 23 Jul 2018 10:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180720132801.22749-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/20 21:28, Tomas Bortoli wrote:
> This patch uses list_del_init() instead of list_del() to eliminate "req_list". This to prevent double list_del()'s calls to the same list from provoking a GPF. Furthermore, this patch fixes an access to "req_list" that was made without getting the relative lock.
> 

I suggest you can apply a 72-character line limit to your
commit messages. Others looks good to me.

Thanks,
Yiwen.

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
> 


