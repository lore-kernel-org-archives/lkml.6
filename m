Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5D0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CC820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZgB0vWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CC820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeGXDg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388201AbeGXDg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:36:27 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31452088E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532399538;
        bh=kBRqOkju9gMswCpAU2eiItITHJM85Ad+TL3ZmvR6BzY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kZgB0vWUTKiz6zqQ67f85jUKp5+lep991BiHafXjsIZskLK0Ok2Qh5bmiHwKIjFPm
         jA3s63HVj+5uuj/MeUNbmMHWVq78+3YNcwh6PB688TkJvVXiIxqZ1hb349I5H7Qw/d
         facgwK0J4DicPA4RAcDWGhHiO7tjOtj6R7ZuuIbU=
Received: by mail-wm0-f45.google.com with SMTP id h20-v6so914070wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 19:32:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlFNx0/k/lCBcK+3XecCaW0W6UCdKZBdpoU02adbwhIPazvSeOPX
        6T1flr7c8fkNP3Qmez0r3JIjW58I4q6HmDd+Wwi51A==
X-Google-Smtp-Source: AAOMgpdDjvbwEakFxocCScGY4bvZ202w4OQEQ5TFXCmr1JEib20svojYOFF6QzpVQHbi0LogTvt4K3BbX850y8Scix0=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr737734wma.21.1532399536276;
 Mon, 23 Jul 2018 19:32:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 19:31:55
 -0700 (PDT)
In-Reply-To: <20180723072505.GA24222@kroah.com>
References: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
 <20180723072505.GA24222@kroah.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Jul 2018 19:31:55 -0700
X-Gmail-Original-Message-ID: <CALCETrXiQkR+k8Dz9-sOpU_J7VK1uokC0Tor3dw704n=jMepMA@mail.gmail.com>
Message-ID: <CALCETrXiQkR+k8Dz9-sOpU_J7VK1uokC0Tor3dw704n=jMepMA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: Remove %ebx handling from error_entry/exit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:25 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Jul 22, 2018 at 11:05:09AM -0700, Andy Lutomirski wrote:
>> error_entry and error_exit communicate the user vs kernel status of
>> the frame using %ebx.  This is unnecessary -- the information is in
>> regs->cs.  Just use regs->cs.
>>
>> This makes error_entry simpler and makes error_exit more robust.
>>
>> It also fixes a nasty bug.  Before all the Spectre nonsense, The
>> xen_failsafe_callback entry point returned like this:
>>
>>         ALLOC_PT_GPREGS_ON_STACK
>>         SAVE_C_REGS
>>         SAVE_EXTRA_REGS
>>         ENCODE_FRAME_POINTER
>>         jmp     error_exit
>>
>> And it did not go through error_entry.  This was bogus: RBX
>> contained garbage, and error_exit expected a flag in RBX.
>> Fortunately, it generally contained *nonzero* garbage, so the
>> correct code path was used.  As part of the Spectre fixes, code was
>> added to clear RBX to mitigate certain speculation attacks.  Now,
>> depending on kernel configuration, RBX got zeroed and, when running
>> some Wine workloads, the kernel crashes.  This was introduced by:
>>
>>     commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>>     exceptions/interrupts, to reduce speculation attack surface")
>>
>> With this patch applied, RBX is no longer needed as a flag, and the
>> problem goes away.
>>
>> I suspect that malicious userspace could use this bug to crash the
>> kernel even without the offending patch applied, though.
>>
>> [Historical note: I wrote this patch as a cleanup before I was aware
>>  of the bug it fixed.]
>>
>> [Note to stable maintainers: this should probably get applied to all
>>  kernels.  If you're nervous about that, a more conservative fix to
>>  add xorl %ebx,%ebx; incl %ebx before the jump to error_exit should
>>  also fix the problem.]
>>
>> Cc: Brian Gerst <brgerst@gmail.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: xen-devel@lists.xenproject.org
>> Cc: x86@kernel.org
>> Cc: stable@vger.kernel.org
>> Fixes: 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")
>> Reported-and-tested-by: "M. Vefa Bicakci" <m.v.b@runbox.com>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>
>> I could also submit the conservative fix tagged for -stable and respin
>> this on top of it.  Ingo, Greg, what do you prefer?
>
> I don't care, this patch looks good to me to take as-is for the stable
> trees.  If you trust it in Linus's tree, it should be fine for others :)
>

My concern is more that something may work differently in older
kernels and there might be some subtle issue.  I'd be surprised, but
still.
