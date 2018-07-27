Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE620862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="smd8IsG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CE620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbeG1AWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388507AbeG1AWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:22:40 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF50208A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532732317;
        bh=/Rl7E5JkSEuZbRYj4ro3yOF00V1giBxLgOywFJ0o8nk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=smd8IsG6CttoUopntOfmg4K+nVPbJct52Vu885lgEhHS+D5Frsu+SXwh2SMZ0L6z1
         EpnXhqQNY0ZcxGecAU10z4XCcOr9u/hChG+05YlTMKhO/JBOVNfE5RMV+Ta68Sdk3b
         g7smsYVT/2F8AR9PmehcEGcXyFCJJ+SVzMNHOzRY=
Received: by mail-wm0-f42.google.com with SMTP id o18-v6so7144108wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:58:37 -0700 (PDT)
X-Gm-Message-State: AOUpUlHZmydwVfAOI+VS5Ovawraim6DqQr/W67oJh72ZCyEp2dxPLBCc
        Vbr/vGjQ3ZUm2sbllqb+70KH4hk/pdysE/oBB3Sf2w==
X-Google-Smtp-Source: AAOMgpdcxFftsbGi6A0kHV3VNqvnLNBlUiFWoo1rBSd1BJ53B+G1mHFNZMLkKOnfPink9CevGw7ChShM6j+uOVhfO4M=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5653882wmd.144.1532732313825;
 Fri, 27 Jul 2018 15:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 15:58:13 -0700 (PDT)
In-Reply-To: <CALMp9eQ3VOOdQpZ2=rqB1W3=RnyZXDxrqXgADsDZ0eSH_8r9tQ@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
 <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net> <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
 <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com> <CALMp9eQ3VOOdQpZ2=rqB1W3=RnyZXDxrqXgADsDZ0eSH_8r9tQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 27 Jul 2018 15:58:13 -0700
X-Gmail-Original-Message-ID: <CALCETrUCiptFxdvAEZFo7A52eEmAEk12bJKTkX8jNLBA_391wg@mail.gmail.com>
Message-ID: <CALCETrUCiptFxdvAEZFo7A52eEmAEk12bJKTkX8jNLBA_391wg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:30 PM, Jim Mattson <jmattson@google.com> wrote:
> On Fri, Jul 27, 2018 at 2:05 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> Does KVM *have* a concept of "maximum non-turbo frequency" of the
>> guest that it would make sense to expose here?  If so, presumably the
>> right solution is to expose it.
>
> KVM has the concept of a guest's invariant TSC frequency. The Maximum
> Non-Turbo Ratio is just some fraction of that. Sadly, the fraction is
> 100 MHz, 133.33MHz, or the "scalable bus frequency" from some other
> MSR, depending on microarchitecture.

Which is problematic, unless KVM wants to start deciding what the base
clock is.  There's MSR_FSB_FREQ, which is supported on Atom only,
IIRC.

I really wish Intel would get its act together.
