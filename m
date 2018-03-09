Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeCII3f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:29:35 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42539 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCII3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:29:34 -0500
Date: Fri, 9 Mar 2018 09:29:32 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] efi: make const array 'apple' static
Message-ID: <20180309082932.GA13228@wunner.de>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-13-ard.biesheuvel@linaro.org>
 <20180309074719.y33xe4bjkjsjsaa3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309074719.y33xe4bjkjsjsaa3@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 08:47:19AM +0100, Ingo Molnar wrote:
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Don't populate the const read-only array 'buf' on the stack but instead
> > make it static. Makes the object code smaller by 64 bytes:
> > 
> > Before:
> >    text	   data	    bss	    dec	    hex	filename
> >    9264	      1	     16	   9281	   2441	arch/x86/boot/compressed/eboot.o
> > 
> > After:
> >    text	   data	    bss	    dec	    hex	filename
> >    9200	      1	     16	   9217	   2401	arch/x86/boot/compressed/eboot.o
> > 
> > (gcc version 7.2.0 x86_64)
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/x86/boot/compressed/eboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index 886a9115af62..f2251c1c9853 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -423,7 +423,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
> >  
> >  static void setup_quirks(struct boot_params *boot_params)
> >  {
> > -	efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
> > +	static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
> >  	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
> >  		efi_table_attr(efi_system_table, fw_vendor, sys_table);
> 
> As a general policy, please don't put 'static' variables into the local
> scope, use file scope instead - right before setup_quirks() would be fine.

Well, I believe the end result is the same and the closer the declaration
is to where it's used, the easier the code is to read and understand.

I object to patches like this because they paper over a missing
compiler optimization:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68725

I have told Colin before that it would be more useful to look into
fixing the underlying compiler issue rather than polluting the kernel
with "static" keywords, but he keeps sending these patches so I've
given up responding:
https://lkml.org/lkml/2017/8/25/636


> Plus an unicode string literal initializer would be pretty descriptive
> as well,  instead of the weird looking character array, i.e. something
> like:
> 
>   static efi_char16_t const apple_unicode_str[] = u"Apple";
> 
> ... or so?

Last time I checked this didn't work, I believe it's because it's C11
and the kernel is compiled with -std=gnu89.  And I'm also not sure if
the oldest gcc version that we support understands u"".

Thanks,

Lukas
