Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D356C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4133D20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4133D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLGQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:32:19 -0500
Received: from wind.enjellic.com ([76.10.64.91]:56344 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGQcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:32:18 -0500
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id wB7GVScS024678;
        Fri, 7 Dec 2018 10:31:28 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id wB7GVR4C024677;
        Fri, 7 Dec 2018 10:31:27 -0600
Date:   Fri, 7 Dec 2018 10:31:27 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to wrap SGX enclave transitions
Message-ID: <20181207163127.GA23494@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20181206221922.31012-1-sean.j.christopherson@intel.com> <20181206221922.31012-5-sean.j.christopherson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206221922.31012-5-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 07 Dec 2018 10:31:28 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:19:22PM -0800, Sean Christopherson wrote:

Good morning, I hope the week is ending well for everyone.

The audience for the issues that Sean is addressing are the groups
that have developed and are delivering an Untrusted RunTime System
(URTS) as a component of SGX Platform SoftWare (PSW).  At the current
time I believe that is Intel and us, although there may be stealth
initiatives as well.

Sean is obviously coordinating with and supporting the Intel SDK/PSW
team.  SGX has now been in the wild for 2-3 years so there is work
other then the reference implementation in the field.  The purpose of
this mail is to make sure that everyone understands the issues and
ramifications of changes that may end up in 'Flag Day' events, if
nothing else so we can get the best possible implementation put
forward.

Baidu and Fortanix are working on Trusted RunTime Systems (TRTS) based
on RUST, I believe, so this will affect them to the extent that they
are implementing their own low level enclave runtime support or they
may be simply building on top of the low level Intel TRTS.  Perhaps
Jethro would comment on these issues if he could.

> Intel Software Guard Extensions (SGX) SGX introduces a new CPL3-only
> enclave mode that runs as a sort of black box shared object that is
> hosted by an untrusted normal CPL3 process.
> 
> Enclave transitions have semantics that are a lovely blend of SYCALL,
> SYSRET and VM-Exit.  In a non-faulting scenario, entering and exiting
> an enclave can only be done through SGX-specific instructions, EENTER
> and EEXIT respectively.  EENTER+EEXIT is analogous to SYSCALL+SYSRET,
> e.g. EENTER/SYSCALL load RCX with the next RIP and EEXIT/SYSRET load
> RIP from R{B,C}X.
> 
> But in a faulting/interrupting scenario, enclave transitions act more
> like VM-Exit and VMRESUME.  Maintaining the black box nature of the
> enclave means that hardware must automatically switch CPU context when
> an Asynchronous Exiting Event (AEE) occurs, an AEE being any interrupt
> or exception (exceptions are AEEs because asynchronous in this context
> is relative to the enclave and not CPU execution, e.g. the enclave
> doesn't get an opportunity to save/fuzz CPU state).
> 
> Like VM-Exits, all AEEs jump to a common location, referred to as the
> Asynchronous Exiting Point (AEP).  The AEP is specified at enclave entry
> via register passed to EENTER/ERESUME, similar to how the hypervisor
> specifies the VM-Exit point (via VMCS.HOST_RIP at VMLAUNCH/VMRESUME).
> Resuming the enclave/VM after the exiting event is handled is done via
> ERESUME/VMRESUME respectively.  In SGX, AEEs that are handled by the
> kernel, e.g. INTR, NMI and most page faults, IRET will journey back to
> the AEP which then ERESUMEs th enclave.
> 
> Enclaves also behave a bit like VMs in the sense that they can generate
> exceptions as part of their normal operation that for all intents and
> purposes need to handled in the enclave/VM.  However, unlike VMX, SGX
> doesn't allow the host to modify its guest's, a.k.a. enclave's, state,
> as doing so would circumvent the enclave's security.  So to handle an
> exception, the enclave must first be re-entered through the normal
> EENTER flow (SYSCALL/SYSRET behavior), and then resumed via ERESUME
> (VMRESUME behavior) after the source of the exception is resolved.
> 
> All of the above is just the tip of the iceberg when it comes to running
> an enclave.  But, SGX was designed in such a way that the host process
> can utilize a library to build, launch and run an enclave.  This is
> roughly analogous to how e.g. libc implementations are used by most
> applications so that the application can focus on its business
> logic.

Just to make sure we are on the same page.

When you refer to 'build' an enclave I assume you mean to construct
the enclave image from a compiled shared object file.  Or are you
suggesting an environment where the library loads dynamically
generated object code into an enclave using Enclave Dynamic Memory
Management (EDMM)?  Building, i.e. compiling and linking an enclave,
doesn't seem to be the province of library support.

Perhaps a more accurate phrase would be; 'to load, initialize and
execute an enclave image'.

To step back further and frame the issue most precisely.  What the
VDSO work is proposing to support is shifting from a model where
applications 'own' enclaves to a model where dynamically linked shared
libraries 'own' enclaves, correct?

Currently, both your PSW and the one we deliver use SGX libraries to
support the loading, initialization and execution of an enclave.  In
the Intel world, applications link against libsgx_urts.so, in our
world, applications link against the SGXfusion.a library in order to
get the enclave entry and exception handling code.  In this model the
library code also provides a signal handler that analyzes the ucontext
structure in order to determine how it got called and to take
appropriate enclave exception handling actions.

With the VDSO model you are proposing an environment where library
developers can implement SGX/enclave based protections of code and
data which the actual application linking against the library would be
totally unaware of, correct?

> The big gotcha is that because enclaves can generate *and* handle
> exceptions, any SGX library must be prepared to handle nearly any
> exception at any time (well, any time a thread is executing in an
> enclave).  In Linux, this means the SGX library must register a
> signal handler in order to intercept relevant exceptions and forward
> them to the enclave (or in some cases, take action on behalf of the
> enclave).  Unfortunately, Linux's signal mechanism doesn't mesh well
> with libraries, e.g. signal handlers are process wide, are difficult
> to chain, etc...  This becomes particularly nasty when using multiple
> levels of libraries that register signal handlers, e.g. running an
> enclave via cgo inside of the Go runtime.
> 
> In comes vDSO to save the day.  Now that vDSO can fixup exceptions,
> add a function, __vdso_sgx_enter_enclave(), to wrap enclave transitions
> and intercept any exceptions that occur when running the enclave.
> 
> __vdso_sgx_enter_enclave() accepts four parameters:
> 
>   - A pointer to a Thread Control Structure (TCS).  A TCS is a page
>     within the enclave that defines/tracks the context of an enclave
>     thread.
> 
>   - An opaque pointer passed to the enclave via RDI, e.g. to marshal
>     data into the enclave.
> 
>   - A pointer to a struct sgx_enclave_exit_info that is used to relay
>     exit/fault information back to the caller.  The primary variable
>     in the exit info is the ENCLU leaf at the time of exit, which can
>     be queried to determine whether the enclave exited cleanly (EEXIT),
>     or took an exception (EENTER or ERESUME).
> 
>     The exact leaf is captured, instead of e.g. a fault flag, so that
>     the caller can identity whether a fault occurred in the enclave or
>     on EENTER.   A fault on EENTER generally means the enclave has died
>     and needs to be restarted.
> 
>     On a clean EEXIT, registers RDI, RSI and RDX are captured as-is,
>     e.g. to pass data out of the enclave.  On a fault that is reported
>     to the caller, the exit info is stuffed (by way of the vDSO fixup
>     handler) with the trapnr, error_code and address.  Not all enclave
>     exits are reported to the caller, e.g. interrupts and faults that
>     are handled by the kernel do not trigger fixup and IRET back to
>     ENCLU[ERESUME], i.e. unconditionally resume the enclave.
> 
>   - An optional exit handler that, when defined, is invoked prior to
>     returning.  The callback provides the enclave's untrusted runtime an
>     opportunity to resolve a fault or service a remote procedure call
>     without losing its stack context.
> 
>     In addition to allowing the runtime to do silly shenanigans with its
>     stack, e.g. pushing data onto the stack from within the enclave, the
>     handler approach preserves the full call stack for debugging purposes.
>     For example, to accept a new EPC page into the enclave, an enclave
>     with a single TCS must re-EENTER the enclave using the same TCS to
>     EACCEPT the new page prior to executing ERESUME to restart at the
>     fault context.  The handler approach allows reentry without undoing
>     the original call stack, i.e. preserves the view of the original
>     interrupted call.

To summarize succinctly, would it be correct to assert that there are
three possible advantages to the VDSO approach:

1.) Shared libraries can own enclaves without the knowledge of
applications.

2.) EDMM responses can be implemented more efficiently.

