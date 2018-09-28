Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C107C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2C21746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdHSyCVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2C21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeI1NXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:23:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1NXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Mc93IaSsturabhMWrsRZ7ic/mZqLn4FrDRgNHfl9yE=; b=MdHSyCVCgr8g0SmU9yqd+LhoH
        mx72faH7fz6QoteUNnBaGm2vMaf6Xa6vv7WM9e//UkB30Jq6dD/KLkD+O+daijg6PsfTe75OlaEb8
        96KS4Ckaro2c41JhG52Zz0mYNvwizbR5msQNNomiLWB6DMzTda1VYRCVDDuNqO2DTI/CTYXC9RVt+
        m87W7i5w5JZbyW1mSqyF1ADapIrkIYPsyOyidsFKqrIIeWhJocOYsiD4PiXNWOSmHB71oDG8F+qcg
        uLXZCuyaR7wXv7IL23s7uygVaPvYp8qvF7UuaqGLHtbTFl6lL4uYKI7tQb8aqTueqtc++uxBEpIlN
        y8QF1h85w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5mlY-0005R9-JP; Fri, 28 Sep 2018 07:00:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 445CE21070931; Fri, 28 Sep 2018 09:00:42 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:00:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
Message-ID: <20180928070042.GF3439@hirez.programming.kicks-ass.net>
References: <0000000000007523a60576e80a47@google.com>
 <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 08:06:26AM +0200, Dmitry Vyukov wrote:
> On Fri, Sep 28, 2018 at 7:51 AM, syzbot
> <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c307aaf3eb47 Merge tag 'iommu-fixes-v4.19-rc5' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13810df1400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com
> 
> +LOCKDEP maintainers,
> 
> What does this BUG mean? And how should it be fixed?
> 
> Thanks
> 
> > BUG: MAX_LOCKDEP_CHAINS too low!

Is the his result of endlessly loading and unloading modules?

In which case, the fix is: don't do that then.


