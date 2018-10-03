Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C91C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A465F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zV4FCjcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A465F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJCRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:08:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40231 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeJCRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:08:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so3247422plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=50/1nEMp/+VNzJUmAvCVjL2S2aSdQU/3D0ak/4PbgCE=;
        b=zV4FCjcH6NfT2FbRNAM5L/WX1LuAdNcybIy0azAp7pXJQP4MYbBMV2rwkZihDEurm8
         hyQvVu+DgfUvheJZhg6wEE1hUfhwzcrM0IAwJz4552DGQ02S+Ad3qMgLDcEIBrBpY2/z
         QK6Y40RRuAscmRi9RQArTADxh46AaWFktKCJjmoUUuL4Gvhk/BkfADgm5zbBKwO/2SBT
         aVtYEF9VzXmvUecx7ZAYraL5TSzLyFh39zUBr+iD6QS6fIS/A2jS0PKaoC6ZFQ1wWHCW
         7a4z1FinzL7GsuLIUPOqHe5T8v5rS8LT/5BRY5zI+M6iJwiDqR1ZqdU8umCBwCGQU7W0
         izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=50/1nEMp/+VNzJUmAvCVjL2S2aSdQU/3D0ak/4PbgCE=;
        b=uhmbRWLB+jO+mhybfn+//zQHjmuaTq5IhVKSu0eprSQJplw/STam0Y7mi/m1CRfymR
         2jqlUcBoUSPDYsl6FjdGrR2PTOgrIqpr/FxMzCjwLPJvPwUR0DFixcahOc+IzBPvazxI
         Ne9ezCWDNGdx6M8W7KSykBU/uszVJxuuDS4NvQ+b5xqSHz32v344SmvE5lH3ziCsikjS
         4polyqcB6mDpmIHEtUCiHCTUw1yqzHPIwFoNAkx5M5nwpJ4rSHD2MHnQV+GLOazRHcnQ
         /h4OB5zV2ldFeIOcj79FOwqJtX+sCaYCPTQCp1Q335uJYdZsHCbszG2BthARlN6jBXzH
         4PIg==
X-Gm-Message-State: ABuFfojDrzygFDYpvNN+gA9cvkjsBdp+7EwyJCSbmD9PDR/ErFyKCUbF
        iLIcLlF5VFyVr7FqoXrsnmgExw==
X-Google-Smtp-Source: ACcGV61V5C3OxTUwh5odPyvF7kccgr5Rwou5tqUJF8UseWXrSYQ3SOjcNfHagTuZpLJFEkkIb7AfGQ==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91-v6mr891725plb.148.1538562033532;
        Wed, 03 Oct 2018 03:20:33 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:4492:ec6e:54db:bcc9? ([2601:646:c200:7429:4492:ec6e:54db:bcc9])
        by smtp.gmail.com with ESMTPSA id t26-v6sm2057609pfa.158.2018.10.03.03.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 03:20:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <87sh1ne64t.fsf@vitty.brq.redhat.com>
Date:   Wed, 3 Oct 2018 03:20:31 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2018, at 2:22 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@kernel.org> writes:
>=20
>> Hi Vitaly, Paolo, Radim, etc.,
>>=20
>>> On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>>=20
>>> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
>>> implementation, which extended the clockid switch case and added yet
>>> another slightly different copy of the same code.
>>>=20
>>> Especially the extended switch case is problematic as the compiler tends=
 to
>>> generate a jump table which then requires to use retpolines. If jump tab=
les
>>> are disabled it adds yet another conditional to the existing maze.
>>>=20
>>> This series takes a different approach by consolidating the almost
>>> identical functions into one implementation for high resolution clocks a=
nd
>>> one for the coarse grained clock ids by storing the base data for each
>>> clock id in an array which is indexed by the clock id.
>>>=20
>>=20
>> I was trying to understand more of the implications of this patch
>> series, and I was again reminded that there is an entire extra copy of
>> the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
>> that code is very, very opaque.
>>=20
>> Can one of you explain what the code is even doing?  =46rom a couple of
>> attempts to read through it, it's a whole bunch of
>> probably-extremely-buggy code that, drumroll please, tries to
>> atomically read the TSC value and the time.  And decide whether the
>> result is "based on the TSC".  And then synthesizes a TSC-to-ns
>> multiplier and shift, based on *something other than the actual
>> multiply and shift used*.
>>=20
>> IOW, unless I'm totally misunderstanding it, the code digs into the
>> private arch clocksource data intended for the vDSO, uses a poorly
>> maintained copy of the vDSO code to read the time (instead of doing
>> the sane thing and using the kernel interfaces for this), and
>> propagates a totally made up copy to the guest.  And gets it entirely
>> wrong when doing nested virt, since, unless there's some secret in
>> this maze, it doesn't acutlaly use the scaling factor from the host
>> when it tells the guest what to do.
>>=20
>> I am really, seriously tempted to send a patch to simply delete all
>> this code.  The correct way to do it is to hook
>=20
> "I have discovered a truly marvelous proof of this, which this margin is
> too narrow to contain" :-)
>=20
> There is a very long history of different (hardware) issues Marcelo was
> fighting with and the current code is the survived Frankenstein. E.g. it
> is very, very unclear what "catchup", "always catchup" and
> masterclock-less mode in general are and if we still need them.
>=20
> That said I'm all for simplification. I'm not sure if we still need to
> care about buggy hardware though.
>=20
>>=20
>> And I don't see how it's even possible to pass kvmclock correctly to
>> the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
>> L1 isn't notified when the data structure changes, so how the heck is
>> it supposed to update the kvmclock structure?
>=20
> Well, this kind of works in the the followin way:
> L1's clocksource is 'tsc_page' which is, basically, a compliment to TSC:
> two numbers provided by L0: offset and scale and KVM was tought to treat
> this clocksource as a good one (see b0c39dc68e3b "x86/kvm: Pass stable
> clocksource to guests when running nested on Hyper-V").
>=20
> The notification you're talking about exists, it is called
> Reenligntenment, see 0092e4346f49 "x86/kvm: Support Hyper-V
> reenlightenment"). When TSC page changes (and this only happens when L1
> is migrated to a different host with a different TSC frequency and TSC
> scaling is not supported by the CPU) we receive an interrupt in L1 (at
> this moment all TSC accesses are emulated which guarantees the
> correctness of the readings), pause all L2 guests, update their kvmclock
> structures with new data (we already know the new TSC frequency) and
> then tell L0 that we're done and it can stop emulating TSC accesses.

That=E2=80=99s delightful!  Does the emulation magic also work for L1 user m=
ode?  If so, couldn=E2=80=99t we drop the HyperV vclock entirely and just fo=
ld the adjustment into the core timekeeping data?  (Preferably the actual co=
re data, which would require core changes, but it could plausibly be done in=
 arch code, too.)

>=20
> (Nothing like this exists for KVM-on-KVM, by the way, when L1's
> clocksource is 'kvmclock' L2s won't get a stable kvmclock clocksource.)
>=20
>=20
