Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED2BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D122087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3+jim9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D122087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGMXes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbeGMXes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:34:48 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33D4208D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 23:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531523883;
        bh=4EaLm3wN0rac96ZCA9ahQFGB3PdOw1zsc4jCCwMooGU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=X3+jim9JdaQG6Rtn0ypQ6/EeZymFN/eUs8ttaDSceVJxLyHIVJcmZJ5m3HiDb4eVT
         NdlglmQz8uGryr2dMUb1sFtrZJA1xnE7itj0wx7LO6Xcl511hcaQrrblhO9KnbPcUJ
         7bDrk1EimsZAvMyyWpygbm29zdD6Unb+nutIMsWE=
Received: by mail-wr1-f50.google.com with SMTP id r16-v6so26527418wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:18:02 -0700 (PDT)
X-Gm-Message-State: AOUpUlFYY4LRLn+gu4aKs6OsC/dq3/HfZZCCj2jcGGNYmNrlyTWmQy96
        VKdio1WTO4xH7uRXPOrV2tUpaoDiTX8hqSlNuX6lcQ==
X-Google-Smtp-Source: AAOMgpflTBAJ04+cj1Te8uznzB7/M++y7TIFfuXHDGjJiXxyi3BS8DxFF3/B7teuHP/z9f7OrXklnk6SXXtbRDYCObo=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr5893427wrs.171.1531523881112;
 Fri, 13 Jul 2018 16:18:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:17:40
 -0700 (PDT)
In-Reply-To: <CALCETrUP1QUKPLPJg6_L5=Mzmq33cSvq+NMaYW01wTCepdjCyg@mail.gmail.com>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-4-git-send-email-joro@8bytes.org> <823BAA9B-FACA-4E91-BE56-315FF569297C@amacapital.net>
 <20180713094849.5bsfpwhxzo5r5exk@8bytes.org> <CALCETrUP1QUKPLPJg6_L5=Mzmq33cSvq+NMaYW01wTCepdjCyg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 16:17:40 -0700
X-Gmail-Original-Message-ID: <CALCETrUBR-TGPY7wF4UwRb7jW39H+rJ4XFen35dgJRysk9sYTQ@mail.gmail.com>
Message-ID: <CALCETrUBR-TGPY7wF4UwRb7jW39H+rJ4XFen35dgJRysk9sYTQ@mail.gmail.com>
Subject: Re: [PATCH 03/39] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
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

On Fri, Jul 13, 2018 at 10:19 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jul 13, 2018 at 2:48 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> On Thu, Jul 12, 2018 at 01:49:13PM -0700, Andy Lutomirski wrote:
>>> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>> >    /* Offset from the sysenter stack to tss.sp0 */
>>> > -    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
>>> > +    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
>>> >           offsetofend(struct cpu_entry_area, entry_stack_page.stack));
>>> >
>>>
>>> The code reads differently. Did you perhaps mean TSS_task_stack?
>>
>> Well, the offset name came from TSS_sysenter_sp0, which was the offset
>> from the sysenter_sp0 (==sysenter-stack) to the task stack in TSS, now
>> sysenter_sp0 became entry_stack, because its used for all entry points
>> and not only sysenter. So with the old convention the naming makes still
>> sense, no?
>>
>
> Trying to parse it certainly makes my brain hurt a bit.  This is the
> offset from the entry stack to sp1, where sp1 is the location of the
> pointer to the task stack.
>
> Maybe all the arithmetic could go in entry_32.S and the asm-offset
> name could just be TSS_sp1, just like on 64-bit?
>

I re-read it again.  How about keeping TSS_entry_stack but making it
be the offset from the TSS to the entry stack.  Then do the arithmetic
in asm.
