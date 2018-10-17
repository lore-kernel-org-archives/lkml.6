Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76F2214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYBJ9YqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76F2214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:52:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=51V0OGFB51gOBIo+ldcrua/+UtLzwkNCMJ7Czh3dCsQ=; b=LYBJ9YqNQpgObcF6/XuGPHdFB
        bCO2Kxm4Lezqpqeo0y6ypJvxsNTaNo98IQFxLhzB7fPnG4cFa+mfx6row+oY/lCAXrLfkzLB6Cvsj
        rOjotDSLye4WBdD7ddY9Ns581igz3fqaebz3n1w1znwoe5FDkq6mKKDnBoQ4NQevBm85+IklVsgFC
        S74z3kBR/K9yzT4DpLovsBffUoNimlFLAF4c4TZlnouymRFC24zprSSdSUPpdw/G/Plc6pebHoQN7
        FsaOHeE1wwj3t1ro+vREGod0/nuxCF4krm7TboqqX7wrF76O0GKZG0c0dlTx0aJIgMTmglbQDpWJ6
        vDP0fwLXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCghv-0008UA-0v; Wed, 17 Oct 2018 07:57:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5D4A2029856B; Wed, 17 Oct 2018 09:57:28 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181017075728.GF3121@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
 <20181017043251.GC1068@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017043251.GC1068@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:32:51PM +0900, Sergey Senozhatsky wrote:
> This probably will be a bit more hairy. logbuf is written to by many
> sources and is read from by many sides, including user-space [both read()
> and write()]. So we will need more flags/magic around memcpy(). A simple,
> "grab the logbuf entry, set the proper offset to point to the next available
> logbuf record and then do memcpy()" won't suffice. We need a flag for
> "memcpy() complete, we can read this entry". Otherwise:

Sure, but lockless buffers mostly have reserve and commit stages anyway.
Exactly to avoid that problem.

> All right. OK. So we are on the same page here:

> - Have more opinions on this. People please speak out.
> - Have clear "let's do it" from Cc-ed people.
> 
> 
> If we are really doing this, then let's split it and have
> incremental changes. Namely, what I suggest is:

I'd start by replacing logbuf with the lockless buffer and ripping out
the current nmi/safe/etc.. bollocks.

There is absolutely no point what so ever in doing anything until that
is sorted.

After that, move the console output to a kthread, but keep earlycon (if
set) synchronous.

Also avoid the whole panic/warn special case when earlycon is set, no
point in doing dodgy crap when you know you have a good option already.

