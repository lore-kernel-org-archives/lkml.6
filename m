Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D361C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5C120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5C120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbeGXJw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:52:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10109 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388136AbeGXJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:52:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E7C69210E0BB;
        Tue, 24 Jul 2018 16:47:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 16:46:29 +0800
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
To:     Tomas Bortoli <tomasbortoli@gmail.com>
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
CC:     <asmadeus@codewreck.org>, <davem@davemloft.net>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B56E764.2090608@huawei.com>
Date:   Tue, 24 Jul 2018 16:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180723121902.20201-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/23 20:19, Tomas Bortoli wrote:
> A double list_del(&req->req_list) is possible in p9_fd_cancel() as
> shown by Syzbot. To prevent it we have to ensure that we have the
> client->lock when deleting the list. Furthermore, we have to update
> the status of the request before releasing the lock, to prevent the
> race.
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

If you want to expand the ranges of client->lock, the cancel_list will not
be necessary, you can optimize this code.

In addition, we delete some person because too many recipients are limited.

Thanks,
Yiwen.

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
>  	}
>  
>  end_clear:
> 


