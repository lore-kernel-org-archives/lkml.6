Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971358AbeCSUac (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:30:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34913 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968853AbeCSUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:30:25 -0400
X-Google-Smtp-Source: AG47ELtI1Wyd+VyPuUmNSugR6d3RwiWL5RrpujOZqcCpWAdXT6qkOlCqn9yaVkU2LG/V/+8Buv/IZA==
Date: Mon, 19 Mar 2018 13:30:21 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Andiry Xu <jix024@eng.ucsd.edu>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        swhiteho@redhat.com, miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [RFC v2 05/83] Add NOVA filesystem definitions and useful helper
 routines.
Message-ID: <20180319203021.GA59118@gmail.com>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-6-git-send-email-jix024@eng.ucsd.edu>
 <0924a2b3-6f21-4aaf-224d-2f5accc21d10@gmail.com>
 <20180311192256.GA630@zzz.localdomain>
 <CAD4Szjsc3kwysGNTEBtOB-F8ZtnmOsmsUm+o6cDZYbvHZkoEsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4Szjsc3kwysGNTEBtOB-F8ZtnmOsmsUm+o6cDZYbvHZkoEsg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:39:55PM -0700, Andiry Xu wrote:
> On Sun, Mar 11, 2018 at 12:22 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Sun, Mar 11, 2018 at 02:00:13PM +0200, Nikolay Borisov wrote:
> >> [Adding Herbert Xu to CC since he is the maintainer of the crypto subsys
> >> maintainer]
> >>
> >> On 10.03.2018 20:17, Andiry Xu wrote:
> >> <snip>
> >>
> >> > +static inline u32 nova_crc32c(u32 crc, const u8 *data, size_t len)
> >> > +{
> >> > +   u8 *ptr = (u8 *) data;
> >> > +   u64 acc = crc; /* accumulator, crc32c value in lower 32b */
> >> > +   u32 csum;
> >> > +
> >> > +   /* x86 instruction crc32 is part of SSE-4.2 */
> >> > +   if (static_cpu_has(X86_FEATURE_XMM4_2)) {
> >> > +           /* This inline assembly implementation should be equivalent
> >> > +            * to the kernel's crc32c_intel_le_hw() function used by
> >> > +            * crc32c(), but this performs better on test machines.
> >> > +            */
> >> > +           while (len > 8) {
> >> > +                   asm volatile(/* 64b quad words */
> >> > +                           "crc32q (%1), %0"
> >> > +                           : "=r" (acc)
> >> > +                           : "r"  (ptr), "0" (acc)
> >> > +                   );
> >> > +                   ptr += 8;
> >> > +                   len -= 8;
> >> > +           }
> >> > +
> >> > +           while (len > 0) {
> >> > +                   asm volatile(/* trailing bytes */
> >> > +                           "crc32b (%1), %0"
> >> > +                           : "=r" (acc)
> >> > +                           : "r"  (ptr), "0" (acc)
> >> > +                   );
> >> > +                   ptr++;
> >> > +                   len--;
> >> > +           }
> >> > +
> >> > +           csum = (u32) acc;
> >> > +   } else {
> >> > +           /* The kernel's crc32c() function should also detect and use the
> >> > +            * crc32 instruction of SSE-4.2. But calling in to this function
> >> > +            * is about 3x to 5x slower than the inline assembly version on
> >> > +            * some test machines.
> >>
> >> That is really odd. Did you try to characterize why this is the case? Is
> >> it purely the overhead of dispatching to the correct backend function?
> >> That's a rather big performance hit.
> >>
> >> > +            */
> >> > +           csum = crc32c(crc, data, len);
> >> > +   }
> >> > +
> >> > +   return csum;
> >> > +}
> >> > +
> >
> > Are you sure that CONFIG_CRYPTO_CRC32C_INTEL was enabled during your tests and
> > that the accelerated version was being called?  Or, perhaps CRC32C_PCL_BREAKEVEN
> > (defined in arch/x86/crypto/crc32c-intel_glue.c) needs to be adjusted.  Please
> > don't hack around performance problems like this; if they exist, they need to be
> > fixed for everyone.
> >
> 
> I have performed the crc32c test on a Xeon X5647 at 2.93GHz, 14G DDR3
> memory at 1066MHz platform.
> You are right that enabling CONFIG_CRYPTO_CRC32C_INTEL improves the
> performance significantly. nova_crc32c() is still slightly faster than
> crc32c() with the flag enabled.
> 
> Result numbers are follows: data size in bytes, latency in ns, column
> 3 is crc32c() with  CONFIG_CRYPTO_CRC32C_INTEL enabled and column 4
> disabled.
> 
> data size (bytes)        nova_crc32c()        crc32c() -enabled
> crc32c() -disabled
> 64                              19                           21 56
> 128                            28                           29 99
> 256                            46                           43 182
> 512                            82                           149 354
> 1024                          157                         232 728
> 2048                          305                         415 1440
> 4096                          603                         725 2869
> 

Probably CRC32C_PCL_BREAKEVEN needs to be adjusted for that CPU, as I suggested
may be the case; notice that your measured speeds are about the same before 512
(CRC32C_PCL_BREAKEVEN) bytes, but the crypto API version is slower at >= 512
bytes.   It would be possible to set the breakeven point in
crc32c_intel_mod_init() depending on the CPU.  Again, if the performance is not
good enough you need to fix it for everyone, not hack around it.

Thanks,

Eric
