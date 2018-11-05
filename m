Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE6ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ED520685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBijIlt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ED520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeKEO3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbeKEO3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:29:05 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC4F20831
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 05:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541394676;
        bh=O2FcUxcPfqPvG81mXAb+uBplQOwz6o8FdobLeGzKjxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MBijIlt35QmMnLYQ7nEEh0txrej1rU9sKDrDZYBYcZiwIl3x5kiP03e44IL0GvgsL
         LzMxFo4p+EgS4lzhbmaPdwMHG+YoJpK62KvgLjT1E1RvtArni/9/Yw4cAbc/M9WkYx
         +ch0XDxBzczLnQOjPiqldZV/CtCmk9jsHX9OweFo=
Received: by mail-wr1-f47.google.com with SMTP id j17-v6so2817955wrq.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 21:11:16 -0800 (PST)
X-Gm-Message-State: AGRZ1gLxmrg5jizAH8InvC1W+nkjb0wVvn8Y3aXXVRRYJ2gdGLZzN9AE
        ZmEchihiZeqeNSDJgTJlrm4MUuiz9nSJC6/U1FeHcw==
X-Google-Smtp-Source: AJdET5eUpCuo429smUHwrhX08vPFmXAmh0ItBJQAX0xHt/ttQoZhLjeZjoV04DMdUCltdkfpnouV0NRQpGQZyDQVOco=
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr18054542wrr.308.1541394674808;
 Sun, 04 Nov 2018 21:11:14 -0800 (PST)
MIME-Version: 1.0
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com> <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
 <47b1c477-46a7-6b04-7537-378e2910611b@intel.com>
In-Reply-To: <47b1c477-46a7-6b04-7537-378e2910611b@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 4 Nov 2018 21:11:03 -0800
X-Gmail-Original-Message-ID: <CALCETrV0RYZPbZ0vyRehvS=L-yZwLQ06=eov+=GkzFm0GoQQpQ@mail.gmail.com>
Message-ID: <CALCETrV0RYZPbZ0vyRehvS=L-yZwLQ06=eov+=GkzFm0GoQQpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:28 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/2/18 12:50 PM, Waiman Long wrote:
> > On 11/02/2018 03:44 PM, Dave Hansen wrote:
> >> On 11/2/18 12:40 PM, Waiman Long wrote:
> >>> The 64k+ limit check is kind of arbitrary. So the check is now removed
> >>> to just let expand_stack() decide if a segmentation fault should happen.
> >> With the 64k check removed, what's the next limit that we bump into?  Is
> >> it just the stack_guard_gap space above the next-lowest VMA?
> > I think it is both the stack_guard_gap space above the next lowest VMA
> > and the rlimit(RLIMIT_STACK).
>
> The gap seems to be hundreds of megabytes, typically where RLIMIT_STACK
> is 8MB by default, so RLIMIT_STACK is likely to be the practical limit
> that will be hit.  So, practically, we've taken a ~64k area that we
> would on-demand extend the stack into in one go, and turned that into a
> the full ~8MB area that you could have expanded into anyway, but all at
> once.
>
> That doesn't seem too insane, especially since we don't physically back
> the 8MB or anything.  Logically, it also seems like you *should* be able
> to touch any bit of the stack within the rlimit.
>
> But, on the other hand, as our comments say: "Accessing the stack below
> %sp is always a bug."  Have we been unsuccessful in convincing our gcc
> buddies of this?

FWIW, the old code is a bit bogus.  Why are we restricting the range
of stack expending addresses for user code without restricting the
range of kernel uaccess addresses that would do the same thing?

So I think I agree with the patch.
