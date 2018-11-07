Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B722086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B722086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeKGVaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:30:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:45942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeKGVaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:30:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D666AAEFA;
        Wed,  7 Nov 2018 12:00:14 +0000 (UTC)
Date:   Wed, 7 Nov 2018 13:00:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Tetsuo Handa' <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181107120012.b5qynrwikjtqp2zx@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
 <8354d714f6b6489d9003d6e04ee10618@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8354d714f6b6489d9003d6e04ee10618@AcuMS.aculab.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-11-07 11:01:05, David Laight wrote:
> From: Tetsuo Handa
> > Sent: 07 November 2018 10:53
> A though:
> 
> Why not make the printf lock slightly 'sticky'?
> - If the output line is incomplete save the cpuid.
> - If there is a saved cpuid that doesn't match the current cpu then spin for a bit.
> 
> Any callers of printk() have to assume they will spin on the buffer for the
> longest printk formatting (and symbol lookup might take a while) so a short
> additional delay won't matter.

Disabling preemption for a single printk() is questionable. We have
spent many years trying to find an acceptable solution to avoid
softlockups and we did not fully succeeded.

And this patchset is about continuous lines. Therefore we would need
to disable preemption for all code intermixed with the related
printks. This does not have much chances to get accepted.


> Then two calls to printk() for the same line won't (usually) get split and
> none of the callers need any changes.

It would require changes to disable the preemption around the related
calls.

We could not do this without a better API and inspecting all users.
Note that we could not detect this by "\n" because it is too
error-prone.

Best Regards,
Petr
