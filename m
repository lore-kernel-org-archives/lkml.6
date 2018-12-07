Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E64C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3054C2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544205925;
	bh=UYttdw/W7iXXQjKp1GQMbomjiCOUngiuqONn1JZYzhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k4Cs/BjK/kDO4/GXIMS9njEU0eyo7Bp9yUgYNN7ZlgG3723oaSMDrZIKhnDvxPzzO
	 B6uBDTkLALMYQwntJ7SIiOsDZQ8ni1oL/9O8W0HO0cGeW49AGquJzN8AabTDSB9kYq
	 wJn9IZW5w39Eqvur5MoIj3JPow6e2VQlbDuFUF9o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3054C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLGSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeLGSFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:05:23 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51792146F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544205922;
        bh=UYttdw/W7iXXQjKp1GQMbomjiCOUngiuqONn1JZYzhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B+HQzuszs+Z+iZQFmH5A1lF4uQG/Fixd0Z9f1h0UJR0Zgab8Dw4zQEmUmMzqGZeyx
         a+prOdUAhLEdM6H61A/Byp/RM4Q+EWDDCPUAtocLIEcpDgh18W9Wwamg36bbUeCb/2
         snpcIum+NMZqar/sJHnHztWv0MuEcb8tSxdiule8=
Received: by mail-wm1-f46.google.com with SMTP id z18so5225653wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:05:21 -0800 (PST)
X-Gm-Message-State: AA+aEWarthMnqIrKso9HtMj8EWLOj0ESp6Vc1dryIGT8UQ7m9JTwaZJd
        CUUER220jZ10IZWqyY/acqW4UbN9QNVUH1A9ty+aSw==
X-Google-Smtp-Source: AFSGD/Ukk/Qok2Il6HrESeciMTQL6P1H4YE6cyfRvoBSjWDYo9ngMAbIHwg8qGNWGhjNn3b1SngXFWebiAVRHk5Kpfs=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr3276001wmf.32.1544205920093;
 Fri, 07 Dec 2018 10:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20181206221922.31012-1-sean.j.christopherson@intel.com>
 <20181206221922.31012-5-sean.j.christopherson@intel.com> <20181207163127.GA23494@wind.enjellic.com>
In-Reply-To: <20181207163127.GA23494@wind.enjellic.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Dec 2018 10:05:07 -0800
X-Gmail-Original-Message-ID: <CALCETrWBB=AvqxhiXAt_kYTjBOaWkuACLF_TN7rzqSKOHfSdaw@mail.gmail.com>
Message-ID: <CALCETrWBB=AvqxhiXAt_kYTjBOaWkuACLF_TN7rzqSKOHfSdaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to
 wrap SGX enclave transitions
