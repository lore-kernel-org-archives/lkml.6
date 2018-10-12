Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06983C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C462087F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C462087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeJMHbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 03:31:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeJMHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 03:31:45 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7127F7F;
        Fri, 12 Oct 2018 23:56:56 +0000 (UTC)
Date:   Fri, 12 Oct 2018 16:56:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/kasan: make quarantine_lock a raw_spinlock_t
Message-Id: <20181012165655.f067886428a394dc7fbae7af@linux-foundation.org>
In-Reply-To: <20181010214945.5owshc3mlrh74z4b@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
        <20181005163018.icbknlzymwjhdehi@linutronix.de>
        <20181005163320.zkacovxvlih6blpp@linutronix.de>
        <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
        <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
        <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
        <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
        <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
        <20181010095343.6qxved3owi6yokoa@linutronix.de>
        <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
        <20181010214945.5owshc3mlrh74z4b@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 23:49:45 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-10-10 11:57:41 [+0200], Dmitry Vyukov wrote:
> > Yes. Clark's patch looks good to me. Probably would be useful to add a
> > comment as to why raw spinlock is used (otherwise somebody may
> > refactor it back later).
> 
> If you really insist, I could add something but this didn't happen so
> far. git's changelog should provide enough information why to why it was
> changed.

Requiring code readers to look up changelogs in git is rather user-hostile.
There are several reasons for using raw_*, so an explanatory comment at
each site is called for.

However it would be smarter to stop "using raw_* for several reasons". 
Instead, create a differently named variant for each such reason.  ie, do

/*
 * Nice comment goes here.  It explains all the possible reasons why -rt
 * might use a raw_spin_lock when a spin_lock could otherwise be used.
 */
#define raw_spin_lock_for_rt	raw_spinlock

Then use raw_spin_lock_for_rt() at all such sites.
