Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA8FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D036C20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D036C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409654AbeKWWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:15:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388116AbeKWWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:15:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 433ED3620;
        Fri, 23 Nov 2018 03:31:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 532A33F5A0;
        Fri, 23 Nov 2018 03:31:34 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:31:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>, zhe.he@windriver.com,
        tglx@linutronix.de, rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181123113130.GA3360@arrakis.emea.arm.com>
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

With qwrlocks, the readers will normally block if there is a pending
writer (to avoid starving the writer), unless in_interrupt() when the
readers are allowed to starve a pending writer.

TLA+/PlusCal model here:  ;)

https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/qrwlock.tla

-- 
Catalin
