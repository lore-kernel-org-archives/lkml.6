Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeBZLZT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:25:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752131AbeBZLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:25:16 -0500
Date: Mon, 26 Feb 2018 12:25:05 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>, herbert@gondor.apana.org.au,
        bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dhowells@redhat.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org,
        davem@davemloft.net, vgoyal@redhat.com
Subject: Re: [PATCH v8 03/13] kexec_file,x86,powerpc: factor out
 kexec_file_ops functions
In-Reply-To: <20180226100138.GC6019@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
        <20180222111732.23051-4-takahiro.akashi@linaro.org>
        <20180223092459.GC4433@dhcp-128-65.nay.redhat.com>
        <20180226100138.GC6019@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022611-0020-0000-0000-000003FBF026
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022611-0021-0000-0000-0000429010A2
Message-Id: <20180226122505.3d999efc@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 19:01:39 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> On Fri, Feb 23, 2018 at 05:24:59PM +0800, Dave Young wrote:
> > Hi AKASHI,
> > 
> > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:  
> > > As arch_kexec_kernel_*_{probe,load}(), arch_kimage_file_post_load_cleanup()
> > > and arch_kexec_kernel_verify_sg can be parameterized with a kexec_file_ops
> > > array and now duplicated among some architectures, let's factor them out.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/kexec.h            |  2 +-
> > >  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
> > >  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++------------------
> > >  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
> > >  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
> > >  arch/x86/kernel/machine_kexec_64.c          | 45 +----------------------
> > >  include/linux/kexec.h                       | 15 ++++----
> > >  kernel/kexec_file.c                         | 57 +++++++++++++++++++++++++++--
> > >  8 files changed, 70 insertions(+), 94 deletions(-)
> > >   
> > 
> > [snip]
> >   
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 990adae52151..a6d14a768b3e 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -26,34 +26,83 @@
> > >  #include <linux/vmalloc.h>
> > >  #include "kexec_internal.h"
> > >  
> > > +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> > > +
> > >  #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> > >  static int kexec_calculate_store_digests(struct kimage *image);
> > >  #else
> > >  static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> > >  #endif
> > >  
> > > +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > +			     unsigned long buf_len)
> > > +{
> > > +	const struct kexec_file_ops * const *fops;
> > > +	int ret = -ENOEXEC;
> > > +
> > > +	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> > > +		ret = (*fops)->probe(buf, buf_len);
> > > +		if (!ret) {
> > > +			image->fops = *fops;
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /* Architectures can provide this probe function */
> > >  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > >  					 unsigned long buf_len)
> > >  {
> > > -	return -ENOEXEC;
> > > +	return _kexec_kernel_image_probe(image, buf, buf_len);  
> > 
> > 
> > I vaguely remember previously I suggest split the _kexec_kernel_image_probe
> > because arch code can call them, and common code also use it like above.
> > But in your new series I do not find where else calls this function
> > except the common code arch_kexec_kernel_image_probe.  If nobody use
> > them then it is not worth to split them out, it is better to just embed
> > them in the __weak functions.  
> 
> Powerpc's arch_kexec_kernel_image_probe() uses
> _kexec_kekrnel_image_probe() as it needs an extra check to rule out
> crash dump for now.

s390 has to use it too. We have to write to a fixed address in the buffer. So
we need to check if the buffer is large enough to write to that address.

Philipp
 
> Thanks,
> -Takahiro AKASHI
> 
> 
> > Ditto for other similar functions.
> > 
> > [snip]
> > 
> > Thanks
> > Dave  
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
