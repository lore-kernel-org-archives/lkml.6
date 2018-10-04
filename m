Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3912098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apd+hKjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3912098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJEDY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJEDY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:24:29 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BD621473
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 20:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538684974;
        bh=lriiZCSWyLRY6zxA+7n2JqZCh0J4iv9p6S31pW/+CWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Apd+hKjmiQw8f8rQMuWp5nqw7873pkiDCr8BgVTDonzmdWJlSrEeb9xihy1vePSTi
         AcjaoG2/yuwALxfju5Ro3INBoJ3C880ECNx9vrzWULjKZCod4qNcsB9YMluZYE6eUA
         7Df3AjVmgb8D0+9iEN1hjDfCQXqVu9sihy1kj+Z0=
Received: by mail-wm1-f42.google.com with SMTP id 143-v6so10178168wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:29:33 -0700 (PDT)
X-Gm-Message-State: ABuFfog1ukP4cI2dkLlKTCo9nVlFHlKnIwKwgvEFx2XL5NnvLyIUcFSt
        W9DfhEhM72HpDAs1ncWc8Vb90Ceg1scZzRMDgN3PSg==
X-Google-Smtp-Source: ACcGV61MAeTyvRhjkrrUF9Varb19DySuv+i4nPRdaRDHc5BYNJCSs7qrlGvsvzPZd3aWewh72q3+SJMbrVCISWNildU=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr5697550wmd.128.1538684972273;
 Thu, 04 Oct 2018 13:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181003213100.189959-1-namit@vmware.com> <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com> <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com> <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com> <20181004091651.GB21151@gmail.com>
 <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
In-Reply-To: <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 13:29:20 -0700
X-Gmail-Original-Message-ID: <CALCETrUm255shi0ba8j+ZJhkxv9HdDJ9A70U1T28bEHEMQi+8Q@mail.gmail.com>
Message-ID: <CALCETrUm255shi0ba8j+ZJhkxv9HdDJ9A70U1T28bEHEMQi+8Q@mail.gmail.com>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:33 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 10/04/18 02:16, Ingo Molnar wrote:
> >
> > * hpa@zytor.com <hpa@zytor.com> wrote:
> >
> >> Ingo: I wasn't talking necessarily about the specifics of each bit, but rather the general
> >> concept about being able to use macros in inlines...
> >
> > Ok, agreed about that part - and some of the patches did improve readability.
> >
> > Also, the 275 lines macros.s is a lot nicer than the 4,200 lines macros.S.
> >
> > Also, I'm not against using workarounds when the benefits are larger than the costs, but I am
> > against *hiding* the fact that these are workarounds and that for some of them there are costs.
> >
>
> Agreed, of course.
>
> >> I can send you something I have been working on in the background, but have been holding off
> >> on because of this, in the morning my time.
> >
> > BTW., I have applied most of the series to tip:x86/kbuild already, and will push them out later
> > today after some testing. I didn't apply the final 3 patches as they have dependencies, but
> > applied the basics and fixed up the changelogs.
> >
> > So you can rely on this.
> >
>
> Wonderful.
>
> Here is the horrible code I mentioned yesterday.  This is about
> implementing the immediate-patching framework that Linus and others have
> discussed (it helps both performance and kernel hardening):
>

I'm wondering if a production version should look more like:

patch_point:
mov $whatever, [target]
.pushsection ".immediate_patches"
.quad .Lpatch_point
.popsection

and let objtool parse the resulting assembled output and emit an entry
in some table mapping patch_point to the actual address and size of
the immediate to be patched.
