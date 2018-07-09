Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA9C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M+Ew+s1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139B12087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeGIOYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:24:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qtKS4ikGJlKhL+8oKy83brpll21nO3rXe+PeVwFCfQ0=; b=M+Ew+s1i8/B5H7+Rkgwd4HdCI
        IbpPJPxARajoNezhgAj2MH1ztkk3C2CDJLasN0TfpZKT7GNLrD3hlhAROk56vTejuGgZ9wtHHnEX/
        +qO1GXfgWcg+BEHaBfoPZTdgSbmveeDTfEoCu2txGjLlPL5hP0DkrDEsbU3Mr/SVrvBQrSIOd/3q1
        LqBKoMWh0OH5JnddmL4xPvZzAPBgnWQDe0fU/0p6f01/yfsmaaRMZr7PuBbkybbheUnOQR+KBzqih
        J2mn6//eS5EuXdkxz19+8ginpVFMZArrxd/ay/QsCUrWXDuGWHHAk6kYsvE1CSP9/zvkaNBa2jZ03
        w8Nwnrm1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcX5p-0002JV-I6; Mon, 09 Jul 2018 14:24:45 +0000
Date:   Mon, 9 Jul 2018 07:24:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm <linux-mm@kvack.org>
Subject: Re: BUG: corrupted list in cpu_stop_queue_work
Message-ID: <20180709142445.GC2662@bombadil.infradead.org>
References: <00000000000032412205706753b5@google.com>
 <000000000000693c7d057087caf3@google.com>
 <1271c58e-876b-0df3-3224-319d82634663@I-love.SAKURA.ne.jp>
 <20180709133212.GA2662@bombadil.infradead.org>
 <8b258017-8817-8050-14a5-5e55c56bbf18@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b258017-8817-8050-14a5-5e55c56bbf18@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:15:54PM +0900, Tetsuo Handa wrote:
> On 2018/07/09 22:32, Matthew Wilcox wrote:
> >> >From d6f24d6eecd79836502527624f8086f4e3e4c331 Mon Sep 17 00:00:00 2001
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Mon, 9 Jul 2018 15:58:44 +0900
> >> Subject: [PATCH] shmem: Fix crash upon xas_store() failure.
> >>
> >> syzbot is reporting list corruption [1]. This is because xas_store() from
> >> shmem_add_to_page_cache() is not handling memory allocation failure. Fix
> >> this by checking xas_error() after xas_store().
> > 
> > I have no idea why you wrote this patch on Monday when I already said
> > I knew what the problem was on Friday, fixed the problem and pushed it
> > out to my git tree on Saturday.
> > 
> 
> Because syzbot found a C reproducer on 2018/07/09 02:29 UTC, and your fix was
> not in time for a kernel version syzbot was testing, and you were not listed
> as a recipient of this bug, and I didn't know you already fixed this bug.
> 
> Anyway, linux-next-20180709 still does not have this fix.
> What is the title of your fix you pushed on Saturday?

I folded it into shmem: Convert shmem_add_to_page_cache to XArray.
I can see it's fixed in today's linux-next.  I fixed it differently
from the way you fixed it, so if you're looking for an xas_error check
after xas_store, you won't find it.
