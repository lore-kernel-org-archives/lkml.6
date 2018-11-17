Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C194B20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFco6HLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C194B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeKQXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKQXuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:50:11 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB0720815;
        Sat, 17 Nov 2018 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542461609;
        bh=dFGN8PdJg014UIu9BoFXQh2tHHMqaZuhoakl7SwTt2E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fFco6HLxR+dncjWz6EBJhlt7rd8cSw0UajF3clplYiMfq9ZOQPTO7SQp2iPQg/uRY
         VEPF5a25HcqJ5HoC+fYUyPkOCQf6T3Lobwu99t0RpaKUdWqLWKP/tajs0ChV6VdXLD
         i7k2P7JHPAFAgVzm06bovVapsl4DJi/m+iPTJ66o=
Message-ID: <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
From:   Jeff Layton <jlayton@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>, NeilBrown <neilb@suse.com>
Cc:     syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat, 17 Nov 2018 08:33:27 -0500
In-Reply-To: <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
References: <000000000000222b58057a7d9f39@google.com>
         <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
         <87bm6svhhl.fsf@notabene.neil.brown.name>
         <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org>
         <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
         <87bm6pewnm.fsf@notabene.neil.brown.name>
         <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 12:37 -0800, Dmitry Vyukov wrote:
> On Thu, Nov 15, 2018 at 3:41 PM, NeilBrown <neilb@suse.com> wrote:
> > On Thu, Nov 15 2018, Dmitry Vyukov wrote:
> > 
> > > On Wed, Nov 14, 2018 at 2:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > > > On Wed, 2018-11-14 at 07:40 +1100, NeilBrown wrote:
> > > > > On Tue, Nov 13 2018, Jeff Layton wrote:
> > > > > 
> > > > > > On Mon, 2018-11-12 at 12:34 -0800, syzbot wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > syzbot found the following crash on:
> > > > > > > 
> > > > > > > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> > > > > > > git tree:       linux-next
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=115dbad5400000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a4a3d526b4157113ec6a
> > > > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > > > > 
> > > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > > > 
> > > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com
> > > 
> > > /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> > > 
> > > Hi Neil,
> > > 
> > > Please include the Reported-by tag next time.
> > 
> > I did, as you can see below.
> > 
> > When the fix is merged into the patch that introduced the bug, do you
> > still want the Reported-by there, even though the bug and the fix are no
> > longer visible?  What if I were to completely rewrite the patch - do I
> > still need the Reported-by??
> > 
> > I'm certainly happy to give credit where due, but keeping a complete
> > history of past bugs in a single commit seems excessive.
> > Please help me to understand your needs.
> 
> Here is the commit as I see it in linux-next:
> https://gist.githubusercontent.com/dvyukov/ac1791c98d95618a48548cef8df84558/raw/a3f819cca2f0bb47db0c2e88d35d020accb069b5/gistfile1.txt
> As far as I see it already includes the fix to locks_mandatory_area,
> but does not include the tag. Maybe it was merged somehow incorrectly.
>
> This is not so much about credit, but more about proper bug tracking.
> But reports on mailing lists are periodically being lost, and then it
> also may be hard to understand when a new crash is a new bug which
> needs to be reported again or an old lost bug.
> syzbot keeps track of all reported bugs and has a notion of
> open/active reports that still need human attention:
> https://syzkaller.appspot.com/#upstream
> and fixed/closed reports that don't need human attention anymore.
> The Reported-by tags are intercepted by syzbot and allows it to
> understand when a bug is fixed and needs to be closed.
> Keeping track of this is important for 2 reasons:
> 1. Closed/fixed bugs go away from the dashboard, so people don't go
> over them again and again.
> 2. If a bug is closed, syzbot will report new similarly looking bugs
> in future (otherwise it will just merge new crashes into the old bug,
> because it thinks it's still the old bug happenning).
> 
> linux-next is somewhat special because commits are being amended, so a
> commit can effectively fix itself. But one way or another syzbot needs
> to know about fixes. Reported-by tags take care of all tracking.
> Otherwise, a human needs to first notice that there is an already
> fixed bug that is still considered open, find the fixing commit and
> issue the "#syz fix" command as I did above. This is especially
> problematic for linux-next as it changes and bisection does not work.
> Here is more info on syzbot bug status tracking:
> https://goo.gl/tpsmEJ#bug-status-tracking
> 

Thanks for the explanation, Dmitry. I've added the tag to the patch in
my tree. It should show up in linux-next soon.

I still find it a little misleading to say that syzbot reported a bug
when it actually found a bug inside an earlier version of the patch, but
I'll just learn to get over it.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

