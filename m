Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034214AbeCBH0s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:26:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33028 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbeCBH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:26:44 -0500
X-Google-Smtp-Source: AG47ELtxzTqfa0K3M0YyBcPPRVmPHzMtNhD8ZNtjByjvXNHbc1RtzkroTj4czc40IBHXRLv3CHMZvw==
Date: Fri, 2 Mar 2018 16:26:56 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Dave Young <dyoung@redhat.com>
Cc: vgoyal@redhat.com, bhe@redhat.com, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/7] kexec_file: make an use of purgatory optional
Message-ID: <20180302072655.GT6019@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
 <20180227044814.24808-2-takahiro.akashi@linaro.org>
 <20180302055859.GB15422@dhcp-128-65.nay.redhat.com>
 <20180302061114.GE15422@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302061114.GE15422@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 02:11:14PM +0800, Dave Young wrote:
> On 03/02/18 at 01:58pm, Dave Young wrote:
> > On 02/27/18 at 01:48pm, AKASHI Takahiro wrote:
> > > On arm64, crash dump kernel's usable memory is protected by
> > > *unmapping* it from kernel virtual space unlike other architectures
> > > where the region is just made read-only. It is highly unlikely that
> > > the region is accidentally corrupted and this observation rationalizes
> > > that digest check code can also be dropped from purgatory.
> > > The resulting code is so simple as it doesn't require a bit ugly
> > > re-linking/relocation stuff, i.e. arch_kexec_apply_relocations_add().
> > > 
> > > Please see:
> > >    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
> > > All that the purgatory does is to shuffle arguments and jump into a new
> > > kernel, while we still need to have some space for a hash value
> > > (purgatory_sha256_digest) which is never checked against.
> > > 
> > > As such, it doesn't make sense to have trampline code between old kernel
> > > and new kernel on arm64.
> > > 
> > > This patch introduces a new configuration, ARCH_HAS_KEXEC_PURGATORY, and
> > > allows related code to be compiled in only if necessary.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/powerpc/Kconfig | 3 +++
> > >  arch/x86/Kconfig     | 3 +++
> > >  kernel/kexec_file.c  | 6 ++++++
> > >  3 files changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index 73ce5dd07642..c32a181a7cbb 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -552,6 +552,9 @@ config KEXEC_FILE
> > >  	  for kernel and initramfs as opposed to a list of segments as is the
> > >  	  case for the older kexec call.
> > >  
> > > +config ARCH_HAS_KEXEC_PURGATORY
> > > +	def_bool KEXEC_FILE
> > > +
> > >  config RELOCATABLE
> > >  	bool "Build a relocatable kernel"
> > >  	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index c1236b187824..f031c3efe47e 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2019,6 +2019,9 @@ config KEXEC_FILE
> > >  	  for kernel and initramfs as opposed to list of segments as
> > >  	  accepted by previous system call.
> > >  
> > > +config ARCH_HAS_KEXEC_PURGATORY
> > > +	def_bool KEXEC_FILE
> > > +
> > >  config KEXEC_VERIFY_SIG
> > >  	bool "Verify kernel signature during kexec_file_load() syscall"
> > >  	depends on KEXEC_FILE
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index e5bcd94c1efb..990adae52151 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -26,7 +26,11 @@
> > >  #include <linux/vmalloc.h>
> > >  #include "kexec_internal.h"
> > >  
> > > +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> > >  static int kexec_calculate_store_digests(struct kimage *image);
> > > +#else
> > > +static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> > > +#endif
> > >  
> > >  /* Architectures can provide this probe function */
> > >  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > @@ -520,6 +524,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> > >  	return 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> > >  /* Calculate and store the digest of segments */
> > >  static int kexec_calculate_store_digests(struct kimage *image)
> > >  {
> > > @@ -1022,3 +1027,4 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
> > >  
> > >  	return 0;
> > >  }
> > > +#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> > > -- 
> > > 2.16.2
> > > 
> > 
> > For this one, I think purgatory digest verification is still good to
> > have, but I do not insist since this is arch specific.
> > 
> > If nobody else objects then I think I can ack the series after some
> > testing passed.
> 
> For the #ifdefs, they can be changed to IS_ENABLED like other similar
> thing.

Ah, OK.

/* Calculate and store the digest of segments */
static int kexec_calculate_store_digests(struct kimage *image)
{
        if (IS_ENABLED(ARCH_HAS_PURGATORY)) {
                /* ... */
        } else {
                return 0;
        }
}

Many thanks,
-Takahiro AKASHI



> 
> > 
> > Thanks
> > Dave
