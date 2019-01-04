Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC2218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Dd3Oh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfADRmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:42:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33875 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfADRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:42:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so17738995plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cAlxe080R5ZoRGHTwEgjwJpM4wqwX9cvA9rSQ935W94=;
        b=m5Dd3Oh6gZmWDSXY7jTDv4dNlKInfEXqr4z1I6VnfNLFFtiFYi9minGNI/FvtKC8pX
         7HYtId4bgozK8B9QmQRCUds9my6Kuwp09keZ+gVURILKP3F1/hmSKmY7PsMreTvyj/CZ
         eHOM3SDDtpBOaiw54ePSo8+PFmpAnIj/aUtHRM/iAAOnq7vGh4hkqOm7YpSMT99JM7/2
         J7Zi7cddYvyvlcoKPWfqTjklry/tuFDeOUKiyELWxxn7UYRoKhagHz5nadpVOrjRpMv5
         0VjbLKU0108WDZh9eeIVmzmpFBTuA5jM1a6EFA/nh+Z1bgyWjtbfMo+RFYv5dGyHkEBZ
         x7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=cAlxe080R5ZoRGHTwEgjwJpM4wqwX9cvA9rSQ935W94=;
        b=H/HcKSzxsLz677jm0C39s2Xd1HjF0mCgnNEo9LIeLj4p6cvoGW8w75vb+uPalXxURZ
         FZ2W3BcLuP11HugCYHuHs06wTMtQIKi6ti1Fa41sa5nCEAAuvM+7OdaVM322qT1o7y+R
         g8As1ActMDn4FdhEyiVNuidejULOpcOdNNbanDWVPAGDZkAYEo37tObdb4z+8Am1mO9u
         H/jh9C3j0VQEpcTflLL1UbO6YQQQRCcLNSEhy48XrveQ0jU1mEjJQjjXZvVjoPNKbtgx
         yTTEmk6O9cxjkAT7StAE9C3/LWasj+SIjvIq1xpCvdfV/dcj0/DO7tZc9MEJPV1KeQmi
         xGlg==
X-Gm-Message-State: AJcUukdNtmR/Y1OqJ9lCcf9NjKThGclplrv6mkS6LAyV1bT44KKJ/pM0
        qtm53X7tExzrfslkrMMSEAs=
X-Google-Smtp-Source: ALg8bN5tvQCKbtNb+1zyNGLzyGyY6EqADoWnDGHWAsOuZgbuo5b4plHIr0ja+aTqkfWoS670QTtwpQ==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr51289334plc.62.1546623765933;
        Fri, 04 Jan 2019 09:42:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u87sm116163599pfi.2.2019.01.04.09.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 09:42:44 -0800 (PST)
