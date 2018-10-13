Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F49C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464EA20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTG4y1qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464EA20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJMV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:28:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeJMV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+XMwMXMjq9ROKzgzKBhLcRtyHTBtbPVhm0+mGC7F25k=; b=tTG4y1qZX3e+AOTlwqIM8VsFl
        ZI6NsUSboNcK+vog+UQlgu4r+p3qXD7ZB/+V5aDBJJ1+TCHtkmk2Zww1Pr8BQDov1l8GnT43Mdpsd
        xCYX8w5r8aqxU9jtDrYjpUhFq3UaAYPALjak0KUhEx0W0217S41zDGMzo+5YOQuE7BTkR81ML8HwW
        9P+a0rPZVNBGE/LWtjFtuTgr9DcN8XC+tn0olrnVzf+7eYcJ+OdUpTpx0bCn9RkHQ2KLrKChlDE/g
        3rus+31DMMwUUW83k9bctO6ePdmebIZt6RN+tqOoZ5TOm7KParB7U2a9PUYreaPWo08zgTXLh7Uuk
        4aGz1Pctg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBKJq-0005zA-9P; Sat, 13 Oct 2018 13:51:02 +0000
Received: by worktop (Postfix, from userid 1000)
        id C07B16E079E; Sat, 13 Oct 2018 15:50:58 +0200 (CEST)
Date:   Sat, 13 Oct 2018 15:50:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/kasan: make quarantine_lock a raw_spinlock_t
Message-ID: <20181013135058.GC4931@worktop.programming.kicks-ass.net>
References: <20181005163320.zkacovxvlih6blpp@linutronix.de>
 <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
 <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
 <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de>
 <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
 <20181010214945.5owshc3mlrh74z4b@linutronix.de>
 <20181012165655.f067886428a394dc7fbae7af@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012165655.f067886428a394dc7fbae7af@linux-foundation.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:56:55PM -0700, Andrew Morton wrote:
> There are several reasons for using raw_*, so an explanatory comment at
> each site is called for.
> 
> However it would be smarter to stop "using raw_* for several reasons". 
> Instead, create a differently named variant for each such reason.  ie, do
> 
> /*
>  * Nice comment goes here.  It explains all the possible reasons why -rt
>  * might use a raw_spin_lock when a spin_lock could otherwise be used.
>  */
> #define raw_spin_lock_for_rt	raw_spinlock
> 
> Then use raw_spin_lock_for_rt() at all such sites.

The whole raw_spinlock_t is for RT, no other reason. It is the one true
spinlock.

From this, it naturally follows that:

 - nesting order: raw_spinlock_t < spinlock_t < mutex_t
 - raw_spinlock_t sections must be bounded

The patch under discussion is the result of the nesting order rule; and
is allowed to violate the second rule, by virtue of it being debug code.

There are no other reasons; and I'm somewhat confused by what you
propose.
