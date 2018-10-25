Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8486C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FEC20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FEC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJZAw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:52:56 -0400
Received: from fieldses.org ([173.255.197.46]:47360 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJZAw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CF8831E3D; Thu, 25 Oct 2018 12:19:27 -0400 (EDT)
Date:   Thu, 25 Oct 2018 12:19:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs@googlegroups.com, Jan Harkes <jaharkes@cs.cmu.edu>,
        Mark Fasheh <mark@fasheh.com>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
Message-ID: <20181025161927.GD5539@fieldses.org>
References: <0000000000003852440576ef80b2@google.com>
 <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
 <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
 <20181024090959.s5y3azpsmtswjyn5@mwanda>
 <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
 <09f6038b7642f425eba162ea2239552e12da2045.camel@kernel.org>
 <20181025150219.GA5539@fieldses.org>
 <CAOQ4uxh_WLVPnLt=r5j5wm7gET=C64RKGexGVdNyJK0d0aMr5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh_WLVPnLt=r5j5wm7gET=C64RKGexGVdNyJK0d0aMr5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 06:17:25PM +0300, Amir Goldstein wrote:
> On Thu, Oct 25, 2018 at 6:02 PM Bruce Fields <bfields@fieldses.org> wrote:
> 
> > > > So I guess it has fallen between the cracks.
> > > > Feel free to send a patch to Jeff.
> > > >
> > > > Thanks,
> > > > Amir.
> > >
> > > Actually, this should probably go to Bruce, as he mostly takes care of
> > > lockd. Patch looks correct though.
> >
> > Yes, if you could resend I'd be happy to handle it.--b.
> 
> Attached.

Thanks, queuing it up for 4.20 and stable.

--b.

> Thanks,
> Amir.

> From 40000f4dcbd5dd18a80efb6aef010f1164985583 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Fri, 28 Sep 2018 20:41:48 +0300
> Subject: [PATCH] lockd: fix access beyond unterminated strings in prints
> 
> printk format used %*s instead of %.*s, so hostname_len does not limit
> the number of bytes accessed from hostname.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/lockd/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index d35cd6be0675..93fb7cf0b92b 100644
> --- a/fs/lockd/host.c
> +++ b/fs/lockd/host.c
> @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct svc_rqst *rqstp,
>  	};
>  	struct lockd_net *ln = net_generic(net, lockd_net_id);
>  
> -	dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> +	dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
>  			(int)hostname_len, hostname, rqstp->rq_vers,
>  			(rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
>  
> -- 
> 2.17.1
> 

