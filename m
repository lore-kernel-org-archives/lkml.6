Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA2FC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCD020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeLAHjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLAHjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:39:24 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC262080A;
        Fri, 30 Nov 2018 20:28:54 +0000 (UTC)
Date:   Fri, 30 Nov 2018 15:28:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181130152852.456ce379@gandalf.local.home>
In-Reply-To: <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
References: <20181129124404.2fe55dd0@gandalf.local.home>
        <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
        <20181129125857.75c55b96@gandalf.local.home>
        <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
        <20181129134725.6d86ade6@gandalf.local.home>
        <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
        <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
        <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
        <20181129202452.56f4j2wdct6qbaqo@treble>
        <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
        <20181130183917.hxmti5josgq4clti@treble>
        <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
        <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 12:18:33 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> Or we could replace that IPI with x86's bona fide serialize-all-cpus
> primitive and then we can just retry instead of emulating.  It's a
> piece of cake -- we just trigger an SMI :)  /me runs away.

I must have fallen on my head one too many times, because I really like
the idea of synchronizing all the CPUs with an SMI! (If that's even
possible). The IPI's that are sent are only to force smp_mb() on all
CPUs. Which should be something an SMI could do.

/me runs after Andy

-- Steve
