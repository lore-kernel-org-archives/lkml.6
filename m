Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0CBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E9E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E9E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeGXLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:25:34 -0400
Received: from nautica.notk.org ([91.121.71.147]:53338 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388251AbeGXLZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:25:34 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id CE764C009; Tue, 24 Jul 2018 12:19:47 +0200 (CEST)
Date:   Tue, 24 Jul 2018 12:19:32 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     jiangyiwen <jiangyiwen@huawei.com>, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
Message-ID: <20180724101932.GA17454@nautica>
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
 <5B568374.9010507@huawei.com>
 <844e4101-6980-82dd-6f02-0a7193ed438c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <844e4101-6980-82dd-6f02-0a7193ed438c@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Tue, Jul 24, 2018:
> >> @@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
> >>  			req->t_err = err;
> >>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
> >>  	}
> >> +	spin_unlock(&m->client->lock);
> > 
> > If you want to expand the ranges of client->lock, the cancel_list will not
> > be necessary, you can optimize this code.
> > 
> 
> Unfortunately, not. Moving the spin_lock() before the for makes the
> crash appear again. This because the calls to list_move() in the for
> before delete all the elements from req->req_list, so the list is empty,
> another call to list_del() would trigger a double del.
> That's why we hold the lock to update the status of all those requests..
> otherwise we have again the race with p9_fd_cancel().

What (I think) he meant is that since you're holding the lock all the
way, you don't need to transfer all the items to a temporary list to
loop on it immediately afterwards, but you could call the client cb
directly.

I'm personally not a fan of this approach as that would duplicate the
code, even if the loop isn't big...

This code is only called at disconnect time so I think using the extra
list doesn't hurt anyone; but as usual do what you feel is better; I
don't mind much either way.

-- 
Dominique Martinet
