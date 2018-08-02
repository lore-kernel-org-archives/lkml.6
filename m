Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50112C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F84F21531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F84F21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeHCAL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:11:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:60239 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeHCAL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:11:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3BC6DC009; Fri,  3 Aug 2018 00:18:45 +0200 (CEST)
Date:   Fri, 3 Aug 2018 00:18:30 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] INFO: task hung in grab_super
Message-ID: <20180802221830.GA18901@nautica>
References: <0000000000002f5541057143a85e@google.com>
 <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
 <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
 <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com>
 <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
 <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov via V9fs-developer wrote on Wed, Jul 18, 2018:
> >> Btw, I see that p9_client_rpc uses wait_event_killable, why wasn't it
> >> killed along with the whole process?
> >>
> >
> > wait_event_killable() would return -ERESTARTSYS if got SIGKILL.
> > But if (c->status == Connected) && (type == P9_TFLUSH) is also true,
> > it ignores SIGKILL by retrying the loop...
> >
> >   again:
> >     err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
> >     if ((err == -ERESTARTSYS) && (c->status == Connected) && (type == P9_TFLUSH)) {
> >       sigpending = 1;
> >       clear_thread_flag(TIF_SIGPENDING);
> >       goto again;
> >     }
> >
> > I wish they don't ignore SIGKILL (by e.g. offloading operations to a kernel thread).
> 
> 
> I guess that's the problem, right? SIGKILL-ed task must not ignore
> SIGKILL and hang in infinite loop. This would explain a bunch of hangs
> in 9p.

Tricky with the current way we handle this, as the normal action if
wait_event_killable is interrupted is to send a tflush message (which is
what you could also notice, if you just send one sigkill it'll just send
a flush message and wait for that instead)

There's work in progress to add refcounting to requests which would make
us one step closer to being able to not wait for the flush reply (or
rather, it'll give us the ability to wait for it asynchronously) ; we
should be able to get rid of that loop after that.

-- 
Dominique
