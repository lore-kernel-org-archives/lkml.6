Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051DC282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC922082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfA3AM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:12:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45445 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfA3AMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:12:55 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1godUH-0000xO-VE; Wed, 30 Jan 2019 01:12:18 +0100
Date:   Wed, 30 Jan 2019 01:12:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
In-Reply-To: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1901300006460.1950@nanos.tec.linutronix.de>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Fri, 21 Dec 2018, Tim Chen wrote:
> Andi and I have made an update to our draft of the Spectre admin guide.
> We may be out on Christmas vacation for a while.  But we want to
> send it out for everyone to take a look.

Yup, it fell through my Christmas cracks as well.

> ---
>  Documentation/admin-guide/spectre.rst | 502 ++++++++++++++++++++++++++++++++++

I agree with Jonathan that this wants to be placed differently. Sorry, I
set the precedence with the l1tf document, but I didn't come up with a good
place either.

Something like admin-guide/hardware-vulnerabilities/... might work.

> +The following CPUs are vulnerable:
> +
> +    - Intel Core, Atom, Pentium, Xeon CPUs
> +    - AMD CPUs like Phenom, EPYC, Zen.
> +    - IBM processors like POWER and zSeries
> +    - Higher end ARM processors
> +    - Apple CPUs
> +    - Higher end MIPS CPUs
> +    - Likely most other high performance CPUs. Contact your CPU vendor for details.
> +
> +This document describes the mitigations on Intel CPUs. Mitigations
> +on other architectures may be different.

No. A lot of the information is the same for all other CPU vendors. So
sharing that document makes a lot of sense. Intel is not the center of the
universe.

> +Problem
> +-------
> +
> +CPUs have shared caches, such as buffers for branch prediction, which are
> +later used to guide speculative execution. These buffers are not flushed
> +over context switches or change in privilege levels. Malicious software

change of privilege levels

> +might influence these buffers and trigger specific speculative execution
> +in the kernel or different user processes.  This speculative execution can
> +then be used to read data in memory and cause side effects, such as displacing
> +data in a data cache. The side effect can then later be measured by the
> +malicious software, and used to determine the memory values read speculatively.
> +
> +Spectre attacks allow tricking other software to disclose
> +values in their memory.

No. Spectre attacks do not allow that. It's the hardware properties which
allow attackers to exploit the side effects of speculative execution.

> +In a typical Spectre variant 1 attack, the attacker passes an parameter

Please explain first what the fundamental difference between variant 1 and
variant 2 is. Then go into details of each variant.

> +to a victim. The victim boundary checks the parameter and rejects illegal
> +values. However due to speculation over branch prediction the code path
> +for correct values might be speculatively executed, then reference memory

reference memory?

> +controlled by the input parameter and leave measurable side effects in
> +the caches.

This really is not describing it properly. Please spell out the most
obvious (at least for this who know) attack vector, i.e. array access based
on the input parameter. That's where the bound check is bypassed.

The attacker could then measure these side effects
> +and determine the leaked value.
> +
> +There are some extensions of Spectre variant 1 attacks for reading
> +data over the network, see [2]. However the attacks are very
> +difficult, low bandwidth and fragile and considered low risk.
> +
> +For Spectre variant 2 the attacker poisons the indirect branch
> +predictors of the CPU.

At least some high level explanation how that poisoning happens would be
appropriate.

> ...  Then control is passed to the victim, which
> +executes indirect branches. Due to the poisoned branch predictor data
> +the CPU can speculatively execute arbitrary code in the victim's
> +address space, such as a code sequence ("disclosure gadget") that
> +reads arbitrary data on some input parameter and causes a measurable
> +cache side effect based on the value. The attacker can then measure
> +this side effect after gaining control again and determine the value.
> +
> +The most useful gadgets take an attacker-controlled input parameter so
> +that the memory read can be controlled. Gadgets without input parameters
> +might be possible, but the attacker would have very little control over what
> +memory can be read, reducing the risk of the attack revealing useful data.

Makes sense.

> +Attack scenarios
> +----------------
> +
> +Here is a list of attack scenarios that have been anticipated, but
> +may not cover all possible attack patterns.  Reduing the occurrences of
> +attack pre-requisites listed can reduce the risk that a spectre attack
> +leaks useful data.
> +
> +1. Local User process attacking kernel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Code in system calls often enforces access controls with conditional
> +branches based on user data.  These branches are potential targets for
> +Spectre v2 exploits.  Interrupt handlers, on the other hand, rarely
> +handle user data or enforce access controls, which makes them unlikely
> +exploit targets.
> +
> +For typical variant 2 attack, the attacker may poison the CPU branch
> +buffers first, and then enter the kernel and trick it into jumping to a