To:     "Dr. Greg Wettstein" <greg@enjellic.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 8:31 AM Dr. Greg <greg@enjellic.com> wrote:
>
> On Thu, Dec 06, 2018 at 02:19:22PM -0800, Sean Christopherson wrote:
>
> Good morning, I hope the week is ending well for everyone.
>
> The audience for the issues that Sean is addressing are the groups
> that have developed and are delivering an Untrusted RunTime System
> (URTS) as a component of SGX Platform SoftWare (PSW).  At the current
> time I believe that is Intel and us, although there may be stealth
> initiatives as well.
>
> Sean is obviously coordinating with and supporting the Intel SDK/PSW
> team.  SGX has now been in the wild for 2-3 years so there is work
> other then the reference implementation in the field.  The purpose of
> this mail is to make sure that everyone understands the issues and
> ramifications of changes that may end up in 'Flag Day' events, if
> nothing else so we can get the best possible implementation put
> forward.
>
> Baidu and Fortanix are working on Trusted RunTime Systems (TRTS) based
> on RUST, I believe, so this will affect them to the extent that they
> are implementing their own low level enclave runtime support or they
> may be simply building on top of the low level Intel TRTS.  Perhaps
> Jethro would comment on these issues if he could.
>
> > Intel Software Guard Extensions (SGX) SGX introduces a new CPL3-only
> > enclave mode that runs as a sort of black box shared object that is
> > hosted by an untrusted normal CPL3 process.
> >
> > Enclave transitions have semantics that are a lovely blend of SYCALL,
> > SYSRET and VM-Exit.  In a non-faulting scenario, entering and exiting
> > an enclave can only be done through SGX-specific instructions, EENTER
> > and EEXIT respectively.  EENTER+EEXIT is analogous to SYSCALL+SYSRET,
> > e.g. EENTER/SYSCALL load RCX with the next RIP and EEXIT/SYSRET load
> > RIP from R{B,C}X.
> >
> > But in a faulting/interrupting scenario, enclave transitions act more
> > like VM-Exit and VMRESUME.  Maintaining the black box nature of the
> > enclave means that hardware must automatically switch CPU context when
> > an Asynchronous Exiting Event (AEE) occurs, an AEE being any interrupt
> > or exception (exceptions are AEEs because asynchronous in this context
> > is relative to the enclave and not CPU execution, e.g. the enclave
> > doesn't get an opportunity to save/fuzz CPU state).
> >
> > Like VM-Exits, all AEEs jump to a common location, referred to as the
> > Asynchronous Exiting Point (AEP).  The AEP is specified at enclave entry
> > via register passed to EENTER/ERESUME, similar to how the hypervisor
> > specifies the VM-Exit point (via VMCS.HOST_RIP at VMLAUNCH/VMRESUME).
> > Resuming the enclave/VM after the exiting event is handled is done via
> > ERESUME/VMRESUME respectively.  In SGX, AEEs that are handled by the
> > kernel, e.g. INTR, NMI and most page faults, IRET will journey back to
> > the AEP which then ERESUMEs th enclave.
> >
> > Enclaves also behave a bit like VMs in the sense that they can generate
> > exceptions as part of their normal operation that for all intents and
> > purposes need to handled in the enclave/VM.  However, unlike VMX, SGX
> > doesn't allow the host to modify its guest's, a.k.a. enclave's, state,
> > as doing so would circumvent the enclave's security.  So to handle an
> > exception, the enclave must first be re-entered through the normal
> > EENTER flow (SYSCALL/SYSRET behavior), and then resumed via ERESUME
> > (VMRESUME behavior) after the source of the exception is resolved.
> >
> > All of the above is just the tip of the iceberg when it comes to running
> > an enclave.  But, SGX was designed in such a way that the host process
> > can utilize a library to build, launch and run an enclave.  This is
> > roughly analogous to how e.g. libc implementations are used by most
> > applications so that the application can focus on its business
> > logic.
>
> Just to make sure we are on the same page.
>
> When you refer to 'build' an enclave I assume you mean to construct
> the enclave image from a compiled shared object file.  Or are you
> suggesting an environment where the library loads dynamically
> generated object code into an enclave using Enclave Dynamic Memory
> Management (EDMM)?  Building, i.e. compiling and linking an enclave,
> doesn't seem to be the province of library support.
>
> Perhaps a more accurate phrase would be; 'to load, initialize and
> execute an enclave image'.
>
> To step back further and frame the issue most precisely.  What the
> VDSO work is proposing to support is shifting from a model where
> applications 'own' enclaves to a model where dynamically linked shared
> libraries 'own' enclaves, correct?

Or just a model where an application can own an enclave but not need
to register a process-wide SIGSEGV handler.  The current model where
try_init_enclave registers a signal handler is extremely impolite.

>
> With the VDSO model you are proposing an environment where library
> developers can implement SGX/enclave based protections of code and
> data which the actual application linking against the library would be
> totally unaware of, correct?

That too.

> To summarize succinctly, would it be correct to assert that there are
> three possible advantages to the VDSO approach:
>
> 1.) Shared libraries can own enclaves without the knowledge of
> applications.

Yes.

>
> 2.) EDMM responses can be implemented more efficiently.

I don't know what that means.  If an enclave is managing its own
memory by asking the untrusted runtime to forward exceptions to it,
this seems like a lovely attack surface.

>
> 3.) Reduction in enclave attack surface.
>
> With respect to point three, perhaps the most important attack on SGX
> security guarantees to date has been documented in Lee et.al.'s
> dark-ROP attack.  A significant aspect of that attack was AEE based
> probing of enclave execution.  Do you have reflections with respect to
> how the proposed archictecture would lessen or facilitate such
> attacks?

No effect whatsoever.  This is an ISA design issue and the untrusted
code has nothing to do with it.

Personally, my opinion is that, if the hardware permits an attack
channel against an enclave, it's in the best interest of everyone for
Linux to make that attack channel available to the greatest extent
possible.  This way no one says "well, my enclave is secure under
Linux, so no big deal.)

>
> The economics of software development seem to be motivating the use of
> libOS approaches to porting applications to enclaves which has
> significant implications with respect to AEE based probing attacks.

That sounds like a generally poor idea.  Maybe it's economically
reasonable, but enclaves really ought not to be that big or
complicated.


>
> >     Note that this effectively requires userspace to implement an exit
> >     handler if they want to support correctable enclave faults, as there
> >     is no other way to request ERESUME.
>
> Once again to be clear for those of us that have investments in the
> existing ABI.
>
> I'm assuming that in the proposed model the URTS would interrogate the
> VDSO to determine the availability of entry and exception handling
> support and then setup the appropriate infrastructure and exit
> handler?

...

> As a result, do you anticipate the need for a 'flag day' with respect
> to URTS/PSW/SDK support for all of this?
>

There will be a flag day when the upstream driver lands.  It would be
great if the vDSO code lands in the same kernel so it's always
available.

> In addition, would you anticipate anything in the design that would be
> problematic for environments where the application would choose to
> implement an enclave in addition to linking against a library that
> implements enclaves?


Nope, should be fine.
