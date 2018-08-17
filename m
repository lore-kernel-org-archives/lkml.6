Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB64C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B27121A31
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B27121A31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeHQVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:43:08 -0400
Received: from fieldses.org ([173.255.197.46]:37232 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeHQVnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:43:07 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C5601BD9; Fri, 17 Aug 2018 14:38:40 -0400 (EDT)
Date:   Fri, 17 Aug 2018 14:38:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: general protection fault in send_sigurg_to_task
Message-ID: <20180817183840.GA12582@fieldses.org>
References: <0000000000007f59610573509684@google.com>
 <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org>
 <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
 <87o9e3gdtg.fsf@xmission.com>
 <CACT4Y+Yjj-n5BQvZhhM41fxxm57ABP1azEnrodmjZ65VrOcoxA@mail.gmail.com>
 <87d0ugc0pk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0ugc0pk.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 01:22:31PM -0500, Eric W. Biederman wrote:
> Dmitry Vyukov <dvyukov@google.com> writes:
> 
> > On Wed, Aug 15, 2018 at 9:01 PM, Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >> Dmitry Vyukov <dvyukov@google.com> writes:
> >>
> >>> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>>> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
> >>>>> syzbot has found a reproducer for the following crash on:
> >>>>>
> >>>>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
> >>>>> git tree:       linux-next
> >>>>
> >>>> I fetched linux-next but don't have 5ed5da74de9e.
> >>>
> >>> Hi Bruce,
> >>>
> >>> +Stephen for the disappeared linux-next commit.
> >>>
> >>> On the dashboard link you can see that it also happened on a more
> >>> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
> >>> now in linux-next.
> >>>
> >>>> I'm also not sure why I'm on the cc for this.
> >>>
> >>> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
> >>> as maintainer of the file, which is the file where the crash happened.
> >>
> >> You need to use your reproducer to bisect and find the commit that
> >> caused this.  Otherwise you will continue to confuse people.
> >>
> >> get_maintainer.pl is not a good target for automated reporting
> >> especially against linux-next.
> >
> > Hi Eric,
> >
> > We will do bisection.
> > But I afraid it will not give perfect attribution for a number of reasons:
> >  - broken build/boot which happens sometimes for prolonged periods and
> > prohibits bisection
> >  - elusive races that can't be reproduced reliably and thus bisection
> > can give wrong results
> >  - bugs introduced too long ago (e.g. author email is not even valid today)
> >  - reproducers triggering more than 1 bug, so base bisection commit
> > can actually be for another bug, or bisection can switch from one bug
> > to another
> >  - last but not least, bugs without reproducers
> > Bisection will add useful information to the bug report, but it will
> > not necessary make attribution better than it is now.
> >
> > Do you have more examples where bugs were misreported? From what I see
> > current attrition works well. There are episodic fallouts, but well,
> > nothing is perfect in this world. Humans don't bisect frequently and
> > misreport sometimes. I think we just need to re-route bugs in such
> > cases.
> 
> I have yet to see syzbot make a good report.  Especially against
> linux-next.

It did result in a fix (thanks!): https://lkml.org/lkml/2018/8/16/47

So I'd call that a better-than-nothing report if not a great report?

There's some value just in timeliness; it's a lot easier for me to fix a
bug that I introduced in the last few days, with the change still fresh
in my mind....

--b.
