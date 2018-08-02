Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7C52145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsk3nToc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7C52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHBKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:02:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HBgaOiMruk8i+DHyh0Y9ef7AOaUVeRWJb3Jp5D/zjWg=; b=gsk3nTocKHO3EZImXNhg30SIr
        cG9CRtT9uV/ksuh/bOYuoh6BH0dlS/pwoOkQDbaGgF17o1HOGLoTuEBYVvhkD3qJFVx10CdWwsvBc
        JZxONTSoqH/gbmmLs7l/9qzmjwZX3slH4X45Sjf2ThpQp4R+SB1+Pe1TbfVUMy+wsy0wSMICxLysL
        JP2y+UO8DoayFwT3K7gh4sPY7l/KiD68VK5mjh/E7ysOzX8zareY3TouVQZ4owzu0E+F2ShcbFHNj
        nCefFAKCKuRP9gdWq9UAPA0uQ3Pheu6sZEbWcSGIDmdB0R4dxnc6c84w3n49A8BINurUtSSz/yQ2r
        C2O8OzpVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fl8j8-0007PE-Lk; Thu, 02 Aug 2018 08:12:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 682D220268267; Thu,  2 Aug 2018 10:12:52 +0200 (CEST)
Date:   Thu, 2 Aug 2018 10:12:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     mingo@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, isaacm@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
Message-ID: <20180802081252.GG2494@hirez.programming.kicks-ass.net>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:34:40PM -0700, Sodagudi Prasad wrote:
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index e190d1e..f932e1e 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -87,9 +87,9 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct
> cpu_stop_work *work)
>                 __cpu_stop_queue_work(stopper, work, &wakeq);
>         else if (work->done)
>                 cpu_stop_signal_done(work->done);
> -       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> 
>         wake_up_q(&wakeq);
> +       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> 

That puts the wakeup back under stopper lock, which causes another
deadlock iirc.
