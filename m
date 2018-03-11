Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeCKVqA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:46:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50283 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeCKVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:45:58 -0400
X-Google-Smtp-Source: AG47ELtCOiw4WYjxLM6EB7aO7iPXiXKGtEeH+fuKK+xkZDBn9NQxpYE93Iyie5jOCDtgmEd72uDThDF7ITpxR4Qo3uU=
MIME-Version: 1.0
In-Reply-To: <20180311192256.GA630@zzz.localdomain>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-6-git-send-email-jix024@eng.ucsd.edu> <0924a2b3-6f21-4aaf-224d-2f5accc21d10@gmail.com>
 <20180311192256.GA630@zzz.localdomain>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Sun, 11 Mar 2018 14:45:57 -0700
Message-ID: <CAD4Szjvo_wuqOZyoaW6gJsuDiNjyHkh4nGW+QdMR0U-NzBXBsg@mail.gmail.com>
Subject: Re: [RFC v2 05/83] Add NOVA filesystem definitions and useful helper routines.
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com, swhiteho@redhat.com,
        miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>, herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 12:22 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Sun, Mar 11, 2018 at 02:00:13PM +0200, Nikolay Borisov wrote:
>> [Adding Herbert Xu to CC since he is the maintainer of the crypto subsys
>> maintainer]
>>
>> On 10.03.2018 20:17, Andiry Xu wrote:
>> <snip>
>>
>> > +static inline u32 nova_crc32c(u32 crc, const u8 *data, size_t len)
>> > +{
>> > +   u8 *ptr = (u8 *) data;
>> > +   u64 acc = crc; /* accumulator, crc32c value in lower 32b */
>> > +   u32 csum;
>> > +
>> > +   /* x86 instruction crc32 is part of SSE-4.2 */
>> > +   if (static_cpu_has(X86_FEATURE_XMM4_2)) {
>> > +           /* This inline assembly implementation should be equivalent
>> > +            * to the kernel's crc32c_intel_le_hw() function used by
>> > +            * crc32c(), but this performs better on test machines.
>> > +            */
>> > +           while (len > 8) {
>> > +                   asm volatile(/* 64b quad words */
>> > +                           "crc32q (%1), %0"
>> > +                           : "=r" (acc)
>> > +                           : "r"  (ptr), "0" (acc)
>> > +                   );
>> > +                   ptr += 8;
>> > +                   len -= 8;
>> > +           }
>> > +
>> > +           while (len > 0) {
>> > +                   asm volatile(/* trailing bytes */
>> > +                           "crc32b (%1), %0"
>> > +                           : "=r" (acc)
>> > +                           : "r"  (ptr), "0" (acc)
>> > +                   );
>> > +                   ptr++;
>> > +                   len--;
>> > +           }
>> > +
>> > +           csum = (u32) acc;
>> > +   } else {
>> > +           /* The kernel's crc32c() function should also detect and use the
>> > +            * crc32 instruction of SSE-4.2. But calling in to this function
>> > +            * is about 3x to 5x slower than the inline assembly version on
>> > +            * some test machines.
>>
>> That is really odd. Did you try to characterize why this is the case? Is
>> it purely the overhead of dispatching to the correct backend function?
>> That's a rather big performance hit.
>>
>> > +            */
>> > +           csum = crc32c(crc, data, len);
>> > +   }
>> > +
>> > +   return csum;
>> > +}
>> > +
>
> Are you sure that CONFIG_CRYPTO_CRC32C_INTEL was enabled during your tests and
> that the accelerated version was being called?  Or, perhaps CRC32C_PCL_BREAKEVEN
> (defined in arch/x86/crypto/crc32c-intel_glue.c) needs to be adjusted.  Please
> don't hack around performance problems like this; if they exist, they need to be
> fixed for everyone.
>

I think we found the issue when implementing NOVA-Fortis metadata and
data protections, which use crc32c a lot. They have been removed in
this patchset; but I will double check and make sure if the issue
exists or not.

Thanks,
Andiry

> Eric
