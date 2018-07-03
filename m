Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1768EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ED52251D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ED52251D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933966AbeGCKGz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:06:55 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:34773 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933536AbeGCKGx (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Tue, 3 Jul 2018 06:06:53 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 03 Jul 2018 04:06:52 -0600
Message-Id: <5B3B4AB802000078001D0216@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Tue, 03 Jul 2018 04:06:48 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "David Laight" <David.Laight@ACULAB.COM>
Cc:     "Borislav Petkov" <bp@alien8.de>, <brgerst@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>, <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, <hpa@zytor.com>
Subject: RE: [tip:x86/asm] x86/entry/64: Add two more instruction
 suffixes
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
 <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
 <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
In-Reply-To: <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 03.07.18 at 10:46, <David.Laight@ACULAB.COM> wrote:
> From: Jan Beulich
>> Sent: 03 July 2018 09:36
> ...
>> As said there, omitting suffixes from instructions in AT&T mode is bad
>> practice when operand size cannot be determined by the assembler from
>> register operands, and is likely going to be warned about by upstream
>> gas in the future (mine does already).
> ...
>> -	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
>> +	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
> 
> Hmmm....
> Does the operand size make any difference at all for the bit instructions?
> I'm pretty sure that the cpus (386 onwards) have always done aligned 32bit
> transfers (the docs never actually said aligned).
> I can't remember whether 64bit mode allows immediates above 31.
> 
> So gas accepting 'btb $n,memory' is giving a false impression of
> what actually happens.

BTB does not exist at all. BTW and (on 64-bit) BTQ do exist though,
and they have behavior differing from BTL. The only AT&T syntax doc
I have says that L is the default suffix to be used, but there are cases
where this wasn't (and maybe still isn't) the case, so omitting a suffix
when register operands aren't available to size instructions has always
been a risky game.

Jan