No, this is imprecise. The attacker may not poison the branch buffer, it
poisons the branch prediction buffer. Then it enters the kernel. After
entering the kernel it cannot trick it (the kernel) to do anything. No, the
poisoned branch prediction buffer causes the hardware speculation unit to
go down the wrong path.

Please be precise. Fairy tales are not useful for anyone.

> +disclosure gadget through an indirect branch. If the attacker wants to control the
> +memory addresses leaked, it would also need to pass a parameter
> +to the gadget, either through a register or through a known address in
> +memory. Finally when it executes again it can measure the side effect.
> +
> +Necessary Prequisites:
> +1. Malicious local process passing parameters to kernel
> +2. Kernel has secrets.

2) is silly. Of course has the kernel secrets. Everything which should not
   accessible by the attacker due to priviledge separation etc. are secrets
   in the view of the attacker. Whether they are useful or not is a
   different story.

> +2. User process attacking another user process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In this scenario an malicious user process wants to attack another

s/an/a/

s/wants to attack/tries to attacks/

> +user process through a context switch.
> +
> +For variant 1 this generally requires passing some parameter between
> +the processes, which needs a data passing relationship, such a remote

such as

> +procedure calls (RPC).
> +
> +For variant 2 the poisoning can happen through a context switch, or
> +on CPUs with simultaneous multi-threading (SMT) potentially on the
> +thread sibling executing in parallel on the same core.  In either case,
> +controlling the memory leaked by the disclosure gadget also requires a data
> +passing relationship to the victim process, otherwise while it may

s/it/the attacker/ otherwise the reference is not conclusive

> +observe values through side effects, it won't know which memory
> +addresses they relate to.
> +
> +Necessary Prerequisites:
> +1. Malicious code running as local process
> +2. Victim processes containing secrets running on same core.

Again. All memory of the victim has to be considered as secret simply
because it should not be accessible for the attacker in the first
place. That's a fundamental guarantee of address space separation which is
violated by the hardware.

> +3. User sandbox attacking runtime in process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A process, such as a web browser, might be running interpreted or JITed
> +untrusted code, such as javascript code downloaded from a website.
> +It uses restrictions in the JIT code generator and checks in a run time
> +to prevent the untrusted code from attacking the hosting process.

Confusing use of 'might be' and present tense. It's not about 'might
be'. You are describing a scenario, so wants to be:

 If a process runs interpreted or JITed untrusted code,...., it uses
 restrictions ....

Hmm?

> +The untrusted code might either use variant 1 or 2 to trick
> +a disclosure gadget in the run time to read memory inside the process.

  to trick a disclosure gadget?

  to trick the hardware into executing a disclosure gadget...

describes it correctly. Please be more careful.

> +
> +Necessary Prerequisites:
> +1. Sandbox in process running untrusted code.
> +2. Runtime in same process containing secrets.

Oh well.

> +4. Kernel sandbox attacking kernel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The kernel has support for running user-supplied programs within the
> +kernel.  Specific rules (such as bounds checking) are enforced on these
> +programs by the kernel to ensure that they do not violate access controls.
> +
> +eBPF is a kernel sub-system that uses user-supplied program
> +to execute JITed untrusted byte code inside the kernel. eBPF is used
> +for manipulating and examining network packets, examining system call
> +parameters for sand boxes and other uses.
> +
> +A malicious local process could upload and trigger an malicious
> +eBPF script to the kernel, with the script attacking the kernel
> +using variant 1 or 2 and reading memory.
> +
> +Necessary Prerequisites:
> +1. Malicious local process
> +2. eBPF JIT enabled for unprivileged users, attacking kernel with secrets
> +on the same machine.

Alexey already commented on that one, but in general the above remarks
vs. precise description apply as well.

> +5. Virtualization guest attacking host
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +An untrusted guest might attack the host through a hyper call
> +or other virtualization exit.

exit mechanisms ?

> +
> +Necessary Prerequisites:
> +1. Untrusted guest attacking host
> +2. Host has secrets on local machine.
> +
> +For variant 1 VM exits use appropriate mitigations

VM exits use?

