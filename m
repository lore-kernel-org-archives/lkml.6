Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C52C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C019720882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTNZ8yK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C019720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeGIIuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:50:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeGIIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W5stwuU4mtY1E404aWVJRmPcl5usRhmh2n4cmpjcHag=; b=nTNZ8yK5Gl5XN5oiLqKlzJQnK
        n0gAxTXddM3hhdp63fGSIRmrpTZG8DvBKN5MQAVnMJpdiPTnp+jH5pDACLFjFEm9tucCHtxvzobrM
        7BYBo0qzVUnx0suiUEwOoI1UxfKVps6vjFK0hYzjLOS4fUyJ6NLdlWs0wNSRcIyXisW/nYU48p/0x
        5nqqb8rn6XocFqUHKM7NpbqKHjXd0kONRYxrIld8827YCM/dzVv9H2vcoh8MA3OMJkoNhy5ZITEJO
        vuNZ6Ay6Oep/vE9xz/TZ+/JBvYkovE0Qm3tdlgqGkQwbJOhJCMZbLkjB/JI2HM7LjdRN4aAnS1laG
        izDRizC1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcRrn-0005oq-Kv; Mon, 09 Jul 2018 08:49:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDA6B2028932D; Mon,  9 Jul 2018 10:49:53 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:49:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Message-ID: <20180709084953.GB2476@hirez.programming.kicks-ass.net>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 10:54:28PM +0900, Tetsuo Handa wrote:
> >> Since syzbot is confused by concurrent printk() messages [1],
> >> this patch changes show_opcodes() to use snprintf().

But how big of a problem is that really? We can't very well remove all
pr_cont stuff from the kernel.


