Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9447C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D2A20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D2A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJYXfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:35:30 -0400
Received: from fieldses.org ([173.255.197.46]:47162 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJYXfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:35:30 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A59551E3D; Thu, 25 Oct 2018 11:02:19 -0400 (EDT)
Date:   Thu, 25 Oct 2018 11:02:19 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20181025150219.GA5539@fieldses.org>
References: <0000000000003852440576ef80b2@google.com>
 <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
 <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
 <20181024090959.s5y3azpsmtswjyn5@mwanda>
 <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
 <09f6038b7642f425eba162ea2239552e12da2045.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f6038b7642f425eba162ea2239552e12da2045.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 06:40:35AM -0400, Jeff Layton wrote:
> On Wed, 2018-10-24 at 12:35 +0300, Amir Goldstein wrote:
> > > > diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> > > > index d35cd6be0675..93fb7cf0b92b 100644
> > > > --- a/fs/lockd/host.c
> > > > +++ b/fs/lockd/host.c
> > > > @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct
> > > > svc_rqst *rqstp,
> > > >         };
> > > >         struct lockd_net *ln = net_generic(net, lockd_net_id);
> > > > 
> > > > -       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> > > > +       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
> > > >                         (int)hostname_len, hostname, rqstp->rq_vers,
> > > >                         (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
> > > > 
> > > 
> > > Why wasn't this one applied?  It looks correct to me.  The rest seem to
> > > have been fixed already.
> > > 
> > 
> > I did not send this patch to Jeff.
> > Jeff was CC'ed on the patch I sent to Miklos
> > and Miklos decided to only take the overlayfs bits:
> > https://marc.info/?l=linux-unionfs&m=153847248625015&w=2
> > 
> > So I guess it has fallen between the cracks.
> > Feel free to send a patch to Jeff.
> > 
> > Thanks,
> > Amir.
> 
> Actually, this should probably go to Bruce, as he mostly takes care of
> lockd. Patch looks correct though.

Yes, if you could resend I'd be happy to handle it.--b.
