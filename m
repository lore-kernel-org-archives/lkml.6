Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBZKBl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:01:41 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:56089 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBZKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:01:37 -0500
X-Google-Smtp-Source: AG47ELvJuBLeqjMXZgUpjqZsjDhuDWx1d0Z8gPMlBG7QKYsU9T53xP+tO+8ZXgUZT9EZn5SkSyRcCg==
Date: Mon, 26 Feb 2018 19:01:39 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Dave Young <dyoung@redhat.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/13] kexec_file,x86,powerpc: factor out
 kexec_file_ops functions
Message-ID: <20180226100138.GC6019@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, bauerman@linux.vnet.ibm.com,
        dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-4-takahiro.akashi@linaro.org>
 <20180223092459.GC4433@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223092459.GC4433@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 05:24:59PM +0800, Dave Young wrote:
> Hi AKASHI,
> 
> On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > As arch_kexec_kernel_*_{probe,load}(), arch_kimage_file_post_load_cleanup()
> > and arch_kexec_kernel_verify_sg can be parameterized with a kexec_file_ops
> > array and now duplicated among some architectures, let's factor them out.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kexec.h            |  2 +-
> >  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
> >  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++------------------
> >  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
> >  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
> >  arch/x86/kernel/machine_kexec_64.c          | 45 +----------------------
> >  include/linux/kexec.h                       | 15 ++++----
> >  kernel/kexec_file.c                         | 57 +++++++++++++++++++++++++++--
> >  8 files changed, 70 insertions(+), 94 deletions(-)
> > 
> 
> [snip]
> 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 990adae52151..a6d14a768b3e 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -26,34 +26,83 @@
> >  #include <linux/vmalloc.h>
> >  #include "kexec_internal.h"
> >  
> > +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> > +
> >  #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >  #else
> >  static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> >  #endif
> >  
> > +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> > +			     unsigned long buf_len)
> > +{
> > +	const struct kexec_file_ops * const *fops;
> > +	int ret = -ENOEXEC;
> > +
> > +	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> > +		ret = (*fops)->probe(buf, buf_len);
> > +		if (!ret) {
> > +			image->fops = *fops;
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /* Architectures can provide this probe function */
> >  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> >  					 unsigned long buf_len)
> >  {
> > -	return -ENOEXEC;
> > +	return _kexec_kernel_image_probe(image, buf, buf_len);
> 
> 
> I vaguely remember previously I suggest split the _kexec_kernel_image_probe
> because arch code can call them, and common code also use it like above.
> But in your new series I do not find where else calls this function
> except the common code arch_kexec_kernel_image_probe.  If nobody use
> them then it is not worth to split them out, it is better to just embed
> them in the __weak functions.

Powerpc's arch_kexec_kernel_image_probe() uses
_kexec_kekrnel_image_probe() as it needs an extra check to rule out
crash dump for now.

Thanks,
-Takahiro AKASHI


> Ditto for other similar functions.
> 
> [snip]
> 
> Thanks
> Dave
