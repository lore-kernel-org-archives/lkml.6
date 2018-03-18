Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeCRMwB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37933 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbeCRMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:51:54 -0400
X-Google-Smtp-Source: AG47ELuhFWwVYk5am/wpeyoSjNgv74KljX+0w+4aHOmS4MCQkc/yzz5PN7eVqU7i8xSVRx835nfE2g==
Date: Sun, 18 Mar 2018 07:51:50 -0500
From: Rob Herring <robh@kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael J Clark <mjc@sifive.com>,
        Trung Tran <trung.tran@ettus.com>, Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] of: Respect CONFIG_CMDLINE{,_EXTENED,_FORCE) with no
 chosen node
Message-ID: <20180318125150.3i54r7i5edefbhfq@rob-hp-laptop>
References: <20180314163105.8638-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314163105.8638-1-palmer@sifive.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 09:31:05AM -0700, Palmer Dabbelt wrote:
> Systems that boot without a chosen node in the device tree should still
> respect the command lines that are built into the kernel.  This patch
> avoids bailing out of the command line argument parsing code when there
> is no chosen node in the device tree.  This is necessary to boot
> straight to a root file system (ie, without an initramfs)
> 
> The intent here is that the only functional change is to copy
> CONFIG_CMDLINE into data if both of them are valid (ie, CONFIG_CMDLINE
> is defined and data is non-null) on systems where there is no chosen
> device tree node.  I don't actually know what the return values do so I
> just preserved them.
> 
> Thanks to Trung and Moritz for finding the bug during our ELC hackathon
> (and providing the first fix), and Michal for suggesting this fix (which
> is cleaner than what I was doing).  I've given this very minimal
> testing: it fixes the RISC-V bug (in conjunction with a patch to move
> from COMMANDLINE_OVERRIDE to COMMANDLINE_FORCE), still works on systems
> with and without the chosen node, and builds on ARM64.
> 
> CC: Michael J Clark <mjc@sifive.com>
> CC: Trung Tran <trung.tran@ettus.com>
> CC: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  drivers/of/fdt.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 84aa9d676375..60241b1cb024 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1084,9 +1084,12 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  
>  	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>  
> -	if (depth != 1 || !data ||
> +	if (!data)
> +		goto no_data;

Just "return 0" here.

> +
> +	if (depth != 1 ||
>  	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
> -		return 0;
> +		goto no_chosen;
>  
>  	early_init_dt_check_for_initrd(node);
>  
> @@ -1117,6 +1120,13 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  
>  	/* break now */
>  	return 1;
> +
> +no_chosen:
> +#ifdef CONFIG_CMDLINE
> +	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);

Best case, this is going to needlessly copy the string on every single 
node that is not /chosen.

Worst case, I think this changes behavior. For example, first you copy 
CONFIG_CMDLINE into data, then on a later iteration, you strlcat 
CONFIG_CMDLINE into data if CONFIG_CMDLINE_EXTEND is enable. There could 
also be some unintended behavior if data has a string to start with. 

I'd really like to see this function re-written to just find the /chosen 
node and then handle each property one by one. The iterating approach is 
silly. I assume it predates libfdt and we didn't have nice functions to 
find nodes by path (or any other way).

I'm working on a patch to re-structure this function. Will send it out 
in the next day.

> +#endif
> +no_data:
> +	return 0;
>  }
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK
> -- 
> 2.16.1
> 
