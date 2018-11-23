Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA23520685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA23520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409581AbeKWVuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:50:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbeKWVuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:50:12 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gQ9Hn-0004cl-O2; Fri, 23 Nov 2018 12:06:11 +0100
Date:   Fri, 23 Nov 2018 12:06:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     zhe.he@windriver.com, catalin.marinas@arm.com, tglx@linutronix.de,
        rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181123110611.s2gmd237j7docrxt@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <20181123110226.GA5125@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123110226.GA5125@andrea>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-23 12:02:55 [+0100], Andrea Parri wrote:
> > is this an RT-only problem? Because mainline should not allow read->read
> > locking or read->write locking for reader-writer locks. If this only
> > happens on v4.18 and not on v4.19 then something must have fixed it.
> 
> Probably misunderstanding, but I'd say that read->read locking is "the
> norm"...?
> 
> If you don't use qrwlock, readers are also "recursive", in part.,
> 
>   P0			P1
>   read_lock(l)
> 			write_lock(l)
>   read_lock(l)
> 
> won't block P0 on the second read_lock().  (qrwlock somehow complicate
> the analysis; IIUC, they are recursive if and only if in_interrupt().).

ehm, peterz, is that true? My memory on that is that all readers will
block if there is a writer pending.

>   Andrea

Sebastian
