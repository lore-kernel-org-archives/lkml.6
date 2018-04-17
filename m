Return-Path: <kernel-hardening-return-13017-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx498RHgMEM8D8KYZUaf5PAp4g7qhUxr1TCsFu2mWJXXMlYmOoBf/5bR7CDRB44SUUew3ZhUK
ARC-Seal: i=1; a=rsa-sha256; t=1523990289; cv=none;
        d=google.com; s=arc-20160816;
        b=cSzb1+9861mljuFnyTKS3P/D7qk+D9jAfSzxyEH6hjBLGMB7mW21tPONxhXmRBPOks
         UsOLmzVERZaDZIdFXnHF2fx4mxIKsl5Q8FaM7puB6IWoBFG8mMo2HUJwfdewfM27aUqk
         ts5fqGgZbI7QhqLY/z5/TeLEmAbHAmJOTPG5U2B4CqDSTvM1tQ+Yy9WPfFCl2RzLy9eg
         1q18ImUjmBAmSA9R6A/16WwaBEILol0IX5a5VoM5obH/2qfRIt1orccb+jhCjzV+RBh4
         kwqhWeCWJL3ok1j11S6lO/uNvCcoy07u7/V6Lj/T9IoxCAdTgsge7NYah2Pd+6JXy6/q
         zcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=+DE6RojaQgLii4AzQx2J//hbAuRGcoTiMkSH6PpH9+4=;
        b=KzXjq4dyZhak32UDIRivXFbn0qgU70r6YcnYo6PUkCxgqWfqMgjFmwhm6mN7kE8Fv7
         79YdhrAlz+BhR08acdgxCf/wLE+f0J2MDE2W1ZF5K/2of+NbpsvQLQwGmWGeL4s45lbP
         DuxDv4ZTEAe0nQglfa59ceXxF/OfYB+Q2AOYw5ct09S/+g/UGT7HTNkUETdbhsDB6hhe
         2wgFMibNoF7yfOZXF+VoSV7rlieuat3bQ3JFPEqTNM5CBSjwB/ZQVVd6DxWmYkpGg4Xw
         Mvesv6A6YrlPgO7Sf1MOONAD5ld2ockGjTILsSum878rgaAtXCgfJoHilEULMmxg3LYO
         BFgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13017-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13017-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13017-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13017-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 00/11] ARMv8.3 pointer authentication userspace support
Date: Tue, 17 Apr 2018 19:37:24 +0100
Message-Id: <20180417183735.56985-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019642179172752?=
X-GMAIL-MSGID: =?utf-8?q?1598019642179172752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series adds support for the ARMv8.3 pointer authentication extension,
enabling userspace return address protection with recent versions of GCC.

Since RFC [1]:
* Make the KVM context switch (semi-lazy)
* Rebase to v4.13-rc1
* Improve pointer authentication documentation
* Add hwcap documentation
* Various minor cleanups

Since v1 [2]:
* Rebase to v4.15-rc1
* Settle on per-process keys
* Strip PACs when unwinding userspace
* Don't expose an XPAC hwcap (this is implied by ID registers)
* Leave APIB, ABPDA, APDB, and APGA keys unsupported for now
* Support IMP DEF algorithms
* Rely on KVM ID register emulation
* Various cleanups

Since v2 [3]:
* Unify HCR_EL2 initialization
* s/POINTER_AUTHENTICATION/PTR_AUTH/
* Drop KVM support (for now)
* Drop detection of generic authentication

While there are use-cases for keys other than APIAKey, the only software that
I'm aware of with pointer authentication support is GCC, which only makes use
of APIAKey. I'm happy to add support for other keys as users appear.

I've pushed the series to the arm64/pointer-auth branch [4] of my linux tree.
I've also pushed out a necessary bootwrapper patch to the pointer-auth branch
[5] of my bootwrapper repo.


Extension Overview 
==================

The ARMv8.3 pointer authentication extension adds functionality to detect
modification of pointer values, mitigating certain classes of attack such as
stack smashing, and making return oriented programming attacks harder

