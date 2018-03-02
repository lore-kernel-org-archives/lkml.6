Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427991AbeCBR22 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:28:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45411 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424941AbeCBR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:28:24 -0500
X-Google-Smtp-Source: AG47ELs+ONxpfRAlAKtjweQp6EpylgWVgaUwTvMhBrnhsd4KlsVGUvp7HufvPhV/bbJxSS6FvvZn3Q==
Subject: Re: [PATCH v5 1/4] of: change overlay apply input data from
 unflattened to FDT
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <1519955520-29975-1-git-send-email-frowand.list@gmail.com>
 <1519955520-29975-2-git-send-email-frowand.list@gmail.com>
 <CAMuHMdWCjqugdSkpLczcD3xsNWMmsZC8z0RLF7iQfL3V95LMZQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <fdfb7ab1-d74c-4398-b86d-cbf4de8d80bf@gmail.com>
Date: Fri, 2 Mar 2018 09:28:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWCjqugdSkpLczcD3xsNWMmsZC8z0RLF7iQfL3V95LMZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/18 01:20, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Fri, Mar 2, 2018 at 2:51 AM,  <frowand.list@gmail.com> wrote:
>> There are still some functions in unittest.c that should be tagged
>> __init due to changes in this patch, but modpost is not warning of
>> them and they are not a risk because they are only called from
>> __init functions.  A sweep of unittest.c for functions that
>> should be tagged __init is on the todo list.
> 
> If modpost doesn't warn, that merely means your compiler decided to
> inline all functions with wrong annotations, hiding the problem.
> Other (versions of) compilers may behave differently, so we do want
> to get this right.
> 
> With my trusty gcc-4.1.2:
> 
>     WARNING: vmlinux.o(.text+0x342dd4): Section mismatch in reference
> from the function of_unittest_apply_revert_overlay_check() to the
> function .init.text:of_unittest_apply_overlay()
>     The function of_unittest_apply_revert_overlay_check() references
>     the function __init of_unittest_apply_overlay().
>     This is often because of_unittest_apply_revert_overlay_check lacks a __init
>     annotation or the annotation of of_unittest_apply_overlay is wrong.
> 
> To fix the above:
> 
> -static int of_unittest_apply_revert_overlay_check(int overlay_nr,
> +static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
> -static void of_unittest_overlay_5(void)
> +static void __init of_unittest_overlay_5(void)
> -static void of_unittest_overlay_11(void)
> +static void __init of_unittest_overlay_11(void)

Yes, that is exactly the extra set of functions I was talking about.  Even
though I would prefer to annotate them, in practice they will not be a
problem because they only get called from __init functions (either directly
or indirectly).  But if Rob will take a patch with them annotated, I will
spin the series.


>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
> 
>> @@ -2290,18 +2275,29 @@ static __init void of_unittest_overlay_high_level(void)
>>                 __of_attach_node_sysfs(np);
>>
>>         if (of_symbols) {
>> +               struct property *new_prop;
>>                 for_each_property_of_node(overlay_base_symbols, prop) {
> 
> drivers/of/unittest.c: In function ‘of_unittest_overlay_high_level’:
> drivers/of/unittest.c:2193: warning: ‘overlay_base_symbols’ may be
> used uninitialized in this function
> 
> This isn't a new warning, so I guess I never reported it before because I
> thought it was a false positive (misguided by the "if (of_symbols)" test?).
> 
> However, now I believe it is not, and an uninitialized pointer will be
> dereferenced if of_root has a __symbols__ node, but overlay_base_root hasn't.

Yes, thanks for reporting it.  My gcc isn't this smart.

Fortunately overlay_base_root does have a __symbols__ node.  But I will fix it
in a patch outside this series.


> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
