Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A516AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5FA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5FA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbeGWDiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:38:17 -0400
Received: from nautica.notk.org ([91.121.71.147]:52276 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbeGWDiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:38:17 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 180E1C009; Mon, 23 Jul 2018 04:39:22 +0200 (CEST)
Date:   Mon, 23 Jul 2018 04:39:07 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] [V9fs-developer] [PATCH] /net/9p/trans_fd.c: fix
 race-condition by flushing workqueue before the kfree()
Message-ID: <20180723023907.GA24608@nautica>
References: <20180720092730.27104-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720092730.27104-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Fri, Jul 20, 2018:
> The patch adds the flush in p9_mux_poll_stop() as it the function used by
> p9_conn_destroy(), in turn called by p9_fd_close() to stop the async
> polling associated with the data regarding the connection.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+39749ed7d9ef6dfb23f6@syzkaller.appspotmail.com

Looks good to me, I'm taking this patch.

If I had to say something, try to aim for slightly shorter subject lines
if possible :)

> ---
> As shown by Syzbot, it is possible to provoke a race between p9_fd_close() 
> and p9_poll_workfn() that is called to take care of the async read/write work
> to do. To make sure p9_fd_close() frees "trans" when it is not used anymore, 
> it has to explicitly flush p9_poll_work before the kfree().
> 
>  net/9p/trans_fd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index bf459ee0feab..a64b01c56e30 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -185,6 +185,8 @@ static void p9_mux_poll_stop(struct p9_conn *m)
>  	spin_lock_irqsave(&p9_poll_lock, flags);
>  	list_del_init(&m->poll_pending_link);
>  	spin_unlock_irqrestore(&p9_poll_lock, flags);
> +
> +	flush_work(&p9_poll_work);
>  }
>  
>  /**
-- 
Dominique Martinet
