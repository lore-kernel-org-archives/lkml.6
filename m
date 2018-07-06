Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3517CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93DF2154B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjv+7kXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93DF2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGFQ3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:29:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGFQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SdU8zxVvfFp4x0TSEeVMIMI3vfopoQWImy5oMcyvABA=; b=rjv+7kXMzDnX/vZAjGJEEGTGy
        mk3oEzDhHwqPoxx7m3lHalHytI2mMGNeqxg+1wFmsAMn+ZpCMBISPxmJDwQr9ZzWgjOHROaPRX22w
        Lw2QwNWEYpnZf1CuHB+hd/OcY7WA8+10rwJmyKueJjfEBALK6uYSbNGfZ4XP4HdrHqijWl6LHIBYD
        Yt9hWjs6ogmcQBXSBUEai9s4LUsr+IlPy5IXyEk/wFoYiS240od5LNilDqGPgYST0rhkSrQbvve9L
        P+6Sr41ZCczxG3vF7mLq56YZ3ihEZRwoar0sfOnLrkJsdmAII79QEV2MlxL78E2c9cG0zsi/f59V9
        691Im2Y9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbTbX-0006Xw-GS; Fri, 06 Jul 2018 16:29:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 021F920291063; Fri,  6 Jul 2018 18:29:05 +0200 (CEST)
Date:   Fri, 6 Jul 2018 18:29:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:53:30PM +0100, David Woodhouse wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4d4e60..89f5814 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1616,7 +1616,8 @@ static inline int spin_needbreak(spinlock_t *lock)
>  
>  static __always_inline bool need_resched(void)
>  {
> -	return unlikely(tif_need_resched());
> +	return unlikely(tif_need_resched()) ||
> +		rcu_urgent_qs_requested();
>  }

Instead of making need_resched() touch two cachelines, I think I would
prefer adding resched_cpu() to rcu_request_urgent_qs_task().

The preempt state is alread a bit complicated and shadowed in the
preempt_count (on some architectures) adding additional bits to it like
this is just asking for trouble.


