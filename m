Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB1BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D377E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548933768;
	bh=HMoqEBIIL8SeQEftUBvx/9KIyHY8YJOl0575CxwiqKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RYW09g7250jKSD2O7fTpG6VhMbI0BQKf57B9ifuvKghgOmX74qlLlzo8tWetF7TJ6
	 aSES8c5GGo/dTtJdNLZAtqdQMossurl+s4nNPzQNRs11Ym0ulL2+7iCuvzOcBCXFhD
	 sPQTX8jQmW9tPzh1FF88ghVjYV6T8bq3unuQxoeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbfAaLWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfAaLWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:22:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9183218E2;
        Thu, 31 Jan 2019 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548933764;
        bh=HMoqEBIIL8SeQEftUBvx/9KIyHY8YJOl0575CxwiqKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugubSKrfE1j9aq6rZMo3gaoufPZX0mIQVD4v6nsJz1ikf8YyA0VH0QndgWnk5xKmv
         YrAGrAl8E/wCvpwzRHgHlypL6A2IOH7VELJGH5kyQRdRGhihmvvvpaPdY+iwHvNlFY
         t1TF/u5pY4I7CKkTAbLY19PcxEu7OEWOFc14AA+g=
Date:   Thu, 31 Jan 2019 12:22:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in relay_open_buf
Message-ID: <20190131112241.GA8383@kroah.com>
References: <00000000000074cbc30580b16bc3@google.com>
 <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
 <CACT4Y+ZtG6Ef4vRApPuZsG0pquCV94Hg0KYBxpgpQueaG8STHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZtG6Ef4vRApPuZsG0pquCV94Hg0KYBxpgpQueaG8STHA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2019 at 12:16:42PM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 31, 2019 at 11:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 31, 2019 at 10:54:18PM +1300, Kees Cook wrote:
> > > On Thu, Jan 31, 2019 at 7:53 AM syzbot
> > > <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12cf10df400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=16c3a70e1e9b29346c43
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13266698c00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715bb64c00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
> > > >
> > > > kasan: CONFIG_KASAN_INLINE enabled
> > > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > > > CPU: 0 PID: 8092 Comm: syz-executor405 Not tainted 5.0.0-rc4-next-20190130
> > > > #22
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]
> > >
> > > static inline void relay_set_buf_dentry(struct rchan_buf *buf,
> > >                                         struct dentry *dentry)
> > > {
> > >         buf->dentry = dentry;
> > >         d_inode(buf->dentry)->i_size = buf->early_bytes; <--
> > > }
> > >
> > > Doing a bisect landed on this:
> > >
> > > ff9fb72bc07705c00795ca48631f7fffe24d2c6b ("debugfs: return error
> > > values, not NULL")
> > >
> > > If I revert this patch, I can't reproduce any more. I don't see a
> > > relationship, though...
> > >
> > > My crash appears as:
> > > [  121.934378] BUG: unable to handle kernel NULL pointer dereference
> > > at 0000000000000047
> > > [  121.937187] #PF error: [normal kernel read fault]
> > > [  121.938824] PGD 800000041f699067 P4D 800000041f699067 PUD 42d08f067 PMD 0
> > > [  121.941166] Oops: 0000 [#1] SMP PTI
> > > [  121.942381] CPU: 2 PID: 3134 Comm: relay Not tainted
> > > 5.0.0-rc4-next-20190130 #1020
> > > [  121.943873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.10.2-1ubuntu1 04/01/2014
> > > [  121.945395] RIP: 0010:relay_open_buf.part.10+0x2b8/0x330
> > > ...
> > > [  121.960021] Call Trace:
> > > [  121.960453]  relay_open+0x18e/0x2c0
> > > [  121.961070]  __blk_trace_setup+0x1af/0x350
> > > [  121.961777]  blk_trace_ioctl+0x93/0x100
> > >
> > >
> > > $ ./scripts/faddr2line vmlinux relay_open_buf.part.10+0x2b8/0x330
> > > relay_open_buf.part.10+0x2b8/0x330:
> > > relay_set_buf_dentry at kernel/relay.c:412
> > > (inlined by) relay_open_buf at kernel/relay.c:458
> > >
> > > So it's the same location, but not sure about 0x47 offset. d_inode is
> > > 0x58 from dentry. And i_size is 0x50 from inode. If this isn't NULL,
> > > but rather an ERR_PTR, the errno is either:
> > >
> > > EBADF 9 Bad file descriptor
> > > EEXIST 17 File exists
> > >
> > > Neither are used in the debugfs patch, but debugfs is clearly used in
> > > do_blk_trace_setup():
> > >
> > >         if (!blk_debugfs_root)
> > >                 return -ENOENT;
> > > ...
> > >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > >         if (!dir)
> > >                 bt->dir = dir = debugfs_create_dir(buts->name,
> > > blk_debugfs_root);
> > >         if (!dir)
> > >                 goto err;
> > > ...
> > >         bt->rchan = relay_open("trace", dir, buts->buf_size,
> > >                                 buts->buf_nr, &blk_relay_callbacks, bt);
> > >
> > > Which is confirmed by the next line in my traceback:
> > >
> > > $ ./scripts/faddr2line vmlinux __blk_trace_setup+0x1af/0x350
> > > __blk_trace_setup+0x1af/0x350:
> > > do_blk_trace_setup at kernel/trace/blktrace.c:534
> > > (inlined by) __blk_trace_setup at kernel/trace/blktrace.c:577
> >
> > Can you test the patch below?
> 
> 
> This can be done as self-service by saying:
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> 
> (is it the right tree/base commit for your change? a patch can
> generally be applied only to the tree/base commit that you used to
> obtain the diff)

It was close, wrong tree, try this:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-linus

And let's see if it works :)


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x

diff --git a/kernel/relay.c b/kernel/relay.c
index 04f248644e06..9e0f52375487 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -428,6 +428,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
 					   S_IRUSR, buf,
 					   &chan->is_global);
+	if (IS_ERR(dentry))
+		dentry = NULL;
 
 	kfree(tmpname);
 
@@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (WARN_ON(dentry))
+		if (IS_ERR_OR_NULL(dentry))
 			goto free_buf;
 	}
 

--zhXaljGHf11kAtnf--
