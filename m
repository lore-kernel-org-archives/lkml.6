Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeCECg0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:36:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932417AbeCECgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:36:24 -0500
Date: Mon, 5 Mar 2018 10:36:07 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: vgoyal@redhat.com, bhe@redhat.com, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/7] kexec_file: refactoring for other architecutres
Message-ID: <20180305023607.GA4185@dhcp-128-65.nay.redhat.com>
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
 <20180302055609.GA15422@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302055609.GA15422@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/18 at 01:56pm, Dave Young wrote:
> Hi AKASHI,
> On 02/27/18 at 01:48pm, AKASHI Takahiro wrote:
> > subject: 
> > 
> > This is a preparatory patch set for adding kexec_file support on arm64.
> > 
> > It was originally included in a arm64 patch set[1], but Philipp is also
> > working on their kexec_file support on s390[2] and some changes are now
> > conflicting.
> > 
> > So these common part was extracted and put into a separate patch set for
> > better integration. What's more, my original patch#4 was split into a few
> > small chunks for easier review after Dave's comment.
> > 
> > As such, the resulting code is basically identical with my original, and
> > the only difference is that kexec_file_loaders[] is now declared in kexec.h
> > after Phillipp's comment[3]. Other than that, this patch set doesn't
> > require any changes on the rest of my original patch set(#1, #6 to #13).
> > 
> > Patch#1 allows making a use of purgatory optional, particularly useful
> > for arm64.
> > Patch#2 commonalizes arch_kexec_kernel_{image_probe, image_load,
> > verify_sig}() and arch_kimage_file_post_load_cleanup() across architectures.
> > Patch#3-#7 is also intended to generalize parse_elf64_headers(), along with
> > exclude_mem_range(), to be made best re-use of.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/561182.html
> > [2] http://lkml.iu.edu//hypermail/linux/kernel/1802.1/02596.html
> > [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/562041.html
> > 
> > AKASHI Takahiro (7):
> >   kexec_file: make an use of purgatory optional
> >   kexec_file,x86,powerpc: factor out kexec_file_ops functions
> >   x86: kexec_file: purge system-ram walking from prepare_elf64_headers()
> >   x86: kexec_file: remove X86_64 dependency from prepare_elf64_headers()
> >   x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer
> >   x86: kexec_file: clean up prepare_elf64_headers()
> >   kexec_file, x86: move re-factored code to generic side
> > 
> >  arch/powerpc/Kconfig                        |   3 +
> >  arch/powerpc/include/asm/kexec.h            |   2 +-
> >  arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
> >  arch/powerpc/kernel/machine_kexec_file_64.c |  39 +---
> >  arch/x86/Kconfig                            |   3 +
> >  arch/x86/include/asm/kexec-bzimage64.h      |   2 +-
> >  arch/x86/kernel/crash.c                     | 332 +++++-----------------------
> >  arch/x86/kernel/kexec-bzimage64.c           |   2 +-
> >  arch/x86/kernel/machine_kexec_64.c          |  45 +---
> >  include/linux/kexec.h                       |  36 ++-
> >  kernel/kexec_file.c                         | 236 +++++++++++++++++++-
> >  11 files changed, 336 insertions(+), 366 deletions(-)
> > 
> > -- 
> > 2.16.2
> > 
> 
> Reviewed them with eyes and provided some comments, but since it changed
> the elf header code, I would like to do some basic vmcore related test
> with crash tools.  Will response later.

Followup: I did some basic testing, did not find problems.

> 
> Overall the cleanups looks good, thank you a lot for the cleanups!
> 
> Thanks
> Dave

Thanks
Dave
