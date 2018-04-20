Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeDTLzX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754631AbeDTLzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:55:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7021742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 07:55:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: corbet@lwn.net, aryabinin@virtuozzo.com, glider@google.com,
        dvyukov@google.com, peterz@infradead.org, mingo@redhat.com,
        tom.zanussi@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: updates for new syscall stub naming
 convention
Message-ID: <20180420075517.076e73b1@gandalf.local.home>
In-Reply-To: <20180420054425.GA19013@light.dominikbrodowski.net>
References: <20180420054425.GA19013@light.dominikbrodowski.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 07:44:25 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> For v4.17-rc1, the naming of syscall stubs changed. Update stack
> traces and similar instances in the documentation to avoid sources
> for confusion.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Except that on x86 I don't see any __se_sys_* functions in kallsyms.

# grep _se_sys /proc/kallsyms
# grep _x64_sys /proc/kallsyms | head 
ffffffff81032ae0 T __x64_sys_arch_prctl
ffffffff81033400 T __x64_sys_rt_sigreturn
ffffffff81036ea0 T __x64_sys_iopl
ffffffff810371d0 T __x64_sys_ioperm
ffffffff81039090 T __x64_sys_modify_ldt
ffffffff81039da0 T __x64_sys_mmap
ffffffff81045060 T __x64_sys_set_thread_area
ffffffff81045150 T __x64_sys_get_thread_area
ffffffff810aa450 T __x64_sys_set_tid_address
ffffffff810ad7c0 T __x64_sys_fork

I'd say leave the documentation alone.

-- Steve