Date:   Fri, 4 Jan 2019 09:42:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
Message-ID: <20190104174242.GA9173@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:57:57PM -0800, Linus Torvalds wrote:
> Nobody has actually used the type (VERIFY_READ vs VERIFY_WRITE) argument
> of the user address range verification function since we got rid of the
> old racy i386-only code to walk page tables by hand.
> 
> It existed because the original 80386 would not honor the write protect
> bit when in kernel mode, so you had to do COW by hand before doing any
> user access.  But we haven't supported that in a long time, and these
> days the 'type' argument is a purely historical artifact.
> 
> A discussion about extending 'user_access_begin()' to do the range
> checking resulted this patch, because there is no way we're going to
> move the old VERIFY_xyz interface to that model.  And it's best done at
> the end of the merge window when I've done most of my merges, so let's
> just get this done once and for all.
> 
> This patch was mostly done with a sed-script, with manual fix-ups for
> the cases that weren't of the trivial 'access_ok(VERIFY_xyz' form.
> 
> There were a couple of notable cases:
> 
>  - csky still had the old "verify_area()" name as an alias.
> 
>  - the iter_iov code had magical hardcoded knowledge of the actual
>    values of VERIFY_{READ,WRITE} (not that they mattered, since nothing
>    really used it)
> 
>  - microblaze used the type argument for a debug printout
> 
> but other than those oddities this should be a total no-op patch.
> 
> I tried to fix up all architectures, did fairly extensive grepping for
> access_ok() uses, and the changes are trivial, but I may have missed
> something.  Any missed conversion should be trivially fixable, though.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

sparc32_defconfig:

In file included from ./include/linux/kernel.h:10:0,
                 from ./include/linux/plist.h:78,
		 from ./include/linux/pm_qos.h:8,
		 from kernel/power/qos.c:32:
./include/linux/uaccess.h: In function '_copy_from_user':
./arch/sparc/include/asm/uaccess_32.h:43:12: error: 'type' undeclared

... and this is just the very first build I happened to try this morning.

I triggered a complete test run and will send another note when I get the
results. I guess 0day will start screaming if it didn't already do so.

Guenter

> ---
>  arch/alpha/include/asm/futex.h                  |  2 +-
>  arch/alpha/include/asm/uaccess.h                |  2 +-
>  arch/alpha/kernel/signal.c                      | 12 +--
>  arch/alpha/lib/csum_partial_copy.c              |  2 +-
>  arch/arc/include/asm/futex.h                    |  2 +-
>  arch/arc/kernel/process.c                       |  2 +-
>  arch/arc/kernel/signal.c                        |  4 +-
>  arch/arm/include/asm/futex.h                    |  4 +-
>  arch/arm/include/asm/uaccess.h                  |  4 +-
>  arch/arm/kernel/perf_callchain.c                |  2 +-
>  arch/arm/kernel/signal.c                        |  6 +-
>  arch/arm/kernel/swp_emulate.c                   |  2 +-
>  arch/arm/kernel/sys_oabi-compat.c               |  4 +-
>  arch/arm/kernel/traps.c                         |  2 +-
>  arch/arm/oprofile/common.c                      |  2 +-
>  arch/arm64/include/asm/futex.h                  |  2 +-
>  arch/arm64/include/asm/uaccess.h                |  8 +-
>  arch/arm64/kernel/armv8_deprecated.c            |  2 +-
>  arch/arm64/kernel/perf_callchain.c              |  4 +-
>  arch/arm64/kernel/signal.c                      |  6 +-
>  arch/arm64/kernel/signal32.c                    |  6 +-
>  arch/arm64/kernel/sys_compat.c                  |  2 +-
>  arch/c6x/kernel/signal.c                        |  4 +-
>  arch/csky/abiv1/alignment.c                     |  4 +-
>  arch/csky/include/asm/uaccess.h                 | 16 +---
>  arch/csky/kernel/signal.c                       |  2 +-
>  arch/csky/lib/usercopy.c                        |  8 +-
>  arch/h8300/kernel/signal.c                      |  4 +-
>  arch/hexagon/include/asm/futex.h                |  2 +-
>  arch/hexagon/include/asm/uaccess.h              |  3 -
>  arch/hexagon/kernel/signal.c                    |  4 +-
>  arch/hexagon/mm/uaccess.c                       |  2 +-
>  arch/ia64/include/asm/futex.h                   |  2 +-
>  arch/ia64/include/asm/uaccess.h                 |  2 +-
>  arch/ia64/kernel/ptrace.c                       |  4 +-
>  arch/ia64/kernel/signal.c                       |  4 +-
>  arch/m68k/include/asm/uaccess_mm.h              |  2 +-
>  arch/m68k/include/asm/uaccess_no.h              |  2 +-
>  arch/m68k/kernel/signal.c                       |  4 +-
>  arch/microblaze/include/asm/futex.h             |  2 +-
>  arch/microblaze/include/asm/uaccess.h           | 23 +++---
>  arch/microblaze/kernel/signal.c                 |  4 +-
>  arch/mips/include/asm/checksum.h                |  4 +-
>  arch/mips/include/asm/futex.h                   |  2 +-
>  arch/mips/include/asm/termios.h                 |  4 +-
>  arch/mips/include/asm/uaccess.h                 | 12 +--
>  arch/mips/kernel/mips-r2-to-r6-emul.c           | 24 +++---
>  arch/mips/kernel/ptrace.c                       | 12 +--
>  arch/mips/kernel/signal.c                       | 12 +--
>  arch/mips/kernel/signal32.c                     |  4 +-
>  arch/mips/kernel/signal_n32.c                   |  4 +-
>  arch/mips/kernel/signal_o32.c                   |  8 +-
>  arch/mips/kernel/syscall.c                      |  2 +-
>  arch/mips/kernel/unaligned.c                    | 98 ++++++++++++-------------
>  arch/mips/math-emu/cp1emu.c                     | 16 ++--
>  arch/mips/mm/cache.c                            |  2 +-
>  arch/mips/mm/gup.c                              |  3 +-
>  arch/mips/oprofile/backtrace.c                  |  2 +-
>  arch/mips/sibyte/common/sb_tbprof.c             |  2 +-
>  arch/nds32/include/asm/futex.h                  |  2 +-
>  arch/nds32/include/asm/uaccess.h                | 11 +--
>  arch/nds32/kernel/perf_event_cpu.c              | 11 ++-
>  arch/nds32/kernel/signal.c                      |  4 +-
>  arch/nds32/mm/alignment.c                       |  8 +-
>  arch/nios2/include/asm/uaccess.h                |  8 +-
>  arch/nios2/kernel/signal.c                      |  2 +-
>  arch/openrisc/include/asm/futex.h               |  2 +-
>  arch/openrisc/include/asm/uaccess.h             |  8 +-
>  arch/openrisc/kernel/signal.c                   |  6 +-
>  arch/parisc/include/asm/futex.h                 |  2 +-
>  arch/parisc/include/asm/uaccess.h               |  2 +-
>  arch/powerpc/include/asm/futex.h                |  2 +-
>  arch/powerpc/include/asm/uaccess.h              |  8 +-
>  arch/powerpc/kernel/align.c                     |  3 +-
>  arch/powerpc/kernel/rtas_flash.c                |  2 +-
>  arch/powerpc/kernel/rtasd.c                     |  2 +-
>  arch/powerpc/kernel/signal.c                    |  2 +-
>  arch/powerpc/kernel/signal_32.c                 | 12 +--
>  arch/powerpc/kernel/signal_64.c                 | 13 ++--
>  arch/powerpc/kernel/syscalls.c                  |  2 +-
>  arch/powerpc/kernel/traps.c                     |  2 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c             |  4 +-
>  arch/powerpc/lib/checksum_wrappers.c            |  4 +-
>  arch/powerpc/mm/fault.c                         |  2 +-
>  arch/powerpc/mm/subpage-prot.c                  |  2 +-
>  arch/powerpc/oprofile/backtrace.c               |  4 +-
>  arch/powerpc/platforms/cell/spufs/file.c        | 16 ++--
>  arch/powerpc/platforms/powernv/opal-lpc.c       |  4 +-
>  arch/powerpc/platforms/pseries/scanlog.c        |  2 +-
>  arch/riscv/include/asm/futex.h                  |  2 +-
>  arch/riscv/include/asm/uaccess.h                | 14 +---
>  arch/riscv/kernel/signal.c                      |  4 +-
>  arch/s390/include/asm/uaccess.h                 |  2 +-
>  arch/sh/include/asm/checksum_32.h               |  2 +-
>  arch/sh/include/asm/futex.h                     |  2 +-
>  arch/sh/include/asm/uaccess.h                   |  9 +--
>  arch/sh/kernel/signal_32.c                      |  8 +-
>  arch/sh/kernel/signal_64.c                      |  8 +-
>  arch/sh/kernel/traps_64.c                       | 12 +--
>  arch/sh/mm/gup.c                                |  3 +-
>  arch/sh/oprofile/backtrace.c                    |  2 +-
>  arch/sparc/include/asm/checksum_32.h            |  2 +-
>  arch/sparc/include/asm/uaccess_32.h             |  2 +-
>  arch/sparc/include/asm/uaccess_64.h             |  2 +-
>  arch/sparc/kernel/sigutil_32.c                  |  2 +-
>  arch/sparc/kernel/unaligned_32.c                |  7 +-
>  arch/um/kernel/ptrace.c                         |  4 +-
>  arch/unicore32/kernel/signal.c                  |  4 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c           |  2 +-
>  arch/x86/ia32/ia32_aout.c                       |  4 +-
>  arch/x86/ia32/ia32_signal.c                     |  8 +-
>  arch/x86/ia32/sys_ia32.c                        |  2 +-
>  arch/x86/include/asm/checksum_32.h              |  2 +-
>  arch/x86/include/asm/pgtable_32.h               |  2 +-
>  arch/x86/include/asm/uaccess.h                  |  7 +-
>  arch/x86/kernel/fpu/signal.c                    |  4 +-
>  arch/x86/kernel/signal.c                        | 14 ++--
>  arch/x86/kernel/stacktrace.c                    |  2 +-
>  arch/x86/kernel/vm86_32.c                       |  4 +-
>  arch/x86/lib/csum-wrappers_64.c                 |  4 +-
>  arch/x86/lib/usercopy_32.c                      |  2 +-
>  arch/x86/lib/usercopy_64.c                      |  2 +-
>  arch/x86/math-emu/fpu_system.h                  |  4 +-
>  arch/x86/math-emu/load_store.c                  |  6 +-
>  arch/x86/math-emu/reg_ld_str.c                  | 48 ++++++------
>  arch/x86/mm/mpx.c                               |  2 +-
>  arch/x86/um/asm/checksum_32.h                   |  2 +-
>  arch/x86/um/signal.c                            |  6 +-
>  arch/xtensa/include/asm/checksum.h              |  2 +-
>  arch/xtensa/include/asm/futex.h                 |  2 +-
>  arch/xtensa/include/asm/uaccess.h               | 10 +--
>  arch/xtensa/kernel/signal.c                     |  4 +-
>  arch/xtensa/kernel/stacktrace.c                 |  2 +-
>  drivers/acpi/acpi_dbg.c                         |  4 +-
>  drivers/char/generic_nvram.c                    |  4 +-
>  drivers/char/mem.c                              |  4 +-
>  drivers/char/nwflash.c                          |  2 +-
>  drivers/char/pcmcia/cm4000_cs.c                 |  4 +-
>  drivers/crypto/ccp/psp-dev.c                    |  6 +-
>  drivers/firewire/core-cdev.c                    |  2 +-
>  drivers/firmware/efi/test/efi_test.c            |  8 +-
>  drivers/fpga/dfl-afu-dma-region.c               |  2 +-
>  drivers/fpga/dfl-fme-pr.c                       |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 18 ++---
>  drivers/gpu/drm/armada/armada_gem.c             |  2 +-
>  drivers/gpu/drm/drm_file.c                      |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c           |  8 +-
>  drivers/gpu/drm/i915/i915_gem.c                 |  7 +-
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c      |  6 +-
>  drivers/gpu/drm/i915/i915_gem_userptr.c         |  3 +-
>  drivers/gpu/drm/i915/i915_ioc32.c               |  2 +-
>  drivers/gpu/drm/i915/i915_perf.c                |  2 +-
>  drivers/gpu/drm/i915/i915_query.c               |  2 +-
>  drivers/gpu/drm/msm/msm_gem_submit.c            |  2 +-
>  drivers/gpu/drm/qxl/qxl_ioctl.c                 |  3 +-
>  drivers/infiniband/core/uverbs_main.c           |  3 +-
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c       |  2 +-
>  drivers/infiniband/hw/qib/qib_file_ops.c        |  2 +-
>  drivers/macintosh/ans-lcd.c                     |  2 +-
>  drivers/macintosh/via-pmu.c                     |  2 +-
>  drivers/media/pci/ivtv/ivtvfb.c                 |  2 +-
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c   | 46 ++++++------
>  drivers/misc/vmw_vmci/vmci_host.c               |  2 +-
>  drivers/pci/proc.c                              |  4 +-
>  drivers/platform/goldfish/goldfish_pipe.c       |  3 +-
>  drivers/pnp/isapnp/proc.c                       |  2 +-
>  drivers/scsi/pmcraid.c                          |  4 +-
>  drivers/scsi/scsi_ioctl.c                       |  2 +-
>  drivers/scsi/sg.c                               | 16 ++--
>  drivers/staging/comedi/comedi_compat32.c        | 24 +++---
>  drivers/tty/n_hdlc.c                            |  2 +-
>  drivers/usb/core/devices.c                      |  2 +-
>  drivers/usb/core/devio.c                        |  7 +-
>  drivers/usb/gadget/function/f_hid.c             |  4 +-
>  drivers/usb/gadget/udc/atmel_usba_udc.c         |  2 +-
>  drivers/vhost/vhost.c                           | 16 ++--
>  drivers/video/fbdev/amifb.c                     |  4 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  2 +-
>  drivers/xen/privcmd.c                           |  6 +-
>  fs/binfmt_aout.c                                |  4 +-
>  fs/btrfs/send.c                                 |  2 +-
>  fs/eventpoll.c                                  |  2 +-
>  fs/fat/dir.c                                    |  4 +-
>  fs/ioctl.c                                      |  2 +-
>  fs/namespace.c                                  |  2 +-
>  fs/ocfs2/dlmfs/dlmfs.c                          |  4 +-
>  fs/pstore/pmsg.c                                |  2 +-
>  fs/pstore/ram_core.c                            |  2 +-
>  fs/read_write.c                                 | 13 ++--
>  fs/readdir.c                                    | 10 +--
>  fs/select.c                                     | 11 +--
>  include/asm-generic/uaccess.h                   | 12 +--
>  include/linux/regset.h                          |  4 +-
>  include/linux/uaccess.h                         |  9 +--
>  include/net/checksum.h                          |  4 +-
>  kernel/bpf/syscall.c                            |  2 +-
>  kernel/compat.c                                 | 16 ++--
>  kernel/events/core.c                            |  2 +-
>  kernel/exit.c                                   |  4 +-
>  kernel/futex.c                                  | 35 +++++----
>  kernel/printk/printk.c                          |  4 +-
>  kernel/ptrace.c                                 |  4 +-
>  kernel/rseq.c                                   |  6 +-
>  kernel/sched/core.c                             |  4 +-
>  kernel/signal.c                                 |  8 +-
>  kernel/sys.c                                    |  2 +-
>  kernel/trace/bpf_trace.c                        |  2 +-
>  lib/bitmap.c                                    |  4 +-
>  lib/iov_iter.c                                  |  8 +-
>  lib/usercopy.c                                  |  4 +-
>  mm/gup.c                                        |  6 +-
>  mm/mincore.c                                    |  4 +-
>  net/batman-adv/icmp_socket.c                    |  2 +-
>  net/batman-adv/log.c                            |  2 +-
>  net/compat.c                                    | 30 ++++----
>  net/sunrpc/sysctl.c                             |  2 +-
>  security/tomoyo/common.c                        |  2 +-
>  sound/core/seq/seq_clientmgr.c                  |  2 +-
>  sound/isa/sb/emu8000_patch.c                    |  4 +-
>  tools/perf/util/include/asm/uaccess.h           |  2 +-
>  virt/kvm/kvm_main.c                             |  3 +-
>  221 files changed, 610 insertions(+), 679 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/futex.h b/arch/alpha/include/asm/futex.h
> index ca3322536f72..bfd3c01038f8 100644
> --- a/arch/alpha/include/asm/futex.h
> +++ b/arch/alpha/include/asm/futex.h
> @@ -68,7 +68,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0, cmp;
>  	u32 prev;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	__asm__ __volatile__ (
> diff --git a/arch/alpha/include/asm/uaccess.h b/arch/alpha/include/asm/uaccess.h
> index 87d8c4f0307d..e69c4e13c328 100644
> --- a/arch/alpha/include/asm/uaccess.h
> +++ b/arch/alpha/include/asm/uaccess.h
> @@ -36,7 +36,7 @@
>  #define __access_ok(addr, size) \
>  	((get_fs().seg & (addr | size | (addr+size))) == 0)
>  
> -#define access_ok(type, addr, size)			\
> +#define access_ok(addr, size)				\
>  ({							\
>  	__chk_user_ptr(addr);				\
>  	__access_ok(((unsigned long)(addr)), (size));	\
> diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
> index 8c0c4ee0be6e..33e904a05881 100644
> --- a/arch/alpha/kernel/signal.c
> +++ b/arch/alpha/kernel/signal.c
> @@ -65,7 +65,7 @@ SYSCALL_DEFINE3(osf_sigaction, int, sig,
>  
>  	if (act) {
>  		old_sigset_t mask;
> -		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
> +		if (!access_ok(act, sizeof(*act)) ||
>  		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
>  		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
>  		    __get_user(mask, &act->sa_mask))
> @@ -77,7 +77,7 @@ SYSCALL_DEFINE3(osf_sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
> +		if (!access_ok(oact, sizeof(*oact)) ||
>  		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
>  		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
>  		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> @@ -207,7 +207,7 @@ do_sigreturn(struct sigcontext __user *sc)
>  	sigset_t set;
>  
>  	/* Verify that it's a good sigcontext before using it */
> -	if (!access_ok(VERIFY_READ, sc, sizeof(*sc)))
> +	if (!access_ok(sc, sizeof(*sc)))
>  		goto give_sigsegv;
>  	if (__get_user(set.sig[0], &sc->sc_mask))
>  		goto give_sigsegv;
> @@ -235,7 +235,7 @@ do_rt_sigreturn(struct rt_sigframe __user *frame)
>  	sigset_t set;
>  
>  	/* Verify that it's a good ucontext_t before using it */
> -	if (!access_ok(VERIFY_READ, &frame->uc, sizeof(frame->uc)))
> +	if (!access_ok(&frame->uc, sizeof(frame->uc)))
>  		goto give_sigsegv;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto give_sigsegv;
> @@ -332,7 +332,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  
>  	oldsp = rdusp();
>  	frame = get_sigframe(ksig, oldsp, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= setup_sigcontext(&frame->sc, regs, set->sig[0], oldsp);
> @@ -377,7 +377,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  
>  	oldsp = rdusp();
>  	frame = get_sigframe(ksig, oldsp, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
> index ddb9c2f376fa..e53f96e8aa6d 100644
> --- a/arch/alpha/lib/csum_partial_copy.c
> +++ b/arch/alpha/lib/csum_partial_copy.c
> @@ -333,7 +333,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len,
>  	unsigned long doff = 7 & (unsigned long) dst;
>  
>  	if (len) {
> -		if (!access_ok(VERIFY_READ, src, len)) {
> +		if (!access_ok(src, len)) {
>  			if (errp) *errp = -EFAULT;
>  			memset(dst, 0, len);
>  			return sum;
> diff --git a/arch/arc/include/asm/futex.h b/arch/arc/include/asm/futex.h
> index eb887dd13e74..c29c3fae6854 100644
> --- a/arch/arc/include/asm/futex.h
> +++ b/arch/arc/include/asm/futex.h
> @@ -126,7 +126,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 expval,
>  	int ret = 0;
>  	u32 existval;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  #ifndef CONFIG_ARC_HAS_LLSC
> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 8ce6e7235915..641c364fc232 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -61,7 +61,7 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>  	/* Z indicates to userspace if operation succeded */
>  	regs->status32 &= ~STATUS_Z_MASK;
>  
> -	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
> +	ret = access_ok(uaddr, sizeof(*uaddr));
>  	if (!ret)
>  		 goto fail;
>  
> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> index 48685445002e..1bfb7de696bd 100644
> --- a/arch/arc/kernel/signal.c
> +++ b/arch/arc/kernel/signal.c
> @@ -169,7 +169,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  
>  	sf = (struct rt_sigframe __force __user *)(regs->sp);
>  
> -	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)))
> +	if (!access_ok(sf, sizeof(*sf)))
>  		goto badframe;
>  
>  	if (__get_user(magic, &sf->sigret_magic))
> @@ -219,7 +219,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
>  	frame = (void __user *)((sp - framesize) & ~7);
>  
>  	/* Check that we can actually write to the signal frame */
> -	if (!access_ok(VERIFY_WRITE, frame, framesize))
> +	if (!access_ok(frame, framesize))
>  		frame = NULL;
>  
>  	return frame;
> diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> index ffebe7b7a5b7..0a46676b4245 100644
> --- a/arch/arm/include/asm/futex.h
> +++ b/arch/arm/include/asm/futex.h
> @@ -50,7 +50,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret;
>  	u32 val;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	smp_mb();
> @@ -104,7 +104,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0;
>  	u32 val;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	preempt_disable();
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index c136eef8f690..27ed17ec45fe 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -279,7 +279,7 @@ static inline void set_fs(mm_segment_t fs)
>  
>  #endif /* CONFIG_MMU */
>  
> -#define access_ok(type, addr, size)	(__range_ok(addr, size) == 0)
> +#define access_ok(addr, size)	(__range_ok(addr, size) == 0)
>  
>  #define user_addr_max() \
>  	(uaccess_kernel() ? ~0UL : get_fs())
> @@ -560,7 +560,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>  
>  static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		n = __clear_user(to, n);
>  	return n;
>  }
> diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
> index 08e43a32a693..3b69a76d341e 100644
> --- a/arch/arm/kernel/perf_callchain.c
> +++ b/arch/arm/kernel/perf_callchain.c
> @@ -37,7 +37,7 @@ user_backtrace(struct frame_tail __user *tail,
>  	struct frame_tail buftail;
>  	unsigned long err;
>  
> -	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
> +	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
>  
>  	pagefault_disable();
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index b908382b69ff..76bb8de6bf6b 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -241,7 +241,7 @@ asmlinkage int sys_sigreturn(struct pt_regs *regs)
>  
>  	frame = (struct sigframe __user *)regs->ARM_sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
>  	if (restore_sigframe(regs, frame))
> @@ -271,7 +271,7 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
>  
>  	frame = (struct rt_sigframe __user *)regs->ARM_sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
>  	if (restore_sigframe(regs, &frame->sig))
> @@ -355,7 +355,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, int framesize)
>  	/*
>  	 * Check that we can actually write to the signal frame.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, frame, framesize))
> +	if (!access_ok(frame, framesize))
>  		frame = NULL;
>  
>  	return frame;
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index a188d5e8ab7f..76f6e6a9736c 100644
> --- a/arch/arm/kernel/swp_emulate.c
> +++ b/arch/arm/kernel/swp_emulate.c
> @@ -198,7 +198,7 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
>  		 destreg, EXTRACT_REG_NUM(instr, RT2_OFFSET), data);
>  
>  	/* Check access in reasonable access range for both SWP and SWPB */
> -	if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
> +	if (!access_ok((address & ~3), 4)) {
>  		pr_debug("SWP{B} emulation: access to %p not allowed!\n",
>  			 (void *)address);
>  		res = -EFAULT;
> diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
> index 40da0872170f..92ab36f38795 100644
> --- a/arch/arm/kernel/sys_oabi-compat.c
> +++ b/arch/arm/kernel/sys_oabi-compat.c
> @@ -285,7 +285,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
>  			maxevents > (INT_MAX/sizeof(*kbuf)) ||
>  			maxevents > (INT_MAX/sizeof(*events)))
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_WRITE, events, sizeof(*events) * maxevents))
> +	if (!access_ok(events, sizeof(*events) * maxevents))
>  		return -EFAULT;
>  	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
>  	if (!kbuf)
> @@ -326,7 +326,7 @@ asmlinkage long sys_oabi_semtimedop(int semid,
>  
>  	if (nsops < 1 || nsops > SEMOPM)
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_READ, tsops, sizeof(*tsops) * nsops))
> +	if (!access_ok(tsops, sizeof(*tsops) * nsops))
>  		return -EFAULT;
>  	sops = kmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
>  	if (!sops)
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 2d668cff8ef4..33af097c454b 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -582,7 +582,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
>  	if (end < start || flags)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_READ, start, end - start))
> +	if (!access_ok(start, end - start))
>  		return -EFAULT;
>  
>  	return __do_cache_op(start, end);
> diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> index cc649a1e46da..7cb3e0453fcd 100644
> --- a/arch/arm/oprofile/common.c
> +++ b/arch/arm/oprofile/common.c
> @@ -88,7 +88,7 @@ static struct frame_tail* user_backtrace(struct frame_tail *tail)
>  	struct frame_tail buftail[2];
>  
>  	/* Also check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
> +	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
>  	if (__copy_from_user_inatomic(buftail, tail, sizeof(buftail)))
>  		return NULL;
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index 07fe2479d310..cccb83ad7fa8 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -96,7 +96,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *_uaddr,
>  	u32 val, tmp;
>  	u32 __user *uaddr;
>  
> -	if (!access_ok(VERIFY_WRITE, _uaddr, sizeof(u32)))
> +	if (!access_ok(_uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	uaddr = __uaccess_mask_ptr(_uaddr);
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index ed252435fd92..547d7a0c9d05 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -95,7 +95,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  	return ret;
>  }
>  
> -#define access_ok(type, addr, size)	__range_ok(addr, size)
> +#define access_ok(addr, size)	__range_ok(addr, size)
>  #define user_addr_max			get_fs
>  
>  #define _ASM_EXTABLE(from, to)						\
> @@ -301,7 +301,7 @@ do {									\
>  ({									\
>  	__typeof__(*(ptr)) __user *__p = (ptr);				\
>  	might_fault();							\
> -	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
> +	if (access_ok(__p, sizeof(*__p))) {				\
>  		__p = uaccess_mask_ptr(__p);				\
>  		__get_user_err((x), __p, (err));			\
>  	} else {							\
> @@ -370,7 +370,7 @@ do {									\
>  ({									\
>  	__typeof__(*(ptr)) __user *__p = (ptr);				\
>  	might_fault();							\
> -	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
> +	if (access_ok(__p, sizeof(*__p))) {				\
>  		__p = uaccess_mask_ptr(__p);				\
>  		__put_user_err((x), __p, (err));			\
>  	} else	{							\
> @@ -418,7 +418,7 @@ extern unsigned long __must_check __arch_copy_in_user(void __user *to, const voi
>  extern unsigned long __must_check __arch_clear_user(void __user *to, unsigned long n);
>  static inline unsigned long __must_check __clear_user(void __user *to, unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		n = __arch_clear_user(__uaccess_mask_ptr(to), n);
>  	return n;
>  }
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 92be1d12d590..e52e7280884a 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -402,7 +402,7 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
>  
>  	/* Check access in reasonable access range for both SWP and SWPB */
>  	user_ptr = (const void __user *)(unsigned long)(address & ~3);
> -	if (!access_ok(VERIFY_WRITE, user_ptr, 4)) {
> +	if (!access_ok(user_ptr, 4)) {
>  		pr_debug("SWP{B} emulation: access to 0x%08x not allowed!\n",
>  			address);
>  		goto fault;
> diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
> index a34c26afacb0..61d983f5756f 100644
> --- a/arch/arm64/kernel/perf_callchain.c
> +++ b/arch/arm64/kernel/perf_callchain.c
> @@ -39,7 +39,7 @@ user_backtrace(struct frame_tail __user *tail,
>  	unsigned long lr;
>  
>  	/* Also check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
> +	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
>  
>  	pagefault_disable();
> @@ -86,7 +86,7 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
>  	unsigned long err;
>  
>  	/* Also check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
> +	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
>  
>  	pagefault_disable();
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 5dcc942906db..867a7cea70e5 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -470,7 +470,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  			offset = 0;
>  			limit = extra_size;
>  
> -			if (!access_ok(VERIFY_READ, base, limit))
> +			if (!access_ok(base, limit))
>  				goto invalid;
>  
>  			continue;
> @@ -556,7 +556,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  
>  	frame = (struct rt_sigframe __user *)regs->sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
>  	if (restore_sigframe(regs, frame))
> @@ -730,7 +730,7 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
>  	/*
>  	 * Check that we can actually write to the signal frame.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, user->sigframe, sp_top - sp))
> +	if (!access_ok(user->sigframe, sp_top - sp))
>  		return -EFAULT;
>  
>  	return 0;
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index 24b09003f821..cb7800acd19f 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -303,7 +303,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
>  
>  	frame = (struct compat_sigframe __user *)regs->compat_sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
>  	if (compat_restore_sigframe(regs, frame))
> @@ -334,7 +334,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
>  
>  	frame = (struct compat_rt_sigframe __user *)regs->compat_sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
>  	if (compat_restore_sigframe(regs, &frame->sig))
> @@ -365,7 +365,7 @@ static void __user *compat_get_sigframe(struct ksignal *ksig,
>  	/*
>  	 * Check that we can actually write to the signal frame.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, frame, framesize))
> +	if (!access_ok(frame, framesize))
>  		frame = NULL;
>  
>  	return frame;
> diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
> index 32653d156747..21005dfe8406 100644
> --- a/arch/arm64/kernel/sys_compat.c
> +++ b/arch/arm64/kernel/sys_compat.c
> @@ -58,7 +58,7 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
>  	if (end < start || flags)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_READ, (const void __user *)start, end - start))
> +	if (!access_ok((const void __user *)start, end - start))
>  		return -EFAULT;
>  
>  	return __do_compat_cache_op(start, end);
> diff --git a/arch/c6x/kernel/signal.c b/arch/c6x/kernel/signal.c
> index 3c4bb5a5c382..33b9f69c38f7 100644
> --- a/arch/c6x/kernel/signal.c
> +++ b/arch/c6x/kernel/signal.c
> @@ -80,7 +80,7 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs)
>  
>  	frame = (struct rt_sigframe __user *) ((unsigned long) regs->sp + 8);
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -149,7 +149,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= __put_user(&frame->info, &frame->pinfo);
> diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> index 60205e98fb87..d789be36eb4f 100644
> --- a/arch/csky/abiv1/alignment.c
> +++ b/arch/csky/abiv1/alignment.c
> @@ -32,7 +32,7 @@ static int ldb_asm(uint32_t addr, uint32_t *valp)
>  	uint32_t val;
>  	int err;
>  
> -	if (!access_ok(VERIFY_READ, (void *)addr, 1))
> +	if (!access_ok((void *)addr, 1))
>  		return 1;
>  
>  	asm volatile (
> @@ -67,7 +67,7 @@ static int stb_asm(uint32_t addr, uint32_t val)
>  {
>  	int err;
>  
> -	if (!access_ok(VERIFY_WRITE, (void *)addr, 1))
> +	if (!access_ok((void *)addr, 1))
>  		return 1;
>  
>  	asm volatile (
> diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
> index acaf0e210d81..eaa1c3403a42 100644
> --- a/arch/csky/include/asm/uaccess.h
> +++ b/arch/csky/include/asm/uaccess.h
> @@ -16,10 +16,7 @@
>  #include <linux/version.h>
>  #include <asm/segment.h>
>  
> -#define VERIFY_READ	0
> -#define VERIFY_WRITE	1
> -
> -static inline int access_ok(int type, const void *addr, unsigned long size)
> +static inline int access_ok(const void *addr, unsigned long size)
>  {
>  	unsigned long limit = current_thread_info()->addr_limit.seg;
>  
> @@ -27,12 +24,7 @@ static inline int access_ok(int type, const void *addr, unsigned long size)
>  		((unsigned long)(addr + size) < limit));
>  }
>  
> -static inline int verify_area(int type, const void *addr, unsigned long size)
> -{
> -	return access_ok(type, addr, size) ? 0 : -EFAULT;
> -}
> -
> -#define __addr_ok(addr) (access_ok(VERIFY_READ, addr, 0))
> +#define __addr_ok(addr) (access_ok(addr, 0))
>  
>  extern int __put_user_bad(void);
>  
> @@ -91,7 +83,7 @@ extern int __put_user_bad(void);
>  	long __pu_err = -EFAULT;					\
>  	typeof(*(ptr)) *__pu_addr = (ptr);				\
>  	typeof(*(ptr)) __pu_val = (typeof(*(ptr)))(x);			\
> -	if (access_ok(VERIFY_WRITE, __pu_addr, size) && __pu_addr)	\
> +	if (access_ok(__pu_addr, size) && __pu_addr)	\
>  		__put_user_size(__pu_val, __pu_addr, (size), __pu_err);	\
>  	__pu_err;							\
>  })
> @@ -217,7 +209,7 @@ do {								\
>  ({								\
>  	int __gu_err = -EFAULT;					\
>  	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
> -	if (access_ok(VERIFY_READ, __gu_ptr, size) && __gu_ptr)	\
> +	if (access_ok(__gu_ptr, size) && __gu_ptr)	\
>  		__get_user_size(x, __gu_ptr, size, __gu_err);	\
>  	__gu_err;						\
>  })
> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index 66e1b729b10b..9967c10eee2b 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -88,7 +88,7 @@ do_rt_sigreturn(void)
>  	struct pt_regs *regs = current_pt_regs();
>  	struct rt_sigframe *frame = (struct rt_sigframe *)(regs->usp);
>  
> -	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> diff --git a/arch/csky/lib/usercopy.c b/arch/csky/lib/usercopy.c
> index ac9170e2cbb8..647a23986fb5 100644
> --- a/arch/csky/lib/usercopy.c
> +++ b/arch/csky/lib/usercopy.c
> @@ -7,7 +7,7 @@
>  unsigned long raw_copy_from_user(void *to, const void *from,
>  			unsigned long n)
>  {
> -	if (access_ok(VERIFY_READ, from, n))
> +	if (access_ok(from, n))
>  		__copy_user_zeroing(to, from, n);
>  	else
>  		memset(to, 0, n);
> @@ -18,7 +18,7 @@ EXPORT_SYMBOL(raw_copy_from_user);
>  unsigned long raw_copy_to_user(void *to, const void *from,
>  			unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		__copy_user(to, from, n);
>  	return n;
>  }
> @@ -113,7 +113,7 @@ long strncpy_from_user(char *dst, const char *src, long count)
>  {
>  	long res = -EFAULT;
>  
> -	if (access_ok(VERIFY_READ, src, 1))
> +	if (access_ok(src, 1))
>  		__do_strncpy_from_user(dst, src, count, res);
>  	return res;
>  }
> @@ -236,7 +236,7 @@ do {							\
>  unsigned long
>  clear_user(void __user *to, unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		__do_clear_user(to, n);
>  	return n;
>  }
> diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
> index 1e8070d08770..e0f2b708e5d9 100644
> --- a/arch/h8300/kernel/signal.c
> +++ b/arch/h8300/kernel/signal.c
> @@ -110,7 +110,7 @@ asmlinkage int sys_rt_sigreturn(void)
>  	sigset_t set;
>  	int er0;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -165,7 +165,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> diff --git a/arch/hexagon/include/asm/futex.h b/arch/hexagon/include/asm/futex.h
> index c889f5993ecd..cb635216a732 100644
> --- a/arch/hexagon/include/asm/futex.h
> +++ b/arch/hexagon/include/asm/futex.h
> @@ -77,7 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval,
>  	int prev;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	__asm__ __volatile__ (
> diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
> index 458b69886b34..a30e58d5f351 100644
> --- a/arch/hexagon/include/asm/uaccess.h
> +++ b/arch/hexagon/include/asm/uaccess.h
> @@ -29,9 +29,6 @@
>  
>  /*
>   * access_ok: - Checks if a user space pointer is valid
> - * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
> - *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
> - *        to write to a block, it is always safe to read from it.
>   * @addr: User space pointer to start of block to check
>   * @size: Size of block to check
>   *
> diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
> index 78aa7304a5c9..31e2cf95f189 100644
> --- a/arch/hexagon/kernel/signal.c
> +++ b/arch/hexagon/kernel/signal.c
> @@ -115,7 +115,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(struct rt_sigframe)))
> +	if (!access_ok(frame, sizeof(struct rt_sigframe)))
>  		return -EFAULT;
>  
>  	if (copy_siginfo_to_user(&frame->info, &ksig->info))
> @@ -244,7 +244,7 @@ asmlinkage int sys_rt_sigreturn(void)
>  	current->restart_block.fn = do_no_restart_syscall;
>  
>  	frame = (struct rt_sigframe __user *)pt_psp(regs);
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&blocked, &frame->uc.uc_sigmask, sizeof(blocked)))
>  		goto badframe;
> diff --git a/arch/hexagon/mm/uaccess.c b/arch/hexagon/mm/uaccess.c
> index c599eb126c9e..6f9c4697552c 100644
> --- a/arch/hexagon/mm/uaccess.c
> +++ b/arch/hexagon/mm/uaccess.c
> @@ -51,7 +51,7 @@ __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count)
>  
>  unsigned long clear_user_hexagon(void __user *dest, unsigned long count)
>  {
> -	if (!access_ok(VERIFY_WRITE, dest, count))
> +	if (!access_ok(dest, count))
>  		return count;
>  	else
>  		return __clear_user_hexagon(dest, count);
> diff --git a/arch/ia64/include/asm/futex.h b/arch/ia64/include/asm/futex.h
> index db2dd85918c2..2e106d462196 100644
> --- a/arch/ia64/include/asm/futex.h
> +++ b/arch/ia64/include/asm/futex.h
> @@ -86,7 +86,7 @@ static inline int
>  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  			      u32 oldval, u32 newval)
>  {
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	{
> diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
> index a74524f2d625..306d469e43da 100644
> --- a/arch/ia64/include/asm/uaccess.h
> +++ b/arch/ia64/include/asm/uaccess.h
> @@ -67,7 +67,7 @@ static inline int __access_ok(const void __user *p, unsigned long size)
>  	return likely(addr <= seg) &&
>  	 (seg == KERNEL_DS.seg || likely(REGION_OFFSET(addr) < RGN_MAP_LIMIT));
>  }
> -#define access_ok(type, addr, size)	__access_ok((addr), (size))
> +#define access_ok(addr, size)	__access_ok((addr), (size))
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
> index 427cd565fd61..6d50ede0ed69 100644
> --- a/arch/ia64/kernel/ptrace.c
> +++ b/arch/ia64/kernel/ptrace.c
> @@ -836,7 +836,7 @@ ptrace_getregs (struct task_struct *child, struct pt_all_user_regs __user *ppr)
>  	char nat = 0;
>  	int i;
>  
> -	if (!access_ok(VERIFY_WRITE, ppr, sizeof(struct pt_all_user_regs)))
> +	if (!access_ok(ppr, sizeof(struct pt_all_user_regs)))
>  		return -EIO;
>  
>  	pt = task_pt_regs(child);
> @@ -981,7 +981,7 @@ ptrace_setregs (struct task_struct *child, struct pt_all_user_regs __user *ppr)
>  
>  	memset(&fpval, 0, sizeof(fpval));
>  
> -	if (!access_ok(VERIFY_READ, ppr, sizeof(struct pt_all_user_regs)))
> +	if (!access_ok(ppr, sizeof(struct pt_all_user_regs)))
>  		return -EIO;
>  
>  	pt = task_pt_regs(child);
> diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
> index 99099f73b207..6062fd14e34e 100644
> --- a/arch/ia64/kernel/signal.c
> +++ b/arch/ia64/kernel/signal.c
> @@ -132,7 +132,7 @@ ia64_rt_sigreturn (struct sigscratch *scr)
>  		 */
>  		retval = (long) &ia64_strace_leave_kernel;
>  
> -	if (!access_ok(VERIFY_READ, sc, sizeof(*sc)))
> +	if (!access_ok(sc, sizeof(*sc)))
>  		goto give_sigsegv;
>  
>  	if (GET_SIGSET(&set, &sc->sc_mask))
> @@ -264,7 +264,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
>  	}
>  	frame = (void __user *) ((new_sp - sizeof(*frame)) & -STACK_ALIGN);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame))) {
> +	if (!access_ok(frame, sizeof(*frame))) {
>  		force_sigsegv(ksig->sig, current);
>  		return 1;
>  	}
> diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
> index c4cb889660aa..7e85de984df1 100644
> --- a/arch/m68k/include/asm/uaccess_mm.h
> +++ b/arch/m68k/include/asm/uaccess_mm.h
> @@ -10,7 +10,7 @@
>  #include <asm/segment.h>
>  
>  /* We let the MMU do all checking */
> -static inline int access_ok(int type, const void __user *addr,
> +static inline int access_ok(const void __user *addr,
>  			    unsigned long size)
>  {
>  	return 1;
> diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
> index 892efb56beef..0134008bf539 100644
> --- a/arch/m68k/include/asm/uaccess_no.h
> +++ b/arch/m68k/include/asm/uaccess_no.h
> @@ -10,7 +10,7 @@
>  
>  #include <asm/segment.h>
>  
> -#define access_ok(type,addr,size)	_access_ok((unsigned long)(addr),(size))
> +#define access_ok(addr,size)	_access_ok((unsigned long)(addr),(size))
>  
>  /*
>   * It is not enough to just have access_ok check for a real RAM address.
> diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
> index 72850b85ecf8..e2a9421c5797 100644
> --- a/arch/m68k/kernel/signal.c
> +++ b/arch/m68k/kernel/signal.c
> @@ -787,7 +787,7 @@ asmlinkage int do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
>  	struct sigframe __user *frame = (struct sigframe __user *)(usp - 4);
>  	sigset_t set;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__get_user(set.sig[0], &frame->sc.sc_mask) ||
>  	    (_NSIG_WORDS > 1 &&
> @@ -812,7 +812,7 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
>  	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)(usp - 4);
>  	sigset_t set;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> diff --git a/arch/microblaze/include/asm/futex.h b/arch/microblaze/include/asm/futex.h
> index 2572077b04ea..8c90357e5983 100644
> --- a/arch/microblaze/include/asm/futex.h
> +++ b/arch/microblaze/include/asm/futex.h
> @@ -71,7 +71,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0, cmp;
>  	u32 prev;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	__asm__ __volatile__ ("1:	lwx	%1, %3, r0;		\
> diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
> index 81f16aadbf9e..dbfea093a7c7 100644
> --- a/arch/microblaze/include/asm/uaccess.h
> +++ b/arch/microblaze/include/asm/uaccess.h
> @@ -60,26 +60,25 @@ static inline int ___range_ok(unsigned long addr, unsigned long size)
>  #define __range_ok(addr, size) \
>  		___range_ok((unsigned long)(addr), (unsigned long)(size))
>  
> -#define access_ok(type, addr, size) (__range_ok((addr), (size)) == 0)
> +#define access_ok(addr, size) (__range_ok((addr), (size)) == 0)
>  
>  #else
>  
> -static inline int access_ok(int type, const void __user *addr,
> -							unsigned long size)
> +static inline int access_ok(const void __user *addr, unsigned long size)
>  {
>  	if (!size)
>  		goto ok;
>  
>  	if ((get_fs().seg < ((unsigned long)addr)) ||
>  			(get_fs().seg < ((unsigned long)addr + size - 1))) {
> -		pr_devel("ACCESS fail: %s at 0x%08x (size 0x%x), seg 0x%08x\n",
> -			type ? "WRITE" : "READ ", (__force u32)addr, (u32)size,
> +		pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
> +			(__force u32)addr, (u32)size,
>  			(u32)get_fs().seg);
>  		return 0;
>  	}
>  ok:
> -	pr_devel("ACCESS OK: %s at 0x%08x (size 0x%x), seg 0x%08x\n",
> -			type ? "WRITE" : "READ ", (__force u32)addr, (u32)size,
> +	pr_devel("ACCESS OK at 0x%08x (size 0x%x), seg 0x%08x\n",
> +			(__force u32)addr, (u32)size,
>  			(u32)get_fs().seg);
>  	return 1;
>  }
> @@ -120,7 +119,7 @@ static inline unsigned long __must_check clear_user(void __user *to,
>  							unsigned long n)
>  {
>  	might_fault();
> -	if (unlikely(!access_ok(VERIFY_WRITE, to, n)))
> +	if (unlikely(!access_ok(to, n)))
>  		return n;
>  
>  	return __clear_user(to, n);
> @@ -174,7 +173,7 @@ extern long __user_bad(void);
>  	const typeof(*(ptr)) __user *__gu_addr = (ptr);			\
>  	int __gu_err = 0;						\
>  									\
> -	if (access_ok(VERIFY_READ, __gu_addr, size)) {			\
> +	if (access_ok(__gu_addr, size)) {			\
>  		switch (size) {						\
>  		case 1:							\
>  			__get_user_asm("lbu", __gu_addr, __gu_val,	\
> @@ -286,7 +285,7 @@ extern long __user_bad(void);
>  	typeof(*(ptr)) __user *__pu_addr = (ptr);			\
>  	int __pu_err = 0;						\
>  									\
> -	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
> +	if (access_ok(__pu_addr, size)) {			\
>  		switch (size) {						\
>  		case 1:							\
>  			__put_user_asm("sb", __pu_addr, __pu_val,	\
> @@ -358,7 +357,7 @@ extern int __strncpy_user(char *to, const char __user *from, int len);
>  static inline long
>  strncpy_from_user(char *dst, const char __user *src, long count)
>  {
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return -EFAULT;
>  	return __strncpy_user(dst, src, count);
>  }
> @@ -372,7 +371,7 @@ extern int __strnlen_user(const char __user *sstr, int len);
>  
>  static inline long strnlen_user(const char __user *src, long n)
>  {
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return 0;
>  	return __strnlen_user(src, n);
>  }
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
> index 97001524ca2d..0685696349bb 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -91,7 +91,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -166,7 +166,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index e8161e4dfde7..dcebaaf8c862 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -63,7 +63,7 @@ static inline
>  __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>  			       int len, __wsum sum, int *err_ptr)
>  {
> -	if (access_ok(VERIFY_READ, src, len))
> +	if (access_ok(src, len))
>  		return csum_partial_copy_from_user(src, dst, len, sum,
>  						   err_ptr);
>  	if (len)
> @@ -81,7 +81,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>  			     __wsum sum, int *err_ptr)
>  {
>  	might_fault();
> -	if (access_ok(VERIFY_WRITE, dst, len)) {
> +	if (access_ok(dst, len)) {
>  		if (uaccess_kernel())
>  			return __csum_partial_copy_kernel(src,
>  							  (__force void *)dst,
> diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
> index 8eff134b3a43..c14d798f3888 100644
> --- a/arch/mips/include/asm/futex.h
> +++ b/arch/mips/include/asm/futex.h
> @@ -129,7 +129,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0;
>  	u32 val;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	if (cpu_has_llsc && R10000_LLSC_WAR) {
> diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
> index ce2d72e34274..bc29eeacc55a 100644
> --- a/arch/mips/include/asm/termios.h
> +++ b/arch/mips/include/asm/termios.h
> @@ -32,7 +32,7 @@ static inline int user_termio_to_kernel_termios(struct ktermios *termios,
>  	unsigned short iflag, oflag, cflag, lflag;
>  	unsigned int err;
>  
> -	if (!access_ok(VERIFY_READ, termio, sizeof(struct termio)))
> +	if (!access_ok(termio, sizeof(struct termio)))
>  		return -EFAULT;
>  
>  	err = __get_user(iflag, &termio->c_iflag);
> @@ -61,7 +61,7 @@ static inline int kernel_termios_to_user_termio(struct termio __user *termio,
>  {
>  	int err;
>  
> -	if (!access_ok(VERIFY_WRITE, termio, sizeof(struct termio)))
> +	if (!access_ok(termio, sizeof(struct termio)))
>  		return -EFAULT;
>  
>  	err = __put_user(termios->c_iflag, &termio->c_iflag);
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index 06629011a434..d43c1dc6ef15 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -109,9 +109,6 @@ static inline bool eva_kernel_access(void)
>  
>  /*
>   * access_ok: - Checks if a user space pointer is valid
> - * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
> - *	  %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
> - *	  to write to a block, it is always safe to read from it.
>   * @addr: User space pointer to start of block to check
>   * @size: Size of block to check
>   *
> @@ -134,7 +131,7 @@ static inline int __access_ok(const void __user *p, unsigned long size)
>  	return (get_fs().seg & (addr | (addr + size) | __ua_size(size))) == 0;
>  }
>  
> -#define access_ok(type, addr, size)					\
> +#define access_ok(addr, size)					\
>  	likely(__access_ok((addr), (size)))
>  
>  /*
> @@ -304,7 +301,7 @@ do {									\
>  	const __typeof__(*(ptr)) __user * __gu_ptr = (ptr);		\
>  									\
>  	might_fault();							\
> -	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size))) {		\
> +	if (likely(access_ok( __gu_ptr, size))) {		\
>  		if (eva_kernel_access())				\
>  			__get_kernel_common((x), size, __gu_ptr);	\
>  		else							\
> @@ -446,7 +443,7 @@ do {									\
>  	int __pu_err = -EFAULT;						\
>  									\
>  	might_fault();							\
> -	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
> +	if (likely(access_ok( __pu_addr, size))) {	\
>  		if (eva_kernel_access())				\
>  			__put_kernel_common(__pu_addr, size);		\
>  		else							\
> @@ -691,8 +688,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
>  ({									\
>  	void __user * __cl_addr = (addr);				\
>  	unsigned long __cl_size = (n);					\
> -	if (__cl_size && access_ok(VERIFY_WRITE,			\
> -					__cl_addr, __cl_size))		\
> +	if (__cl_size && access_ok(__cl_addr, __cl_size))		\
>  		__cl_size = __clear_user(__cl_addr, __cl_size);		\
>  	__cl_size;							\
>  })
> diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
> index cb22a558431e..c50c89a978f1 100644
> --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
> +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
> @@ -1205,7 +1205,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  	case lwl_op:
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1278,7 +1278,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  	case lwr_op:
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1352,7 +1352,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  	case swl_op:
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1422,7 +1422,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  	case swr_op:
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1497,7 +1497,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1616,7 +1616,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1735,7 +1735,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1853,7 +1853,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  
>  		rt = regs->regs[MIPSInst_RT(inst)];
>  		vaddr = regs->regs[MIPSInst_RS(inst)] + MIPSInst_SIMM(inst);
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGSEGV;
>  			break;
> @@ -1970,7 +1970,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  			err = SIGBUS;
>  			break;
>  		}
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGBUS;
>  			break;
> @@ -2026,7 +2026,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  			err = SIGBUS;
>  			break;
>  		}
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 4)) {
> +		if (!access_ok((void __user *)vaddr, 4)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGBUS;
>  			break;
> @@ -2089,7 +2089,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  			err = SIGBUS;
>  			break;
>  		}
> -		if (!access_ok(VERIFY_READ, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGBUS;
>  			break;
> @@ -2150,7 +2150,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  			err = SIGBUS;
>  			break;
>  		}
> -		if (!access_ok(VERIFY_WRITE, (void __user *)vaddr, 8)) {
> +		if (!access_ok((void __user *)vaddr, 8)) {
>  			current->thread.cp0_baduaddr = vaddr;
>  			err = SIGBUS;
>  			break;
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index ea54575255ea..0057c910bc2f 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -71,7 +71,7 @@ int ptrace_getregs(struct task_struct *child, struct user_pt_regs __user *data)
>  	struct pt_regs *regs;
>  	int i;
>  
> -	if (!access_ok(VERIFY_WRITE, data, 38 * 8))
> +	if (!access_ok(data, 38 * 8))
>  		return -EIO;
>  
>  	regs = task_pt_regs(child);
> @@ -98,7 +98,7 @@ int ptrace_setregs(struct task_struct *child, struct user_pt_regs __user *data)
>  	struct pt_regs *regs;
>  	int i;
>  
> -	if (!access_ok(VERIFY_READ, data, 38 * 8))
> +	if (!access_ok(data, 38 * 8))
>  		return -EIO;
>  
>  	regs = task_pt_regs(child);
> @@ -125,7 +125,7 @@ int ptrace_get_watch_regs(struct task_struct *child,
>  
>  	if (!cpu_has_watch || boot_cpu_data.watch_reg_use_cnt == 0)
>  		return -EIO;
> -	if (!access_ok(VERIFY_WRITE, addr, sizeof(struct pt_watch_regs)))
> +	if (!access_ok(addr, sizeof(struct pt_watch_regs)))
>  		return -EIO;
>  
>  #ifdef CONFIG_32BIT
> @@ -167,7 +167,7 @@ int ptrace_set_watch_regs(struct task_struct *child,
>  
>  	if (!cpu_has_watch || boot_cpu_data.watch_reg_use_cnt == 0)
>  		return -EIO;
> -	if (!access_ok(VERIFY_READ, addr, sizeof(struct pt_watch_regs)))
> +	if (!access_ok(addr, sizeof(struct pt_watch_regs)))
>  		return -EIO;
>  	/* Check the values. */
>  	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
> @@ -359,7 +359,7 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
>  {
>  	int i;
>  
> -	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
> +	if (!access_ok(data, 33 * 8))
>  		return -EIO;
>  
>  	if (tsk_used_math(child)) {
> @@ -385,7 +385,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
>  	u32 value;
>  	int i;
>  
> -	if (!access_ok(VERIFY_READ, data, 33 * 8))
> +	if (!access_ok(data, 33 * 8))
>  		return -EIO;
>  
>  	init_fp_ctx(child);
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index d3a23758592c..d75337974ee9 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -590,7 +590,7 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>  	if (act) {
>  		old_sigset_t mask;
>  
> -		if (!access_ok(VERIFY_READ, act, sizeof(*act)))
> +		if (!access_ok(act, sizeof(*act)))
>  			return -EFAULT;
>  		err |= __get_user(new_ka.sa.sa_handler, &act->sa_handler);
>  		err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
> @@ -604,7 +604,7 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
> +		if (!access_ok(oact, sizeof(*oact)))
>  			return -EFAULT;
>  		err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>  		err |= __put_user(old_ka.sa.sa_handler, &oact->sa_handler);
> @@ -630,7 +630,7 @@ asmlinkage void sys_sigreturn(void)
>  
>  	regs = current_pt_regs();
>  	frame = (struct sigframe __user *)regs->regs[29];
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&blocked, &frame->sf_mask, sizeof(blocked)))
>  		goto badframe;
> @@ -667,7 +667,7 @@ asmlinkage void sys_rt_sigreturn(void)
>  
>  	regs = current_pt_regs();
>  	frame = (struct rt_sigframe __user *)regs->regs[29];
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -705,7 +705,7 @@ static int setup_frame(void *sig_return, struct ksignal *ksig,
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	err |= setup_sigcontext(regs, &frame->sf_sc);
> @@ -744,7 +744,7 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	/* Create siginfo.  */
> diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
> index b5d9e1784aff..59b8965433c2 100644
> --- a/arch/mips/kernel/signal32.c
> +++ b/arch/mips/kernel/signal32.c
> @@ -46,7 +46,7 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
>  		old_sigset_t mask;
>  		s32 handler;
>  
> -		if (!access_ok(VERIFY_READ, act, sizeof(*act)))
> +		if (!access_ok(act, sizeof(*act)))
>  			return -EFAULT;
>  		err |= __get_user(handler, &act->sa_handler);
>  		new_ka.sa.sa_handler = (void __user *)(s64)handler;
> @@ -61,7 +61,7 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
> +		if (!access_ok(oact, sizeof(*oact)))
>  			return -EFAULT;
>  		err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>  		err |= __put_user((u32)(u64)old_ka.sa.sa_handler,
> diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
> index 8f65aaf9206d..c498b027823e 100644
> --- a/arch/mips/kernel/signal_n32.c
> +++ b/arch/mips/kernel/signal_n32.c
> @@ -73,7 +73,7 @@ asmlinkage void sysn32_rt_sigreturn(void)
>  
>  	regs = current_pt_regs();
>  	frame = (struct rt_sigframe_n32 __user *)regs->regs[29];
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
>  		goto badframe;
> @@ -110,7 +110,7 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	/* Create siginfo.  */
> diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
> index b6e3ddef48a0..df259618e834 100644
> --- a/arch/mips/kernel/signal_o32.c
> +++ b/arch/mips/kernel/signal_o32.c
> @@ -118,7 +118,7 @@ static int setup_frame_32(void *sig_return, struct ksignal *ksig,
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	err |= setup_sigcontext32(regs, &frame->sf_sc);
> @@ -160,7 +160,7 @@ asmlinkage void sys32_rt_sigreturn(void)
>  
>  	regs = current_pt_regs();
>  	frame = (struct rt_sigframe32 __user *)regs->regs[29];
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
>  		goto badframe;
> @@ -197,7 +197,7 @@ static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
> +	if (!access_ok(frame, sizeof (*frame)))
>  		return -EFAULT;
>  
>  	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
> @@ -262,7 +262,7 @@ asmlinkage void sys32_sigreturn(void)
>  
>  	regs = current_pt_regs();
>  	frame = (struct sigframe32 __user *)regs->regs[29];
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_conv_sigset_from_user(&blocked, &frame->sf_mask))
>  		goto badframe;
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 41a0db08cd37..b6dc78ad5d8c 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -101,7 +101,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
>  	if (unlikely(addr & 3))
>  		return -EINVAL;
>  
> -	if (unlikely(!access_ok(VERIFY_WRITE, (const void __user *)addr, 4)))
> +	if (unlikely(!access_ok((const void __user *)addr, 4)))
>  		return -EINVAL;
>  
>  	if (cpu_has_llsc && R10000_LLSC_WAR) {
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index c60e7719ef77..595ca9c85111 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -936,7 +936,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		if (insn.dsp_format.func == lx_op) {
>  			switch (insn.dsp_format.op) {
>  			case lwx_op:
> -				if (!access_ok(VERIFY_READ, addr, 4))
> +				if (!access_ok(addr, 4))
>  					goto sigbus;
>  				LoadW(addr, value, res);
>  				if (res)
> @@ -945,7 +945,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  				regs->regs[insn.dsp_format.rd] = value;
>  				break;
>  			case lhx_op:
> -				if (!access_ok(VERIFY_READ, addr, 2))
> +				if (!access_ok(addr, 2))
>  					goto sigbus;
>  				LoadHW(addr, value, res);
>  				if (res)
> @@ -968,7 +968,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  			set_fs(USER_DS);
>  			switch (insn.spec3_format.func) {
>  			case lhe_op:
> -				if (!access_ok(VERIFY_READ, addr, 2)) {
> +				if (!access_ok(addr, 2)) {
>  					set_fs(seg);
>  					goto sigbus;
>  				}
> @@ -981,7 +981,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  				regs->regs[insn.spec3_format.rt] = value;
>  				break;
>  			case lwe_op:
> -				if (!access_ok(VERIFY_READ, addr, 4)) {
> +				if (!access_ok(addr, 4)) {
>  					set_fs(seg);
>  					goto sigbus;
>  				}
> @@ -994,7 +994,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  				regs->regs[insn.spec3_format.rt] = value;
>  				break;
>  			case lhue_op:
> -				if (!access_ok(VERIFY_READ, addr, 2)) {
> +				if (!access_ok(addr, 2)) {
>  					set_fs(seg);
>  					goto sigbus;
>  				}
> @@ -1007,7 +1007,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  				regs->regs[insn.spec3_format.rt] = value;
>  				break;
>  			case she_op:
> -				if (!access_ok(VERIFY_WRITE, addr, 2)) {
> +				if (!access_ok(addr, 2)) {
>  					set_fs(seg);
>  					goto sigbus;
>  				}
> @@ -1020,7 +1020,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  				}
>  				break;
>  			case swe_op:
> -				if (!access_ok(VERIFY_WRITE, addr, 4)) {
> +				if (!access_ok(addr, 4)) {
>  					set_fs(seg);
>  					goto sigbus;
>  				}
> @@ -1041,7 +1041,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  #endif
>  		break;
>  	case lh_op:
> -		if (!access_ok(VERIFY_READ, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		if (IS_ENABLED(CONFIG_EVA)) {
> @@ -1060,7 +1060,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		break;
>  
>  	case lw_op:
> -		if (!access_ok(VERIFY_READ, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		if (IS_ENABLED(CONFIG_EVA)) {
> @@ -1079,7 +1079,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		break;
>  
>  	case lhu_op:
> -		if (!access_ok(VERIFY_READ, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		if (IS_ENABLED(CONFIG_EVA)) {
> @@ -1106,7 +1106,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_READ, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		LoadWU(addr, value, res);
> @@ -1129,7 +1129,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_READ, addr, 8))
> +		if (!access_ok(addr, 8))
>  			goto sigbus;
>  
>  		LoadDW(addr, value, res);
> @@ -1144,7 +1144,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		goto sigill;
>  
>  	case sh_op:
> -		if (!access_ok(VERIFY_WRITE, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		compute_return_epc(regs);
> @@ -1164,7 +1164,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		break;
>  
>  	case sw_op:
> -		if (!access_ok(VERIFY_WRITE, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		compute_return_epc(regs);
> @@ -1192,7 +1192,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_WRITE, addr, 8))
> +		if (!access_ok(addr, 8))
>  			goto sigbus;
>  
>  		compute_return_epc(regs);
> @@ -1254,7 +1254,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  
>  		switch (insn.msa_mi10_format.func) {
>  		case msa_ld_op:
> -			if (!access_ok(VERIFY_READ, addr, sizeof(*fpr)))
> +			if (!access_ok(addr, sizeof(*fpr)))
>  				goto sigbus;
>  
>  			do {
> @@ -1290,7 +1290,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  			break;
>  
>  		case msa_st_op:
> -			if (!access_ok(VERIFY_WRITE, addr, sizeof(*fpr)))
> +			if (!access_ok(addr, sizeof(*fpr)))
>  				goto sigbus;
>  
>  			/*
> @@ -1463,7 +1463,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if (reg == 31)
>  				goto sigbus;
>  
> -			if (!access_ok(VERIFY_READ, addr, 8))
> +			if (!access_ok(addr, 8))
>  				goto sigbus;
>  
>  			LoadW(addr, value, res);
> @@ -1482,7 +1482,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if (reg == 31)
>  				goto sigbus;
>  
> -			if (!access_ok(VERIFY_WRITE, addr, 8))
> +			if (!access_ok(addr, 8))
>  				goto sigbus;
>  
>  			value = regs->regs[reg];
> @@ -1502,7 +1502,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if (reg == 31)
>  				goto sigbus;
>  
> -			if (!access_ok(VERIFY_READ, addr, 16))
> +			if (!access_ok(addr, 16))
>  				goto sigbus;
>  
>  			LoadDW(addr, value, res);
> @@ -1525,7 +1525,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if (reg == 31)
>  				goto sigbus;
>  
> -			if (!access_ok(VERIFY_WRITE, addr, 16))
> +			if (!access_ok(addr, 16))
>  				goto sigbus;
>  
>  			value = regs->regs[reg];
> @@ -1548,11 +1548,10 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if ((rvar > 9) || !reg)
>  				goto sigill;
>  			if (reg & 0x10) {
> -				if (!access_ok
> -				    (VERIFY_READ, addr, 4 * (rvar + 1)))
> +				if (!access_ok(addr, 4 * (rvar + 1)))
>  					goto sigbus;
>  			} else {
> -				if (!access_ok(VERIFY_READ, addr, 4 * rvar))
> +				if (!access_ok(addr, 4 * rvar))
>  					goto sigbus;
>  			}
>  			if (rvar == 9)
> @@ -1585,11 +1584,10 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if ((rvar > 9) || !reg)
>  				goto sigill;
>  			if (reg & 0x10) {
> -				if (!access_ok
> -				    (VERIFY_WRITE, addr, 4 * (rvar + 1)))
> +				if (!access_ok(addr, 4 * (rvar + 1)))
>  					goto sigbus;
>  			} else {
> -				if (!access_ok(VERIFY_WRITE, addr, 4 * rvar))
> +				if (!access_ok(addr, 4 * rvar))
>  					goto sigbus;
>  			}
>  			if (rvar == 9)
> @@ -1623,11 +1621,10 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if ((rvar > 9) || !reg)
>  				goto sigill;
>  			if (reg & 0x10) {
> -				if (!access_ok
> -				    (VERIFY_READ, addr, 8 * (rvar + 1)))
> +				if (!access_ok(addr, 8 * (rvar + 1)))
>  					goto sigbus;
>  			} else {
> -				if (!access_ok(VERIFY_READ, addr, 8 * rvar))
> +				if (!access_ok(addr, 8 * rvar))
>  					goto sigbus;
>  			}
>  			if (rvar == 9)
> @@ -1665,11 +1662,10 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  			if ((rvar > 9) || !reg)
>  				goto sigill;
>  			if (reg & 0x10) {
> -				if (!access_ok
> -				    (VERIFY_WRITE, addr, 8 * (rvar + 1)))
> +				if (!access_ok(addr, 8 * (rvar + 1)))
>  					goto sigbus;
>  			} else {
> -				if (!access_ok(VERIFY_WRITE, addr, 8 * rvar))
> +				if (!access_ok(addr, 8 * rvar))
>  					goto sigbus;
>  			}
>  			if (rvar == 9)
> @@ -1788,7 +1784,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  		case mm_lwm16_op:
>  			reg = insn.mm16_m_format.rlist;
>  			rvar = reg + 1;
> -			if (!access_ok(VERIFY_READ, addr, 4 * rvar))
> +			if (!access_ok(addr, 4 * rvar))
>  				goto sigbus;
>  
>  			for (i = 16; rvar; rvar--, i++) {
> @@ -1808,7 +1804,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  		case mm_swm16_op:
>  			reg = insn.mm16_m_format.rlist;
>  			rvar = reg + 1;
> -			if (!access_ok(VERIFY_WRITE, addr, 4 * rvar))
> +			if (!access_ok(addr, 4 * rvar))
>  				goto sigbus;
>  
>  			for (i = 16; rvar; rvar--, i++) {
> @@ -1862,7 +1858,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	}
>  
>  loadHW:
> -	if (!access_ok(VERIFY_READ, addr, 2))
> +	if (!access_ok(addr, 2))
>  		goto sigbus;
>  
>  	LoadHW(addr, value, res);
> @@ -1872,7 +1868,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	goto success;
>  
>  loadHWU:
> -	if (!access_ok(VERIFY_READ, addr, 2))
> +	if (!access_ok(addr, 2))
>  		goto sigbus;
>  
>  	LoadHWU(addr, value, res);
> @@ -1882,7 +1878,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	goto success;
>  
>  loadW:
> -	if (!access_ok(VERIFY_READ, addr, 4))
> +	if (!access_ok(addr, 4))
>  		goto sigbus;
>  
>  	LoadW(addr, value, res);
> @@ -1900,7 +1896,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	 * would blow up, so for now we don't handle unaligned 64-bit
>  	 * instructions on 32-bit kernels.
>  	 */
> -	if (!access_ok(VERIFY_READ, addr, 4))
> +	if (!access_ok(addr, 4))
>  		goto sigbus;
>  
>  	LoadWU(addr, value, res);
> @@ -1922,7 +1918,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	 * would blow up, so for now we don't handle unaligned 64-bit
>  	 * instructions on 32-bit kernels.
>  	 */
> -	if (!access_ok(VERIFY_READ, addr, 8))
> +	if (!access_ok(addr, 8))
>  		goto sigbus;
>  
>  	LoadDW(addr, value, res);
> @@ -1936,7 +1932,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	goto sigill;
>  
>  storeHW:
> -	if (!access_ok(VERIFY_WRITE, addr, 2))
> +	if (!access_ok(addr, 2))
>  		goto sigbus;
>  
>  	value = regs->regs[reg];
> @@ -1946,7 +1942,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	goto success;
>  
>  storeW:
> -	if (!access_ok(VERIFY_WRITE, addr, 4))
> +	if (!access_ok(addr, 4))
>  		goto sigbus;
>  
>  	value = regs->regs[reg];
> @@ -1964,7 +1960,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
>  	 * would blow up, so for now we don't handle unaligned 64-bit
>  	 * instructions on 32-bit kernels.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, addr, 8))
> +	if (!access_ok(addr, 8))
>  		goto sigbus;
>  
>  	value = regs->regs[reg];
> @@ -2122,7 +2118,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		goto sigbus;
>  
>  	case MIPS16e_lh_op:
> -		if (!access_ok(VERIFY_READ, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		LoadHW(addr, value, res);
> @@ -2133,7 +2129,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		break;
>  
>  	case MIPS16e_lhu_op:
> -		if (!access_ok(VERIFY_READ, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		LoadHWU(addr, value, res);
> @@ -2146,7 +2142,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  	case MIPS16e_lw_op:
>  	case MIPS16e_lwpc_op:
>  	case MIPS16e_lwsp_op:
> -		if (!access_ok(VERIFY_READ, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		LoadW(addr, value, res);
> @@ -2165,7 +2161,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_READ, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		LoadWU(addr, value, res);
> @@ -2189,7 +2185,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_READ, addr, 8))
> +		if (!access_ok(addr, 8))
>  			goto sigbus;
>  
>  		LoadDW(addr, value, res);
> @@ -2204,7 +2200,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		goto sigill;
>  
>  	case MIPS16e_sh_op:
> -		if (!access_ok(VERIFY_WRITE, addr, 2))
> +		if (!access_ok(addr, 2))
>  			goto sigbus;
>  
>  		MIPS16e_compute_return_epc(regs, &oldinst);
> @@ -2217,7 +2213,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  	case MIPS16e_sw_op:
>  	case MIPS16e_swsp_op:
>  	case MIPS16e_i8_op:	/* actually - MIPS16e_swrasp_func */
> -		if (!access_ok(VERIFY_WRITE, addr, 4))
> +		if (!access_ok(addr, 4))
>  			goto sigbus;
>  
>  		MIPS16e_compute_return_epc(regs, &oldinst);
> @@ -2237,7 +2233,7 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
>  		 * would blow up, so for now we don't handle unaligned 64-bit
>  		 * instructions on 32-bit kernels.
>  		 */
> -		if (!access_ok(VERIFY_WRITE, addr, 8))
> +		if (!access_ok(addr, 8))
>  			goto sigbus;
>  
>  		MIPS16e_compute_return_epc(regs, &oldinst);
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 82e2993c1a2c..e60e29078ef5 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -1063,7 +1063,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  				     MIPSInst_SIMM(ir));
>  		MIPS_FPU_EMU_INC_STATS(loads);
>  
> -		if (!access_ok(VERIFY_READ, dva, sizeof(u64))) {
> +		if (!access_ok(dva, sizeof(u64))) {
>  			MIPS_FPU_EMU_INC_STATS(errors);
>  			*fault_addr = dva;
>  			return SIGBUS;
> @@ -1081,7 +1081,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  				      MIPSInst_SIMM(ir));
>  		MIPS_FPU_EMU_INC_STATS(stores);
>  		DIFROMREG(dval, MIPSInst_RT(ir));
> -		if (!access_ok(VERIFY_WRITE, dva, sizeof(u64))) {
> +		if (!access_ok(dva, sizeof(u64))) {
>  			MIPS_FPU_EMU_INC_STATS(errors);
>  			*fault_addr = dva;
>  			return SIGBUS;
> @@ -1097,7 +1097,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  		wva = (u32 __user *) (xcp->regs[MIPSInst_RS(ir)] +
>  				      MIPSInst_SIMM(ir));
>  		MIPS_FPU_EMU_INC_STATS(loads);
> -		if (!access_ok(VERIFY_READ, wva, sizeof(u32))) {
> +		if (!access_ok(wva, sizeof(u32))) {
>  			MIPS_FPU_EMU_INC_STATS(errors);
>  			*fault_addr = wva;
>  			return SIGBUS;
> @@ -1115,7 +1115,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  				      MIPSInst_SIMM(ir));
>  		MIPS_FPU_EMU_INC_STATS(stores);
>  		SIFROMREG(wval, MIPSInst_RT(ir));
> -		if (!access_ok(VERIFY_WRITE, wva, sizeof(u32))) {
> +		if (!access_ok(wva, sizeof(u32))) {
>  			MIPS_FPU_EMU_INC_STATS(errors);
>  			*fault_addr = wva;
>  			return SIGBUS;
> @@ -1493,7 +1493,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  				xcp->regs[MIPSInst_FT(ir)]);
>  
>  			MIPS_FPU_EMU_INC_STATS(loads);
> -			if (!access_ok(VERIFY_READ, va, sizeof(u32))) {
> +			if (!access_ok(va, sizeof(u32))) {
>  				MIPS_FPU_EMU_INC_STATS(errors);
>  				*fault_addr = va;
>  				return SIGBUS;
> @@ -1513,7 +1513,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  			MIPS_FPU_EMU_INC_STATS(stores);
>  
>  			SIFROMREG(val, MIPSInst_FS(ir));
> -			if (!access_ok(VERIFY_WRITE, va, sizeof(u32))) {
> +			if (!access_ok(va, sizeof(u32))) {
>  				MIPS_FPU_EMU_INC_STATS(errors);
>  				*fault_addr = va;
>  				return SIGBUS;
> @@ -1590,7 +1590,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  				xcp->regs[MIPSInst_FT(ir)]);
>  
>  			MIPS_FPU_EMU_INC_STATS(loads);
> -			if (!access_ok(VERIFY_READ, va, sizeof(u64))) {
> +			if (!access_ok(va, sizeof(u64))) {
>  				MIPS_FPU_EMU_INC_STATS(errors);
>  				*fault_addr = va;
>  				return SIGBUS;
> @@ -1609,7 +1609,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  
>  			MIPS_FPU_EMU_INC_STATS(stores);
>  			DIFROMREG(val, MIPSInst_FS(ir));
> -			if (!access_ok(VERIFY_WRITE, va, sizeof(u64))) {
> +			if (!access_ok(va, sizeof(u64))) {
>  				MIPS_FPU_EMU_INC_STATS(errors);
>  				*fault_addr = va;
>  				return SIGBUS;
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 70a523151ff3..55099fbff4e6 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -76,7 +76,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
>  {
>  	if (bytes == 0)
>  		return 0;
> -	if (!access_ok(VERIFY_WRITE, (void __user *) addr, bytes))
> +	if (!access_ok((void __user *) addr, bytes))
>  		return -EFAULT;
>  
>  	__flush_icache_user_range(addr, addr + bytes);
> diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
> index 5a4875cac1ec..0d14e0d8eacf 100644
> --- a/arch/mips/mm/gup.c
> +++ b/arch/mips/mm/gup.c
> @@ -195,8 +195,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
> -	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> -					(void __user *)start, len)))
> +	if (unlikely(!access_ok((void __user *)start, len)))
>  		return 0;
>  
>  	/*
> diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
> index 806fb798091f..07d98ba7f49e 100644
> --- a/arch/mips/oprofile/backtrace.c
> +++ b/arch/mips/oprofile/backtrace.c
> @@ -19,7 +19,7 @@ struct stackframe {
>  static inline int get_mem(unsigned long addr, unsigned long *result)
>  {
>  	unsigned long *address = (unsigned long *) addr;
> -	if (!access_ok(VERIFY_READ, address, sizeof(unsigned long)))
> +	if (!access_ok(address, sizeof(unsigned long)))
>  		return -1;
>  	if (__copy_from_user_inatomic(result, address, sizeof(unsigned long)))
>  		return -3;
> diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
> index 99c720be72d2..9ff26b0cd3b6 100644
> --- a/arch/mips/sibyte/common/sb_tbprof.c
> +++ b/arch/mips/sibyte/common/sb_tbprof.c
> @@ -458,7 +458,7 @@ static ssize_t sbprof_tb_read(struct file *filp, char *buf,
>  	char *dest    =	 buf;
>  	long  cur_off = *offp;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, size))
> +	if (!access_ok(buf, size))
>  		return -EFAULT;
>  
>  	mutex_lock(&sbp.lock);
> diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
> index cb6cb91cfdf8..baf178bf1d0b 100644
> --- a/arch/nds32/include/asm/futex.h
> +++ b/arch/nds32/include/asm/futex.h
> @@ -40,7 +40,7 @@ futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
>  	int ret = 0;
>  	u32 val, tmp, flags;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	smp_mb();
> diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
> index 362a32d9bd16..53dcb49b0b12 100644
> --- a/arch/nds32/include/asm/uaccess.h
> +++ b/arch/nds32/include/asm/uaccess.h
> @@ -13,9 +13,6 @@
>  #include <asm/types.h>
>  #include <linux/mm.h>
>  
> -#define VERIFY_READ	0
> -#define VERIFY_WRITE	1
> -
>  #define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
>  
>  /*
> @@ -53,7 +50,7 @@ static inline void set_fs(mm_segment_t fs)
>  
>  #define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
>  
> -#define access_ok(type, addr, size)	\
> +#define access_ok(addr, size)	\
>  	__range_ok((unsigned long)addr, (unsigned long)size)
>  /*
>   * Single-value transfer routines.  They automatically use the right
> @@ -94,7 +91,7 @@ static inline void set_fs(mm_segment_t fs)
>  ({									\
>  	const __typeof__(*(ptr)) __user *__p = (ptr);			\
>  	might_fault();							\
> -	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
> +	if (access_ok(__p, sizeof(*__p))) {		\
>  		__get_user_err((x), __p, (err));			\
>  	} else {							\
>  		(x) = 0; (err) = -EFAULT;				\
> @@ -189,7 +186,7 @@ do {									\
>  ({									\
>  	__typeof__(*(ptr)) __user *__p = (ptr);				\
>  	might_fault();							\
> -	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
> +	if (access_ok(__p, sizeof(*__p))) {		\
>  		__put_user_err((x), __p, (err));			\
>  	} else	{							\
>  		(err) = -EFAULT;					\
> @@ -279,7 +276,7 @@ extern unsigned long __arch_copy_to_user(void __user * to, const void *from,
>  #define INLINE_COPY_TO_USER
>  static inline unsigned long clear_user(void __user * to, unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		n = __arch_clear_user(to, n);
>  	return n;
>  }
> diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
> index 5e00ce54d0ff..334c2a6cec23 100644
> --- a/arch/nds32/kernel/perf_event_cpu.c
> +++ b/arch/nds32/kernel/perf_event_cpu.c
> @@ -1306,7 +1306,7 @@ user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp)
>  		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
>  
>  	/* Check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(buftail)))
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
>  		return 0;
>  	if (__copy_from_user_inatomic
>  		(&buftail, user_frame_tail, sizeof(buftail)))
> @@ -1332,7 +1332,7 @@ user_backtrace_opt_size(struct perf_callchain_entry_ctx *entry,
>  		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
>  
>  	/* Check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(buftail)))
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
>  		return 0;
>  	if (__copy_from_user_inatomic
>  		(&buftail, user_frame_tail, sizeof(buftail)))
> @@ -1386,7 +1386,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  		user_frame_tail =
>  			(unsigned long *)(fp - (unsigned long)sizeof(fp));
>  
> -		if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(fp)))
> +		if (!access_ok(user_frame_tail, sizeof(fp)))
>  			return;
>  
>  		if (__copy_from_user_inatomic
> @@ -1406,8 +1406,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  				(unsigned long *)(fp -
>  					(unsigned long)sizeof(buftail));
>  
> -			if (!access_ok
> -				(VERIFY_READ, user_frame_tail, sizeof(buftail)))
> +			if (!access_ok(user_frame_tail, sizeof(buftail)))
>  				return;
>  
>  			if (__copy_from_user_inatomic
> @@ -1424,7 +1423,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  					(unsigned long *)(fp - (unsigned long)
>  						sizeof(buftail_opt_size));
>  
> -				if (!access_ok(VERIFY_READ, user_frame_tail,
> +				if (!access_ok(user_frame_tail,
>  					       sizeof(buftail_opt_size)))
>  					return;
>  
> diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
> index 5b5be082cfa4..5f7660aa2d68 100644
> --- a/arch/nds32/kernel/signal.c
> +++ b/arch/nds32/kernel/signal.c
> @@ -151,7 +151,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
>  
>  	frame = (struct rt_sigframe __user *)regs->sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (restore_sigframe(regs, frame))
> @@ -275,7 +275,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t * set, struct pt_regs *regs)
>  	    get_sigframe(ksig, regs, sizeof(*frame));
>  	int err = 0;
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	__put_user_error(0, &frame->uc.uc_flags, err);
> diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
> index e1aed9dc692d..c8b9061a2ee3 100644
> --- a/arch/nds32/mm/alignment.c
> +++ b/arch/nds32/mm/alignment.c
> @@ -289,13 +289,13 @@ static inline int do_16(unsigned long inst, struct pt_regs *regs)
>  		unaligned_addr += shift;
>  
>  	if (load) {
> -		if (!access_ok(VERIFY_READ, (void *)unaligned_addr, len))
> +		if (!access_ok((void *)unaligned_addr, len))
>  			return -EACCES;
>  
>  		get_data(unaligned_addr, &target_val, len);
>  		*idx_to_addr(regs, target_idx) = target_val;
>  	} else {
> -		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
> +		if (!access_ok((void *)unaligned_addr, len))
>  			return -EACCES;
>  		target_val = *idx_to_addr(regs, target_idx);
>  		set_data((void *)unaligned_addr, target_val, len);
> @@ -479,7 +479,7 @@ static inline int do_32(unsigned long inst, struct pt_regs *regs)
>  
>  	if (load) {
>  
> -		if (!access_ok(VERIFY_READ, (void *)unaligned_addr, len))
> +		if (!access_ok((void *)unaligned_addr, len))
>  			return -EACCES;
>  
>  		get_data(unaligned_addr, &target_val, len);
> @@ -491,7 +491,7 @@ static inline int do_32(unsigned long inst, struct pt_regs *regs)
>  			*idx_to_addr(regs, RT(inst)) = target_val;
>  	} else {
>  
> -		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
> +		if (!access_ok((void *)unaligned_addr, len))
>  			return -EACCES;
>  
>  		target_val = *idx_to_addr(regs, RT(inst));
> diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
> index dfa3c7cb30b4..e0ea10806491 100644
> --- a/arch/nios2/include/asm/uaccess.h
> +++ b/arch/nios2/include/asm/uaccess.h
> @@ -37,7 +37,7 @@
>  	(((signed long)(((long)get_fs().seg) &	\
>  		((long)(addr) | (((long)(addr)) + (len)) | (len)))) == 0)
>  
> -#define access_ok(type, addr, len)		\
> +#define access_ok(addr, len)		\
>  	likely(__access_ok((unsigned long)(addr), (unsigned long)(len)))
>  
>  # define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
> @@ -70,7 +70,7 @@ static inline unsigned long __must_check __clear_user(void __user *to,
>  static inline unsigned long __must_check clear_user(void __user *to,
>  						    unsigned long n)
>  {
> -	if (!access_ok(VERIFY_WRITE, to, n))
> +	if (!access_ok(to, n))
>  		return n;
>  	return __clear_user(to, n);
>  }
> @@ -142,7 +142,7 @@ do {									\
>  	long __gu_err = -EFAULT;					\
>  	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
>  	unsigned long __gu_val = 0;					\
> -	if (access_ok(VERIFY_READ,  __gu_ptr, sizeof(*__gu_ptr)))	\
> +	if (access_ok( __gu_ptr, sizeof(*__gu_ptr)))	\
>  		__get_user_common(__gu_val, sizeof(*__gu_ptr),		\
>  			__gu_ptr, __gu_err);				\
>  	(x) = (__force __typeof__(x))__gu_val;				\
> @@ -168,7 +168,7 @@ do {									\
>  	long __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
>  	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
> -	if (access_ok(VERIFY_WRITE, __pu_ptr, sizeof(*__pu_ptr))) {	\
> +	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
>  		switch (sizeof(*__pu_ptr)) {				\
>  		case 1:							\
>  			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
> diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
> index 20662b0f6c9e..4a81876b6086 100644
> --- a/arch/nios2/kernel/signal.c
> +++ b/arch/nios2/kernel/signal.c
> @@ -106,7 +106,7 @@ asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
>  	sigset_t set;
>  	int rval;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> diff --git a/arch/openrisc/include/asm/futex.h b/arch/openrisc/include/asm/futex.h
> index 618da4a1bffb..fe894e6331ae 100644
> --- a/arch/openrisc/include/asm/futex.h
> +++ b/arch/openrisc/include/asm/futex.h
> @@ -72,7 +72,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0;
>  	u32 prev;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	__asm__ __volatile__ (				\
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index bbf5c79cce7a..bc8191a34db7 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -58,7 +58,7 @@
>  /* Ensure that addr is below task's addr_limit */
>  #define __addr_ok(addr) ((unsigned long) addr < get_fs())
>  
> -#define access_ok(type, addr, size) \
> +#define access_ok(addr, size) \
>  	__range_ok((unsigned long)addr, (unsigned long)size)
>  
>  /*
> @@ -102,7 +102,7 @@ extern long __put_user_bad(void);
>  ({									\
>  	long __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
> -	if (access_ok(VERIFY_WRITE, __pu_addr, size))			\
> +	if (access_ok(__pu_addr, size))			\
>  		__put_user_size((x), __pu_addr, (size), __pu_err);	\
>  	__pu_err;							\
>  })
> @@ -175,7 +175,7 @@ struct __large_struct {
>  ({									\
>  	long __gu_err = -EFAULT, __gu_val = 0;				\
>  	const __typeof__(*(ptr)) * __gu_addr = (ptr);			\
> -	if (access_ok(VERIFY_READ, __gu_addr, size))			\
> +	if (access_ok(__gu_addr, size))			\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;							\
> @@ -254,7 +254,7 @@ extern unsigned long __clear_user(void *addr, unsigned long size);
>  static inline __must_check unsigned long
>  clear_user(void *addr, unsigned long size)
>  {
> -	if (likely(access_ok(VERIFY_WRITE, addr, size)))
> +	if (likely(access_ok(addr, size)))
>  		size = __clear_user(addr, size);
>  	return size;
>  }
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 265f10fb3930..5ac9d3b1d615 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -50,7 +50,7 @@ static int restore_sigcontext(struct pt_regs *regs,
>  
>  	/*
>  	 * Restore the regs from &sc->regs.
> -	 * (sc is already checked for VERIFY_READ since the sigframe was
> +	 * (sc is already checked since the sigframe was
>  	 *  checked in sys_sigreturn previously)
>  	 */
>  	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
> @@ -83,7 +83,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
>  	if (((long)frame) & 3)
>  		goto badframe;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -161,7 +161,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	/* Create siginfo.  */
> diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
> index cf7ba058f619..d2c3e4106851 100644
> --- a/arch/parisc/include/asm/futex.h
> +++ b/arch/parisc/include/asm/futex.h
> @@ -95,7 +95,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	if (uaccess_kernel() && !uaddr)
>  		return -EFAULT;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	/* HPPA has no cmpxchg in hardware and therefore the
> diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
> index ea70e36ce6af..30ac2865ea73 100644
> --- a/arch/parisc/include/asm/uaccess.h
> +++ b/arch/parisc/include/asm/uaccess.h
> @@ -27,7 +27,7 @@
>   * that put_user is the same as __put_user, etc.
>   */
>  
> -#define access_ok(type, uaddr, size)	\
> +#define access_ok(uaddr, size)	\
>  	( (uaddr) == (uaddr) )
>  
>  #define put_user __put_user
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
> index 94542776a62d..88b38b37c21b 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -72,7 +72,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	int ret = 0;
>  	u32 prev;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>          __asm__ __volatile__ (
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index ebc0b916dcf9..b31bf45eebd4 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -62,7 +62,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
>  
>  #endif
>  
> -#define access_ok(type, addr, size)		\
> +#define access_ok(addr, size)		\
>  	(__chk_user_ptr(addr), (void)(type),		\
>  	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
>  
> @@ -166,7 +166,7 @@ do {								\
>  	long __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
>  	might_fault();							\
> -	if (access_ok(VERIFY_WRITE, __pu_addr, size))			\
> +	if (access_ok(__pu_addr, size))			\
>  		__put_user_size((x), __pu_addr, (size), __pu_err);	\
>  	__pu_err;							\
>  })
> @@ -276,7 +276,7 @@ do {								\
>  	__long_type(*(ptr)) __gu_val = 0;				\
>  	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
>  	might_fault();							\
> -	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
> +	if (access_ok(__gu_addr, (size))) {		\
>  		barrier_nospec();					\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	}								\
> @@ -374,7 +374,7 @@ extern unsigned long __clear_user(void __user *addr, unsigned long size);
>  static inline unsigned long clear_user(void __user *addr, unsigned long size)
>  {
>  	might_fault();
> -	if (likely(access_ok(VERIFY_WRITE, addr, size)))
> +	if (likely(access_ok(addr, size)))
>  		return __clear_user(addr, size);
>  	return size;
>  }
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index 11550a3d1ac2..0d1b6370bae0 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -131,8 +131,7 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
>  
>  	/* Verify the address of the operand */
>  	if (unlikely(user_mode(regs) &&
> -		     !access_ok((flags & ST ? VERIFY_WRITE : VERIFY_READ),
> -				addr, nb)))
> +		     !access_ok(addr, nb)))
>  		return -EFAULT;
>  
>  	/* userland only */
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index 10fabae2574d..8246f437bbc6 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -523,7 +523,7 @@ static ssize_t validate_flash_write(struct file *file, const char __user *buf,
>  		args_buf->status = VALIDATE_INCOMPLETE;
>  	}
>  
> -	if (!access_ok(VERIFY_READ, buf, count)) {
> +	if (!access_ok(buf, count)) {
>  		rc = -EFAULT;
>  		goto done;
>  	}
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 38cadae4ca4f..8a1746d755c9 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -335,7 +335,7 @@ static ssize_t rtas_log_read(struct file * file, char __user * buf,
>  
>  	count = rtas_error_log_buffer_max;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	tmp = kmalloc(count, GFP_KERNEL);
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index b3e8db376ecd..e6c30cee6abf 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -44,7 +44,7 @@ void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
>  	newsp = (oldsp - frame_size) & ~0xFUL;
>  
>  	/* Check access */
> -	if (!access_ok(VERIFY_WRITE, (void __user *)newsp, oldsp - newsp))
> +	if (!access_ok((void __user *)newsp, oldsp - newsp))
>  		return NULL;
>  
>          return (void __user *)newsp;
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 2d47cc79e5b3..ede4f04281ae 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1017,7 +1017,7 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
>  #else
>  	if (__get_user(mcp, &ucp->uc_regs))
>  		return -EFAULT;
> -	if (!access_ok(VERIFY_READ, mcp, sizeof(*mcp)))
> +	if (!access_ok(mcp, sizeof(*mcp)))
>  		return -EFAULT;
>  #endif
>  	set_current_blocked(&set);
> @@ -1120,7 +1120,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  		 */
>  		mctx = (struct mcontext __user *)
>  			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
> -		if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
> +		if (!access_ok(old_ctx, ctx_size)
>  		    || save_user_regs(regs, mctx, NULL, 0, ctx_has_vsx_region)
>  		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
>  		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
> @@ -1128,7 +1128,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	}
>  	if (new_ctx == NULL)
>  		return 0;
> -	if (!access_ok(VERIFY_READ, new_ctx, ctx_size) ||
> +	if (!access_ok(new_ctx, ctx_size) ||
>  	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
>  		return -EFAULT;
>  
> @@ -1169,7 +1169,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  
>  	rt_sf = (struct rt_sigframe __user *)
>  		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
> -	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
> +	if (!access_ok(rt_sf, sizeof(*rt_sf)))
>  		goto bad;
>  
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> @@ -1315,7 +1315,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
>  	current->thread.debug.dbcr0 = new_dbcr0;
>  #endif
>  
> -	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx)) ||
> +	if (!access_ok(ctx, sizeof(*ctx)) ||
>  	    fault_in_pages_readable((u8 __user *)ctx, sizeof(*ctx)))
>  		return -EFAULT;
>  
> @@ -1500,7 +1500,7 @@ SYSCALL_DEFINE0(sigreturn)
>  	{
>  		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
>  		addr = sr;
> -		if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
> +		if (!access_ok(sr, sizeof(*sr))
>  		    || restore_user_regs(regs, sr, 1))
>  			goto badframe;
>  	}
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 0935fe6c282a..bd5e6834ca69 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -383,7 +383,7 @@ static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
>  	err |= __get_user(v_regs, &sc->v_regs);
>  	if (err)
>  		return err;
> -	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
> +	if (v_regs && !access_ok(v_regs, 34 * sizeof(vector128)))
>  		return -EFAULT;
>  	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
>  	if (v_regs != NULL && (msr & MSR_VEC) != 0) {
> @@ -502,10 +502,9 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
>  	err |= __get_user(tm_v_regs, &tm_sc->v_regs);
>  	if (err)
>  		return err;
> -	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
> +	if (v_regs && !access_ok(v_regs, 34 * sizeof(vector128)))
>  		return -EFAULT;
> -	if (tm_v_regs && !access_ok(VERIFY_READ,
> -				    tm_v_regs, 34 * sizeof(vector128)))
> +	if (tm_v_regs && !access_ok(tm_v_regs, 34 * sizeof(vector128)))
>  		return -EFAULT;
>  	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
>  	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
> @@ -671,7 +670,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  		ctx_has_vsx_region = 1;
>  
>  	if (old_ctx != NULL) {
> -		if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
> +		if (!access_ok(old_ctx, ctx_size)
>  		    || setup_sigcontext(&old_ctx->uc_mcontext, current, 0, NULL, 0,
>  					ctx_has_vsx_region)
>  		    || __copy_to_user(&old_ctx->uc_sigmask,
> @@ -680,7 +679,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	}
>  	if (new_ctx == NULL)
>  		return 0;
> -	if (!access_ok(VERIFY_READ, new_ctx, ctx_size)
> +	if (!access_ok(new_ctx, ctx_size)
>  	    || __get_user(tmp, (u8 __user *) new_ctx)
>  	    || __get_user(tmp, (u8 __user *) new_ctx + ctx_size - 1))
>  		return -EFAULT;
> @@ -725,7 +724,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, uc, sizeof(*uc)))
> +	if (!access_ok(uc, sizeof(*uc)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 466216506eb2..e6982ab21816 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -89,7 +89,7 @@ ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, s
>  	if ( (unsigned long)n >= 4096 )
>  	{
>  		unsigned long __user *buffer = (unsigned long __user *)n;
> -		if (!access_ok(VERIFY_READ, buffer, 5*sizeof(unsigned long))
> +		if (!access_ok(buffer, 5*sizeof(unsigned long))
>  		    || __get_user(n, buffer)
>  		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
>  		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 00af2c4febf4..64936b60d521 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -837,7 +837,7 @@ static void p9_hmi_special_emu(struct pt_regs *regs)
>  	addr = (__force const void __user *)ea;
>  
>  	/* Check it */
> -	if (!access_ok(VERIFY_READ, addr, 16)) {
> +	if (!access_ok(addr, 16)) {
>  		pr_devel("HMI vec emu: bad access %i:%s[%d] nip=%016lx"
>  			 " instr=%08x addr=%016lx\n",
>  			 smp_processor_id(), current->comm, current->pid,
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 6f2d2fb4e098..bd2dcfbf00cd 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1744,7 +1744,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
>  	int first_pass;
>  	unsigned long hpte[2];
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	if (kvm_is_radix(kvm))
>  		return 0;
> @@ -1844,7 +1844,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
>  	int mmu_ready;
>  	int pshift;
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	if (kvm_is_radix(kvm))
>  		return -EINVAL;
> diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
> index a0cb63fb76a1..890d4ddd91d6 100644
> --- a/arch/powerpc/lib/checksum_wrappers.c
> +++ b/arch/powerpc/lib/checksum_wrappers.c
> @@ -37,7 +37,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>  		goto out;
>  	}
>  
> -	if (unlikely((len < 0) || !access_ok(VERIFY_READ, src, len))) {
> +	if (unlikely((len < 0) || !access_ok(src, len))) {
>  		*err_ptr = -EFAULT;
>  		csum = (__force unsigned int)sum;
>  		goto out;
> @@ -78,7 +78,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>  		goto out;
>  	}
>  
> -	if (unlikely((len < 0) || !access_ok(VERIFY_WRITE, dst, len))) {
> +	if (unlikely((len < 0) || !access_ok(dst, len))) {
>  		*err_ptr = -EFAULT;
>  		csum = -1; /* invalid checksum */
>  		goto out;
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a6dcfda3e11e..887f11bcf330 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -274,7 +274,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  			return false;
>  
>  		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> -		    access_ok(VERIFY_READ, nip, sizeof(*nip))) {
> +		    access_ok(nip, sizeof(*nip))) {
>  			unsigned int inst;
>  			int res;
>  
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 3327551c8b47..5e4178790dee 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -214,7 +214,7 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
>  		return 0;
>  	}
>  
> -	if (!access_ok(VERIFY_READ, map, (len >> PAGE_SHIFT) * sizeof(u32)))
> +	if (!access_ok(map, (len >> PAGE_SHIFT) * sizeof(u32)))
>  		return -EFAULT;
>  
>  	down_write(&mm->mmap_sem);
> diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
> index 5df6290d1ccc..260c53700978 100644
> --- a/arch/powerpc/oprofile/backtrace.c
> +++ b/arch/powerpc/oprofile/backtrace.c
> @@ -31,7 +31,7 @@ static unsigned int user_getsp32(unsigned int sp, int is_first)
>  	unsigned int stack_frame[2];
>  	void __user *p = compat_ptr(sp);
>  
> -	if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
> +	if (!access_ok(p, sizeof(stack_frame)))
>  		return 0;
>  
>  	/*
> @@ -57,7 +57,7 @@ static unsigned long user_getsp64(unsigned long sp, int is_first)
>  {
>  	unsigned long stack_frame[3];
>  
> -	if (!access_ok(VERIFY_READ, (void __user *)sp, sizeof(stack_frame)))
> +	if (!access_ok((void __user *)sp, sizeof(stack_frame)))
>  		return 0;
>  
>  	if (__copy_from_user_inatomic(stack_frame, (void __user *)sp,
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 43e7b93f27c7..ae8123edddc6 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -609,7 +609,7 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
>  	if (len < 4)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	udata = (void __user *)buf;
> @@ -717,7 +717,7 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
>  	if (len < 4)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	udata = (void __user *)buf;
> @@ -856,7 +856,7 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
>  		return -EINVAL;
>  
>  	udata = (void __user *)buf;
> -	if (!access_ok(VERIFY_READ, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	if (__get_user(wbox_data, udata))
> @@ -1994,7 +1994,7 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
>  	int ret;
>  	struct spu_context *ctx = file->private_data;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	ret = spu_acquire_saved(ctx);
> @@ -2034,7 +2034,7 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
>  	struct spu_context *ctx = file->private_data;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	ret = spu_acquire_saved(ctx);
> @@ -2077,7 +2077,7 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
>  	struct spu_context *ctx = file->private_data;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	ret = spu_acquire_saved(ctx);
> @@ -2129,7 +2129,7 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
>  	struct spu_context *ctx = file->private_data;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	ret = spu_acquire_saved(ctx);
> @@ -2160,7 +2160,7 @@ static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
>  	if (len < ret)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, len))
> +	if (!access_ok(buf, len))
>  		return -EFAULT;
>  
>  	info.proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
> diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
> index 6c7ad1d8b32e..2623996a193a 100644
> --- a/arch/powerpc/platforms/powernv/opal-lpc.c
> +++ b/arch/powerpc/platforms/powernv/opal-lpc.c
> @@ -192,7 +192,7 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
>  	u32 data, pos, len, todo;
>  	int rc;
>  
> -	if (!access_ok(VERIFY_WRITE, ubuf, count))
> +	if (!access_ok(ubuf, count))
>  		return -EFAULT;
>  
>  	todo = count;
> @@ -283,7 +283,7 @@ static ssize_t lpc_debug_write(struct file *filp, const char __user *ubuf,
>  	u32 data, pos, len, todo;
>  	int rc;
>  
> -	if (!access_ok(VERIFY_READ, ubuf, count))
> +	if (!access_ok(ubuf, count))
>  		return -EFAULT;
>  
>  	todo = count;
> diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
> index 054ce7a16fc3..24b157e1e890 100644
> --- a/arch/powerpc/platforms/pseries/scanlog.c
> +++ b/arch/powerpc/platforms/pseries/scanlog.c
> @@ -63,7 +63,7 @@ static ssize_t scanlog_read(struct file *file, char __user *buf,
>  		return -EINVAL;
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	for (;;) {
> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
> index 3b19eba1bc8e..66641624d8a5 100644
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h
> @@ -95,7 +95,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	u32 val;
>  	uintptr_t tmp;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	__enable_user_access();
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 8c3e3e3c8be1..637b896894fc 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -54,14 +54,8 @@ static inline void set_fs(mm_segment_t fs)
>  #define user_addr_max()	(get_fs())
>  
>  
> -#define VERIFY_READ	0
> -#define VERIFY_WRITE	1
> -
>  /**
>   * access_ok: - Checks if a user space pointer is valid
> - * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
> - *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
> - *        to write to a block, it is always safe to read from it.
>   * @addr: User space pointer to start of block to check
>   * @size: Size of block to check
>   *
> @@ -76,7 +70,7 @@ static inline void set_fs(mm_segment_t fs)
>   * checks that the pointer is in the user space range - after calling
>   * this function, memory access functions may still return -EFAULT.
>   */
> -#define access_ok(type, addr, size) ({					\
> +#define access_ok(addr, size) ({					\
>  	__chk_user_ptr(addr);						\
>  	likely(__access_ok((unsigned long __force)(addr), (size)));	\
>  })
> @@ -258,7 +252,7 @@ do {								\
>  ({								\
>  	const __typeof__(*(ptr)) __user *__p = (ptr);		\
>  	might_fault();						\
> -	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?		\
> +	access_ok(__p, sizeof(*__p)) ?		\
>  		__get_user((x), __p) :				\
>  		((x) = 0, -EFAULT);				\
>  })
> @@ -386,7 +380,7 @@ do {								\
>  ({								\
>  	__typeof__(*(ptr)) __user *__p = (ptr);			\
>  	might_fault();						\
> -	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?		\
> +	access_ok(__p, sizeof(*__p)) ?		\
>  		__put_user((x), __p) :				\
>  		-EFAULT;					\
>  })
> @@ -421,7 +415,7 @@ static inline
>  unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  {
>  	might_fault();
> -	return access_ok(VERIFY_WRITE, to, n) ?
> +	return access_ok(to, n) ?
>  		__clear_user(to, n) : n;
>  }
>  
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index f9b5e7e352ef..837e1646091a 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -115,7 +115,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  
>  	frame = (struct rt_sigframe __user *)regs->sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -187,7 +187,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  	long err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index ad6b91013a05..bd2545977ad3 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -48,7 +48,7 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>  	__range_ok((unsigned long)(addr), (size));	\
>  })
>  
> -#define access_ok(type, addr, size) __access_ok(addr, size)
> +#define access_ok(addr, size) __access_ok(addr, size)
>  
>  unsigned long __must_check
>  raw_copy_from_user(void *to, const void __user *from, unsigned long n);
> diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
> index b58f3d95dc19..36b84cfd3f67 100644
> --- a/arch/sh/include/asm/checksum_32.h
> +++ b/arch/sh/include/asm/checksum_32.h
> @@ -197,7 +197,7 @@ static inline __wsum csum_and_copy_to_user(const void *src,
>  					   int len, __wsum sum,
>  					   int *err_ptr)
>  {
> -	if (access_ok(VERIFY_WRITE, dst, len))
> +	if (access_ok(dst, len))
>  		return csum_partial_copy_generic((__force const void *)src,
>  						dst, len, sum, NULL, err_ptr);
>  
> diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
> index 6d192f4908a7..3190ec89df81 100644
> --- a/arch/sh/include/asm/futex.h
> +++ b/arch/sh/include/asm/futex.h
> @@ -22,7 +22,7 @@ static inline int
>  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  			      u32 oldval, u32 newval)
>  {
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	return atomic_futex_op_cmpxchg_inatomic(uval, uaddr, oldval, newval);
> diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
> index 32eb56e00c11..deebbfab5342 100644
> --- a/arch/sh/include/asm/uaccess.h
> +++ b/arch/sh/include/asm/uaccess.h
> @@ -18,7 +18,7 @@
>   */
>  #define __access_ok(addr, size)		\
>  	(__addr_ok((addr) + (size)))
> -#define access_ok(type, addr, size)	\
> +#define access_ok(addr, size)	\
>  	(__chk_user_ptr(addr),		\
>  	 __access_ok((unsigned long __force)(addr), (size)))
>  
> @@ -66,7 +66,7 @@ struct __large_struct { unsigned long buf[100]; };
>  	long __gu_err = -EFAULT;					\
>  	unsigned long __gu_val = 0;					\
>  	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
> -	if (likely(access_ok(VERIFY_READ, __gu_addr, (size))))		\
> +	if (likely(access_ok(__gu_addr, (size))))		\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;							\
> @@ -87,7 +87,7 @@ struct __large_struct { unsigned long buf[100]; };
>  	long __pu_err = -EFAULT;				\
>  	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
>  	__typeof__(*(ptr)) __pu_val = x;			\
> -	if (likely(access_ok(VERIFY_WRITE, __pu_addr, size)))	\
> +	if (likely(access_ok(__pu_addr, size)))	\
>  		__put_user_size(__pu_val, __pu_addr, (size),	\
>  				__pu_err);			\
>  	__pu_err;						\
> @@ -132,8 +132,7 @@ __kernel_size_t __clear_user(void *addr, __kernel_size_t size);
>  	void __user * __cl_addr = (addr);				\
>  	unsigned long __cl_size = (n);					\
>  									\
> -	if (__cl_size && access_ok(VERIFY_WRITE,			\
> -		((unsigned long)(__cl_addr)), __cl_size))		\
> +	if (__cl_size && access_ok(__cl_addr, __cl_size))		\
>  		__cl_size = __clear_user(__cl_addr, __cl_size);		\
>  									\
>  	__cl_size;							\
> diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
> index c46c0020ff55..2a2121ba8ebe 100644
> --- a/arch/sh/kernel/signal_32.c
> +++ b/arch/sh/kernel/signal_32.c
> @@ -160,7 +160,7 @@ asmlinkage int sys_sigreturn(void)
>          /* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__get_user(set.sig[0], &frame->sc.oldmask)
> @@ -190,7 +190,7 @@ asmlinkage int sys_rt_sigreturn(void)
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -272,7 +272,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
> @@ -338,7 +338,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
> index 76661dee3c65..f1f1598879c2 100644
> --- a/arch/sh/kernel/signal_64.c
> +++ b/arch/sh/kernel/signal_64.c
> @@ -259,7 +259,7 @@ asmlinkage int sys_sigreturn(unsigned long r2, unsigned long r3,
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__get_user(set.sig[0], &frame->sc.oldmask)
> @@ -293,7 +293,7 @@ asmlinkage int sys_rt_sigreturn(unsigned long r2, unsigned long r3,
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -379,7 +379,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
>  
>  	frame = get_sigframe(&ksig->ka, regs->regs[REG_SP], sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
> @@ -465,7 +465,7 @@ static int setup_rt_frame(struct ksignal *kig, sigset_t *set,
>  
>  	frame = get_sigframe(&ksig->ka, regs->regs[REG_SP], sizeof(*frame));
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	err |= __put_user(&frame->info, &frame->pinfo);
> diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
> index c52bda4d2574..8ce90a7da67d 100644
> --- a/arch/sh/kernel/traps_64.c
> +++ b/arch/sh/kernel/traps_64.c
> @@ -40,7 +40,7 @@ static int read_opcode(reg_size_t pc, insn_size_t *result_opcode, int from_user_
>  		/* SHmedia */
>  		aligned_pc = pc & ~3;
>  		if (from_user_mode) {
> -			if (!access_ok(VERIFY_READ, aligned_pc, sizeof(insn_size_t))) {
> +			if (!access_ok(aligned_pc, sizeof(insn_size_t))) {
>  				get_user_error = -EFAULT;
>  			} else {
>  				get_user_error = __get_user(opcode, (insn_size_t *)aligned_pc);
> @@ -180,7 +180,7 @@ static int misaligned_load(struct pt_regs *regs,
>  	if (user_mode(regs)) {
>  		__u64 buffer;
>  
> -		if (!access_ok(VERIFY_READ, (unsigned long) address, 1UL<<width_shift)) {
> +		if (!access_ok((unsigned long) address, 1UL<<width_shift)) {
>  			return -1;
>  		}
>  
> @@ -254,7 +254,7 @@ static int misaligned_store(struct pt_regs *regs,
>  	if (user_mode(regs)) {
>  		__u64 buffer;
>  
> -		if (!access_ok(VERIFY_WRITE, (unsigned long) address, 1UL<<width_shift)) {
> +		if (!access_ok((unsigned long) address, 1UL<<width_shift)) {
>  			return -1;
>  		}
>  
> @@ -327,7 +327,7 @@ static int misaligned_fpu_load(struct pt_regs *regs,
>  		__u64 buffer;
>  		__u32 buflo, bufhi;
>  
> -		if (!access_ok(VERIFY_READ, (unsigned long) address, 1UL<<width_shift)) {
> +		if (!access_ok((unsigned long) address, 1UL<<width_shift)) {
>  			return -1;
>  		}
>  
> @@ -400,7 +400,7 @@ static int misaligned_fpu_store(struct pt_regs *regs,
>  		/* Initialise these to NaNs. */
>  		__u32 buflo=0xffffffffUL, bufhi=0xffffffffUL;
>  
> -		if (!access_ok(VERIFY_WRITE, (unsigned long) address, 1UL<<width_shift)) {
> +		if (!access_ok((unsigned long) address, 1UL<<width_shift)) {
>  			return -1;
>  		}
>  
> @@ -663,7 +663,7 @@ void do_reserved_inst(unsigned long error_code, struct pt_regs *regs)
>  	/* SHmedia : check for defect.  This requires executable vmas
>  	   to be readable too. */
>  	aligned_pc = pc & ~3;
> -	if (!access_ok(VERIFY_READ, aligned_pc, sizeof(insn_size_t)))
> +	if (!access_ok(aligned_pc, sizeof(insn_size_t)))
>  		get_user_error = -EFAULT;
>  	else
>  		get_user_error = __get_user(opcode, (insn_size_t *)aligned_pc);
> diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
> index 56c86ca98ecf..3e27f6d1f1ec 100644
> --- a/arch/sh/mm/gup.c
> +++ b/arch/sh/mm/gup.c
> @@ -177,8 +177,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
> -	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> -					(void __user *)start, len)))
> +	if (unlikely(!access_ok((void __user *)start, len)))
>  		return 0;
>  
>  	/*
> diff --git a/arch/sh/oprofile/backtrace.c b/arch/sh/oprofile/backtrace.c
> index c7695f99c8c3..8279a7e91043 100644
> --- a/arch/sh/oprofile/backtrace.c
> +++ b/arch/sh/oprofile/backtrace.c
> @@ -51,7 +51,7 @@ user_backtrace(unsigned long *stackaddr, struct pt_regs *regs)
>  	unsigned long buf_stack;
>  
>  	/* Also check accessibility of address */
> -	if (!access_ok(VERIFY_READ, stackaddr, sizeof(unsigned long)))
> +	if (!access_ok(stackaddr, sizeof(unsigned long)))
>  		return NULL;
>  
>  	if (__copy_from_user_inatomic(&buf_stack, stackaddr, sizeof(unsigned long)))
> diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
> index d1e53d7aed39..5fc98d80b03b 100644
> --- a/arch/sparc/include/asm/checksum_32.h
> +++ b/arch/sparc/include/asm/checksum_32.h
> @@ -87,7 +87,7 @@ static inline __wsum
>  csum_partial_copy_to_user(const void *src, void __user *dst, int len,
>  			  __wsum sum, int *err)
>  {
> -	if (!access_ok (VERIFY_WRITE, dst, len)) {
> +	if (!access_ok(dst, len)) {
>  		*err = -EFAULT;
>  		return sum;
>  	} else {
> diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
> index de71c65b99f0..69afb856e181 100644
> --- a/arch/sparc/include/asm/uaccess_32.h
> +++ b/arch/sparc/include/asm/uaccess_32.h
> @@ -39,7 +39,7 @@
>  #define __user_ok(addr, size) ({ (void)(size); (addr) < STACK_TOP; })
>  #define __kernel_ok (uaccess_kernel())
>  #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
> -#define access_ok(type, addr, size) \
> +#define access_ok(addr, size) \
>  	({ (void)(type); __access_ok((unsigned long)(addr), size); })
>  
>  /*
> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
> index cbb308cee394..87ae9ffb1521 100644
> --- a/arch/sparc/include/asm/uaccess_64.h
> +++ b/arch/sparc/include/asm/uaccess_64.h
> @@ -68,7 +68,7 @@ static inline int __access_ok(const void __user * addr, unsigned long size)
>  	return 1;
>  }
>  
> -static inline int access_ok(int type, const void __user * addr, unsigned long size)
> +static inline int access_ok(const void __user * addr, unsigned long size)
>  {
>  	return 1;
>  }
> diff --git a/arch/sparc/kernel/sigutil_32.c b/arch/sparc/kernel/sigutil_32.c
> index 1e9fae56a853..f25c6daa9f52 100644
> --- a/arch/sparc/kernel/sigutil_32.c
> +++ b/arch/sparc/kernel/sigutil_32.c
> @@ -65,7 +65,7 @@ int restore_fpu_state(struct pt_regs *regs, __siginfo_fpu_t __user *fpu)
>  	set_used_math();
>  	clear_tsk_thread_flag(current, TIF_USEDFPU);
>  
> -	if (!access_ok(VERIFY_READ, fpu, sizeof(*fpu)))
> +	if (!access_ok(fpu, sizeof(*fpu)))
>  		return -EFAULT;
>  
>  	err = __copy_from_user(&current->thread.float_regs[0], &fpu->si_float_regs[0],
> diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
> index 64ac8c0c1429..83db94c0b431 100644
> --- a/arch/sparc/kernel/unaligned_32.c
> +++ b/arch/sparc/kernel/unaligned_32.c
> @@ -278,7 +278,6 @@ static inline int ok_for_user(struct pt_regs *regs, unsigned int insn,
>  			      enum direction dir)
>  {
>  	unsigned int reg;
> -	int check = (dir == load) ? VERIFY_READ : VERIFY_WRITE;
>  	int size = ((insn >> 19) & 3) == 3 ? 8 : 4;
>  
>  	if ((regs->pc | regs->npc) & 3)
> @@ -290,18 +289,18 @@ static inline int ok_for_user(struct pt_regs *regs, unsigned int insn,
>  
>  	reg = (insn >> 25) & 0x1f;
>  	if (reg >= 16) {
> -		if (!access_ok(check, WINREG_ADDR(reg - 16), size))
> +		if (!access_ok(WINREG_ADDR(reg - 16), size))
>  			return -EFAULT;
>  	}
>  	reg = (insn >> 14) & 0x1f;
>  	if (reg >= 16) {
> -		if (!access_ok(check, WINREG_ADDR(reg - 16), size))
> +		if (!access_ok(WINREG_ADDR(reg - 16), size))
>  			return -EFAULT;
>  	}
>  	if (!(insn & 0x2000)) {
>  		reg = (insn & 0x1f);
>  		if (reg >= 16) {
> -			if (!access_ok(check, WINREG_ADDR(reg - 16), size))
> +			if (!access_ok(WINREG_ADDR(reg - 16), size))
>  				return -EFAULT;
>  		}
>  	}
> diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
> index 1a1d88a4d940..5f47422401e1 100644
> --- a/arch/um/kernel/ptrace.c
> +++ b/arch/um/kernel/ptrace.c
> @@ -66,7 +66,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  
>  #ifdef PTRACE_GETREGS
>  	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
> -		if (!access_ok(VERIFY_WRITE, p, MAX_REG_OFFSET)) {
> +		if (!access_ok(p, MAX_REG_OFFSET)) {
>  			ret = -EIO;
>  			break;
>  		}
> @@ -81,7 +81,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  #ifdef PTRACE_SETREGS
>  	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
>  		unsigned long tmp = 0;
> -		if (!access_ok(VERIFY_READ, p, MAX_REG_OFFSET)) {
> +		if (!access_ok(p, MAX_REG_OFFSET)) {
>  			ret = -EIO;
>  			break;
>  		}
> diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
> index 4ae51cf15ade..63be04809d40 100644
> --- a/arch/unicore32/kernel/signal.c
> +++ b/arch/unicore32/kernel/signal.c
> @@ -117,7 +117,7 @@ asmlinkage int __sys_rt_sigreturn(struct pt_regs *regs)
>  
>  	frame = (struct rt_sigframe __user *)regs->UCreg_sp;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (restore_sigframe(regs, &frame->sig))
> @@ -205,7 +205,7 @@ static inline void __user *get_sigframe(struct k_sigaction *ka,
>  	/*
>  	 * Check that we can actually write to the signal frame.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, frame, framesize))
> +	if (!access_ok(frame, framesize))
>  		frame = NULL;
>  
>  	return frame;
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index d78bcc03e60e..d9d81ad7a400 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -99,7 +99,7 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
>  	 * sig_on_uaccess_err, this could go away.
>  	 */
>  
> -	if (!access_ok(VERIFY_WRITE, (void __user *)ptr, size)) {
> +	if (!access_ok((void __user *)ptr, size)) {
>  		struct thread_struct *thread = &current->thread;
>  
>  		thread->error_code	= X86_PF_USER | X86_PF_WRITE;
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index 8e02b30cf08e..f65b78d32f5e 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -176,10 +176,10 @@ static int aout_core_dump(struct coredump_params *cprm)
>  
>  	/* make sure we actually have a data and stack area to dump */
>  	set_fs(USER_DS);
> -	if (!access_ok(VERIFY_READ, (void *) (unsigned long)START_DATA(dump),
> +	if (!access_ok((void *) (unsigned long)START_DATA(dump),
>  		       dump.u_dsize << PAGE_SHIFT))
>  		dump.u_dsize = 0;
> -	if (!access_ok(VERIFY_READ, (void *) (unsigned long)START_STACK(dump),
> +	if (!access_ok((void *) (unsigned long)START_STACK(dump),
>  		       dump.u_ssize << PAGE_SHIFT))
>  		dump.u_ssize = 0;
>  
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 86b1341cba9a..321fe5f5d0e9 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -119,7 +119,7 @@ asmlinkage long sys32_sigreturn(void)
>  	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
>  	sigset_t set;
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__get_user(set.sig[0], &frame->sc.oldmask)
>  	    || (_COMPAT_NSIG_WORDS > 1
> @@ -147,7 +147,7 @@ asmlinkage long sys32_rt_sigreturn(void)
>  
>  	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -269,7 +269,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame), &fpstate);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (__put_user(sig, &frame->sig))
> @@ -349,7 +349,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame), &fpstate);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	put_user_try {
> diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
> index 11ef7b7c9cc8..a43212036257 100644
> --- a/arch/x86/ia32/sys_ia32.c
> +++ b/arch/x86/ia32/sys_ia32.c
> @@ -75,7 +75,7 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
>  	typeof(ubuf->st_gid) gid = 0;
>  	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
>  	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
> -	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(struct stat64)) ||
> +	if (!access_ok(ubuf, sizeof(struct stat64)) ||
>  	    __put_user(huge_encode_dev(stat->dev), &ubuf->st_dev) ||
>  	    __put_user(stat->ino, &ubuf->__st_ino) ||
>  	    __put_user(stat->ino, &ubuf->st_ino) ||
> diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
> index 7a659c74cd03..f57b94e02c57 100644
> --- a/arch/x86/include/asm/checksum_32.h
> +++ b/arch/x86/include/asm/checksum_32.h
> @@ -182,7 +182,7 @@ static inline __wsum csum_and_copy_to_user(const void *src,
>  	__wsum ret;
>  
>  	might_sleep();
> -	if (access_ok(VERIFY_WRITE, dst, len)) {
> +	if (access_ok(dst, len)) {
>  		stac();
>  		ret = csum_partial_copy_generic(src, (__force void *)dst,
>  						len, sum, NULL, err_ptr);
> diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
> index b3ec519e3982..4fe9e7fc74d3 100644
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -37,7 +37,7 @@ void sync_initial_page_table(void);
>  /*
>   * Define this if things work differently on an i386 and an i486:
>   * it will (on an i486) warn about kernel memory accesses that are
> - * done without a 'access_ok(VERIFY_WRITE,..)'
> + * done without a 'access_ok( ..)'
>   */
>  #undef TEST_ACCESS_OK
>  
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index b5e58cc0c5e7..3920f456db79 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -77,9 +77,6 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
>  
>  /**
>   * access_ok: - Checks if a user space pointer is valid
> - * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
> - *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
> - *        to write to a block, it is always safe to read from it.
>   * @addr: User space pointer to start of block to check
>   * @size: Size of block to check
>   *
> @@ -95,7 +92,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
>   * checks that the pointer is in the user space range - after calling
>   * this function, memory access functions may still return -EFAULT.
>   */
> -#define access_ok(type, addr, size)					\
> +#define access_ok(addr, size)					\
>  ({									\
>  	WARN_ON_IN_IRQ();						\
>  	likely(!__range_not_ok(addr, size, user_addr_max()));		\
> @@ -670,7 +667,7 @@ extern void __cmpxchg_wrong_size(void)
>  
>  #define user_atomic_cmpxchg_inatomic(uval, ptr, old, new)		\
>  ({									\
> -	access_ok(VERIFY_WRITE, (ptr), sizeof(*(ptr))) ?		\
> +	access_ok((ptr), sizeof(*(ptr))) ?		\
>  		__user_atomic_cmpxchg_inatomic((uval), (ptr),		\
>  				(old), (new), sizeof(*(ptr))) :		\
>  		-EFAULT;						\
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index d99a8ee9e185..f6a1d299627c 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -164,7 +164,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
>  			 IS_ENABLED(CONFIG_IA32_EMULATION));
>  
> -	if (!access_ok(VERIFY_WRITE, buf, size))
> +	if (!access_ok(buf, size))
>  		return -EACCES;
>  
>  	if (!static_cpu_has(X86_FEATURE_FPU))
> @@ -281,7 +281,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		return 0;
>  	}
>  
> -	if (!access_ok(VERIFY_READ, buf, size))
> +	if (!access_ok(buf, size))
>  		return -EACCES;
>  
>  	fpu__initialize(fpu);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 92a3b312a53c..08dfd4c1a4f9 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -322,7 +322,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
>  
>  	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (__put_user(sig, &frame->sig))
> @@ -385,7 +385,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>  
>  	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	put_user_try {
> @@ -465,7 +465,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>  
>  	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
> @@ -547,7 +547,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
>  
>  	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return -EFAULT;
>  
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
> @@ -610,7 +610,7 @@ SYSCALL_DEFINE0(sigreturn)
>  
>  	frame = (struct sigframe __user *)(regs->sp - 8);
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__get_user(set.sig[0], &frame->sc.oldmask) || (_NSIG_WORDS > 1
>  		&& __copy_from_user(&set.sig[1], &frame->extramask,
> @@ -642,7 +642,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	unsigned long uc_flags;
>  
>  	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> @@ -871,7 +871,7 @@ asmlinkage long sys32_x32_rt_sigreturn(void)
>  
>  	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
>  		goto badframe;
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 7627455047c2..5c2d71a1dc06 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -177,7 +177,7 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
>  {
>  	int ret;
>  
> -	if (!access_ok(VERIFY_READ, fp, sizeof(*frame)))
> +	if (!access_ok(fp, sizeof(*frame)))
>  		return 0;
>  
>  	ret = 1;
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index c2fd39752da8..a092b6b40c6b 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -114,7 +114,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
>  	user = vm86->user_vm86;
>  
> -	if (!access_ok(VERIFY_WRITE, user, vm86->vm86plus.is_vm86pus ?
> +	if (!access_ok(user, vm86->vm86plus.is_vm86pus ?
>  		       sizeof(struct vm86plus_struct) :
>  		       sizeof(struct vm86_struct))) {
>  		pr_alert("could not access userspace vm86 info\n");
> @@ -278,7 +278,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>  	if (vm86->saved_sp0)
>  		return -EPERM;
>  
> -	if (!access_ok(VERIFY_READ, user_vm86, plus ?
> +	if (!access_ok(user_vm86, plus ?
>  		       sizeof(struct vm86_struct) :
>  		       sizeof(struct vm86plus_struct)))
>  		return -EFAULT;
> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index 8bd53589ecfb..a6a2b7dccbff 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -27,7 +27,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
>  	might_sleep();
>  	*errp = 0;
>  
> -	if (!likely(access_ok(VERIFY_READ, src, len)))
> +	if (!likely(access_ok(src, len)))
>  		goto out_err;
>  
>  	/*
> @@ -89,7 +89,7 @@ csum_partial_copy_to_user(const void *src, void __user *dst,
>  
>  	might_sleep();
>  
> -	if (unlikely(!access_ok(VERIFY_WRITE, dst, len))) {
> +	if (unlikely(!access_ok(dst, len))) {
>  		*errp = -EFAULT;
>  		return 0;
>  	}
> diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
> index 71fb58d44d58..bfd94e7812fc 100644
> --- a/arch/x86/lib/usercopy_32.c
> +++ b/arch/x86/lib/usercopy_32.c
> @@ -67,7 +67,7 @@ unsigned long
>  clear_user(void __user *to, unsigned long n)
>  {
>  	might_fault();
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		__do_clear_user(to, n);
>  	return n;
>  }
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index 1bd837cdc4b1..ee42bb0cbeb3 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -48,7 +48,7 @@ EXPORT_SYMBOL(__clear_user);
>  
>  unsigned long clear_user(void __user *to, unsigned long n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n))
> +	if (access_ok(to, n))
>  		return __clear_user(to, n);
>  	return n;
>  }
> diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
> index c8b1b31ed7c4..f98a0c956764 100644
> --- a/arch/x86/math-emu/fpu_system.h
> +++ b/arch/x86/math-emu/fpu_system.h
> @@ -104,7 +104,7 @@ static inline bool seg_writable(struct desc_struct *d)
>  #define instruction_address	(*(struct address *)&I387->soft.fip)
>  #define operand_address		(*(struct address *)&I387->soft.foo)
>  
> -#define FPU_access_ok(x,y,z)	if ( !access_ok(x,y,z) ) \
> +#define FPU_access_ok(y,z)	if ( !access_ok(y,z) ) \
>  				math_abort(FPU_info,SIGSEGV)
>  #define FPU_abort		math_abort(FPU_info, SIGSEGV)
>  
> @@ -119,7 +119,7 @@ static inline bool seg_writable(struct desc_struct *d)
>  /* A simpler test than access_ok() can probably be done for
>     FPU_code_access_ok() because the only possible error is to step
>     past the upper boundary of a legal code area. */
> -#define	FPU_code_access_ok(z) FPU_access_ok(VERIFY_READ,(void __user *)FPU_EIP,z)
> +#define	FPU_code_access_ok(z) FPU_access_ok((void __user *)FPU_EIP,z)
>  #endif
>  
>  #define FPU_get_user(x,y)       get_user((x),(y))
> diff --git a/arch/x86/math-emu/load_store.c b/arch/x86/math-emu/load_store.c
> index f821a9cd7753..f15263e158e8 100644
> --- a/arch/x86/math-emu/load_store.c
> +++ b/arch/x86/math-emu/load_store.c
> @@ -251,7 +251,7 @@ int FPU_load_store(u_char type, fpu_addr_modes addr_modes,
>  		break;
>  	case 024:		/* fldcw */
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_READ, data_address, 2);
> +		FPU_access_ok(data_address, 2);
>  		FPU_get_user(control_word,
>  			     (unsigned short __user *)data_address);
>  		RE_ENTRANT_CHECK_ON;
> @@ -291,7 +291,7 @@ int FPU_load_store(u_char type, fpu_addr_modes addr_modes,
>  		break;
>  	case 034:		/* fstcw m16int */
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, data_address, 2);
> +		FPU_access_ok(data_address, 2);
>  		FPU_put_user(control_word,
>  			     (unsigned short __user *)data_address);
>  		RE_ENTRANT_CHECK_ON;
> @@ -305,7 +305,7 @@ int FPU_load_store(u_char type, fpu_addr_modes addr_modes,
>  		break;
>  	case 036:		/* fstsw m2byte */
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, data_address, 2);
> +		FPU_access_ok(data_address, 2);
>  		FPU_put_user(status_word(),
>  			     (unsigned short __user *)data_address);
>  		RE_ENTRANT_CHECK_ON;
> diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
> index d40ff45497b9..f3779743d15e 100644
> --- a/arch/x86/math-emu/reg_ld_str.c
> +++ b/arch/x86/math-emu/reg_ld_str.c
> @@ -84,7 +84,7 @@ int FPU_load_extended(long double __user *s, int stnr)
>  	FPU_REG *sti_ptr = &st(stnr);
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, s, 10);
> +	FPU_access_ok(s, 10);
>  	__copy_from_user(sti_ptr, s, 10);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -98,7 +98,7 @@ int FPU_load_double(double __user *dfloat, FPU_REG *loaded_data)
>  	unsigned m64, l64;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, dfloat, 8);
> +	FPU_access_ok(dfloat, 8);
>  	FPU_get_user(m64, 1 + (unsigned long __user *)dfloat);
>  	FPU_get_user(l64, (unsigned long __user *)dfloat);
>  	RE_ENTRANT_CHECK_ON;
> @@ -159,7 +159,7 @@ int FPU_load_single(float __user *single, FPU_REG *loaded_data)
>  	int exp, tag, negative;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, single, 4);
> +	FPU_access_ok(single, 4);
>  	FPU_get_user(m32, (unsigned long __user *)single);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -214,7 +214,7 @@ int FPU_load_int64(long long __user *_s)
>  	FPU_REG *st0_ptr = &st(0);
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, _s, 8);
> +	FPU_access_ok(_s, 8);
>  	if (copy_from_user(&s, _s, 8))
>  		FPU_abort;
>  	RE_ENTRANT_CHECK_ON;
> @@ -243,7 +243,7 @@ int FPU_load_int32(long __user *_s, FPU_REG *loaded_data)
>  	int negative;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, _s, 4);
> +	FPU_access_ok(_s, 4);
>  	FPU_get_user(s, _s);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -271,7 +271,7 @@ int FPU_load_int16(short __user *_s, FPU_REG *loaded_data)
>  	int s, negative;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, _s, 2);
> +	FPU_access_ok(_s, 2);
>  	/* Cast as short to get the sign extended. */
>  	FPU_get_user(s, _s);
>  	RE_ENTRANT_CHECK_ON;
> @@ -304,7 +304,7 @@ int FPU_load_bcd(u_char __user *s)
>  	int sign;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, s, 10);
> +	FPU_access_ok(s, 10);
>  	RE_ENTRANT_CHECK_ON;
>  	for (pos = 8; pos >= 0; pos--) {
>  		l *= 10;
> @@ -345,7 +345,7 @@ int FPU_store_extended(FPU_REG *st0_ptr, u_char st0_tag,
>  
>  	if (st0_tag != TAG_Empty) {
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, d, 10);
> +		FPU_access_ok(d, 10);
>  
>  		FPU_put_user(st0_ptr->sigl, (unsigned long __user *)d);
>  		FPU_put_user(st0_ptr->sigh,
> @@ -364,7 +364,7 @@ int FPU_store_extended(FPU_REG *st0_ptr, u_char st0_tag,
>  		/* The masked response */
>  		/* Put out the QNaN indefinite */
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, d, 10);
> +		FPU_access_ok(d, 10);
>  		FPU_put_user(0, (unsigned long __user *)d);
>  		FPU_put_user(0xc0000000, 1 + (unsigned long __user *)d);
>  		FPU_put_user(0xffff, 4 + (short __user *)d);
> @@ -539,7 +539,7 @@ int FPU_store_double(FPU_REG *st0_ptr, u_char st0_tag, double __user *dfloat)
>  			/* The masked response */
>  			/* Put out the QNaN indefinite */
>  			RE_ENTRANT_CHECK_OFF;
> -			FPU_access_ok(VERIFY_WRITE, dfloat, 8);
> +			FPU_access_ok(dfloat, 8);
>  			FPU_put_user(0, (unsigned long __user *)dfloat);
>  			FPU_put_user(0xfff80000,
>  				     1 + (unsigned long __user *)dfloat);
> @@ -552,7 +552,7 @@ int FPU_store_double(FPU_REG *st0_ptr, u_char st0_tag, double __user *dfloat)
>  		l[1] |= 0x80000000;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, dfloat, 8);
> +	FPU_access_ok(dfloat, 8);
>  	FPU_put_user(l[0], (unsigned long __user *)dfloat);
>  	FPU_put_user(l[1], 1 + (unsigned long __user *)dfloat);
>  	RE_ENTRANT_CHECK_ON;
> @@ -724,7 +724,7 @@ int FPU_store_single(FPU_REG *st0_ptr, u_char st0_tag, float __user *single)
>  			/* The masked response */
>  			/* Put out the QNaN indefinite */
>  			RE_ENTRANT_CHECK_OFF;
> -			FPU_access_ok(VERIFY_WRITE, single, 4);
> +			FPU_access_ok(single, 4);
>  			FPU_put_user(0xffc00000,
>  				     (unsigned long __user *)single);
>  			RE_ENTRANT_CHECK_ON;
> @@ -742,7 +742,7 @@ int FPU_store_single(FPU_REG *st0_ptr, u_char st0_tag, float __user *single)
>  		templ |= 0x80000000;
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, single, 4);
> +	FPU_access_ok(single, 4);
>  	FPU_put_user(templ, (unsigned long __user *)single);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -791,7 +791,7 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_char st0_tag, long long __user *d)
>  	}
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, d, 8);
> +	FPU_access_ok(d, 8);
>  	if (copy_to_user(d, &tll, 8))
>  		FPU_abort;
>  	RE_ENTRANT_CHECK_ON;
> @@ -838,7 +838,7 @@ int FPU_store_int32(FPU_REG *st0_ptr, u_char st0_tag, long __user *d)
>  	}
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, d, 4);
> +	FPU_access_ok(d, 4);
>  	FPU_put_user(t.sigl, (unsigned long __user *)d);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -884,7 +884,7 @@ int FPU_store_int16(FPU_REG *st0_ptr, u_char st0_tag, short __user *d)
>  	}
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, d, 2);
> +	FPU_access_ok(d, 2);
>  	FPU_put_user((short)t.sigl, d);
>  	RE_ENTRANT_CHECK_ON;
>  
> @@ -925,7 +925,7 @@ int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d)
>  		if (control_word & CW_Invalid) {
>  			/* Produce the QNaN "indefinite" */
>  			RE_ENTRANT_CHECK_OFF;
> -			FPU_access_ok(VERIFY_WRITE, d, 10);
> +			FPU_access_ok(d, 10);
>  			for (i = 0; i < 7; i++)
>  				FPU_put_user(0, d + i);	/* These bytes "undefined" */
>  			FPU_put_user(0xc0, d + 7);	/* This byte "undefined" */
> @@ -941,7 +941,7 @@ int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d)
>  	}
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, d, 10);
> +	FPU_access_ok(d, 10);
>  	RE_ENTRANT_CHECK_ON;
>  	for (i = 0; i < 9; i++) {
>  		b = FPU_div_small(&ll, 10);
> @@ -1034,7 +1034,7 @@ u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s)
>  	    ((addr_modes.default_mode == PM16)
>  	     ^ (addr_modes.override.operand_size == OP_SIZE_PREFIX))) {
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_READ, s, 0x0e);
> +		FPU_access_ok(s, 0x0e);
>  		FPU_get_user(control_word, (unsigned short __user *)s);
>  		FPU_get_user(partial_status, (unsigned short __user *)(s + 2));
>  		FPU_get_user(tag_word, (unsigned short __user *)(s + 4));
> @@ -1056,7 +1056,7 @@ u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s)
>  		}
>  	} else {
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_READ, s, 0x1c);
> +		FPU_access_ok(s, 0x1c);
>  		FPU_get_user(control_word, (unsigned short __user *)s);
>  		FPU_get_user(partial_status, (unsigned short __user *)(s + 4));
>  		FPU_get_user(tag_word, (unsigned short __user *)(s + 8));
> @@ -1125,7 +1125,7 @@ void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
>  
>  	/* Copy all registers in stack order. */
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_READ, s, 80);
> +	FPU_access_ok(s, 80);
>  	__copy_from_user(register_base + offset, s, other);
>  	if (offset)
>  		__copy_from_user(register_base, s + other, offset);
> @@ -1146,7 +1146,7 @@ u_char __user *fstenv(fpu_addr_modes addr_modes, u_char __user *d)
>  	    ((addr_modes.default_mode == PM16)
>  	     ^ (addr_modes.override.operand_size == OP_SIZE_PREFIX))) {
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, d, 14);
> +		FPU_access_ok(d, 14);
>  #ifdef PECULIAR_486
>  		FPU_put_user(control_word & ~0xe080, (unsigned long __user *)d);
>  #else
> @@ -1174,7 +1174,7 @@ u_char __user *fstenv(fpu_addr_modes addr_modes, u_char __user *d)
>  		d += 0x0e;
>  	} else {
>  		RE_ENTRANT_CHECK_OFF;
> -		FPU_access_ok(VERIFY_WRITE, d, 7 * 4);
> +		FPU_access_ok(d, 7 * 4);
>  #ifdef PECULIAR_486
>  		control_word &= ~0xe080;
>  		/* An 80486 sets nearly all of the reserved bits to 1. */
> @@ -1204,7 +1204,7 @@ void fsave(fpu_addr_modes addr_modes, u_char __user *data_address)
>  	d = fstenv(addr_modes, data_address);
>  
>  	RE_ENTRANT_CHECK_OFF;
> -	FPU_access_ok(VERIFY_WRITE, d, 80);
> +	FPU_access_ok(d, 80);
>  
>  	/* Copy all registers in stack order. */
>  	if (__copy_to_user(d, register_base + offset, other))
> diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> index 2385538e8065..de1851d15699 100644
> --- a/arch/x86/mm/mpx.c
> +++ b/arch/x86/mm/mpx.c
> @@ -495,7 +495,7 @@ static int get_bt_addr(struct mm_struct *mm,
>  	unsigned long bd_entry;
>  	unsigned long bt_addr;
>  
> -	if (!access_ok(VERIFY_READ, (bd_entry_ptr), sizeof(*bd_entry_ptr)))
> +	if (!access_ok((bd_entry_ptr), sizeof(*bd_entry_ptr)))
>  		return -EFAULT;
>  
>  	while (1) {
> diff --git a/arch/x86/um/asm/checksum_32.h b/arch/x86/um/asm/checksum_32.h
> index 83a75f8a1233..b9ac7c9eb72c 100644
> --- a/arch/x86/um/asm/checksum_32.h
> +++ b/arch/x86/um/asm/checksum_32.h
> @@ -43,7 +43,7 @@ static __inline__ __wsum csum_and_copy_to_user(const void *src,
>  						     void __user *dst,
>  						     int len, __wsum sum, int *err_ptr)
>  {
> -	if (access_ok(VERIFY_WRITE, dst, len)) {
> +	if (access_ok(dst, len)) {
>  		if (copy_to_user(dst, src, len)) {
>  			*err_ptr = -EFAULT;
>  			return (__force __wsum)-1;
> diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
> index 727ed442e0a5..8b4a71efe7ee 100644
> --- a/arch/x86/um/signal.c
> +++ b/arch/x86/um/signal.c
> @@ -367,7 +367,7 @@ int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
>  	/* This is the same calculation as i386 - ((sp + 4) & 15) == 0 */
>  	stack_top = ((stack_top + 4) & -16UL) - 4;
>  	frame = (struct sigframe __user *) stack_top - 1;
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return 1;
>  
>  	restorer = frame->retcode;
> @@ -412,7 +412,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
>  
>  	stack_top &= -8UL;
>  	frame = (struct rt_sigframe __user *) stack_top - 1;
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		return 1;
>  
>  	restorer = frame->retcode;
> @@ -497,7 +497,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
>  	/* Subtract 128 for a red zone and 8 for proper alignment */
>  	frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128 - 8);
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto out;
>  
>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
> diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
> index 3ae74d7e074b..f302ef57973a 100644
> --- a/arch/xtensa/include/asm/checksum.h
> +++ b/arch/xtensa/include/asm/checksum.h
> @@ -243,7 +243,7 @@ static __inline__ __wsum csum_and_copy_to_user(const void *src,
>  					       void __user *dst, int len,
>  					       __wsum sum, int *err_ptr)
>  {
> -	if (access_ok(VERIFY_WRITE, dst, len))
> +	if (access_ok(dst, len))
>  		return csum_partial_copy_generic(src,dst,len,sum,NULL,err_ptr);
>  
>  	if (len)
> diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
> index fd0eef6b8e7c..505d09eff184 100644
> --- a/arch/xtensa/include/asm/futex.h
> +++ b/arch/xtensa/include/asm/futex.h
> @@ -93,7 +93,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  {
>  	int ret = 0;
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  #if !XCHAL_HAVE_S32C1I
> diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
> index d11ef2939652..4b2480304bc3 100644
> --- a/arch/xtensa/include/asm/uaccess.h
> +++ b/arch/xtensa/include/asm/uaccess.h
> @@ -42,7 +42,7 @@
>  #define __user_ok(addr, size) \
>  		(((size) <= TASK_SIZE)&&((addr) <= TASK_SIZE-(size)))
>  #define __access_ok(addr, size) (__kernel_ok || __user_ok((addr), (size)))
> -#define access_ok(type, addr, size) __access_ok((unsigned long)(addr), (size))
> +#define access_ok(addr, size) __access_ok((unsigned long)(addr), (size))
>  
>  #define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
>  
> @@ -86,7 +86,7 @@ extern long __put_user_bad(void);
>  ({									\
>  	long __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
> -	if (access_ok(VERIFY_WRITE, __pu_addr, size))			\
> +	if (access_ok(__pu_addr, size))			\
>  		__put_user_size((x), __pu_addr, (size), __pu_err);	\
>  	__pu_err;							\
>  })
> @@ -183,7 +183,7 @@ __asm__ __volatile__(					\
>  ({									\
>  	long __gu_err = -EFAULT, __gu_val = 0;				\
>  	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
> -	if (access_ok(VERIFY_READ, __gu_addr, size))			\
> +	if (access_ok(__gu_addr, size))			\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;							\
> @@ -269,7 +269,7 @@ __xtensa_clear_user(void *addr, unsigned long size)
>  static inline unsigned long
>  clear_user(void *addr, unsigned long size)
>  {
> -	if (access_ok(VERIFY_WRITE, addr, size))
> +	if (access_ok(addr, size))
>  		return __xtensa_clear_user(addr, size);
>  	return size ? -EFAULT : 0;
>  }
> @@ -284,7 +284,7 @@ extern long __strncpy_user(char *, const char *, long);
>  static inline long
>  strncpy_from_user(char *dst, const char *src, long count)
>  {
> -	if (access_ok(VERIFY_READ, src, 1))
> +	if (access_ok(src, 1))
>  		return __strncpy_user(dst, src, count);
>  	return -EFAULT;
>  }
> diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
> index 74e1682876ac..dc22a238ed9c 100644
> --- a/arch/xtensa/kernel/signal.c
> +++ b/arch/xtensa/kernel/signal.c
> @@ -251,7 +251,7 @@ asmlinkage long xtensa_rt_sigreturn(long a0, long a1, long a2, long a3,
>  
>  	frame = (struct rt_sigframe __user *) regs->areg[1];
>  
> -	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
>  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -348,7 +348,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
>  	if (regs->depc > 64)
>  		panic ("Double exception sys_sigreturn\n");
>  
> -	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame))) {
> +	if (!access_ok(frame, sizeof(*frame))) {
>  		return -EFAULT;
>  	}
>  
> diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
> index 0df4080fa20f..174c11f13bba 100644
> --- a/arch/xtensa/kernel/stacktrace.c
> +++ b/arch/xtensa/kernel/stacktrace.c
> @@ -91,7 +91,7 @@ void xtensa_backtrace_user(struct pt_regs *regs, unsigned int depth,
>  		pc = MAKE_PC_FROM_RA(a0, pc);
>  
>  		/* Check if the region is OK to access. */
> -		if (!access_ok(VERIFY_READ, &SPILL_SLOT(a1, 0), 8))
> +		if (!access_ok(&SPILL_SLOT(a1, 0), 8))
>  			return;
>  		/* Copy a1, a0 from user space stack frame. */
>  		if (__get_user(a0, &SPILL_SLOT(a1, 0)) ||
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index f21c99ec46ee..a2dcd62ea32f 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -614,7 +614,7 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
>  
>  	if (!count)
>  		return 0;
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	while (count > 0) {
> @@ -684,7 +684,7 @@ static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
>  
>  	if (!count)
>  		return 0;
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	while (count > 0) {
> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> index 14e728fbb8a0..ff5394f47587 100644
> --- a/drivers/char/generic_nvram.c
> +++ b/drivers/char/generic_nvram.c
> @@ -44,7 +44,7 @@ static ssize_t read_nvram(struct file *file, char __user *buf,
>  	unsigned int i;
>  	char __user *p = buf;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	if (*ppos >= nvram_len)
>  		return 0;
> @@ -62,7 +62,7 @@ static ssize_t write_nvram(struct file *file, const char __user *buf,
>  	const char __user *p = buf;
>  	char c;
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	if (*ppos >= nvram_len)
>  		return 0;
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 7b4e4de778e4..b08dc50f9f26 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -609,7 +609,7 @@ static ssize_t read_port(struct file *file, char __user *buf,
>  	unsigned long i = *ppos;
>  	char __user *tmp = buf;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	while (count-- > 0 && i < 65536) {
>  		if (__put_user(inb(i), tmp) < 0)
> @@ -627,7 +627,7 @@ static ssize_t write_port(struct file *file, const char __user *buf,
>  	unsigned long i = *ppos;
>  	const char __user *tmp = buf;
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	while (count-- > 0 && i < 65536) {
>  		char c;
> diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
> index a284ae25e69a..76fb434068d4 100644
> --- a/drivers/char/nwflash.c
> +++ b/drivers/char/nwflash.c
> @@ -167,7 +167,7 @@ static ssize_t flash_write(struct file *file, const char __user *buf,
>  	if (count > gbFlashSize - p)
>  		count = gbFlashSize - p;
>  			
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	/*
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index 809507bf8f1c..7a4eb86aedac 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -1445,11 +1445,11 @@ static long cmm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	      _IOC_DIR(cmd), _IOC_READ, _IOC_WRITE, size, cmd);
>  
>  	if (_IOC_DIR(cmd) & _IOC_READ) {
> -		if (!access_ok(VERIFY_WRITE, argp, size))
> +		if (!access_ok(argp, size))
>  			goto out;
>  	}
>  	if (_IOC_DIR(cmd) & _IOC_WRITE) {
> -		if (!access_ok(VERIFY_READ, argp, size))
> +		if (!access_ok(argp, size))
>  			goto out;
>  	}
>  	rc = 0;
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index d64a78ccc03e..b16be8a11d92 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -364,7 +364,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
>  		goto cmd;
>  
>  	/* allocate a physically contiguous buffer to store the CSR blob */
> -	if (!access_ok(VERIFY_WRITE, input.address, input.length) ||
> +	if (!access_ok(input.address, input.length) ||
>  	    input.length > SEV_FW_BLOB_MAX_SIZE) {
>  		ret = -EFAULT;
>  		goto e_free;
> @@ -644,14 +644,14 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp)
>  
>  	/* Allocate a physically contiguous buffer to store the PDH blob. */
>  	if ((input.pdh_cert_len > SEV_FW_BLOB_MAX_SIZE) ||
> -	    !access_ok(VERIFY_WRITE, input.pdh_cert_address, input.pdh_cert_len)) {
> +	    !access_ok(input.pdh_cert_address, input.pdh_cert_len)) {
>  		ret = -EFAULT;
>  		goto e_free;
>  	}
>  
>  	/* Allocate a physically contiguous buffer to store the cert chain blob. */
>  	if ((input.cert_chain_len > SEV_FW_BLOB_MAX_SIZE) ||
> -	    !access_ok(VERIFY_WRITE, input.cert_chain_address, input.cert_chain_len)) {
> +	    !access_ok(input.cert_chain_address, input.cert_chain_len)) {
>  		ret = -EFAULT;
>  		goto e_free;
>  	}
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index d8e185582642..16a7045736a9 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -1094,7 +1094,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
>  		return -EINVAL;
>  
>  	p = (struct fw_cdev_iso_packet __user *)u64_to_uptr(a->packets);
> -	if (!access_ok(VERIFY_READ, p, a->size))
> +	if (!access_ok(p, a->size))
>  		return -EFAULT;
>  
>  	end = (void __user *)p + a->size;
> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
> index 769640940c9f..51ecf7d6da48 100644
> --- a/drivers/firmware/efi/test/efi_test.c
> +++ b/drivers/firmware/efi/test/efi_test.c
> @@ -68,7 +68,7 @@ copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
>  		return 0;
>  	}
>  
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return -EFAULT;
>  
>  	buf = memdup_user(src, len);
> @@ -89,7 +89,7 @@ copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
>  static inline int
>  get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
>  {
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return -EFAULT;
>  
>  	*len = user_ucs2_strsize(src);
> @@ -116,7 +116,7 @@ copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
>  {
>  	size_t len;
>  
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return -EFAULT;
>  
>  	len = user_ucs2_strsize(src);
> @@ -140,7 +140,7 @@ copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
>  	if (!src)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_WRITE, dst, 1))
> +	if (!access_ok(dst, 1))
>  		return -EFAULT;
>  
>  	return copy_to_user(dst, src, len);
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 025aba3ea76c..e18a786fc943 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -369,7 +369,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
>  	if (user_addr + length < user_addr)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, (void __user *)(unsigned long)user_addr,
> +	if (!access_ok((void __user *)(unsigned long)user_addr,
>  		       length))
>  		return -EINVAL;
>  
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index fe5a5578fbf7..d9ca9554844a 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -99,8 +99,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  		return -EINVAL;
>  	}
>  
> -	if (!access_ok(VERIFY_READ,
> -		       (void __user *)(unsigned long)port_pr.buffer_address,
> +	if (!access_ok((void __user *)(unsigned long)port_pr.buffer_address,
>  		       port_pr.buffer_size))
>  		return -EFAULT;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3623538baf6f..be68752c3469 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -158,8 +158,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>  	}
>  
>  	if ((args->ring_base_address) &&
> -		(!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->ring_base_address,
> +		(!access_ok((const void __user *) args->ring_base_address,
>  			sizeof(uint64_t)))) {
>  		pr_err("Can't access ring base address\n");
>  		return -EFAULT;
> @@ -170,31 +169,27 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>  		return -EINVAL;
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->read_pointer_address,
> +	if (!access_ok((const void __user *) args->read_pointer_address,
>  			sizeof(uint32_t))) {
>  		pr_err("Can't access read pointer\n");
>  		return -EFAULT;
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->write_pointer_address,
> +	if (!access_ok((const void __user *) args->write_pointer_address,
>  			sizeof(uint32_t))) {
>  		pr_err("Can't access write pointer\n");
>  		return -EFAULT;
>  	}
>  
>  	if (args->eop_buffer_address &&
> -		!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->eop_buffer_address,
> +		!access_ok((const void __user *) args->eop_buffer_address,
>  			sizeof(uint32_t))) {
>  		pr_debug("Can't access eop buffer");
>  		return -EFAULT;
>  	}
>  
>  	if (args->ctx_save_restore_address &&
> -		!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->ctx_save_restore_address,
> +		!access_ok((const void __user *) args->ctx_save_restore_address,
>  			sizeof(uint32_t))) {
>  		pr_debug("Can't access ctx save restore buffer");
>  		return -EFAULT;
> @@ -365,8 +360,7 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>  	}
>  
>  	if ((args->ring_base_address) &&
> -		(!access_ok(VERIFY_WRITE,
> -			(const void __user *) args->ring_base_address,
> +		(!access_ok((const void __user *) args->ring_base_address,
>  			sizeof(uint64_t)))) {
>  		pr_err("Can't access ring base address\n");
>  		return -EFAULT;
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> index 892c1d9304bb..642d0e70d0f8 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -334,7 +334,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
>  
>  	ptr = (char __user *)(uintptr_t)args->ptr;
>  
> -	if (!access_ok(VERIFY_READ, ptr, args->size))
> +	if (!access_ok(ptr, args->size))
>  		return -EFAULT;
>  
>  	ret = fault_in_pages_readable(ptr, args->size);
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ffa8dc35515f..46f48f245eb5 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -525,7 +525,7 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
>  	struct drm_device *dev = file_priv->minor->dev;
>  	ssize_t ret;
>  
> -	if (!access_ok(VERIFY_WRITE, buffer, count))
> +	if (!access_ok(buffer, count))
>  		return -EFAULT;
>  
>  	ret = mutex_lock_interruptible(&file_priv->event_read_lock);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 96efc84396bf..18c27f795cf6 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -339,7 +339,6 @@ static int etnaviv_ioctl_gem_userptr(struct drm_device *dev, void *data,
>  	struct drm_file *file)
>  {
>  	struct drm_etnaviv_gem_userptr *args = data;
> -	int access;
>  
>  	if (args->flags & ~(ETNA_USERPTR_READ|ETNA_USERPTR_WRITE) ||
>  	    args->flags == 0)
> @@ -351,12 +350,7 @@ static int etnaviv_ioctl_gem_userptr(struct drm_device *dev, void *data,
>  	    args->user_ptr & ~PAGE_MASK)
>  		return -EINVAL;
>  
> -	if (args->flags & ETNA_USERPTR_WRITE)
> -		access = VERIFY_WRITE;
> -	else
> -		access = VERIFY_READ;
> -
> -	if (!access_ok(access, (void __user *)(unsigned long)args->user_ptr,
> +	if (!access_ok((void __user *)(unsigned long)args->user_ptr,
>  		       args->user_size))
>  		return -EFAULT;
>  
> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> index a9de07bb72c8..216f52b744a6 100644
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -1282,8 +1282,7 @@ i915_gem_pread_ioctl(struct drm_device *dev, void *data,
>  	if (args->size == 0)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_WRITE,
> -		       u64_to_user_ptr(args->data_ptr),
> +	if (!access_ok(u64_to_user_ptr(args->data_ptr),
>  		       args->size))
>  		return -EFAULT;
>  
> @@ -1609,9 +1608,7 @@ i915_gem_pwrite_ioctl(struct drm_device *dev, void *data,
>  	if (args->size == 0)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_READ,
> -		       u64_to_user_ptr(args->data_ptr),
> -		       args->size))
> +	if (!access_ok(u64_to_user_ptr(args->data_ptr), args->size))
>  		return -EFAULT;
>  
>  	obj = i915_gem_object_lookup(file, args->handle);
> diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> index 8ff6b581cf1c..fee66ccebed6 100644
> --- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> @@ -1447,7 +1447,7 @@ static int eb_relocate_vma(struct i915_execbuffer *eb, struct i915_vma *vma)
>  	 * to read. However, if the array is not writable the user loses
>  	 * the updated relocation values.
>  	 */
> -	if (unlikely(!access_ok(VERIFY_READ, urelocs, remain*sizeof(*urelocs))))
> +	if (unlikely(!access_ok(urelocs, remain*sizeof(*urelocs))))
>  		return -EFAULT;
>  
>  	do {
> @@ -1554,7 +1554,7 @@ static int check_relocations(const struct drm_i915_gem_exec_object2 *entry)
>  
>  	addr = u64_to_user_ptr(entry->relocs_ptr);
>  	size *= sizeof(struct drm_i915_gem_relocation_entry);
> -	if (!access_ok(VERIFY_READ, addr, size))
> +	if (!access_ok(addr, size))
>  		return -EFAULT;
>  
>  	end = addr + size;
> @@ -2090,7 +2090,7 @@ get_fence_array(struct drm_i915_gem_execbuffer2 *args,
>  		return ERR_PTR(-EINVAL);
>  
>  	user = u64_to_user_ptr(args->cliprects_ptr);
> -	if (!access_ok(VERIFY_READ, user, nfences * sizeof(*user)))
> +	if (!access_ok(user, nfences * sizeof(*user)))
>  		return ERR_PTR(-EFAULT);
>  
>  	fences = kvmalloc_array(nfences, sizeof(*fences),
> diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
> index 3df77020aada..9558582c105e 100644
> --- a/drivers/gpu/drm/i915/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
> @@ -789,8 +789,7 @@ i915_gem_userptr_ioctl(struct drm_device *dev,
>  	if (offset_in_page(args->user_ptr | args->user_size))
>  		return -EINVAL;
>  
> -	if (!access_ok(args->flags & I915_USERPTR_READ_ONLY ? VERIFY_READ : VERIFY_WRITE,
> -		       (char __user *)(unsigned long)args->user_ptr, args->user_size))
> +	if (!access_ok((char __user *)(unsigned long)args->user_ptr, args->user_size))
>  		return -EFAULT;
>  
>  	if (args->flags & I915_USERPTR_READ_ONLY) {
> diff --git a/drivers/gpu/drm/i915/i915_ioc32.c b/drivers/gpu/drm/i915/i915_ioc32.c
> index 0e5c580d117c..e869daf9c8a9 100644
> --- a/drivers/gpu/drm/i915/i915_ioc32.c
> +++ b/drivers/gpu/drm/i915/i915_ioc32.c
> @@ -52,7 +52,7 @@ static int compat_i915_getparam(struct file *file, unsigned int cmd,
>  		return -EFAULT;
>  
>  	request = compat_alloc_user_space(sizeof(*request));
> -	if (!access_ok(VERIFY_WRITE, request, sizeof(*request)) ||
> +	if (!access_ok(request, sizeof(*request)) ||
>  	    __put_user(req32.param, &request->param) ||
>  	    __put_user((void __user *)(unsigned long)req32.value,
>  		       &request->value))
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 4529edfdcfc8..2b2eb57ca71f 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -3052,7 +3052,7 @@ static struct i915_oa_reg *alloc_oa_regs(struct drm_i915_private *dev_priv,
>  	if (!n_regs)
>  		return NULL;
>  
> -	if (!access_ok(VERIFY_READ, regs, n_regs * sizeof(u32) * 2))
> +	if (!access_ok(regs, n_regs * sizeof(u32) * 2))
>  		return ERR_PTR(-EFAULT);
>  
>  	/* No is_valid function means we're not allowing any register to be programmed. */
> diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> index 6fc4b8eeab42..fe56465cdfd6 100644
> --- a/drivers/gpu/drm/i915/i915_query.c
> +++ b/drivers/gpu/drm/i915/i915_query.c
> @@ -46,7 +46,7 @@ static int query_topology_info(struct drm_i915_private *dev_priv,
>  	if (topo.flags != 0)
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, u64_to_user_ptr(query_item->data_ptr),
> +	if (!access_ok(u64_to_user_ptr(query_item->data_ptr),
>  		       total_length))
>  		return -EFAULT;
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index a28465d90529..12b983fc0b56 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -77,7 +77,7 @@ void msm_gem_submit_free(struct msm_gem_submit *submit)
>  static inline unsigned long __must_check
>  copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> -	if (access_ok(VERIFY_READ, from, n))
> +	if (access_ok(from, n))
>  		return __copy_from_user_inatomic(to, from, n);
>  	return -EFAULT;
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index 6e828158bcb0..d410e2925162 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -163,8 +163,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
>  	if (cmd->command_size > PAGE_SIZE - sizeof(union qxl_release_info))
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_READ,
> -		       u64_to_user_ptr(cmd->command),
> +	if (!access_ok(u64_to_user_ptr(cmd->command),
>  		       cmd->command_size))
>  		return -EFAULT;
>  
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 9f9172eb1512..fb0007aa0c27 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -611,8 +611,7 @@ static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
>  			if (hdr->out_words * 8 < method_elm->resp_size)
>  				return -ENOSPC;
>  
> -			if (!access_ok(VERIFY_WRITE,
> -				       u64_to_user_ptr(ex_hdr->response),
> +			if (!access_ok(u64_to_user_ptr(ex_hdr->response),
>  				       (hdr->out_words + ex_hdr->provider_out_words) * 8))
>  				return -EFAULT;
>  		} else {
> diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> index dbe7d14a5c76..0cd71ce7cc71 100644
> --- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> +++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> @@ -232,7 +232,7 @@ static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
>  	}
>  
>  	/* Verify that access is OK for the user buffer */
> -	if (!access_ok(VERIFY_WRITE, (void __user *)vaddr,
> +	if (!access_ok((void __user *)vaddr,
>  		       npages * PAGE_SIZE)) {
>  		dd_dev_err(dd, "Fail vaddr %p, %u pages, !access_ok\n",
>  			   (void *)vaddr, npages);
> diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
> index 98e1ce14fa2a..78fa634de98a 100644
> --- a/drivers/infiniband/hw/qib/qib_file_ops.c
> +++ b/drivers/infiniband/hw/qib/qib_file_ops.c
> @@ -343,7 +343,7 @@ static int qib_tid_update(struct qib_ctxtdata *rcd, struct file *fp,
>  
>  	/* virtual address of first page in transfer */
>  	vaddr = ti->tidvaddr;
> -	if (!access_ok(VERIFY_WRITE, (void __user *) vaddr,
> +	if (!access_ok((void __user *) vaddr,
>  		       cnt * PAGE_SIZE)) {
>  		ret = -EFAULT;
>  		goto done;
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index ef0c2366cf59..400960cf04d5 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -64,7 +64,7 @@ anslcd_write( struct file * file, const char __user * buf,
>  	printk(KERN_DEBUG "LCD: write\n");
>  #endif
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	mutex_lock(&anslcd_mutex);
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index ac0cf37d6239..21d532a78fa4 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -2188,7 +2188,7 @@ pmu_read(struct file *file, char __user *buf,
>  
>  	if (count < 1 || !pp)
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	spin_lock_irqsave(&pp->lock, flags);
> diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
> index 3e02de02ffdd..8ec2525d8ef5 100644
> --- a/drivers/media/pci/ivtv/ivtvfb.c
> +++ b/drivers/media/pci/ivtv/ivtvfb.c
> @@ -356,7 +356,7 @@ static int ivtvfb_prep_frame(struct ivtv *itv, int cmd, void __user *source,
>  		IVTVFB_WARN("ivtvfb_prep_frame: Count not a multiple of 4 (%d)\n", count);
>  
>  	/* Check Source */
> -	if (!access_ok(VERIFY_READ, source + dest_offset, count)) {
> +	if (!access_ok(source + dest_offset, count)) {
>  		IVTVFB_WARN("Invalid userspace pointer %p\n", source);
>  
>  		IVTVFB_DEBUG_WARN("access_ok() failed for offset 0x%08lx source %p count %d\n",
> diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> index fe4577a46869..73dac1d8d4f6 100644
> --- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> +++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> @@ -158,7 +158,7 @@ static int get_v4l2_window32(struct v4l2_window __user *p64,
>  	compat_caddr_t p;
>  	u32 clipcount;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    copy_in_user(&p64->w, &p32->w, sizeof(p32->w)) ||
>  	    assign_in_user(&p64->field, &p32->field) ||
>  	    assign_in_user(&p64->chromakey, &p32->chromakey) ||
> @@ -283,7 +283,7 @@ static int __bufsize_v4l2_format(struct v4l2_format32 __user *p32, u32 *size)
>  
>  static int bufsize_v4l2_format(struct v4l2_format32 __user *p32, u32 *size)
>  {
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)))
> +	if (!access_ok(p32, sizeof(*p32)))
>  		return -EFAULT;
>  	return __bufsize_v4l2_format(p32, size);
>  }
> @@ -335,7 +335,7 @@ static int get_v4l2_format32(struct v4l2_format __user *p64,
>  			     struct v4l2_format32 __user *p32,
>  			     void __user *aux_buf, u32 aux_space)
>  {
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)))
> +	if (!access_ok(p32, sizeof(*p32)))
>  		return -EFAULT;
>  	return __get_v4l2_format32(p64, p32, aux_buf, aux_space);
>  }
> @@ -343,7 +343,7 @@ static int get_v4l2_format32(struct v4l2_format __user *p64,
>  static int bufsize_v4l2_create(struct v4l2_create_buffers32 __user *p32,
>  			       u32 *size)
>  {
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)))
> +	if (!access_ok(p32, sizeof(*p32)))
>  		return -EFAULT;
>  	return __bufsize_v4l2_format(&p32->format, size);
>  }
> @@ -352,7 +352,7 @@ static int get_v4l2_create32(struct v4l2_create_buffers __user *p64,
>  			     struct v4l2_create_buffers32 __user *p32,
>  			     void __user *aux_buf, u32 aux_space)
>  {
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    copy_in_user(p64, p32,
>  			 offsetof(struct v4l2_create_buffers32, format)))
>  		return -EFAULT;
> @@ -404,7 +404,7 @@ static int __put_v4l2_format32(struct v4l2_format __user *p64,
>  static int put_v4l2_format32(struct v4l2_format __user *p64,
>  			     struct v4l2_format32 __user *p32)
>  {
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)))
> +	if (!access_ok(p32, sizeof(*p32)))
>  		return -EFAULT;
>  	return __put_v4l2_format32(p64, p32);
>  }
> @@ -412,7 +412,7 @@ static int put_v4l2_format32(struct v4l2_format __user *p64,
>  static int put_v4l2_create32(struct v4l2_create_buffers __user *p64,
>  			     struct v4l2_create_buffers32 __user *p32)
>  {
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    copy_in_user(p32, p64,
>  			 offsetof(struct v4l2_create_buffers32, format)) ||
>  	    assign_in_user(&p32->capabilities, &p64->capabilities) ||
> @@ -434,7 +434,7 @@ static int get_v4l2_standard32(struct v4l2_standard __user *p64,
>  			       struct v4l2_standard32 __user *p32)
>  {
>  	/* other fields are not set by the user, nor used by the driver */
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p64->index, &p32->index))
>  		return -EFAULT;
>  	return 0;
> @@ -443,7 +443,7 @@ static int get_v4l2_standard32(struct v4l2_standard __user *p64,
>  static int put_v4l2_standard32(struct v4l2_standard __user *p64,
>  			       struct v4l2_standard32 __user *p32)
>  {
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p32->index, &p64->index) ||
>  	    assign_in_user(&p32->id, &p64->id) ||
>  	    copy_in_user(p32->name, p64->name, sizeof(p32->name)) ||
> @@ -560,7 +560,7 @@ static int bufsize_v4l2_buffer(struct v4l2_buffer32 __user *p32, u32 *size)
>  	u32 type;
>  	u32 length;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    get_user(type, &p32->type) ||
>  	    get_user(length, &p32->length))
>  		return -EFAULT;
> @@ -593,7 +593,7 @@ static int get_v4l2_buffer32(struct v4l2_buffer __user *p64,
>  	compat_caddr_t p;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p64->index, &p32->index) ||
>  	    get_user(type, &p32->type) ||
>  	    put_user(type, &p64->type) ||
> @@ -632,7 +632,7 @@ static int get_v4l2_buffer32(struct v4l2_buffer __user *p64,
>  			return -EFAULT;
>  
>  		uplane32 = compat_ptr(p);
> -		if (!access_ok(VERIFY_READ, uplane32,
> +		if (!access_ok(uplane32,
>  			       num_planes * sizeof(*uplane32)))
>  			return -EFAULT;
>  
> @@ -691,7 +691,7 @@ static int put_v4l2_buffer32(struct v4l2_buffer __user *p64,
>  	compat_caddr_t p;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p32->index, &p64->index) ||
>  	    get_user(type, &p64->type) ||
>  	    put_user(type, &p32->type) ||
> @@ -781,7 +781,7 @@ static int get_v4l2_framebuffer32(struct v4l2_framebuffer __user *p64,
>  {
>  	compat_caddr_t tmp;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    get_user(tmp, &p32->base) ||
>  	    put_user_force(compat_ptr(tmp), &p64->base) ||
>  	    assign_in_user(&p64->capability, &p32->capability) ||
> @@ -796,7 +796,7 @@ static int put_v4l2_framebuffer32(struct v4l2_framebuffer __user *p64,
>  {
>  	void *base;
>  
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    get_user(base, &p64->base) ||
>  	    put_user(ptr_to_compat((void __user *)base), &p32->base) ||
>  	    assign_in_user(&p32->capability, &p64->capability) ||
> @@ -893,7 +893,7 @@ static int bufsize_v4l2_ext_controls(struct v4l2_ext_controls32 __user *p32,
>  {
>  	u32 count;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    get_user(count, &p32->count))
>  		return -EFAULT;
>  	if (count > V4L2_CID_MAX_CTRLS)
> @@ -913,7 +913,7 @@ static int get_v4l2_ext_controls32(struct file *file,
>  	u32 n;
>  	compat_caddr_t p;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p64->which, &p32->which) ||
>  	    get_user(count, &p32->count) ||
>  	    put_user(count, &p64->count) ||
> @@ -929,7 +929,7 @@ static int get_v4l2_ext_controls32(struct file *file,
>  	if (get_user(p, &p32->controls))
>  		return -EFAULT;
>  	ucontrols = compat_ptr(p);
> -	if (!access_ok(VERIFY_READ, ucontrols, count * sizeof(*ucontrols)))
> +	if (!access_ok(ucontrols, count * sizeof(*ucontrols)))
>  		return -EFAULT;
>  	if (aux_space < count * sizeof(*kcontrols))
>  		return -EFAULT;
> @@ -979,7 +979,7 @@ static int put_v4l2_ext_controls32(struct file *file,
>  	 * with __user causes smatch warnings, so instead declare it
>  	 * without __user and cast it as a userspace pointer where needed.
>  	 */
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p32->which, &p64->which) ||
>  	    get_user(count, &p64->count) ||
>  	    put_user(count, &p32->count) ||
> @@ -994,7 +994,7 @@ static int put_v4l2_ext_controls32(struct file *file,
>  	if (get_user(p, &p32->controls))
>  		return -EFAULT;
>  	ucontrols = compat_ptr(p);
> -	if (!access_ok(VERIFY_WRITE, ucontrols, count * sizeof(*ucontrols)))
> +	if (!access_ok(ucontrols, count * sizeof(*ucontrols)))
>  		return -EFAULT;
>  
>  	for (n = 0; n < count; n++) {
> @@ -1043,7 +1043,7 @@ struct v4l2_event32 {
>  static int put_v4l2_event32(struct v4l2_event __user *p64,
>  			    struct v4l2_event32 __user *p32)
>  {
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p32->type, &p64->type) ||
>  	    copy_in_user(&p32->u, &p64->u, sizeof(p64->u)) ||
>  	    assign_in_user(&p32->pending, &p64->pending) ||
> @@ -1069,7 +1069,7 @@ static int get_v4l2_edid32(struct v4l2_edid __user *p64,
>  {
>  	compat_uptr_t tmp;
>  
> -	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p64->pad, &p32->pad) ||
>  	    assign_in_user(&p64->start_block, &p32->start_block) ||
>  	    assign_in_user_cast(&p64->blocks, &p32->blocks) ||
> @@ -1085,7 +1085,7 @@ static int put_v4l2_edid32(struct v4l2_edid __user *p64,
>  {
>  	void *edid;
>  
> -	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
> +	if (!access_ok(p32, sizeof(*p32)) ||
>  	    assign_in_user(&p32->pad, &p64->pad) ||
>  	    assign_in_user(&p32->start_block, &p64->start_block) ||
>  	    assign_in_user(&p32->blocks, &p64->blocks) ||
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> index 5da1f3e3f997..997f92543dd4 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -236,7 +236,7 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
>  	 * about the size.
>  	 */
>  	BUILD_BUG_ON(sizeof(bool) != sizeof(u8));
> -	if (!access_ok(VERIFY_WRITE, (void __user *)uva, sizeof(u8)))
> +	if (!access_ok((void __user *)uva, sizeof(u8)))
>  		return VMCI_ERROR_GENERIC;
>  
>  	/*
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 7ac035af39f0..6fa1627ce08d 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -52,7 +52,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  		nbytes = size - pos;
>  	cnt = nbytes;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, cnt))
> +	if (!access_ok(buf, cnt))
>  		return -EINVAL;
>  
>  	pci_config_pm_runtime_get(dev);
> @@ -125,7 +125,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  		nbytes = size - pos;
>  	cnt = nbytes;
>  
> -	if (!access_ok(VERIFY_READ, buf, cnt))
> +	if (!access_ok(buf, cnt))
>  		return -EINVAL;
>  
>  	pci_config_pm_runtime_get(dev);
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index 7c639006252e..321bc673c417 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -416,8 +416,7 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
>  	if (unlikely(bufflen == 0))
>  		return 0;
>  	/* Check the buffer range for access */
> -	if (unlikely(!access_ok(is_write ? VERIFY_WRITE : VERIFY_READ,
> -				buffer, bufflen)))
> +	if (unlikely(!access_ok(buffer, bufflen)))
>  		return -EFAULT;
>  
>  	address = (unsigned long)buffer;
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 262285e48a09..051613140812 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -47,7 +47,7 @@ static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
>  		nbytes = size - pos;
>  	cnt = nbytes;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, cnt))
> +	if (!access_ok(buf, cnt))
>  		return -EINVAL;
>  
>  	isapnp_cfg_begin(dev->card->number, dev->number);
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> index 7c4673308f5b..e338d7a4f571 100644
> --- a/drivers/scsi/pmcraid.c
> +++ b/drivers/scsi/pmcraid.c
> @@ -3600,7 +3600,7 @@ static long pmcraid_ioctl_passthrough(
>  	u32 ioasc;
>  	int request_size;
>  	int buffer_size;
> -	u8 access, direction;
> +	u8 direction;
>  	int rc = 0;
>  
>  	/* If IOA reset is in progress, wait 10 secs for reset to complete */
> @@ -3649,10 +3649,8 @@ static long pmcraid_ioctl_passthrough(
>  	request_size = le32_to_cpu(buffer->ioarcb.data_transfer_length);
>  
>  	if (buffer->ioarcb.request_flags0 & TRANSFER_DIR_WRITE) {
> -		access = VERIFY_READ;
>  		direction = DMA_TO_DEVICE;
>  	} else {
> -		access = VERIFY_WRITE;
>  		direction = DMA_FROM_DEVICE;
>  	}
>  
> diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
> index cc30fccc1a2e..840d96fe81bc 100644
> --- a/drivers/scsi/scsi_ioctl.c
> +++ b/drivers/scsi/scsi_ioctl.c
> @@ -221,7 +221,7 @@ int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
>  
>  	switch (cmd) {
>  	case SCSI_IOCTL_GET_IDLUN:
> -		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
> +		if (!access_ok(arg, sizeof(struct scsi_idlun)))
>  			return -EFAULT;
>  
>  		__put_user((sdev->id & 0xff)
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 4e27460ec926..d3f15319b9b3 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -434,7 +434,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
>  	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
>  				      "sg_read: count=%d\n", (int) count));
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
>  		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
> @@ -632,7 +632,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>  	      scsi_block_when_processing_errors(sdp->device)))
>  		return -ENXIO;
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
>  	if (count < SZ_SG_HEADER)
>  		return -EIO;
> @@ -729,7 +729,7 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char __user *buf,
>  
>  	if (count < SZ_SG_IO_HDR)
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT; /* protects following copy_from_user()s + get_user()s */
>  
>  	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
> @@ -768,7 +768,7 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char __user *buf,
>  		sg_remove_request(sfp, srp);
>  		return -EMSGSIZE;
>  	}
> -	if (!access_ok(VERIFY_READ, hp->cmdp, hp->cmd_len)) {
> +	if (!access_ok(hp->cmdp, hp->cmd_len)) {
>  		sg_remove_request(sfp, srp);
>  		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
>  	}
> @@ -922,7 +922,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>  			return -ENODEV;
>  		if (!scsi_block_when_processing_errors(sdp->device))
>  			return -ENXIO;
> -		if (!access_ok(VERIFY_WRITE, p, SZ_SG_IO_HDR))
> +		if (!access_ok(p, SZ_SG_IO_HDR))
>  			return -EFAULT;
>  		result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
>  				 1, read_only, 1, &srp);
> @@ -968,7 +968,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>  	case SG_GET_LOW_DMA:
>  		return put_user((int) sdp->device->host->unchecked_isa_dma, ip);
>  	case SG_GET_SCSI_ID:
> -		if (!access_ok(VERIFY_WRITE, p, sizeof (sg_scsi_id_t)))
> +		if (!access_ok(p, sizeof (sg_scsi_id_t)))
>  			return -EFAULT;
>  		else {
>  			sg_scsi_id_t __user *sg_idp = p;
> @@ -997,7 +997,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>  		sfp->force_packid = val ? 1 : 0;
>  		return 0;
>  	case SG_GET_PACK_ID:
> -		if (!access_ok(VERIFY_WRITE, ip, sizeof (int)))
> +		if (!access_ok(ip, sizeof (int)))
>  			return -EFAULT;
>  		read_lock_irqsave(&sfp->rq_list_lock, iflags);
>  		list_for_each_entry(srp, &sfp->rq_list, entry) {
> @@ -1078,7 +1078,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>  		val = (sdp->device ? 1 : 0);
>  		return put_user(val, ip);
>  	case SG_GET_REQUEST_TABLE:
> -		if (!access_ok(VERIFY_WRITE, p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
> +		if (!access_ok(p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
>  			return -EFAULT;
>  		else {
>  			sg_req_info_t *rinfo;
> diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
> index fa9d239474ee..36a3564ba1fb 100644
> --- a/drivers/staging/comedi/comedi_compat32.c
> +++ b/drivers/staging/comedi/comedi_compat32.c
> @@ -102,8 +102,8 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
>  	chaninfo = compat_alloc_user_space(sizeof(*chaninfo));
>  
>  	/* Copy chaninfo structure.  Ignore unused members. */
> -	if (!access_ok(VERIFY_READ, chaninfo32, sizeof(*chaninfo32)) ||
> -	    !access_ok(VERIFY_WRITE, chaninfo, sizeof(*chaninfo)))
> +	if (!access_ok(chaninfo32, sizeof(*chaninfo32)) ||
> +	    !access_ok(chaninfo, sizeof(*chaninfo)))
>  		return -EFAULT;
>  
>  	err = 0;
> @@ -136,8 +136,8 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
>  	rangeinfo = compat_alloc_user_space(sizeof(*rangeinfo));
>  
>  	/* Copy rangeinfo structure. */
> -	if (!access_ok(VERIFY_READ, rangeinfo32, sizeof(*rangeinfo32)) ||
> -	    !access_ok(VERIFY_WRITE, rangeinfo, sizeof(*rangeinfo)))
> +	if (!access_ok(rangeinfo32, sizeof(*rangeinfo32)) ||
> +	    !access_ok(rangeinfo, sizeof(*rangeinfo)))
>  		return -EFAULT;
>  
>  	err = 0;
> @@ -163,8 +163,8 @@ static int get_compat_cmd(struct comedi_cmd __user *cmd,
>  	} temp;
>  
>  	/* Copy cmd structure. */
> -	if (!access_ok(VERIFY_READ, cmd32, sizeof(*cmd32)) ||
> -	    !access_ok(VERIFY_WRITE, cmd, sizeof(*cmd)))
> +	if (!access_ok(cmd32, sizeof(*cmd32)) ||
> +	    !access_ok(cmd, sizeof(*cmd)))
>  		return -EFAULT;
>  
>  	err = 0;
> @@ -217,8 +217,8 @@ static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
>  	 * Assume the pointer values are already valid.
>  	 * (Could use ptr_to_compat() to set them.)
>  	 */
> -	if (!access_ok(VERIFY_READ, cmd, sizeof(*cmd)) ||
> -	    !access_ok(VERIFY_WRITE, cmd32, sizeof(*cmd32)))
> +	if (!access_ok(cmd, sizeof(*cmd)) ||
> +	    !access_ok(cmd32, sizeof(*cmd32)))
>  		return -EFAULT;
>  
>  	err = 0;
> @@ -317,8 +317,8 @@ static int get_compat_insn(struct comedi_insn __user *insn,
>  
>  	/* Copy insn structure.  Ignore the unused members. */
>  	err = 0;
> -	if (!access_ok(VERIFY_READ, insn32, sizeof(*insn32)) ||
> -	    !access_ok(VERIFY_WRITE, insn, sizeof(*insn)))
> +	if (!access_ok(insn32, sizeof(*insn32)) ||
> +	    !access_ok(insn, sizeof(*insn)))
>  		return -EFAULT;
>  
>  	err |= __get_user(temp.uint, &insn32->insn);
> @@ -350,7 +350,7 @@ static int compat_insnlist(struct file *file, unsigned long arg)
>  	insnlist32 = compat_ptr(arg);
>  
>  	/* Get 32-bit insnlist structure.  */
> -	if (!access_ok(VERIFY_READ, insnlist32, sizeof(*insnlist32)))
> +	if (!access_ok(insnlist32, sizeof(*insnlist32)))
>  		return -EFAULT;
>  
>  	err = 0;
> @@ -365,7 +365,7 @@ static int compat_insnlist(struct file *file, unsigned long arg)
>  					     insn[n_insns]));
>  
>  	/* Set native insnlist structure. */
> -	if (!access_ok(VERIFY_WRITE, &s->insnlist, sizeof(s->insnlist)))
> +	if (!access_ok(&s->insnlist, sizeof(s->insnlist)))
>  		return -EFAULT;
>  
>  	err |= __put_user(n_insns, &s->insnlist.n_insns);
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index 99460af61b77..4164414d4c64 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -573,7 +573,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
>  		return -EIO;
>  
>  	/* verify user access to buffer */
> -	if (!access_ok(VERIFY_WRITE, buf, nr)) {
> +	if (!access_ok(buf, nr)) {
>  		printk(KERN_WARNING "%s(%d) n_hdlc_tty_read() can't verify user "
>  		"buffer\n", __FILE__, __LINE__);
>  		return -EFAULT;
> diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
> index 3de3c750b5f6..44f28a114c2b 100644
> --- a/drivers/usb/core/devices.c
> +++ b/drivers/usb/core/devices.c
> @@ -598,7 +598,7 @@ static ssize_t usb_device_read(struct file *file, char __user *buf,
>  		return -EINVAL;
>  	if (nbytes <= 0)
>  		return 0;
> -	if (!access_ok(VERIFY_WRITE, buf, nbytes))
> +	if (!access_ok(buf, nbytes))
>  		return -EFAULT;
>  
>  	mutex_lock(&usb_bus_idr_lock);
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index a75bc0b8a50f..d65566341dd1 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1094,7 +1094,7 @@ static int proc_control(struct usb_dev_state *ps, void __user *arg)
>  		ctrl.bRequestType, ctrl.bRequest, ctrl.wValue,
>  		ctrl.wIndex, ctrl.wLength);
>  	if (ctrl.bRequestType & 0x80) {
> -		if (ctrl.wLength && !access_ok(VERIFY_WRITE, ctrl.data,
> +		if (ctrl.wLength && !access_ok(ctrl.data,
>  					       ctrl.wLength)) {
>  			ret = -EINVAL;
>  			goto done;
> @@ -1183,7 +1183,7 @@ static int proc_bulk(struct usb_dev_state *ps, void __user *arg)
>  	}
>  	tmo = bulk.timeout;
>  	if (bulk.ep & 0x80) {
> -		if (len1 && !access_ok(VERIFY_WRITE, bulk.data, len1)) {
> +		if (len1 && !access_ok(bulk.data, len1)) {
>  			ret = -EINVAL;
>  			goto done;
>  		}
> @@ -1584,8 +1584,7 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
>  	}
>  
>  	if (uurb->buffer_length > 0 &&
> -			!access_ok(is_in ? VERIFY_WRITE : VERIFY_READ,
> -				uurb->buffer, uurb->buffer_length)) {
> +			!access_ok(uurb->buffer, uurb->buffer_length)) {
>  		ret = -EFAULT;
>  		goto error;
>  	}
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 54e859dcb25c..75b113a5b25c 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -252,7 +252,7 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
>  	if (!count)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_WRITE, buffer, count))
> +	if (!access_ok(buffer, count))
>  		return -EFAULT;
>  
>  	spin_lock_irqsave(&hidg->read_spinlock, flags);
> @@ -339,7 +339,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
>  	unsigned long flags;
>  	ssize_t status = -ENOMEM;
>  
> -	if (!access_ok(VERIFY_READ, buffer, count))
> +	if (!access_ok(buffer, count))
>  		return -EFAULT;
>  
>  	spin_lock_irqsave(&hidg->write_spinlock, flags);
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 11247322d587..660712e0bf98 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -88,7 +88,7 @@ static ssize_t queue_dbg_read(struct file *file, char __user *buf,
>  	size_t len, remaining, actual = 0;
>  	char tmpbuf[38];
>  
> -	if (!access_ok(VERIFY_WRITE, buf, nbytes))
> +	if (!access_ok(buf, nbytes))
>  		return -EFAULT;
>  
>  	inode_lock(file_inode(file));
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 55e5aa662ad5..9f7942cbcbb2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -655,7 +655,7 @@ static bool log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
>  	    a + (unsigned long)log_base > ULONG_MAX)
>  		return false;
>  
> -	return access_ok(VERIFY_WRITE, log_base + a,
> +	return access_ok(log_base + a,
>  			 (sz + VHOST_PAGE_SIZE * 8 - 1) / VHOST_PAGE_SIZE / 8);
>  }
>  
> @@ -681,7 +681,7 @@ static bool vq_memory_access_ok(void __user *log_base, struct vhost_umem *umem,
>  			return false;
>  
>  
> -		if (!access_ok(VERIFY_WRITE, (void __user *)a,
> +		if (!access_ok((void __user *)a,
>  				    node->size))
>  			return false;
>  		else if (log_all && !log_access_ok(log_base,
> @@ -973,10 +973,10 @@ static bool umem_access_ok(u64 uaddr, u64 size, int access)
>  		return false;
>  
>  	if ((access & VHOST_ACCESS_RO) &&
> -	    !access_ok(VERIFY_READ, (void __user *)a, size))
> +	    !access_ok((void __user *)a, size))
>  		return false;
>  	if ((access & VHOST_ACCESS_WO) &&
> -	    !access_ok(VERIFY_WRITE, (void __user *)a, size))
> +	    !access_ok((void __user *)a, size))
>  		return false;
>  	return true;
>  }
> @@ -1185,10 +1185,10 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
>  {
>  	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>  
> -	return access_ok(VERIFY_READ, desc, num * sizeof *desc) &&
> -	       access_ok(VERIFY_READ, avail,
> +	return access_ok(desc, num * sizeof *desc) &&
> +	       access_ok(avail,
>  			 sizeof *avail + num * sizeof *avail->ring + s) &&
> -	       access_ok(VERIFY_WRITE, used,
> +	       access_ok(used,
>  			sizeof *used + num * sizeof *used->ring + s);
>  }
>  
> @@ -1814,7 +1814,7 @@ int vhost_vq_init_access(struct vhost_virtqueue *vq)
>  		goto err;
>  	vq->signalled_used_valid = false;
>  	if (!vq->iotlb &&
> -	    !access_ok(VERIFY_READ, &vq->used->idx, sizeof vq->used->idx)) {
> +	    !access_ok(&vq->used->idx, sizeof vq->used->idx)) {
>  		r = -EFAULT;
>  		goto err;
>  	}
> diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
> index 0777aff211e5..758457026694 100644
> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -1855,7 +1855,7 @@ static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var,
>  	var->yspot = par->crsr.spot_y;
>  	if (size > var->height * var->width)
>  		return -ENAMETOOLONG;
> -	if (!access_ok(VERIFY_WRITE, data, size))
> +	if (!access_ok(data, size))
>  		return -EFAULT;
>  	delta = 1 << par->crsr.fmode;
>  	lspr = lofsprite + (delta << 1);
> @@ -1935,7 +1935,7 @@ static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var,
>  		return -EINVAL;
>  	if (!var->height)
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_READ, data, var->width * var->height))
> +	if (!access_ok(data, var->width * var->height))
>  		return -EFAULT;
>  	delta = 1 << fmode;
>  	lofsprite = shfsprite = (u_short *)spritememory;
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index a3edb20ea4c3..53f93616c671 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -493,7 +493,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
>  	if (!display || !display->driver->memory_read)
>  		return -ENOENT;
>  
> -	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
> +	if (!access_ok(mr->buffer, mr->buffer_size))
>  		return -EFAULT;
>  
>  	if (mr->w > 4096 || mr->h > 4096)
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 7e6e682104dc..b24ddac1604b 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -459,14 +459,14 @@ static long privcmd_ioctl_mmap_batch(
>  			return -EFAULT;
>  		/* Returns per-frame error in m.arr. */
>  		m.err = NULL;
> -		if (!access_ok(VERIFY_WRITE, m.arr, m.num * sizeof(*m.arr)))
> +		if (!access_ok(m.arr, m.num * sizeof(*m.arr)))
>  			return -EFAULT;
>  		break;
>  	case 2:
>  		if (copy_from_user(&m, udata, sizeof(struct privcmd_mmapbatch_v2)))
>  			return -EFAULT;
>  		/* Returns per-frame error code in m.err. */
> -		if (!access_ok(VERIFY_WRITE, m.err, m.num * (sizeof(*m.err))))
> +		if (!access_ok(m.err, m.num * (sizeof(*m.err))))
>  			return -EFAULT;
>  		break;
>  	default:
> @@ -661,7 +661,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
>  			goto out;
>  		}
>  
> -		if (!access_ok(VERIFY_WRITE, kbufs[i].uptr,
> +		if (!access_ok(kbufs[i].uptr,
>  			       kbufs[i].size)) {
>  			rc = -EFAULT;
>  			goto out;
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index c3deb2e35f20..ca9725f18e00 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -78,9 +78,9 @@ static int aout_core_dump(struct coredump_params *cprm)
>  
>  /* make sure we actually have a data and stack area to dump */
>  	set_fs(USER_DS);
> -	if (!access_ok(VERIFY_READ, START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
> +	if (!access_ok(START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
>  		dump.u_dsize = 0;
> -	if (!access_ok(VERIFY_READ, START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
> +	if (!access_ok(START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
>  		dump.u_ssize = 0;
>  
>  	set_fs(KERNEL_DS);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 1b15b43905f8..7ea2d6b1f170 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6646,7 +6646,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  		goto out;
>  	}
>  
> -	if (!access_ok(VERIFY_READ, arg->clone_sources,
> +	if (!access_ok(arg->clone_sources,
>  			sizeof(*arg->clone_sources) *
>  			arg->clone_sources_count)) {
>  		ret = -EFAULT;
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 8a5a1010886b..7ebae39fbcb3 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2172,7 +2172,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
>  		return -EINVAL;
>  
>  	/* Verify that the area passed by the user is writeable */
> -	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event)))
> +	if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
>  		return -EFAULT;
>  
>  	/* Get the "struct file *" for the eventpoll file */
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index c8366cb8eccd..0295a095b920 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -805,7 +805,7 @@ static long fat_dir_ioctl(struct file *filp, unsigned int cmd,
>  		return fat_generic_ioctl(filp, cmd, arg);
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE, d1, sizeof(struct __fat_dirent[2])))
> +	if (!access_ok(d1, sizeof(struct __fat_dirent[2])))
>  		return -EFAULT;
>  	/*
>  	 * Yes, we don't need this put_user() absolutely. However old
> @@ -845,7 +845,7 @@ static long fat_compat_dir_ioctl(struct file *filp, unsigned cmd,
>  		return fat_generic_ioctl(filp, cmd, (unsigned long)arg);
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE, d1, sizeof(struct compat_dirent[2])))
> +	if (!access_ok(d1, sizeof(struct compat_dirent[2])))
>  		return -EFAULT;
>  	/*
>  	 * Yes, we don't need this put_user() absolutely. However old
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index d64f622cac8b..fef3a6bf7c78 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -203,7 +203,7 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
>  
>  	if (fiemap.fm_extent_count != 0 &&
> -	    !access_ok(VERIFY_WRITE, fieinfo.fi_extents_start,
> +	    !access_ok(fieinfo.fi_extents_start,
>  		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
>  		return -EFAULT;
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a7f91265ea67..97b7c7098c3d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2651,7 +2651,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
>  	const char __user *f = from;
>  	char c;
>  
> -	if (!access_ok(VERIFY_READ, from, n))
> +	if (!access_ok(from, n))
>  		return n;
>  
>  	current->kernel_uaccess_faults_ok++;
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index b8fa1487cd85..8decbe95dcec 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -254,7 +254,7 @@ static ssize_t dlmfs_file_read(struct file *filp,
>  	if (!count)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	/* don't read past the lvb */
> @@ -302,7 +302,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
>  	if (!count)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	/* don't write past the lvb */
> diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
> index 24db02de1787..97fcef74e5af 100644
> --- a/fs/pstore/pmsg.c
> +++ b/fs/pstore/pmsg.c
> @@ -33,7 +33,7 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  	record.size = count;
>  
>  	/* check outside lock, page in any data. write_user also checks */
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	mutex_lock(&pmsg_lock);
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index c11711c2cc83..f375c0735351 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -357,7 +357,7 @@ int notrace persistent_ram_write_user(struct persistent_ram_zone *prz,
>  	int rem, ret = 0, c = count;
>  	size_t start;
>  
> -	if (unlikely(!access_ok(VERIFY_READ, s, count)))
> +	if (unlikely(!access_ok(s, count)))
>  		return -EFAULT;
>  	if (unlikely(c > prz->buffer_size)) {
>  		s += c - prz->buffer_size;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 58f30537c47a..ff3c5e6f87cf 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -442,7 +442,7 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
>  		return -EBADF;
>  	if (!(file->f_mode & FMODE_CAN_READ))
>  		return -EINVAL;
> -	if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
> +	if (unlikely(!access_ok(buf, count)))
>  		return -EFAULT;
>  
>  	ret = rw_verify_area(READ, file, pos, count);
> @@ -538,7 +538,7 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
>  		return -EBADF;
>  	if (!(file->f_mode & FMODE_CAN_WRITE))
>  		return -EINVAL;
> -	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
> +	if (unlikely(!access_ok(buf, count)))
>  		return -EFAULT;
>  
>  	ret = rw_verify_area(WRITE, file, pos, count);
> @@ -718,9 +718,6 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
>  	return ret;
>  }
>  
> -/* A write operation does a read from user space and vice versa */
> -#define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
> -
>  /**
>   * rw_copy_check_uvector() - Copy an array of &struct iovec from userspace
>   *     into the kernel and check that it is valid.
> @@ -810,7 +807,7 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
>  			goto out;
>  		}
>  		if (type >= 0
> -		    && unlikely(!access_ok(vrfy_dir(type), buf, len))) {
> +		    && unlikely(!access_ok(buf, len))) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
> @@ -856,7 +853,7 @@ ssize_t compat_rw_copy_check_uvector(int type,
>  	*ret_pointer = iov;
>  
>  	ret = -EFAULT;
> -	if (!access_ok(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
> +	if (!access_ok(uvector, nr_segs*sizeof(*uvector)))
>  		goto out;
>  
>  	/*
> @@ -881,7 +878,7 @@ ssize_t compat_rw_copy_check_uvector(int type,
>  		if (len < 0)	/* size_t not fitting in compat_ssize_t .. */
>  			goto out;
>  		if (type >= 0 &&
> -		    !access_ok(vrfy_dir(type), compat_ptr(buf), len)) {
> +		    !access_ok(compat_ptr(buf), len)) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
> diff --git a/fs/readdir.c b/fs/readdir.c
> index d97f548e6323..2f6a4534e0df 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -105,7 +105,7 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!access_ok(VERIFY_WRITE, dirent,
> +	if (!access_ok(dirent,
>  			(unsigned long)(dirent->d_name + namlen + 1) -
>  				(unsigned long)dirent))
>  		goto efault;
> @@ -221,7 +221,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
>  	};
>  	int error;
>  
> -	if (!access_ok(VERIFY_WRITE, dirent, count))
> +	if (!access_ok(dirent, count))
>  		return -EFAULT;
>  
>  	f = fdget_pos(fd);
> @@ -304,7 +304,7 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
>  	};
>  	int error;
>  
> -	if (!access_ok(VERIFY_WRITE, dirent, count))
> +	if (!access_ok(dirent, count))
>  		return -EFAULT;
>  
>  	f = fdget_pos(fd);
> @@ -365,7 +365,7 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!access_ok(VERIFY_WRITE, dirent,
> +	if (!access_ok(dirent,
>  			(unsigned long)(dirent->d_name + namlen + 1) -
>  				(unsigned long)dirent))
>  		goto efault;
> @@ -475,7 +475,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
>  	};
>  	int error;
>  
> -	if (!access_ok(VERIFY_WRITE, dirent, count))
> +	if (!access_ok(dirent, count))
>  		return -EFAULT;
>  
>  	f = fdget_pos(fd);
> diff --git a/fs/select.c b/fs/select.c
> index 4c8652390c94..d0f35dbc0e8f 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -381,9 +381,6 @@ typedef struct {
>  #define FDS_BYTES(nr)	(FDS_LONGS(nr)*sizeof(long))
>  
>  /*
> - * We do a VERIFY_WRITE here even though we are only reading this time:
> - * we'll write to it eventually..
> - *
>   * Use "unsigned long" accesses to let user-mode fd_set's be long-aligned.
>   */
>  static inline
> @@ -782,7 +779,7 @@ SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,
>  	sigset_t __user *up = NULL;
>  
>  	if (sig) {
> -		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
> +		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
>  		    || __get_user(up, (sigset_t __user * __user *)sig)
>  		    || __get_user(sigsetsize,
>  				(size_t __user *)(sig+sizeof(void *))))
> @@ -802,7 +799,7 @@ SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *,
>  	sigset_t __user *up = NULL;
>  
>  	if (sig) {
> -		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
> +		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
>  		    || __get_user(up, (sigset_t __user * __user *)sig)
>  		    || __get_user(sigsetsize,
>  				(size_t __user *)(sig+sizeof(void *))))
> @@ -1368,7 +1365,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
>  	compat_uptr_t up = 0;
>  
>  	if (sig) {
> -		if (!access_ok(VERIFY_READ, sig,
> +		if (!access_ok(sig,
>  				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
>  				__get_user(up, (compat_uptr_t __user *)sig) ||
>  				__get_user(sigsetsize,
> @@ -1390,7 +1387,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
>  	compat_uptr_t up = 0;
>  
>  	if (sig) {
> -		if (!access_ok(VERIFY_READ, sig,
> +		if (!access_ok(sig,
>  				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
>  		    	__get_user(up, (compat_uptr_t __user *)sig) ||
>  		    	__get_user(sigsetsize,
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 6b2e63df2739..d82c78a79da5 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -35,7 +35,7 @@ static inline void set_fs(mm_segment_t fs)
>  #define segment_eq(a, b) ((a).seg == (b).seg)
>  #endif
>  
> -#define access_ok(type, addr, size) __access_ok((unsigned long)(addr),(size))
> +#define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
>  
>  /*
>   * The architecture should really override this if possible, at least
> @@ -78,7 +78,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
>  ({								\
>  	void __user *__p = (ptr);				\
>  	might_fault();						\
> -	access_ok(VERIFY_WRITE, __p, sizeof(*ptr)) ?		\
> +	access_ok(__p, sizeof(*ptr)) ?		\
>  		__put_user((x), ((__typeof__(*(ptr)) __user *)__p)) :	\
>  		-EFAULT;					\
>  })
> @@ -140,7 +140,7 @@ extern int __put_user_bad(void) __attribute__((noreturn));
>  ({								\
>  	const void __user *__p = (ptr);				\
>  	might_fault();						\
> -	access_ok(VERIFY_READ, __p, sizeof(*ptr)) ?		\
> +	access_ok(__p, sizeof(*ptr)) ?		\
>  		__get_user((x), (__typeof__(*(ptr)) __user *)__p) :\
>  		((x) = (__typeof__(*(ptr)))0,-EFAULT);		\
>  })
> @@ -175,7 +175,7 @@ __strncpy_from_user(char *dst, const char __user *src, long count)
>  static inline long
>  strncpy_from_user(char *dst, const char __user *src, long count)
>  {
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return -EFAULT;
>  	return __strncpy_from_user(dst, src, count);
>  }
> @@ -196,7 +196,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
>   */
>  static inline long strnlen_user(const char __user *src, long n)
>  {
> -	if (!access_ok(VERIFY_READ, src, 1))
> +	if (!access_ok(src, 1))
>  		return 0;
>  	return __strnlen_user(src, n);
>  }
> @@ -217,7 +217,7 @@ static inline __must_check unsigned long
>  clear_user(void __user *to, unsigned long n)
>  {
>  	might_fault();
> -	if (!access_ok(VERIFY_WRITE, to, n))
> +	if (!access_ok(to, n))
>  		return n;
>  
>  	return __clear_user(to, n);
> diff --git a/include/linux/regset.h b/include/linux/regset.h
> index 494cedaafdf2..a85c1707285c 100644
> --- a/include/linux/regset.h
> +++ b/include/linux/regset.h
> @@ -376,7 +376,7 @@ static inline int copy_regset_to_user(struct task_struct *target,
>  	if (!regset->get)
>  		return -EOPNOTSUPP;
>  
> -	if (!access_ok(VERIFY_WRITE, data, size))
> +	if (!access_ok(data, size))
>  		return -EFAULT;
>  
>  	return regset->get(target, regset, offset, size, NULL, data);
> @@ -402,7 +402,7 @@ static inline int copy_regset_from_user(struct task_struct *target,
>  	if (!regset->set)
>  		return -EOPNOTSUPP;
>  
> -	if (!access_ok(VERIFY_READ, data, size))
> +	if (!access_ok(data, size))
>  		return -EFAULT;
>  
>  	return regset->set(target, regset, offset, size, NULL, data);
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index efe79c1cdd47..bf2523867a02 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -6,9 +6,6 @@
>  #include <linux/thread_info.h>
>  #include <linux/kasan-checks.h>
>  
> -#define VERIFY_READ 0
> -#define VERIFY_WRITE 1
> -
>  #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
>  
>  #include <asm/uaccess.h>
> @@ -111,7 +108,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
>  	unsigned long res = n;
>  	might_fault();
> -	if (likely(access_ok(VERIFY_READ, from, n))) {
> +	if (likely(access_ok(from, n))) {
>  		kasan_check_write(to, n);
>  		res = raw_copy_from_user(to, from, n);
>  	}
> @@ -129,7 +126,7 @@ static inline unsigned long
>  _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>  	might_fault();
> -	if (access_ok(VERIFY_WRITE, to, n)) {
> +	if (access_ok(to, n)) {
>  		kasan_check_read(from, n);
>  		n = raw_copy_to_user(to, from, n);
>  	}
> @@ -160,7 +157,7 @@ static __always_inline unsigned long __must_check
>  copy_in_user(void __user *to, const void __user *from, unsigned long n)
>  {
>  	might_fault();
> -	if (access_ok(VERIFY_WRITE, to, n) && access_ok(VERIFY_READ, from, n))
> +	if (access_ok(to, n) && access_ok(from, n))
>  		n = raw_copy_in_user(to, from, n);
>  	return n;
>  }
> diff --git a/include/net/checksum.h b/include/net/checksum.h
> index aef2b2bb6603..0f319e13be2c 100644
> --- a/include/net/checksum.h
> +++ b/include/net/checksum.h
> @@ -30,7 +30,7 @@ static inline
>  __wsum csum_and_copy_from_user (const void __user *src, void *dst,
>  				      int len, __wsum sum, int *err_ptr)
>  {
> -	if (access_ok(VERIFY_READ, src, len))
> +	if (access_ok(src, len))
>  		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
>  
>  	if (len)
> @@ -46,7 +46,7 @@ static __inline__ __wsum csum_and_copy_to_user
>  {
>  	sum = csum_partial(src, len, sum);
>  
> -	if (access_ok(VERIFY_WRITE, dst, len)) {
> +	if (access_ok(dst, len)) {
>  		if (copy_to_user(dst, src, len) == 0)
>  			return sum;
>  	}
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0607db304def..b155cd17c1bd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -79,7 +79,7 @@ int bpf_check_uarg_tail_zero(void __user *uaddr,
>  	if (unlikely(actual_size > PAGE_SIZE))	/* silly large */
>  		return -E2BIG;
>  
> -	if (unlikely(!access_ok(VERIFY_READ, uaddr, actual_size)))
> +	if (unlikely(!access_ok(uaddr, actual_size)))
>  		return -EFAULT;
>  
>  	if (actual_size <= expected_size)
> diff --git a/kernel/compat.c b/kernel/compat.c
> index 089d00d0da9c..705d4ae6c018 100644
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
> @@ -95,28 +95,28 @@ int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
>  
>  static int __compat_get_timeval(struct timeval *tv, const struct old_timeval32 __user *ctv)
>  {
> -	return (!access_ok(VERIFY_READ, ctv, sizeof(*ctv)) ||
> +	return (!access_ok(ctv, sizeof(*ctv)) ||
>  			__get_user(tv->tv_sec, &ctv->tv_sec) ||
>  			__get_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
>  }
>  
>  static int __compat_put_timeval(const struct timeval *tv, struct old_timeval32 __user *ctv)
>  {
> -	return (!access_ok(VERIFY_WRITE, ctv, sizeof(*ctv)) ||
> +	return (!access_ok(ctv, sizeof(*ctv)) ||
>  			__put_user(tv->tv_sec, &ctv->tv_sec) ||
>  			__put_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
>  }
>  
>  static int __compat_get_timespec(struct timespec *ts, const struct old_timespec32 __user *cts)
>  {
> -	return (!access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
> +	return (!access_ok(cts, sizeof(*cts)) ||
>  			__get_user(ts->tv_sec, &cts->tv_sec) ||
>  			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>  }
>  
>  static int __compat_put_timespec(const struct timespec *ts, struct old_timespec32 __user *cts)
>  {
> -	return (!access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
> +	return (!access_ok(cts, sizeof(*cts)) ||
>  			__put_user(ts->tv_sec, &cts->tv_sec) ||
>  			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>  }
> @@ -335,7 +335,7 @@ int get_compat_sigevent(struct sigevent *event,
>  		const struct compat_sigevent __user *u_event)
>  {
>  	memset(event, 0, sizeof(*event));
> -	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
> +	return (!access_ok(u_event, sizeof(*u_event)) ||
>  		__get_user(event->sigev_value.sival_int,
>  			&u_event->sigev_value.sival_int) ||
>  		__get_user(event->sigev_signo, &u_event->sigev_signo) ||
> @@ -354,7 +354,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!access_ok(VERIFY_READ, umask, bitmap_size / 8))
> +	if (!access_ok(umask, bitmap_size / 8))
>  		return -EFAULT;
>  
>  	user_access_begin();
> @@ -384,7 +384,7 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!access_ok(VERIFY_WRITE, umask, bitmap_size / 8))
> +	if (!access_ok(umask, bitmap_size / 8))
>  		return -EFAULT;
>  
>  	user_access_begin();
> @@ -438,7 +438,7 @@ void __user *compat_alloc_user_space(unsigned long len)
>  
>  	ptr = arch_compat_alloc_user_space(len);
>  
> -	if (unlikely(!access_ok(VERIFY_WRITE, ptr, len)))
> +	if (unlikely(!access_ok(ptr, len)))
>  		return NULL;
>  
>  	return ptr;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 67ecac337374..3cd13a30f732 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10135,7 +10135,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  	u32 size;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, uattr, PERF_ATTR_SIZE_VER0))
> +	if (!access_ok(uattr, PERF_ATTR_SIZE_VER0))
>  		return -EFAULT;
>  
>  	/*
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d21f35..8a01b671dc1f 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1604,7 +1604,7 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
>  	if (!infop)
>  		return err;
>  
> -	if (!access_ok(VERIFY_WRITE, infop, sizeof(*infop)))
> +	if (!access_ok(infop, sizeof(*infop)))
>  		return -EFAULT;
>  
>  	user_access_begin();
> @@ -1732,7 +1732,7 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>  	if (!infop)
>  		return err;
>  
> -	if (!access_ok(VERIFY_WRITE, infop, sizeof(*infop)))
> +	if (!access_ok(infop, sizeof(*infop)))
>  		return -EFAULT;
>  
>  	user_access_begin();
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 054105854e0e..be3bff2315ff 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -481,13 +481,18 @@ static void drop_futex_key_refs(union futex_key *key)
>  	}
>  }
>  
> +enum futex_access {
> +	FUTEX_READ,
> +	FUTEX_WRITE
> +};
> +
>  /**
>   * get_futex_key() - Get parameters which are the keys for a futex
>   * @uaddr:	virtual address of the futex
>   * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
>   * @key:	address where result is stored.
> - * @rw:		mapping needs to be read/write (values: VERIFY_READ,
> - *              VERIFY_WRITE)
> + * @rw:		mapping needs to be read/write (values: FUTEX_READ,
> + *              FUTEX_WRITE)
>   *
>   * Return: a negative error code or 0
>   *
> @@ -500,7 +505,7 @@ static void drop_futex_key_refs(union futex_key *key)
>   * lock_page() might sleep, the caller should not hold a spinlock.
>   */
>  static int
> -get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, int rw)
> +get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_access rw)
>  {
>  	unsigned long address = (unsigned long)uaddr;
>  	struct mm_struct *mm = current->mm;
> @@ -516,7 +521,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, int rw)
>  		return -EINVAL;
>  	address -= key->both.offset;
>  
> -	if (unlikely(!access_ok(rw, uaddr, sizeof(u32))))
> +	if (unlikely(!access_ok(uaddr, sizeof(u32))))
>  		return -EFAULT;
>  
>  	if (unlikely(should_fail_futex(fshared)))
> @@ -546,7 +551,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, int rw)
>  	 * If write access is not required (eg. FUTEX_WAIT), try
>  	 * and get read-only access.
>  	 */
> -	if (err == -EFAULT && rw == VERIFY_READ) {
> +	if (err == -EFAULT && rw == FUTEX_READ) {
>  		err = get_user_pages_fast(address, 1, 0, &page);
>  		ro = 1;
>  	}
> @@ -1583,7 +1588,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
>  	if (!bitset)
>  		return -EINVAL;
>  
> -	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, VERIFY_READ);
> +	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
>  	if (unlikely(ret != 0))
>  		goto out;
>  
> @@ -1642,7 +1647,7 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
>  		oparg = 1 << oparg;
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
>  	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> @@ -1682,10 +1687,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
>  	DEFINE_WAKE_Q(wake_q);
>  
>  retry:
> -	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, VERIFY_READ);
> +	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
>  	if (unlikely(ret != 0))
>  		goto out;
> -	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, VERIFY_WRITE);
> +	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
>  	if (unlikely(ret != 0))
>  		goto out_put_key1;
>  
> @@ -1961,11 +1966,11 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>  	}
>  
>  retry:
> -	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, VERIFY_READ);
> +	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
>  	if (unlikely(ret != 0))
>  		goto out;
>  	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
> -			    requeue_pi ? VERIFY_WRITE : VERIFY_READ);
> +			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
>  	if (unlikely(ret != 0))
>  		goto out_put_key1;
>  
> @@ -2634,7 +2639,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
>  	 * while the syscall executes.
>  	 */
>  retry:
> -	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, VERIFY_READ);
> +	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
>  	if (unlikely(ret != 0))
>  		return ret;
>  
> @@ -2793,7 +2798,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
>  	}
>  
>  retry:
> -	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, VERIFY_WRITE);
> +	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
>  	if (unlikely(ret != 0))
>  		goto out;
>  
> @@ -2972,7 +2977,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  	if ((uval & FUTEX_TID_MASK) != vpid)
>  		return -EPERM;
>  
> -	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, VERIFY_WRITE);
> +	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
>  	if (ret)
>  		return ret;
>  
> @@ -3199,7 +3204,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
>  	 */
>  	rt_mutex_init_waiter(&rt_waiter);
>  
> -	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, VERIFY_WRITE);
> +	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
>  	if (unlikely(ret != 0))
>  		goto out;
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1306fe0c1dc6..d3d170374ceb 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1466,7 +1466,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			return -EINVAL;
>  		if (!len)
>  			return 0;
> -		if (!access_ok(VERIFY_WRITE, buf, len))
> +		if (!access_ok(buf, len))
>  			return -EFAULT;
>  		error = wait_event_interruptible(log_wait,
>  						 syslog_seq != log_next_seq);
> @@ -1484,7 +1484,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			return -EINVAL;
>  		if (!len)
>  			return 0;
> -		if (!access_ok(VERIFY_WRITE, buf, len))
> +		if (!access_ok(buf, len))
>  			return -EFAULT;
>  		error = syslog_print_all(buf, len, clear);
>  		break;
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index c2cee9db5204..771e93f9c43f 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1073,7 +1073,7 @@ int ptrace_request(struct task_struct *child, long request,
>  		struct iovec kiov;
>  		struct iovec __user *uiov = datavp;
>  
> -		if (!access_ok(VERIFY_WRITE, uiov, sizeof(*uiov)))
> +		if (!access_ok(uiov, sizeof(*uiov)))
>  			return -EFAULT;
>  
>  		if (__get_user(kiov.iov_base, &uiov->iov_base) ||
> @@ -1229,7 +1229,7 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
>  		compat_uptr_t ptr;
>  		compat_size_t len;
>  
> -		if (!access_ok(VERIFY_WRITE, uiov, sizeof(*uiov)))
> +		if (!access_ok(uiov, sizeof(*uiov)))
>  			return -EFAULT;
>  
>  		if (__get_user(ptr, &uiov->iov_base) ||
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index c6242d8594dc..25e9a7b60eba 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -267,7 +267,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  
>  	if (unlikely(t->flags & PF_EXITING))
>  		return;
> -	if (unlikely(!access_ok(VERIFY_WRITE, t->rseq, sizeof(*t->rseq))))
> +	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
>  		goto error;
>  	ret = rseq_ip_fixup(regs);
>  	if (unlikely(ret < 0))
> @@ -295,7 +295,7 @@ void rseq_syscall(struct pt_regs *regs)
>  
>  	if (!t->rseq)
>  		return;
> -	if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
> +	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
>  	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
>  		force_sig(SIGSEGV, t);
>  }
> @@ -351,7 +351,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>  	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
>  	    rseq_len != sizeof(*rseq))
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_WRITE, rseq, rseq_len))
> +	if (!access_ok(rseq, rseq_len))
>  		return -EFAULT;
>  	current->rseq = rseq;
>  	current->rseq_len = rseq_len;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f66920173370..1f3e19fd6dc6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4450,7 +4450,7 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	u32 size;
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, uattr, SCHED_ATTR_SIZE_VER0))
> +	if (!access_ok(uattr, SCHED_ATTR_SIZE_VER0))
>  		return -EFAULT;
>  
>  	/* Zero the full structure, so that a short copy will be nice: */
> @@ -4650,7 +4650,7 @@ static int sched_read_attr(struct sched_attr __user *uattr,
>  {
>  	int ret;
>  
> -	if (!access_ok(VERIFY_WRITE, uattr, usize))
> +	if (!access_ok(uattr, usize))
>  		return -EFAULT;
>  
>  	/*
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 53e07d97ffe0..e1d7ad8e6ab1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3997,7 +3997,7 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  
>  	if (act) {
>  		old_sigset_t mask;
> -		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
> +		if (!access_ok(act, sizeof(*act)) ||
>  		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
>  		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
>  		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> @@ -4012,7 +4012,7 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
> +		if (!access_ok(oact, sizeof(*oact)) ||
>  		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
>  		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
>  		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> @@ -4034,7 +4034,7 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	compat_uptr_t handler, restorer;
>  
>  	if (act) {
> -		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
> +		if (!access_ok(act, sizeof(*act)) ||
>  		    __get_user(handler, &act->sa_handler) ||
>  		    __get_user(restorer, &act->sa_restorer) ||
>  		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> @@ -4052,7 +4052,7 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
> +		if (!access_ok(oact, sizeof(*oact)) ||
>  		    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
>  			       &oact->sa_handler) ||
>  		    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 64b5a230f38d..a48cbf1414b8 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2627,7 +2627,7 @@ COMPAT_SYSCALL_DEFINE1(sysinfo, struct compat_sysinfo __user *, info)
>  		s.freehigh >>= bitcount;
>  	}
>  
> -	if (!access_ok(VERIFY_WRITE, info, sizeof(struct compat_sysinfo)) ||
> +	if (!access_ok(info, sizeof(struct compat_sysinfo)) ||
>  	    __put_user(s.uptime, &info->uptime) ||
>  	    __put_user(s.loads[0], &info->loads[0]) ||
>  	    __put_user(s.loads[1], &info->loads[1]) ||
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9ddb6fddb4e0..8b068adb9da1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -170,7 +170,7 @@ BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
>  		return -EPERM;
>  	if (unlikely(uaccess_kernel()))
>  		return -EPERM;
> -	if (!access_ok(VERIFY_WRITE, unsafe_ptr, size))
> +	if (!access_ok(unsafe_ptr, size))
>  		return -EPERM;
>  
>  	return probe_kernel_write(unsafe_ptr, src, size);
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index eead55aa7170..98872e9025da 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -443,7 +443,7 @@ int bitmap_parse_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
>  			int nmaskbits)
>  {
> -	if (!access_ok(VERIFY_READ, ubuf, ulen))
> +	if (!access_ok(ubuf, ulen))
>  		return -EFAULT;
>  	return __bitmap_parse((const char __force *)ubuf,
>  				ulen, 1, maskp, nmaskbits);
> @@ -641,7 +641,7 @@ int bitmap_parselist_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
>  			int nmaskbits)
>  {
> -	if (!access_ok(VERIFY_READ, ubuf, ulen))
> +	if (!access_ok(ubuf, ulen))
>  		return -EFAULT;
>  	return __bitmap_parselist((const char __force *)ubuf,
>  					ulen, 1, maskp, nmaskbits);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1928009f506e..c93870987b58 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -136,7 +136,7 @@
>  
>  static int copyout(void __user *to, const void *from, size_t n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n)) {
> +	if (access_ok(to, n)) {
>  		kasan_check_read(from, n);
>  		n = raw_copy_to_user(to, from, n);
>  	}
> @@ -145,7 +145,7 @@ static int copyout(void __user *to, const void *from, size_t n)
>  
>  static int copyin(void *to, const void __user *from, size_t n)
>  {
> -	if (access_ok(VERIFY_READ, from, n)) {
> +	if (access_ok(from, n)) {
>  		kasan_check_write(to, n);
>  		n = raw_copy_from_user(to, from, n);
>  	}
> @@ -614,7 +614,7 @@ EXPORT_SYMBOL(_copy_to_iter);
>  #ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
>  static int copyout_mcsafe(void __user *to, const void *from, size_t n)
>  {
> -	if (access_ok(VERIFY_WRITE, to, n)) {
> +	if (access_ok(to, n)) {
>  		kasan_check_read(from, n);
>  		n = copy_to_user_mcsafe((__force void *) to, from, n);
>  	}
> @@ -1663,7 +1663,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
>  {
>  	if (len > MAX_RW_COUNT)
>  		len = MAX_RW_COUNT;
> -	if (unlikely(!access_ok(!rw, buf, len)))
> +	if (unlikely(!access_ok(buf, len)))
>  		return -EFAULT;
>  
>  	iov->iov_base = buf;
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index 3744b2a8e591..c2bfbcaeb3dc 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -8,7 +8,7 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
>  {
>  	unsigned long res = n;
>  	might_fault();
> -	if (likely(access_ok(VERIFY_READ, from, n))) {
> +	if (likely(access_ok(from, n))) {
>  		kasan_check_write(to, n);
>  		res = raw_copy_from_user(to, from, n);
>  	}
> @@ -23,7 +23,7 @@ EXPORT_SYMBOL(_copy_from_user);
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>  	might_fault();
> -	if (likely(access_ok(VERIFY_WRITE, to, n))) {
> +	if (likely(access_ok(to, n))) {
>  		kasan_check_read(from, n);
>  		n = raw_copy_to_user(to, from, n);
>  	}
> diff --git a/mm/gup.c b/mm/gup.c
> index 8cb68a50dbdf..6f591ccb8eca 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1813,8 +1813,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
>  
> -	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> -					(void __user *)start, len)))
> +	if (unlikely(!access_ok((void __user *)start, len)))
>  		return 0;
>  
>  	/*
> @@ -1868,8 +1867,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	if (nr_pages <= 0)
>  		return 0;
>  
> -	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> -					(void __user *)start, len)))
> +	if (unlikely(!access_ok((void __user *)start, len)))
>  		return -EFAULT;
>  
>  	if (gup_fast_permitted(start, nr_pages, write)) {
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 4985965aa20a..218099b5ed31 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -233,14 +233,14 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
>  		return -EINVAL;
>  
>  	/* ..and we need to be passed a valid user-space range */
> -	if (!access_ok(VERIFY_READ, (void __user *) start, len))
> +	if (!access_ok((void __user *) start, len))
>  		return -ENOMEM;
>  
>  	/* This also avoids any overflows on PAGE_ALIGN */
>  	pages = len >> PAGE_SHIFT;
>  	pages += (offset_in_page(len)) != 0;
>  
> -	if (!access_ok(VERIFY_WRITE, vec, pages))
> +	if (!access_ok(vec, pages))
>  		return -EFAULT;
>  
>  	tmp = (void *) __get_free_page(GFP_USER);
> diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
> index d70f363c52ae..6d5859714f52 100644
> --- a/net/batman-adv/icmp_socket.c
> +++ b/net/batman-adv/icmp_socket.c
> @@ -147,7 +147,7 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
>  	if (!buf || count < sizeof(struct batadv_icmp_packet))
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	error = wait_event_interruptible(socket_client->queue_wait,
> diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
> index 02e55b78132f..75f602e1ce94 100644
> --- a/net/batman-adv/log.c
> +++ b/net/batman-adv/log.c
> @@ -136,7 +136,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
>  	if (count == 0)
>  		return 0;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	error = wait_event_interruptible(debug_log->queue_wait,
> diff --git a/net/compat.c b/net/compat.c
> index c3a2f868e8af..959d1c51826d 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -358,7 +358,7 @@ static int do_set_sock_timeout(struct socket *sock, int level,
>  
>  	if (optlen < sizeof(*up))
>  		return -EINVAL;
> -	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
> +	if (!access_ok(up, sizeof(*up)) ||
>  	    __get_user(ktime.tv_sec, &up->tv_sec) ||
>  	    __get_user(ktime.tv_usec, &up->tv_usec))
>  		return -EFAULT;
> @@ -438,7 +438,7 @@ static int do_get_sock_timeout(struct socket *sock, int level, int optname,
>  
>  	if (!err) {
>  		if (put_user(sizeof(*up), optlen) ||
> -		    !access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
> +		    !access_ok(up, sizeof(*up)) ||
>  		    __put_user(ktime.tv_sec, &up->tv_sec) ||
>  		    __put_user(ktime.tv_usec, &up->tv_usec))
>  			err = -EFAULT;
> @@ -590,8 +590,8 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
>  			compat_alloc_user_space(sizeof(struct group_req));
>  		u32 interface;
>  
> -		if (!access_ok(VERIFY_READ, gr32, sizeof(*gr32)) ||
> -		    !access_ok(VERIFY_WRITE, kgr, sizeof(struct group_req)) ||
> +		if (!access_ok(gr32, sizeof(*gr32)) ||
> +		    !access_ok(kgr, sizeof(struct group_req)) ||
>  		    __get_user(interface, &gr32->gr_interface) ||
>  		    __put_user(interface, &kgr->gr_interface) ||
>  		    copy_in_user(&kgr->gr_group, &gr32->gr_group,
> @@ -611,8 +611,8 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
>  			sizeof(struct group_source_req));
>  		u32 interface;
>  
> -		if (!access_ok(VERIFY_READ, gsr32, sizeof(*gsr32)) ||
> -		    !access_ok(VERIFY_WRITE, kgsr,
> +		if (!access_ok(gsr32, sizeof(*gsr32)) ||
> +		    !access_ok(kgsr,
>  			sizeof(struct group_source_req)) ||
>  		    __get_user(interface, &gsr32->gsr_interface) ||
>  		    __put_user(interface, &kgsr->gsr_interface) ||
> @@ -631,7 +631,7 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
>  		struct group_filter __user *kgf;
>  		u32 interface, fmode, numsrc;
>  
> -		if (!access_ok(VERIFY_READ, gf32, __COMPAT_GF0_SIZE) ||
> +		if (!access_ok(gf32, __COMPAT_GF0_SIZE) ||
>  		    __get_user(interface, &gf32->gf_interface) ||
>  		    __get_user(fmode, &gf32->gf_fmode) ||
>  		    __get_user(numsrc, &gf32->gf_numsrc))
> @@ -641,7 +641,7 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
>  		if (koptlen < GROUP_FILTER_SIZE(numsrc))
>  			return -EINVAL;
>  		kgf = compat_alloc_user_space(koptlen);
> -		if (!access_ok(VERIFY_WRITE, kgf, koptlen) ||
> +		if (!access_ok(kgf, koptlen) ||
>  		    __put_user(interface, &kgf->gf_interface) ||
>  		    __put_user(fmode, &kgf->gf_fmode) ||
>  		    __put_user(numsrc, &kgf->gf_numsrc) ||
> @@ -675,7 +675,7 @@ int compat_mc_getsockopt(struct sock *sock, int level, int optname,
>  		return getsockopt(sock, level, optname, optval, optlen);
>  
>  	koptlen = compat_alloc_user_space(sizeof(*koptlen));
> -	if (!access_ok(VERIFY_READ, optlen, sizeof(*optlen)) ||
> +	if (!access_ok(optlen, sizeof(*optlen)) ||
>  	    __get_user(ulen, optlen))
>  		return -EFAULT;
>  
> @@ -685,14 +685,14 @@ int compat_mc_getsockopt(struct sock *sock, int level, int optname,
>  	if (klen < GROUP_FILTER_SIZE(0))
>  		return -EINVAL;
>  
> -	if (!access_ok(VERIFY_WRITE, koptlen, sizeof(*koptlen)) ||
> +	if (!access_ok(koptlen, sizeof(*koptlen)) ||
>  	    __put_user(klen, koptlen))
>  		return -EFAULT;
>  
>  	/* have to allow space for previous compat_alloc_user_space, too */
>  	kgf = compat_alloc_user_space(klen+sizeof(*optlen));
>  
> -	if (!access_ok(VERIFY_READ, gf32, __COMPAT_GF0_SIZE) ||
> +	if (!access_ok(gf32, __COMPAT_GF0_SIZE) ||
>  	    __get_user(interface, &gf32->gf_interface) ||
>  	    __get_user(fmode, &gf32->gf_fmode) ||
>  	    __get_user(numsrc, &gf32->gf_numsrc) ||
> @@ -706,18 +706,18 @@ int compat_mc_getsockopt(struct sock *sock, int level, int optname,
>  	if (err)
>  		return err;
>  
> -	if (!access_ok(VERIFY_READ, koptlen, sizeof(*koptlen)) ||
> +	if (!access_ok(koptlen, sizeof(*koptlen)) ||
>  	    __get_user(klen, koptlen))
>  		return -EFAULT;
>  
>  	ulen = klen - (sizeof(*kgf)-sizeof(*gf32));
>  
> -	if (!access_ok(VERIFY_WRITE, optlen, sizeof(*optlen)) ||
> +	if (!access_ok(optlen, sizeof(*optlen)) ||
>  	    __put_user(ulen, optlen))
>  		return -EFAULT;
>  
> -	if (!access_ok(VERIFY_READ, kgf, klen) ||
> -	    !access_ok(VERIFY_WRITE, gf32, ulen) ||
> +	if (!access_ok(kgf, klen) ||
> +	    !access_ok(gf32, ulen) ||
>  	    __get_user(interface, &kgf->gf_interface) ||
>  	    __get_user(fmode, &kgf->gf_fmode) ||
>  	    __get_user(numsrc, &kgf->gf_numsrc) ||
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index 8c3936403fea..0bea8ff8b0d3 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -89,7 +89,7 @@ proc_dodebug(struct ctl_table *table, int write,
>  	left = *lenp;
>  
>  	if (write) {
> -		if (!access_ok(VERIFY_READ, buffer, left))
> +		if (!access_ok(buffer, left))
>  			return -EFAULT;
>  		p = buffer;
>  		while (left && __get_user(c, p) >= 0 && isspace(c))
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 9b38f94b5dd0..c598aa00d5e3 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -2591,7 +2591,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
>  	int idx;
>  	if (!head->write)
>  		return -ENOSYS;
> -	if (!access_ok(VERIFY_READ, buffer, buffer_len))
> +	if (!access_ok(buffer, buffer_len))
>  		return -EFAULT;
>  	if (mutex_lock_interruptible(&head->io_sem))
>  		return -EINTR;
> diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
> index 92e6524a3a9d..7d4640d1fe9f 100644
> --- a/sound/core/seq/seq_clientmgr.c
> +++ b/sound/core/seq/seq_clientmgr.c
> @@ -393,7 +393,7 @@ static ssize_t snd_seq_read(struct file *file, char __user *buf, size_t count,
>  	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT))
>  		return -ENXIO;
>  
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
>  	/* check client structures are in place */
> diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
> index d45a6b9d6437..3d44c358c4b3 100644
> --- a/sound/isa/sb/emu8000_patch.c
> +++ b/sound/isa/sb/emu8000_patch.c
> @@ -183,10 +183,10 @@ snd_emu8000_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
>  	}
>  
>  	if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS) {
> -		if (!access_ok(VERIFY_READ, data, sp->v.size))
> +		if (!access_ok(data, sp->v.size))
>  			return -EFAULT;
>  	} else {
> -		if (!access_ok(VERIFY_READ, data, sp->v.size * 2))
> +		if (!access_ok(data, sp->v.size * 2))
>  			return -EFAULT;
>  	}
>  
> diff --git a/tools/perf/util/include/asm/uaccess.h b/tools/perf/util/include/asm/uaccess.h
> index 6a6f4b990547..548100315710 100644
> --- a/tools/perf/util/include/asm/uaccess.h
> +++ b/tools/perf/util/include/asm/uaccess.h
> @@ -10,6 +10,6 @@
>  
>  #define get_user	__get_user
>  
> -#define access_ok(type, addr, size)	1
> +#define access_ok(addr, size)	1
>  
>  #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 666d0155662d..1f888a103f78 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -939,8 +939,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	/* We can read the guest memory with __xxx_user() later on. */
>  	if ((id < KVM_USER_MEM_SLOTS) &&
>  	    ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
> -	     !access_ok(VERIFY_WRITE,
> -			(void __user *)(unsigned long)mem->userspace_addr,
> +	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>  			mem->memory_size)))
>  		goto out;
>  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
> -- 
> 2.7.4
