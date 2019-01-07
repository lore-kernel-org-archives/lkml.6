Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CE1206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jP2wvDVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfAGPbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:31:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfAGPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhK0lQAb/T5Qb5P/c+gcywcn+Yx+I8NF2/YJfH4L2Cw=; b=jP2wvDVajxT7WYgavzqXL612V
        eQazChXO42iMuXy1lSyJE9tYg2O2CUBxmzJIN6T3wl2+fMAYC6wCUPtM2ZheODvjquXXkgdo7a1u7
        qVXqiMg55HEnzxvAZTLw2oW35afcKX8QaWwh/bThB2UpDnq92dyqkvdEujALMOX2KO+iZHT8Q8PEL
        Vee/Y3N+imoy7SY9PxtjhhWiesLBuSD0jtZVrUZLm6uua7XrpooeYGCbK0lOH7bms3C+76nJBI1WZ
        KN2nncpZ7t1J2+pU5ndiYEqSm9UtS1PDa+quRdqymnQFfHfxjpzlbS88vyppxRWrzSPtGJ9dem/Yj
        Vhgcivq0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggWsA-0006C0-Pp; Mon, 07 Jan 2019 15:31:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C4BC20074A04; Mon,  7 Jan 2019 16:31:25 +0100 (CET)
Date:   Mon, 7 Jan 2019 16:31:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>, dave@stgolabs.net,
        mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20190107153125.GL2218@hirez.programming.kicks-ass.net>
References: <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <CAONzpcbvyvXdUEL6Mc8_kN_Z_=jYiRCzDScSWH07+MOtbgxdKQ@mail.gmail.com>
 <f85780cd-6d90-6cf3-2474-4f9998f5cbd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85780cd-6d90-6cf3-2474-4f9998f5cbd5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:35:09AM -0500, Waiman Long wrote:
> On 12/17/2018 08:12 AM, Yongji Xie wrote:
> > On Mon, 17 Dec 2018 at 19:37, Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Mon, Dec 10, 2018 at 11:12:52PM +0800, Yongji Xie wrote:
> >>> Hi Peter,
> >>>
> >>> Please let me know If there is any progress on this issue. Thank you!
> >> Right, sorry, my brain was filled with snot and didn't want to make
> >> sense of things.
> >>
> >> I've put some patches here:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> >>
> >> Could you have a look?
> > That looks good to me. Thank you!
> >
> > Thanks,
> > Yongji
> 
> Peter,
> 
> Are you planning to move the patch over to tip as the merge window has
> just closed?

Sorry; yes, probably, I just got back from a 2 week holiday and am
somewhat scrambling to remember where I left off and what all landed in
my inbox.
