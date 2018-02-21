Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeBUI5x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:57:53 -0500
Received: from mail01.prevas.se ([62.95.78.3]:10906 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeBUI5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:57:51 -0500
X-IronPort-AV: E=Sophos;i="5.46,543,1511823600";
   d="scan'208";a="3278863"
Subject: Re: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180217072011.GB16074@avx2>
 <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
 <20180220160212.8f3942d40e0b4014e2aa457c@linux-foundation.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <317b6413-0a46-8f5c-ad24-c5e183bc9a7a@prevas.dk>
Date: Wed, 21 Feb 2018 09:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220160212.8f3942d40e0b4014e2aa457c@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-21 01:02, Andrew Morton wrote:
> On Sat, 17 Feb 2018 16:06:42 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Sat, Feb 17, 2018 at 9:20 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>
>>
>>> -               seq_printf(m, "%s", symname);
>>> +               seq_puts(m, symname);
>>
>> While this might have no security concerns, the pattern might be
>> brainlessly used by some janitors and there would have security
>> implications.
> 
> And I'd like to see a changelog, please.  One which explains why
> `symname' cannot have a %s (etc) in it, and never will.

OK, since #youtoo: It doesn't _matter_ if symname is "%pHAHAHA %fooled
you <unicode for evil grin emoji>", seq_puts does not interpret it at
all. There are _never_ security implications with the above replacement.
Sure, seq_printf(m, symname) would be bad, but that's not what is being
done.

AFAICT, this should always lead to slightly smaller code (one less
parameter passed) and in all likelyhood also slightly faster (no format
interpretation, no slow char-by-char handling by the string() function
etc.). So the only case where I'd think this should not necessarily be
done would be in a long sequence of seq_printf, where only one or two
could be replaced by seq_puts/seq_putc.

Rasmus
