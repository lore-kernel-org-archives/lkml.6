Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0AF2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yhcl3i6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0AF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeH3Rud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:50:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3Rud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R3TBcVuhLPWyn2glzr6ojX6Qq9+f+P9w5Yk4UofKILE=; b=Yhcl3i6drgfn38rXTgkkgZARr
        Ls6lhqPX57ktp3i3Cobs8nvXXGgYv98+5ddXLfABhzqRVTUJYc9W2oJAC3Kx0YrhlkvGjXoxazDdi
        o7gTKtMsdALKGm3N+v4IVl2/O36PzrBdRK5qb2se8it8JqwfvGtQh7SJXT1eqJr7Ozgy83hnhbTUQ
        9WMIOH37JCa60sZrAVc2rViWAner+RGvRZgH4HPuQhXrKfPi1kxbbkCwMI+gnqwUD5ZopqSHQ2zf9
        xNGI2/JUPZzda3OByLONm3N17fJE4w2YXGy4Q/UZIkHgKbRsoAJCIfLb3PJmRGqaVNql5hzIgBn6E
        EM+w2dkHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNIy-00089a-KN; Thu, 30 Aug 2018 13:48:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F0432024EB08; Thu, 30 Aug 2018 15:48:10 +0200 (CEST)
Date:   Thu, 30 Aug 2018 15:48:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Siegfried Metz <frame@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, len.brown@intel.com, rjw@rjwysocki.net,
        diego.viola@gmail.com, rui.zhang@intel.com,
        viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180830134810.GV24142@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830130439.GM24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:04:39PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 12:55:30PM +0200, Siegfried Metz wrote:
> > Dear kernel developers,
> > 
> > since mainline kernel 4.18 (up to the latest mainline kernel 4.18.5)
> > Intel Core 2 Duo processors are affected by boot stalling early in the
> > boot process. As it is so early there is no dmesg output (or any log).
> > 
> > A few users in the Arch Linux community used git bisect and tracked the
> > issue down to this the bad commit:
> > 7197e77abcb65a71d0b21d67beb24f153a96055e clocksource: Remove kthread
> 
> I just dug out my core2duo laptop (Lenovo T500) and build a tip/master
> kernel for it (x86_64 debian distro .config).
> 
> Seems to boot just fine.. 3/3 so far.
> 
> Any other clues?

The .config from https://bugzilla.kernel.org/attachment.cgi?id=278183
seems to boot far enough to drop me into a busybox -- it doesn't seem to
contain enough bits to actually boot my system and I can't be arsed to
figure out what's missing.


