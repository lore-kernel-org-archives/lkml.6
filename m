Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BB9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8189820C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfBZQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:38:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfBZQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E001D3695F;
        Tue, 26 Feb 2019 16:38:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id E67B15D6B6;
        Tue, 26 Feb 2019 16:38:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Feb 2019 17:38:25 +0100 (CET)
Date:   Tue, 26 Feb 2019 17:38:22 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190226163821.GC21443@redhat.com>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
 <20190205111757.oieqgdcdnctoegav@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205111757.oieqgdcdnctoegav@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 26 Feb 2019 16:38:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Sorry, I just noticed your email...

On 02/05, Sebastian Andrzej Siewior wrote:
>
> On 2019-01-21 12:21:17 [+0100], Oleg Nesterov wrote:
> > > This is part of our ABI for *sure*.  Inspecting that state is how
> > > userspace makes sense of MPX or protection keys faults.  We even use
> > > this in selftests/.
> >
> > Yes.
> >
> > And in any case I do not understand the idea to use the second in-kernel struct fpu.
> > A signal handler can be interrupted by another signal, this will need to save/restore
> > the FPU state again.
>
> So I assumed that while SIGUSR1 is handled SIGUSR2 will wait until the
> current signal is handled. So no interruption. But then SIGSEGV is
> probably the exception which will interrupt SIGUSR1. So we would need a
> third one…

I guess you do not need my answer, but just in case.

SIGSEGV is not an exception. A SIGUSR1 handler can be interrupted by any other
signal which is not included in sigaction->sa_mask. Even SIGUSR1 can interrupt
the handler if SA_NODEFER was used.


> The idea was to save the FPU state in-kernel so we don't have to
> revalidate everything because userspace had access to it and could do
> things.

I understand, but this simply can't work, see above.

Oleg.

