Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF643C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314720877
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xvQd5U8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbeG0W3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389211AbeG0W3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:29:44 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7992089B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532725564;
        bh=zT74hnl5692JFnw385aRNriLeubfh6BjrDVI/Qey2xs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xvQd5U8tc0CaiBdZkisvqqrh71rIsysw1r/5WpFF4QjkRMmAbs5Xlud7UJve+Rx3C
         4bK0bVW07lrZmu5LESPDw0SukaGkDa/Y/jrnbaauSxqtwVGFLxyWZTsnb3t/EUFcUw
         4FwsI1jhROC68ksqyPwUBAUcMs7rfn662UFwABOU=
Received: by mail-wm0-f47.google.com with SMTP id l2-v6so3004447wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:06:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlEtjdhNRVcOaU8UjgmrLiLNnYRJ5tn20rCjg11b1JkGVIJ/92co
        lQ1PHbfszt0OD1aNzHeXwhh4tjd3b8jz9VhnmVUB+Q==
X-Google-Smtp-Source: AAOMgpc4HM8xxJYSUHjnMT+KiW23kfDlilBadzl9N9SOMFPZywNK7aD0L+IT+Wvcc5EFY3pUtnpJjUvR706Rvss1c88=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5417001wmd.144.1532725560973;
 Fri, 27 Jul 2018 14:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 14:05:40 -0700 (PDT)
In-Reply-To: <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
 <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net> <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 27 Jul 2018 14:05:40 -0700
X-Gmail-Original-Message-ID: <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
Message-ID: <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Jim Mattson <jmattson@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        "open list:USER-MODE LINUX (UML)" 
        <user-mode-linux-user@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:03 PM, Jim Mattson <jmattson@google.com> wrote:
> On Fri, Jul 27, 2018 at 1:46 PM, Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>> On Jul 27, 2018, at 1:28 PM, Jim Mattson <jmattson@google.com> wrote:
>>> Initializing this bit to zero helps with migration, but then if the
>>> CPUID faulting bits in both MSRs are set, userspace has to take pains
>>> to ensure that MSR_PLATFORM_INFO is restored first, or the
>>> MSR_MISC_FEATURES_ENABLES value will be rejected.
>>
>> The code could drop the constraint and just let the entry possibly fail =
if the MSRs are set wrong
>
> That would be an improvement, I think.

I personally don't know enough about the QEMU, kvmtool, etc
architecture to know whether this would be a good idea.

>
>>> I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
>>> feeding into someone's calculated TSC frequency.
>>
>> Hmm. I don=E2=80=99t have a good answer to that. Are there any real CPUs=
 that have this MSR but don=E2=80=99t have that field?
>
> No. The reason I bring this up is that a customer has code that
> expects to be able to derive the TSC frequency from this MSR (per
> Intel's instructions in SDM volume 3, section 18.7.3), and they were
> surprised to find that the MSR raises #GP on our platform. We're
> looking into cherry-picking this support from upstream as a start, but
> I know the customer would be unhappy to read zero from bits 15:8.

Does KVM *have* a concept of "maximum non-turbo frequency" of the
guest that it would make sense to expose here?  If so, presumably the
right solution is to expose it.