3.) Reduction in enclave attack surface.

With respect to point three, perhaps the most important attack on SGX
security guarantees to date has been documented in Lee et.al.'s
dark-ROP attack.  A significant aspect of that attack was AEE based
probing of enclave execution.  Do you have reflections with respect to
how the proposed archictecture would lessen or facilitate such
attacks?

The economics of software development seem to be motivating the use of
libOS approaches to porting applications to enclaves which has
significant implications with respect to AEE based probing attacks.

>     Note that this effectively requires userspace to implement an exit
>     handler if they want to support correctable enclave faults, as there
>     is no other way to request ERESUME.

Once again to be clear for those of us that have investments in the
existing ABI.

I'm assuming that in the proposed model the URTS would interrogate the
VDSO to determine the availability of entry and exception handling
support and then setup the appropriate infrastructure and exit
handler?  VDSO's are typically the domain of the system library.
Given the nature of SGX I couldn't even conceive of Glibc offering
support and, if it was acceptable to provide support, the potential
timeframe that would be involved in seeing deployment in the field.

As a result, do you anticipate the need for a 'flag day' with respect
to URTS/PSW/SDK support for all of this?

In addition, would you anticipate anything in the design that would be
problematic for environments where the application would choose to
implement an enclave in addition to linking against a library that
implements enclaves?

We will be interested in your reflections on the above issues.

Have a good weekend.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker
IDfusion, LLC
4206 N. 19th Ave.           Implementing measured information privacy
Fargo, ND  58102            and integrity architectures.
PH: 701-281-1686
FAX: 701-281-3949           EMAIL: gw@idfusion.org
------------------------------------------------------------------------------
"My thoughts on the composition and effectiveness of the advisory
 committee?

 I think they are destined to accomplish about the same thing as what
 you would get from locking 9 chimpanzees in a room with an armed
 thermonuclear weapon and a can opener with orders to disarm it."
                                -- Dr. Greg Wettstein
                                   Resurrection
