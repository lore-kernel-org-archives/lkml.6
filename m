Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA25C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F8F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfBGFEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:04:10 -0500
Received: from ozlabs.org ([203.11.71.1]:55265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfBGFEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:04:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w5ng2hX4z9s6w;
        Thu,  7 Feb 2019 16:04:07 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
In-Reply-To: <20190205174242.GA24427@kermit.br.ibm.com>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr> <20190205174242.GA24427@kermit.br.ibm.com>
Date:   Thu, 07 Feb 2019 16:04:07 +1100
Message-ID: <87zhr8jik8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 37b226e8df13..ef99edd63da3 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>>  #define probe_kernel_address(addr, retval)		\
>>  	probe_kernel_read(&retval, addr, sizeof(retval))
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
>> +					    size_t size)
>> +{
>> +	long ret;
>> +
>> +	if (!access_ok(src, size))
>> +		return -EFAULT;
>
> Hopefully, there is still time for a minor comment.
>
> Do we need to differentiate the returned error here, e.g.: return
> -EACCES?
>
> I wonder if there will be situations where callers need to know why
> probe_user_read() failed.

It's pretty standard to return EFAULT when an access_ok() check fails,
so I think using EFAULT here is the safest option.

If we used EACCES we'd need to be more careful about converting code to
use this helper, as doing so would potentially cause the error value to
change, which in some cases is not OK.

cheers
