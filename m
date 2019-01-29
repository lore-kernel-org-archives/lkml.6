Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTAjJxyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfA2Jdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:33:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfA2Jdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IgaUZh2ibqOOkXFFhAg4ZAn6SIM8qktSqVGBKR98ZL0=; b=oTAjJxyJtmZeS0TQV92asRNxV
        BaR+aWX+PY86wofvwsgYBYiS7XFYRhePfJhcIcijO6FC9rNvPlVi//aN9LScwqrC+FZyfDxVIhxf6
        nVJNxk2z/xKx705dfW6x1MPO+Ji7MtO8klnFhVQunhpl7XFS4yz0v52Ui2riXlqrKOeW7FqtxFHJS
        cDWDN7tzQJDrPTttRCCc0lc3AMdLIQQtXF5WyI7vXoW8KExwD33j1Q/MUx44whgJH/HO3BaKQBdYu
        iMuf1Vwq/XAtlBKzRNZb2C8zIH8IdNMhLhmH9iWSl1PI/SO5p2bNijSNzSbSfE7EBob1W/mQbHzWN
        mGaIg+1dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goPlo-0008Kn-TA; Tue, 29 Jan 2019 09:33:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9546A20101B8F; Tue, 29 Jan 2019 10:33:27 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:33:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190129093327.GE28485@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129090108.GA26906@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:01:08AM +0100, Heiko Carstens wrote:

> However now I see every now and then the following failure from the
> same test case:
> 
> tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.
> 
> 		/* ESRCH can happen only for non-robust PI mutexes where
> 		   the owner of the lock died.	*/
> 		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);
> 
> I just verified that this happened also without your patch, I just
> didn't see it since I started my tests with panic_on_warn=1 and the
> warning triggered always earlier.
> So, this seems to be something different.

*groan*... so while the other thing reproduced, I've not seen this
happen and I ran the test for hours.

I'll start it up again, see what happens..