> +("bounds clipping") to prevent speculation leaking data
> +in kernel code. For variant 2 the kernel flushes the branch buffer.

> +6. Virtualization guest attacking other guest
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +An untrusted guest attacking another guest containing

s/containing secrets// Stop this secret thing please. It's not helpful in
any way.

> +secrets. Mitigations are similar to when a guest attack
> +the host.

That's not a proper sentence.

The (host?) kernel has mitigations for this in place which are similar to
the mitigations which are used to prevent guest to host attacks.

> +Runtime vulnerability information
> +---------------------------------
> +
> +The kernel reports the vulnerability and mitigation status in
> +/sys/devices/system/cpu/vulnerabilities/*

Can we please align that with the wording in the L1TF document?

  The Linux kernel provides a sysfs interface to enumerate the current L1TF
  status of the system: whether the system is vulnerable, and which
  mitigations are active. The relevant sysfs file is:

> +The spectre_v1 file describes the always enabled variant 1
> +mitigation:

> +
> +/sys/devices/system/cpu/vulnerabilities/spectre_v1
> +
> +The value in this file:
> +
> +  =======================================  =================================
> +  'Mitigation: __user pointer sanitation'  Protection in kernel on a case by
> +                                           case base with explicit pointer
> +                                           sanitation.
> +  =======================================  =================================

This fails to mention that these protections are on a case by case basis
and there is no guarantee that all possible attack vectors are covered.


> +The spectre_v2 kernel file reports if the kernel has been compiled with a
> +retpoline aware compiler, if the CPU has hardware mitigation, and if the

How on earth should anyone who is not familiar with the inner workings of
all this know what a retpoline compiler is?

> +CPU has microcode support for additional process specific mitigations.
> +
> +It also reports CPU features enabled by microcode to mitigate attack
> +between user processes:
> +
> +1. Indirect Branch Prediction Barrier (IBPB) to add additional
> +   isolation between processes of different users
> +2. Single Thread Indirect Branch Prediction (STIBP) to additional
> +   isolation between CPU threads running on the same core.
> +
> +These CPU features may impact performance when used and can
> +be enabled per process on a case-by-case base.
> +
> +/sys/devices/system/cpu/vulnerabilities/spectre_v2
> +
> +The values in this file:
> +
> +  - Kernel status:
> +
> +  ====================================  =================================
> +  'Not affected'                        The processor is not vulnerable
> +  'Vulnerable'                          Vulnerable, no mitigation
> +  'Mitigation: Full generic retpoline'  Software-focused mitigation
> +  'Mitigation: Full AMD retpoline'      AMD-specific software mitigation
> +  'Mitigation: Enhanced IBRS'           Hardware-focused mitigation
> +  ====================================  =================================
> +
> +  - Firmware status:
> +
> +  ========== =============================================================
> +  'IBRS_FW'  Protection against user program attacks when calling firmware
> +  ========== =============================================================
> +
> +  - Indirect branch prediction barrier (IBPB) status for protection between
> +    processes of different users. This feature can be controlled through
> +    prctl per process, or through kernel command line options. For more details
> +    see below.

rst supports hyperlinks and 'see below' is a lame reference. The title of
that chapter is known, right?

> +
> +  ===================   ========================================================
> +  'IBPB: disabled'      IBPB unused
> +  'IBPB: always-on'     Use IBPB on all tasks
> +  'IBPB: conditional'   Use IBPB on SECCOMP or indirect branch restricted tasks
> +  ===================   ========================================================
> +
> +  - Single threaded indirect branch prediction (STIBP) status for protection
> +    between different hyper threads. This feature can be controlled through
> +    prctl per process, or through kernel command line options. For more details
> +    see below.

Ditto.

> +
> +  ====================  ========================================================
> +  'STIBP: disabled'     STIBP unused
> +  'STIBP: forced'       Use STIBP on all tasks
> +  'STIBP: conditional'  Use STIBP on SECCOMP or indirect branch restricted tasks
> +  ====================  ========================================================
> +
> +  - Return stack buffer (RSB) protection status:
> +
> +  =============   ===========================================
> +  'RSB filling'   Protection of RSB on context switch enabled
> +  =============   ===========================================
> +
> +Full mitigations might require an microcode update from the CPU
> +vendor. When the necessary microcode is not available the kernel
> +will report vulnerability.
> +
> +Kernel mitigation
> +-----------------
> +
> +The kernel has default on mitigations for Variant 1 and Variant 2

Wrong. V1 is default on. V2 is only available when there is a retpoline
capable compiler used to build the kernel.

> +against attacks from user programs or guests. For variant 1 it
> +annotates vulnerable kernel code (as determined by the sparse code
> +scanning tool and code audits) to use "bounds clipping" to avoid any
> +usable disclosure gadgets.
> +
> +For variant 2 the kernel employs "retpoline" with compiler help to secure

Again. There needs to be a paragraph which explains what retpoline is
about. Then you can spare all the repeating (and different) explanations in
these contexts.

> +the indirect branches inside the kernel, when CONFIG_RETPOLINE is enabled
> +and the compiler supports retpoline. On Intel Skylake-era systems the
> +mitigation covers most, but not all, cases, see [1] for more details.
> +
> +On CPUs with hardware mitigations for variant 2, retpoline is
> +automatically disabled at runtime.
> +
> +Using kernel address space randomization (CONFIG_RANDOMIZE_SLAB=y
> +and CONFIG_SLAB_FREELIST_RANDOM=y in the kernel configuration)
> +makes attacks on the kernel generally more difficult.
> +
> +Host mitigation
> +---------------
> +
> +The Linux kernel uses retpoline to eliminate attacks on indirect
> +branches. It also flushes the Return Branch Stack on every VM exit to
> +prevent guests from attacking the host kernel when retpoline is
> +enabled.
> +
> +Variant 1 attacks are mitigated unconditionally.

As far as covered ....

> +The kernel also allows guests to use any microcode based mitigations
> +they chose to use (such as IBPB or STIBP), assuming the
> +host has an updated microcode and reports the feature in
> +/sys/devices/system/cpu/vulnerabilities/spectre_v2.

What has the sysfs file to do with that? The guest can only use it when the
host reports the feature to the guest. In fact the host allows the guest
more features to use than the host kernel uses itself.

> +Mitigation control at kernel build time
> +---------------------------------------
> +
> +When the CONFIG_RETPOLINE option is enabled the kernel uses special
> +code sequences to avoid attacks on indirect branches through
> +Variant 2 attacks.
> +
> +The compiler also needs to support retpoline and support the
> +-mindirect-branch=thunk-extern -mindirect-branch-register options
> +for gcc, or -mretpoline-external-thunk option for clang.
> +
> +When the compiler doesn't support these options the kernel
> +will report that it is vulnerable.
> +
> +Variant 1 mitigations and other side channel related user APIs are

side channel related user APIs ???

> +enabled unconditionally.
> +
> +Hardware mitigation
> +-------------------
> +
> +Some CPUs have hardware mitigations (e.g. enhanced IBRS) for Spectre
> +variant 2.  The 4.19 kernel has support for detecting this capability

That has been backported ....

> +and automatically disable any unnecessary workarounds at runtime.
> +
> +User program mitigation
> +-----------------------
> +
> +For variant 1 user programs can use LFENCE or bounds clipping. For more
> +details see [3].
> +
> +For variant 2 user programs can be compiled with retpoline or
> +restricting its indirect branch speculation via prctl.  (See

s/its/their/

> +Documenation/speculation.txt for detailed API.)

Huch? What has that file to do with the prctl?

> +User programs should use address space randomization
> +(/proc/sys/kernel/randomize_va_space = 1 or 2) to make any attacks

s/any//

> +more difficult.

> +APIs for mitigation control of user process
> +-------------------------------------------
> +
> +When enabling the "prctl" option for spectre_v2_user boot parameter,
> +prctl can be used to restrict indirect branch speculation on a process.
> +See Documenation/speculation.txt for detailed API.

See above.

> +Processes containing secrets, such as cryptographic keys, may invoke
> +this prctl for extra protection against Spectre v2.
> +
> +Before running untrusted processes, restricting their indirect branch
> +speculation will prevent such processes from launching Spectre v2 attacks.
> +
> +Restricting indirect branch speuclation on a process should be only used
> +as needed, as restricting speculation reduces both performance of the
> +process, and also process running on the sibling CPU thread.
> +
> +Under the "seccomp" option, the processes sandboxed with SECCOMP will
> +have indirect branch speculation restricted automatically.

This whole section needs a lot of care and is incomplete and partially
misleading.

Also please follow the L1TF documentation which explains for each of the
mitigation modes which kind of attacks are prevented and which holes
remain.

It's a good start but far from where it should be.

Thanks,

	tglx