> 
> diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admin-guide/bug-hunting.rst
> index f278b289e260..cebff8e5c59f 100644
> --- a/Documentation/admin-guide/bug-hunting.rst
> +++ b/Documentation/admin-guide/bug-hunting.rst
> @@ -30,7 +30,7 @@ Kernel bug reports often come with a stack dump like the one below::
>  	 [<c1362907>] ? driver_detach+0x87/0x90
>  	 [<c1361c48>] ? bus_remove_driver+0x38/0x90
>  	 [<c13d1c18>] ? usb_deregister+0x58/0xb0
> -	 [<c109fbb0>] ? SyS_delete_module+0x130/0x1f0
> +	 [<c109fbb0>] ? __se_sys_delete_module+0x130/0x1f0
>  	 [<c1055654>] ? task_work_run+0x64/0x80
>  	 [<c1000fa5>] ? exit_to_usermode_loop+0x85/0x90
>  	 [<c10013f0>] ? do_fast_syscall_32+0x80/0x130
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index f7a18f274357..0fe231401ae9 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -60,7 +60,7 @@ A typical out of bounds access report looks like this::
>       init_module+0x9/0x47 [test_kasan]
>       do_one_initcall+0x99/0x200
>       load_module+0x2cb3/0x3b20
> -     SyS_finit_module+0x76/0x80
> +     __se_sys_finit_module+0x76/0x80
>       system_call_fastpath+0x12/0x17
>      INFO: Slab 0xffffea0001a4ef00 objects=17 used=7 fp=0xffff8800693bd728 flags=0x100000000004080
>      INFO: Object 0xffff8800693bc558 @offset=1368 fp=0xffff8800693bc720
> @@ -101,7 +101,7 @@ A typical out of bounds access report looks like this::
>       [<ffffffff811e4e5c>] ? __vunmap+0xec/0x160
>       [<ffffffff81114f63>] load_module+0x2cb3/0x3b20
>       [<ffffffff8110fd70>] ? m_show+0x240/0x240
> -     [<ffffffff81115f06>] SyS_finit_module+0x76/0x80
> +     [<ffffffff81115f06>] __se_sys_finit_module+0x76/0x80
>       [<ffffffff81cd3129>] system_call_fastpath+0x12/0x17
>      Memory state around the buggy address:
>       ffff8800693bc300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index c2f6452e38ed..df3f4016137a 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -103,7 +103,7 @@ program using kcov:
>  
>  After piping through addr2line output of the program looks as follows::
>  
> -    SyS_read
> +    __se_sys_read
>      fs/read_write.c:562
>      __fdget_pos
>      fs/file.c:774
> @@ -115,7 +115,7 @@ After piping through addr2line output of the program looks as follows::
>      fs/file.c:760
>      __fdget_pos
>      fs/file.c:784
> -    SyS_read
> +    __se_sys_read
>      fs/read_write.c:562
>  
>  If a program needs to collect coverage from several threads (independently),
> diff --git a/Documentation/locking/lockstat.txt b/Documentation/locking/lockstat.txt
> index 5786ad2cd5e6..346a67e72671 100644
> --- a/Documentation/locking/lockstat.txt
> +++ b/Documentation/locking/lockstat.txt
> @@ -96,7 +96,7 @@ Look at the current lock statistics:
>  12                           &mm->mmap_sem             17          [<ffffffff81127e71>] vm_munmap+0x41/0x80
>  13                         ---------------
>  14                           &mm->mmap_sem              1          [<ffffffff81046fda>] dup_mmap+0x2a/0x3f0
> -15                           &mm->mmap_sem             60          [<ffffffff81129e29>] SyS_mprotect+0xe9/0x250
> +15                           &mm->mmap_sem             60          [<ffffffff81129e29>] __se_sys_mprotect+0xe9/0x250
>  16                           &mm->mmap_sem             41          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
>  17                           &mm->mmap_sem             68          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
>  18
> diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
> index 6e05510afc28..f36784deae99 100644
> --- a/Documentation/trace/histogram.txt
> +++ b/Documentation/trace/histogram.txt
> @@ -598,7 +598,7 @@
>           apparmor_cred_prepare+0x1f/0x50
>           security_prepare_creds+0x16/0x20
>           prepare_creds+0xdf/0x1a0
> -         SyS_capset+0xb5/0x200
> +         __se_sys_capset+0xb5/0x200
>           system_call_fastpath+0x12/0x6a
>      } hitcount:          1  bytes_req:         32  bytes_alloc:         32
>      .
> @@ -609,7 +609,7 @@
>           i915_gem_execbuffer2+0x6c/0x2c0 [i915]
>           drm_ioctl+0x349/0x670 [drm]
>           do_vfs_ioctl+0x2f0/0x4f0
> -         SyS_ioctl+0x81/0xa0
> +         __se_sys_ioctl+0x81/0xa0
>           system_call_fastpath+0x12/0x6a
>      } hitcount:      17726  bytes_req:   13944120  bytes_alloc:   19593808
>      { stacktrace:
> @@ -618,7 +618,7 @@
>           load_elf_binary+0x102/0x1650
>           search_binary_handler+0x97/0x1d0
>           do_execveat_common.isra.34+0x551/0x6e0
> -         SyS_execve+0x3a/0x50
> +         __se_sys_execve+0x3a/0x50
>           return_from_execve+0x0/0x23
>      } hitcount:      33348  bytes_req:   17152128  bytes_alloc:   20226048
>      { stacktrace:
> @@ -629,7 +629,7 @@
>           path_openat+0x31/0x5f0
>           do_filp_open+0x3a/0x90
>           do_sys_open+0x128/0x220
> -         SyS_open+0x1e/0x20
> +         __se_sys_open+0x1e/0x20
>           system_call_fastpath+0x12/0x6a
>      } hitcount:    4766422  bytes_req:    9532844  bytes_alloc:   38131376
>      { stacktrace:
> @@ -639,7 +639,7 @@
>           proc_reg_read+0x3d/0x80
>           __vfs_read+0x28/0xe0
>           vfs_read+0x86/0x140
> -         SyS_read+0x46/0xb0
> +         __se_sys_read+0x46/0xb0
>           system_call_fastpath+0x12/0x6a
>      } hitcount:      19133  bytes_req:   78368768  bytes_alloc:   78368768
>  
> @@ -1535,8 +1535,8 @@
>               udp_sendmsg+0x2bf/0x980
>               inet_sendmsg+0x67/0xa0
>               sock_sendmsg+0x38/0x50
> -             SYSC_sendto+0xef/0x170
> -             SyS_sendto+0xe/0x10
> +             __do_sys_sendto+0xef/0x170
> +             __se_sys_sendto+0xe/0x10
>               entry_SYSCALL_64_fastpath+0x12/0x6a
>      } hitcount:          2
>      { stacktrace:
> @@ -1591,11 +1591,11 @@
>               udp_sendmsg+0x2bf/0x980
>               inet_sendmsg+0x67/0xa0
>               sock_sendmsg+0x38/0x50
> -             SYSC_sendto+0xef/0x170
> +             __do_sys_sendto+0xef/0x170
>      } hitcount:         88
>      { stacktrace:
>               _do_fork+0x18e/0x330
> -             SyS_clone+0x19/0x20
> +             __se_sys_clone+0x19/0x20
>               entry_SYSCALL_64_fastpath+0x12/0x6a
>      } hitcount:        244
>  
