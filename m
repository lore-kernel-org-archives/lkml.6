Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A284DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0DB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0DB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGTJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:22:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeGTJWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:22:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AA831BC4BBDF;
        Fri, 20 Jul 2018 16:35:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Fri, 20 Jul 2018
 16:34:58 +0800
Subject: Re: [V9fs-developer] [PATCH] /net/9p/trans_fd.c: fix race-condition
 by flushing workqueue before the kfree()
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180719200607.30286-1-tomasbortoli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B519EB0.8000700@huawei.com>
Date:   Fri, 20 Jul 2018 16:34:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180719200607.30286-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/20 4:06, Tomas Bortoli wrote:
> The patch adds the flush in p9_mux_poll_stop() as it the function used by
> p9_conn_destroy(), in turn called by p9_fd_close() to stop the async
> polling associated with the data regarding the connection.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+39749ed7d9ef6dfb23f6@syzkaller.appspotmail.com
> ---
> As shown by Syzbot, it is possible to provoke a race between p9_fd_close() 
> and p9_poll_workfn() that is called to take care of the async read/write work
> to do. To make sure p9_fd_close() frees "trans" when it is not used anymore, 
> it has to explicitly call flush_scheduled_work() before the kfree().
> 
>  net/9p/trans_fd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index bf459ee0feab..76ae134c05d9 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -185,6 +185,8 @@ static void p9_mux_poll_stop(struct p9_conn *m)
>  	spin_lock_irqsave(&p9_poll_lock, flags);
>  	list_del_init(&m->poll_pending_link);
>  	spin_unlock_irqrestore(&p9_poll_lock, flags);
> +
> +	flush_scheduled_work();

I suggest we should use flush_work(&p9_poll_work), flush_scheduled_work is not
suitable.

Thanks.

>  }
>  
>  /**
> 

