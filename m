Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E58C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BBA20834
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x1LoGKYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BBA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJXTIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeJXTIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:08:13 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B1920824;
        Wed, 24 Oct 2018 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540377638;
        bh=T7sgOfv6Pa9Qm0zkYYhd3EuEZxlK0I3rcidhsItzG6k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=x1LoGKYMhKlGO+0gn4UntRWo4DD/U2mrDTUanSA3dtgU3rZ1RWzU5afLJ0sSep5hW
         0qzICWjPdSUg+vTH3jnrfQlV5XMfjj5pnqFzsbb1gXqeymoLl7TjPIwkf4X3JShzAD
         r8UrZmnxN0KIkZA7E0Z9nxAoveFJcoOf1iJPjpA4=
Message-ID: <09f6038b7642f425eba162ea2239552e12da2045.camel@kernel.org>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs@googlegroups.com, Jan Harkes <jaharkes@cs.cmu.edu>,
        Mark Fasheh <mark@fasheh.com>
Date:   Wed, 24 Oct 2018 06:40:35 -0400
In-Reply-To: <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
References: <0000000000003852440576ef80b2@google.com>
         <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
         <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
         <20181024090959.s5y3azpsmtswjyn5@mwanda>
         <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 12:35 +0300, Amir Goldstein wrote:
> > > diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> > > index d35cd6be0675..93fb7cf0b92b 100644
> > > --- a/fs/lockd/host.c
> > > +++ b/fs/lockd/host.c
> > > @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct
> > > svc_rqst *rqstp,
> > >         };
> > >         struct lockd_net *ln = net_generic(net, lockd_net_id);
> > > 
> > > -       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> > > +       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
> > >                         (int)hostname_len, hostname, rqstp->rq_vers,
> > >                         (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
> > > 
> > 
> > Why wasn't this one applied?  It looks correct to me.  The rest seem to
> > have been fixed already.
> > 
> 
> I did not send this patch to Jeff.
> Jeff was CC'ed on the patch I sent to Miklos
> and Miklos decided to only take the overlayfs bits:
> https://marc.info/?l=linux-unionfs&m=153847248625015&w=2
> 
> So I guess it has fallen between the cracks.
> Feel free to send a patch to Jeff.
> 
> Thanks,
> Amir.

Actually, this should probably go to Bruce, as he mostly takes care of
lockd. Patch looks correct though.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

