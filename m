Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFDSqw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:46:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24887 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeFDSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:46:51 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="176488093"
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <albert@sifive.com>
References: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
 <20180601152123.47256-4-luc.vanoostenryck@gmail.com>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <235fec3e-be2e-874a-8313-e7390fcdca74@wdc.com>
Date: Mon, 4 Jun 2018 11:46:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601152123.47256-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/18 8:22 AM, Luc Van Oostenryck wrote:
> __copy_user() is a function, written in assembly, used to copy
> memory between kernel & user space. As such its to & from args
> may both take a user pointer or a kernel pointer.
> 
> However the prototype for this function declare these two args
> as 'void __user *', which is no more & no less correct than
> declaring them as 'void *'. In fact theer is no possible correct

/s/theer/there

> annotation for such a function.
> 
> The problem is worked around here by declaring these args as
> unsigned long and casting them to the right type in each of
> two callers raw_copy_{to,from}_user() as some kind of cast would
> be needed anyway.
> 
> Note: another solution, maybe cleaner but slightly more complex,
>        would be to declare two version of __copy_user,
>        either in the asm file or via an alias, each having already
>        the correct typing for raw_copy_{to,from}_user().
> 

I feel that would be a better solution as it is implemented similarly
in ARM as well.

I am unable to understand how "unsigned long" is better than "void*".
x86 implementation has both arguments as void*. Can you please clarify ?


Regards,
Atish
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   arch/riscv/include/asm/uaccess.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 14b0b22fb..c7a6a4a4a 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -392,19 +392,19 @@ do {								\
>   })
>   
>   
> -extern unsigned long __must_check __copy_user(void __user *to,
> -	const void __user *from, unsigned long n);
> +extern unsigned long __must_check __copy_user(unsigned long to,
> +	const unsigned long from, unsigned long n);
>   
>   static inline unsigned long
>   raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>   {
> -	return __copy_user(to, from, n);
> +	return __copy_user((unsigned long)to, (unsigned long)from, n);
>   }
>   
>   static inline unsigned long
>   raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>   {
> -	return __copy_user(to, from, n);
> +	return __copy_user((unsigned long)to, (unsigned long)from, n);
>   }
>   
>   extern long strncpy_from_user(char *dest, const char __user *src, long count);
> 
