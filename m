Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B26C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C1027A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhaSoE5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1027A68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeF1XaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbeF1XaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:30:18 -0400
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com [209.85.128.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584AB27A64
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530228617;
        bh=UHPcfjjF3HVJ2SeYOqaQCEBTsZgrZ/bh5l6vCRIibYI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NhaSoE5aSX8cBEtSH2PPdzZKnMOCpk+o3w6/RuqZSc7uV2Pk8CfZP77Gw51eFryWT
         XVfpzN9uxfmPtOEi0qe2lhIQZsbJUcO/izfmplfPQxPOxmkaMv7ZvZHNa8VJvlj8TG
         cOZPi5Pki5XfTUei+z7YSTtUa7urP9tGvkjaiYbw=
Received: by mail-wr0-f170.google.com with SMTP id c5-v6so7066064wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 16:30:17 -0700 (PDT)
X-Gm-Message-State: APt69E3IO9i5drm8VHrVo5CUb4Jedm5Fjx5e6szwF/iPnucWKivBFErh
        yS4V8oY1BJr9akSUVKFpBiq+QUd1VTzNfipZ8irWTQ==
X-Google-Smtp-Source: AAOMgpc2qFDrB6TkcI56wU2wwvzPCR085o9UksVldTec96mes8dxp2KrAlQkucnP0JsUTS8PYrq41rjpvqgwHlJfa20=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr10072993wrd.67.1530228615843;
 Thu, 28 Jun 2018 16:30:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 16:29:55
 -0700 (PDT)
In-Reply-To: <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jun 2018 16:29:55 -0700
X-Gmail-Original-Message-ID: <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
Message-ID: <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jun 28, 2018 at 1:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> This is okay with me for a fix outside the merge window.  Can you do a
>> followup for the next merge window that fixes it better, though?  In
>> particular, TASK_SIZE is generally garbage.  I think a better fix
>> would be something like adding a new arch-overridable helper like:
>>
>> static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }
>
> We already have that. It's called "user_addr_max()".

Nah, that one is more or less equivalent to TASK_SIZE_MAX, except that
it's different if set_fs() is used.

>
> It's the limit we use for user accesses.
>
> That said, I don't see why we should even check the IP. It's not like
> that's done by signal handling either.

The idea is that, if someone screws up and sticks a number like
0xbaadf00d00045678 into their rseq abort_ip in a 32-bit x86 program
(when they actually mean 0x00045678), we want to something consistent.
On a 32-bit kernel, presumably it gets cast to u32 somewhere and it
works.  On a 64-bit kernel, we end up shoving 0xbaadf00d00045678 into
regs->ip, and then the entry code will do, um, something.  If I had to
guess, I would guess that at least IRET is likely to truncate if we're
returning to a 32-bit CS.  But I really don't want to start promising
that we won't segfault if a different path gets invoked on some future
kernel on some future CPU of if we're on an AMD CPU using their
utterly braindead SYSRETL microcode, etc.

So I think we're much better off if we either promise that rseq
truncates the address for 32-bit users or that it segfaults if high
bits are set for 32-bit users.

TASK_SIZE is a super shitty way to do this.  The correct thing is to
either add some check to the exit-to-usermode slowpath that rseq can
trigger or if we add some reasonable way for rseq to say "is this
address a legitimate addressable virtual address for the current
task's user space operating mode."  We don't have such a thing right
now.
