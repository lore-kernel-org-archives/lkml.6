Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeDPGhv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:37:51 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43320 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeDPGhu (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 16 Apr 2018 02:37:50 -0400
Date: Mon, 16 Apr 2018 14:37:38 +0800
From: joeyli <jlee@suse.com>
To: Randy Wright <rwright@hpe.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Randy Wright <rwright@hpe.com>,
        Ingo Molnar <mingo@redhat.com>, akpm@linux-foundation.org,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180416063738.GH16023@linux-l9pv.suse>
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Apr 16, 2018 at 11:09:04AM +0800, Dave Young wrote:
> On 04/16/18 at 10:57am, Dave Young wrote:
> > On 04/13/18 at 02:27pm, Lee, Chun-Yi wrote:
> > > When using kdump, SOMETIMES the "size not consistent" warning message
> > > shows up when the crash kernel boots with early_ioremap_debug parameter:
> > > 
> > > WARNING: CPU: 0 PID: 0 at ../mm/early_ioremap.c:182 early_iounmap+0x4f/0x12c()
> > > early_iounmap(ffffffffff200180, 00000118) [0] size not consistent 00000120
> > >
[...snip] 
> > 
> > Good catch.  The kexec code need to be fixed to use a separate buffer so
> > avoid the alignment like what kexec-tools did.  I can submit a fix for
> > that.
> 
> Can you try below code, see if it works?
>

Randy, do you want to try Dave's kexec patch on your environment? Please remove
my patch first.  

Thanks a lot!
Joey Lee
 
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 3182908b7e6c..eaee37c54b7b 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -398,11 +398,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	 * little bit simple
>  	 */
>  	efi_map_sz = efi_get_runtime_map_size();
> -	efi_map_sz = ALIGN(efi_map_sz, 16);
>  	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
>  				MAX_ELFCOREHDR_STR_LEN;
>  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
> -	kbuf.bufsz = params_cmdline_sz + efi_map_sz +
> +	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16)+
>  				sizeof(struct setup_data) +
>  				sizeof(struct efi_setup_data);
>  
> @@ -410,7 +409,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	if (!params)
>  		return ERR_PTR(-ENOMEM);
>  	efi_map_offset = params_cmdline_sz;
> -	efi_setup_data_offset = efi_map_offset + efi_map_sz;
> +	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
>  
>  	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
>  	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
