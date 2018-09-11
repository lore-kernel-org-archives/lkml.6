Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07921C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D3120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irAh/EVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D3120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeIKStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:49:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZv7ZRr+ODS2qpif3H7gy3h5Ic8KbX0j8evaPRf0blo=; b=irAh/EVZObp0zItpATqhTSLrE
        oY0dG3HCVKyl350qDib/u9utel22rRSf4vr6b/ZX/9/FDrQ95Jtxh5Rn5p0ZVdX7hOzUfpjooY5j4
        +N3kkU2wuaKNsQpBrRL1ttunDvL0r4+r2eCh1o7W6+37iAvFB91TH1m9+BKrv3BSC2xq1cnpL+UKt
        gJY0ExpRcTawyR6OJiYehMtBuzYVtz5VfsqPfEHrJib9YohlvNpIFNdnBvw/639UrhylM8rHt7FY5
        /C8nMs+w2UUC8DlM7WM/emfuZpzCIVI2hW9aoyLMaoOU9i3gHCpnD57RQTv+rcyrvA9dkG+rq9aAf
        UI/vJLWnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzj3N-0007a1-Ob; Tue, 11 Sep 2018 13:50:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 417452057F828; Tue, 11 Sep 2018 15:50:04 +0200 (CEST)
Date:   Tue, 11 Sep 2018 15:50:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv3 6/6] tty/ldsem: Decrement wait_readers on timeouted
 down_read()
Message-ID: <20180911135004.GU24106@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-7-dima@arista.com>
 <20180911120258.GC19234@hirez.programming.kicks-ass.net>
 <1536670918.2710.29.camel@arista.com>
 <1536672802.2710.33.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536672802.2710.33.camel@arista.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:33:22PM +0100, Dmitry Safonov wrote:
> > > You might want to think about ditching that ldsem thing entirely,
> > > and use a regular rwsem ?
> > 
> > Yeah, but AFAICS, regular rwsem will need to have a timeout then (for
> > write). So, I thought fixing this pile would be simpler than adding
> > timeout and probably writer-priority to generic rwsem?
> > 
> > And I guess, we still will need fixes for stable for the bugs here..
> > 
> > I expect that timeouts are ABI, while the gain of adding priority may
> > be measured. I'll give it a shot (adding timeout/priority for linux-
> > next) to rwsem if you say it's acceptable.
> 
> Actually, priority looks quite simple: we can add writers in the head
> of wait_list and it probably may work.
> Timeout looks also not a rocket science.
> So, I can try to do that if you say it's acceptable (with the gain
> measures).

So why do you need writer priority? The comment that goes with ldsems
doesn't explain I think, it just says it has it.

In general I dislike unfair locks, they always cause trouble.

> After this can of worms that I need to fix regardless.

Sure.
