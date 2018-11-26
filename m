Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D688C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UATschJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC9820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKZTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:34:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dFfCRLDk1yob2SgCd+1I3aUGQ8QQYq7LIE7duVE0qvI=; b=UATschJSxShFT7IxiJ7jXlQ8N
        5fMMMj2K30Isa1o0nO+HbuRB1pBoqpCB0mgty7P9LvOrwQYvJKvguqH9cvjmrhmoUgc0AZ0VqQuht
        upqHweYjyKoSrz2/QBtQnSPexRyZqswQyTGaUjpDIH6zulZNZ3crjyho+UNcj9wacWCQ1/6a00/Gj
        3/53O6Sqj+NcqA/yt3ZaxIwInwswd6REMyBzMVsi6L8tGeZq0Rq5J3Ak28BqtLXWFFQYpxV4MWkAn
        ir0jY0cW2lvfBJ5EdciWxZSxGEXqsSqI9s96PgKQdUa5TgCf7Yr1+J6MkJGj5Yp2TiXYrRysOY4tV
        hWgTT3lZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRCRg-0002IN-0R; Mon, 26 Nov 2018 08:40:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09C6B2029FD58; Mon, 26 Nov 2018 09:40:42 +0100 (CET)
Date:   Mon, 26 Nov 2018 09:40:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        zhe.he@windriver.com, catalin.marinas@arm.com, tglx@linutronix.de,
        rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181126084042.GK2113@hirez.programming.kicks-ass.net>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <20181123110226.GA5125@andrea>
 <20181123110611.s2gmd237j7docrxt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123110611.s2gmd237j7docrxt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:06:11PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-23 12:02:55 [+0100], Andrea Parri wrote:
> > > is this an RT-only problem? Because mainline should not allow read->read
> > > locking or read->write locking for reader-writer locks. If this only
> > > happens on v4.18 and not on v4.19 then something must have fixed it.
> > 
> > Probably misunderstanding, but I'd say that read->read locking is "the
> > norm"...?
> > 
> > If you don't use qrwlock, readers are also "recursive", in part.,
> > 
> >   P0			P1
> >   read_lock(l)
> > 			write_lock(l)
> >   read_lock(l)
> > 
> > won't block P0 on the second read_lock().  (qrwlock somehow complicate
> > the analysis; IIUC, they are recursive if and only if in_interrupt().).
> 
> ehm, peterz, is that true? My memory on that is that all readers will
> block if there is a writer pending.

Since qrwlock is the more strict, all users should use its semantics.
Just like we cannot 'rely' on the unfairness of some lock
implementations.
