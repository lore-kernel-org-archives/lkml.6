Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D9DCDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D63320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ADby6NGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D63320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933581AbeFLJYo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:24:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33567 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbeFLJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:24:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so19352214oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fT4LvBQno4KmzP+ejnRwvqGk4h7hneauCpysJiUHZmI=;
        b=ADby6NGCnyo7yJiCjmWw3/PNbdP1LR12zUHCoKoWvh8Ama3Mkw+aRjh7QTlx00OGBW
         9gL9hQvu1VTRjgMX5WQAmAvztNi7nR61/tPJLr5DrVN4qBAVeAAO1Sna/lFuzAHUX4MN
         r97ghB0e+FP/FgcvV+vKU7un651ekWm6l/chA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fT4LvBQno4KmzP+ejnRwvqGk4h7hneauCpysJiUHZmI=;
        b=JrNsQOFJzN9HwQUeJl/5j0+5Dx+pj0DNaKmoA+xvX6ioXr9uGHDuSoxaSW+o5fmhN0
         zTuE7ZGSWtBJRmKPIBWjr+87mqT953bt9OYyHAy5EPUma+sf7kNH6slRCuhb99xgrb3L
         fYpukYNkpP2XVcoePFz+kN3hXizAwftkOKyN427EEiU8zK3q68kWcR4WMAVDKIc97HSK
         68NOjAMvtT66+AqVZYtZwweVa0CE9QMyERbvcI4Xy6FCxTEj+yvj7jJwM/R0Tmlkx7dL
         oWv2UJX83fGvoVpdKn1ATCfd2AaU24qGHIuRxiZtzN6/8kUTPwf8/AONso3WBBktqzYE
         v3FQ==
X-Gm-Message-State: APt69E1M4QQXIjZgArF15cb7TCoVLBRcV2JmNKUGH/AmqYtGXEUbVV/V
        WQAzoMQrQE6/eZOHj3sCu+qbcoJznt/AX0hWrVDxwg==
X-Google-Smtp-Source: ADUXVKJoRqrrCHA/i5PXuIy0Uz/e/A0Af20DkwHD8kHbHLwPTsPdeNFNo5uLzTIRmB0ByvqCaQKB+wVCESC1G0kEPwA=
X-Received: by 2002:aca:a646:: with SMTP id p67-v6mr1395545oie.149.1528795480393;
 Tue, 12 Jun 2018 02:24:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:24:39
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180612024029.GZ30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk> <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk> <20180612024029.GZ30522@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Jun 2018 11:24:39 +0200
Message-ID: <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
Subject: Re: [PATCH 14/39] ovl: stack file ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:40 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jun 12, 2018 at 03:29:26AM +0100, Al Viro wrote:
>
>> It might (or might not) work for the filesystems you'd been testing
>> on, but it's a lot of trouble waiting to happen.  Hell, try and use
>> ecryptfs as lower layer, see how fast it'll blow up.  Sure, it's
>> a dumb testcase, but I don't see how to check if something more
>> realistic is trouble-free.

That's funny, because when dhowells added the patch to make f_path
point to the overlay, I was fighting tooth and claw against that
change on the grounds of being unsafe, but it went through regardless
(and was in fact one of the biggest headaches in overlay/vfs
interaction).

So you might be right that there are bugs in the handling of ecryptfs,
etc, however the patchset is guaranteed not to cause regressions in
this area.

And yes, it would be best to get rid of that kludge once and for all.

>>
>> I'd been trying to come up with some way to salvage that kludge of yours,
>> but I don't see any solutions.  We don't have good proxies for "this
>> filesystem might be unsafe as lower layer" ;-/
>
> Note that anything that uses file_dentry() anywhere near ->open(),
> ->read_iter() or ->write_iter() is an instant trouble with your scheme.
> Such as
> int nfs_open(struct inode *inode, struct file *filp)
> {
>         struct nfs_open_context *ctx;
>
>         ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);
>         if (IS_ERR(ctx))
>                 return PTR_ERR(ctx);
>         nfs_file_set_open_context(filp, ctx);
>         put_nfs_open_context(ctx);
>         nfs_fscache_open_file(inode, filp);
>         return 0;
> }
>
> You do want to support NFS for lower layers, right?

There's no change regarding how file_dentry() works.  We've just
pushed these weird files (f_path points to overlay, f_inode points to
underlay) down into the guts of overlayfs and are not directly
referenced from the file table anymore.  That shouldn't make *any*
difference from the lower fs's pov.

The only difference is that now the real file has creds inherited from
mounter task.  If lower filesystem's a_ops did some permission
checking based on that, then that might make a difference in behavior.
But I guess that difference would be in the positive direction, making
behavior more consistent.

Thanks,
Miklos
