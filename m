Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615AEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121BF216ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRnrplIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121BF216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeHGWoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeHGWoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:44:55 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B536521731
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533673726;
        bh=j/ohKG4q6gqn4sbAAw09R8Kom1LBCU9eO5goFLkDhnE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lRnrplIJfvdcnCRySoL7MOAI8xn43qRFitktNW97beT3crGst78ChXqmm7232iP4h
         rJP/u8moZCVN3bvwqhtMekMZ2e+Oj2lITqrgJprxyzoV2HBpnt9UPJcYBtinwCuUW8
         WLJMUB53a5iw8jwxdkeWC1wnXLult/V+TdQMVuE0=
Received: by mail-wr1-f53.google.com with SMTP id r16-v6so16924681wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:28:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlGn1OU/qVNiAyeZvhbN9VOfcQBL18Fy6ra2gMHcc58AvcwZnyda
        Y0RA7z9NR35Qi9UexY8wrd+LIhwHINoV1pjl0TUGvg==
X-Google-Smtp-Source: AAOMgpfTYaHD9dKZMajod5mRGE4QN/OjhOU8jlSEPaARVlrExYDpWa2qtcD4yVRuA2foT/3T7clEKvQvvn2DAUqb0A8=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr13388789wrd.67.1533673724192;
 Tue, 07 Aug 2018 13:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 13:28:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1808072218310.1672@nanos.tec.linutronix.de>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
 <1533637471-30953-3-git-send-email-joro@8bytes.org> <feea2aff-91ff-89a6-9d7c-5402a1d6a27f@intel.com>
 <CALCETrXj1-CC-rcnM5s2SvbSFKjZPMYj0O-9d1PY0MRdGEKs-g@mail.gmail.com> <alpine.DEB.2.21.1808072218310.1672@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 7 Aug 2018 13:28:23 -0700
X-Gmail-Original-Message-ID: <CALCETrX4e=U21c+_9u_PrvJecDpjKiuQ-KGeW=Z3ME=a2=Kj9Q@mail.gmail.com>
Message-ID: <CALCETrX4e=U21c+_9u_PrvJecDpjKiuQ-KGeW=Z3ME=a2=Kj9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mm/pti: Don't clear permissions in pti_clone_pmd()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 7 Aug 2018, Andy Lutomirski wrote:
>
>> On Tue, Aug 7, 2018 at 11:34 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>> > On 08/07/2018 03:24 AM, Joerg Roedel wrote:
>> >> The function sets the global-bit on cloned PMD entries,
>> >> which only makes sense when the permissions are identical
>> >> between the user and the kernel page-table.
>> >>
>> >> Further, only write-permissions are cleared for entry-text
>> >> and kernel-text sections, which are not writeable anyway.
>> >
>> > I think this patch is correct, but I'd be curious if Andy remembers why
>> > we chose to clear _PAGE_RW on these things.  It might have been that we
>> > were trying to say that the *entry* code shouldn't write to this stuff,
>> > regardless of whether the normal kernel can.
>> >
>> > But, either way, I agree with the logic here that Global pages must
>> > share permissions between both mappings, so feel free to add my Ack.  I
>> > just want to make sure Andy doesn't remember some detail I'm forgetting.
>>
>> I suspect it's because we used to (and maybe still do) initialize the
>> user tables before mark_read_only().
>
> We still do that because we need the entry stuff working for interrupts
> early on. We now repeat the clone after mark_ro so the mask RW is not
> longer required.

Agreed.
