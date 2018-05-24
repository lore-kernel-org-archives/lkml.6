Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161576AbeEXV4h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:56:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55693 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969755AbeEXV4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:56:36 -0400
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com>
 <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
 <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
 <CAKwvOdnKo4k_Q7dRF0vSq7FuwiDsy3hdx9kPvrgMrb5pV_nS2Q@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <edccc580-5dac-a747-4326-53f401c8fab9@zytor.com>
Date: Thu, 24 May 2018 14:56:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnKo4k_Q7dRF0vSq7FuwiDsy3hdx9kPvrgMrb5pV_nS2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/18 14:27, Nick Desaulniers wrote:
> https://godbolt.org/g/oku8ux
> 
> Is there a more canonical way the kernel does feature detection that looks
> better than:
> 

Hm. I though we had, but it doesn't seem so. For cc we only seem to be
able to detect flags. For as we have rules that can detect new
instructions; something similar in Kbuild would be good.

> diff --git a/arch/x86/include/asm/irqflags.h
> b/arch/x86/include/asm/irqflags.h
> index 89f08955fff7..90974b5d023c 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -13,6 +13,8 @@
>    * Interrupt control:
>    */
> 
> +#ifdef GCC_VERSION
> +#if GCC_VERSION < 40900

We don't actually test if GCC_VERSION is defined anywhere in the kernel.
We probably should explicitly define it to either 0 or some baseline
version if it is undefined.  (Clang defines __GNUC__ so it will define
GCC_VERSION.)

	-hpa