The extension introduces the concept of a pointer authentication code (PAC),
which is stored in some upper bits of pointers. Each PAC is derived from the
original pointer, another 64-bit value (e.g. the stack pointer), and a secret
128-bit key.

New instructions are added which can be used to:

* Insert a PAC into a pointer
* Strip a PAC from a pointer
* Authenticate strip a PAC from a pointer

If authentication succeeds, the code is removed, yielding the original pointer.
If authentication fails, bits are set in the pointer such that it is guaranteed
to cause a fault if used.

These instructions can make use of four keys:

* APIAKey (A.K.A. Instruction A key)
* APIBKey (A.K.A. Instruction B key)
* APDAKey (A.K.A. Data A key)
* APDBKey (A.K.A. Data B Key)

A subset of these instruction encodings have been allocated from the HINT
space, and will operate as NOPs on any ARMv8-A parts which do not feature the
extension (or if purposefully disabled by the kernel). Software using only this
subset of the instructions should function correctly on all ARMv8-A parts.

Additionally, instructions are added to authenticate small blocks of memory in
similar fashion, using APGAKey (A.K.A. Generic key).


This Series
===========

This series enables the use of instructions using APIAKey, which is initialised
and maintained per-process (shared by all threads). This series does not add
support for APIBKey, APDAKey, APDBKey, nor APGAKey.

I've given this some basic testing with a homebrew test suite. More ideally,
we'd add some tests to the kernel source tree.

For the time being, pointer authentication functionality is hidden from
guests via ID register trapping.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/498941.html
[2] https://lkml.kernel.org/r/1500480092-28480-1-git-send-email-mark.rutland@arm.com
[3] https://lkml.kernel.org/r/20171127163806.31435-1-mark.rutland@arm.com
[4] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/pointer-auth
[5] git://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git pointer-auth


Mark Rutland (11):
  arm64: add pointer authentication register bits
  arm64/kvm: consistently handle host HCR_EL2 flags
  arm64/kvm: hide ptrauth from guests
  arm64: Don't trap host pointer auth use to EL2
  arm64/cpufeature: detect pointer authentication
  asm-generic: mm_hooks: allow hooks to be overridden individually
  arm64: add basic pointer authentication support
  arm64: expose user PAC bit positions via ptrace
  arm64: perf: strip PAC when unwinding userspace
  arm64: enable pointer authentication
  arm64: docs: document pointer authentication

 Documentation/arm64/booting.txt                |   8 ++
 Documentation/arm64/elf_hwcaps.txt             |   6 ++
 Documentation/arm64/pointer-authentication.txt |  84 ++++++++++++++++++++
 arch/arm64/Kconfig                             |  23 ++++++
 arch/arm64/include/asm/cpucaps.h               |   5 +-
 arch/arm64/include/asm/esr.h                   |   3 +-
 arch/arm64/include/asm/kvm_arm.h               |   3 +
 arch/arm64/include/asm/mmu.h                   |   5 ++
 arch/arm64/include/asm/mmu_context.h           |  25 +++++-
 arch/arm64/include/asm/pointer_auth.h          | 104 +++++++++++++++++++++++++
 arch/arm64/include/asm/sysreg.h                |  30 +++++++
 arch/arm64/include/uapi/asm/hwcap.h            |   1 +
 arch/arm64/include/uapi/asm/ptrace.h           |   7 ++
 arch/arm64/kernel/cpufeature.c                 |  56 +++++++++++++
 arch/arm64/kernel/cpuinfo.c                    |   1 +
 arch/arm64/kernel/head.S                       |   5 +-
 arch/arm64/kernel/perf_callchain.c             |   5 +-
 arch/arm64/kernel/ptrace.c                     |  38 +++++++++
 arch/arm64/kvm/handle_exit.c                   |  18 +++++
 arch/arm64/kvm/hyp/switch.c                    |   2 +-
 arch/arm64/kvm/sys_regs.c                      |   9 +++
 include/asm-generic/mm_hooks.h                 |  11 +++
 include/uapi/linux/elf.h                       |   1 +
 23 files changed, 441 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/arm64/pointer-authentication.txt
 create mode 100644 arch/arm64/include/asm/pointer_auth.h

-- 
2.11.0
