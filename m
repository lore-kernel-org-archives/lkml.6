Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A0F279A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Fdt0MkxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A0F279A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935690AbeF1U4s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:56:48 -0400
Received: from mail.efficios.com ([167.114.142.138]:50146 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeF1U4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:56:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C10B922EA6A;
        Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id oFwiNID3aV5X; Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 77DC322EA67;
        Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 77DC322EA67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530219405;
        bh=7dnHIL3lY3zJkvdfIyJkkzbkHK4giwmfZCtI66wF5ic=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Fdt0MkxUBDGJB9DDxTWbrhFuKWlbGthiqKWAffsQ7deVM2FGBt1pyUGHAu4mHhuNp
         1lzuFKvGtNrLeXm4Uqum+7xbH+CwQTX7tkHHwZZnC95hoF9NQQnqnZHrXEc6o9AkFj
         P0T7/ercmuoNugbLDJkDksV1sg83Az5TunzEGFpxOtYcfWwfA9wVD+RTxbLRZufutQ
         sJhPB34+VWQVQMFeu31UgPQRZp42jIbg0drje/N/ATFdcrG9Kiv2Nb33z+6haGHeg5
         SPzmWisMbymHfZxg48wrZ54b3jy9DNLsemWIkCr9GKjKMnkSsiEzo6zKEvqsGMuLYn
         VHeO8KHhc63SQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id sb2LLc0em6GE; Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 597FB22EA60;
        Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
Date:   Thu, 28 Jun 2018 16:56:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1074518629.9408.1530219405324.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: kHvWI6Urg2LteztK1iHd2b4YHD36iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 4:22 PM, Andy Lutomirski luto@kernel.org wrote:

> On Thu, Jun 28, 2018 at 9:23 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Validating the abort_ip field of rseq_cs ensures that the kernel don't
>> return to an invalid address when returning to userspace after an abort.
>> I don't fully trust each architecture code to cleanly deal with invalid
>> return addresses.
>>
>> Validating the range [ start_ip, start_ip + post_commit_offset ] is an
>> extra validation step ensuring that userspace provides valid values to
>> describe the critical section.
>>
>> If validation fails, the process is killed with a segmentation fault.
>>
>> Change the rseq ABI so rseq_cs start_ip, post_commit_offset and abort_ip
>> fields are seen as 64-bit fields by both 32-bit and 64-bit kernels rather
>> that ignoring the 32 upper bits on 32-bit kernels. This ensures we have
>> a consistent behavior for a 32-bit binary executed on 32-bit kernels and
>> in compat mode on 64-bit kernels.
> 
> This is okay with me for a fix outside the merge window.  Can you do a
> followup for the next merge window that fixes it better, though?  In
> particular, TASK_SIZE is generally garbage.  I think a better fix
> would be something like adding a new arch-overridable helper like:
> 
> static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }
> 
> and overriding it on x86 as something like:
> 
> static inline unsigned long current_max_user_addr(void) {
> #ifdef CONFIG_IA32_EMULATION
>  return user_64bit_mode(current_pt_regs()) ? TASK_SIZE_MAX : (1UL << 32) - 1;
> #else
>  return TASK_SIZE_MAX;
> }
> 
> TASK_SIZE really needs to die.

Sure, I'll put it in my backlog.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
