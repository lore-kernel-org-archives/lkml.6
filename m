Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97990C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC4521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBHDB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:01:27 -0500
Received: from ozlabs.org ([203.11.71.1]:33491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfBHDB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:01:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wg1b29qsz9sBZ;
        Fri,  8 Feb 2019 14:01:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jann Horn <jannh@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
In-Reply-To: <CAG48ez1gXgsBG6bYGG5+B4Dqkhk_iVaYLqt63RaxURxE0yt9eA@mail.gmail.com>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr> <CAG48ez1gXgsBG6bYGG5+B4Dqkhk_iVaYLqt63RaxURxE0yt9eA@mail.gmail.com>
Date:   Fri, 08 Feb 2019 14:01:22 +1100
Message-ID: <87imxvj859.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:
> On Thu, Feb 7, 2019 at 10:22 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> In powerpc code, there are several places implementing safe
>> access to user data. This is sometimes implemented using
>> probe_kernel_address() with additional access_ok() verification,
>> sometimes with get_user() enclosed in a pagefault_disable()/enable()
>> pair, etc. :
>>     show_user_instructions()
>>     bad_stack_expansion()
>>     p9_hmi_special_emu()
>>     fsl_pci_mcheck_exception()
>>     read_user_stack_64()
>>     read_user_stack_32() on PPC64
>>     read_user_stack_32() on PPC32
>>     power_pmu_bhrb_to()
>>
>> In the same spirit as probe_kernel_read(), this patch adds
>> probe_user_read().
>>
>> probe_user_read() does the same as probe_kernel_read() but
>> first checks that it is really a user address.
>>
>> The patch defines this function as a static inline so the "size"
>> variable can be examined for const-ness by the check_object_size()
>> in __copy_from_user_inatomic()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
>
>
>> ---
>>  v3: Moved 'Returns:" comment after description.
>>      Explained in the commit log why the function is defined static inline
>>
>>  v2: Added "Returns:" comment and removed probe_user_address()
>>
>>  include/linux/uaccess.h | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 37b226e8df13..ef99edd63da3 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>>  #define probe_kernel_address(addr, retval)             \
>>         probe_kernel_read(&retval, addr, sizeof(retval))
>>
>> +/**
>> + * probe_user_read(): safely attempt to read from a user location
>> + * @dst: pointer to the buffer that shall take the data
>> + * @src: address to read from
>> + * @size: size of the data chunk
>> + *
>> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
>> + * happens, handle that and return -EFAULT.
>> + *
>> + * We ensure that the copy_from_user is executed in atomic context so that
>> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
>> + * probe_user_read() suitable for use within regions where the caller
>> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
>> + *
>> + * Returns: 0 on success, -EFAULT on error.
>> + */
>> +
>> +#ifndef probe_user_read
>> +static __always_inline long probe_user_read(void *dst, const void __user *src,
>> +                                           size_t size)
>> +{
>> +       long ret;
>> +
>> +       if (!access_ok(src, size))
>> +               return -EFAULT;
>
> If this happens in code that's running with KERNEL_DS, the access_ok()
> is a no-op. If this helper is only intended for accessing real
> userspace memory, it would be more robust to add
> set_fs(USER_DS)/set_fs(oldfs) around this thing. Looking at the
> functions you're referring to in the commit message, e.g.
> show_user_instructions() does an explicit `__access_ok(pc,
> NR_INSN_TO_PRINT * sizeof(int), USER_DS)` to get the same effect.

Yeah I raised the same question up thread.

I think we're both right :) - it should explicitly set USER_DS.

There's precedent for that in the code you mentioned and also in the
perf code, eg:

  88b0193d9418 ("perf/callchain: Force USER_DS when invoking perf_callchain_user()")


cheers
