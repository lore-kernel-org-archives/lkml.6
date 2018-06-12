Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5D91C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA822089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vu1XqA1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA822089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935049AbeFLWzu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:55:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934002AbeFLWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qDOtPVXSvz/i+yNz3l5JiZWMhwzdk6Kd0mTMjrp2JRc=; b=Vu1XqA1WB6cYe7uFF4c5EaMts
        qbUvka8zDr5pOMCnaHX5YKDgbmOH1WnEenDvO4O5B7xF+a46t3OuHRDuxQiD+jtZsU3ZzQD06lApz
        ccRakZpiNsjSK3cAyy9fQck2wftQlt2aeoxRlj6s/YLCJ/WFmOZFGuMQRqKz7R3tZo+VCUup2Q1I9
        QHNXYrie0W7C4AjbCZRRUcXwmzVvTAftOMb3bK0OR2yav/AwvD8sCcLrEuk9uML9OjaiICa4KSwO5
        sZTgp09AiRQB+zZqyvR22ASvhUCgRARE3HupWQes2P9msTY/lAiUR8OhnHOwtg04kVNrXKhiabdvr
        W75kmAzAQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSsCS-0001JE-C2; Tue, 12 Jun 2018 22:55:40 +0000
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, quilt-dev@nongnu.org
References: <20180612083449.100099222@infradead.org>
 <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
 <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
 <alpine.DEB.2.21.1806122134410.1592@nanos.tec.linutronix.de>
 <20180612215411.wcma6o7zd6cbytkk@linutronix.de>
 <CA+55aFxCs+-6qNQoRLRx+-xzO_8dYXubK2B6LhuxObi7-ijbbw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a7b8827-56b7-254b-a410-f1c622b45b8f@infradead.org>
Date:   Tue, 12 Jun 2018 15:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxCs+-6qNQoRLRx+-xzO_8dYXubK2B6LhuxObi7-ijbbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 03:03 PM, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 2:54 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> mutt sets this and the tip-bot, too. The difference is that quilt also
>> sets the filename parameter. Do the mutt or tip-bot mails look flowed?
> 
> No, they look fine.
> 
> And yes, the difference looks to be that filename. Looking at the
> tipbot emails, I see:
> 
>   Content-Transfer-Encoding: 8bit
>   Content-Type: text/plain; charset=UTF-8
>   Content-Disposition: inline
> 
> and the email looks perfectly normal.
> 
> So it's not Content-Disposition itself that triggers it, it is indeed
> that *together* with filename information, so
> 
>   Content-Type: text/plain; charset=UTF-8
>   Content-Disposition: inline; filename=peterz-swait-1.patch
> 
> makes gmail go "Oh, I want to help you download this thing", and makes
> that "download attachment" widget, and makes the text itself act
> flowed.
> 
> Yeah, that's just stupid of gmail.
> 
> I've sent feedback, but judging by my last attempt to get something
> fixed (making the mobile application have a "Plain text" mode), I
> expect to be laughed at by some coked-up QA person who thinks "flowed"
> is obviously better.


FWIW, Peter's patches also show up in Thunderbird as attachments (at least
for me they do).

-- 
~Randy
