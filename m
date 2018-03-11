Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeCKEL4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 23:11:56 -0500
Received: from server.atrad.com.au ([150.101.241.2]:40842 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeCKELz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 23:11:55 -0500
Date: Sun, 11 Mar 2018 14:40:56 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: fujitsu-laptop: Revert UNSUPPORTED_CMD
 back to an int
Message-ID: <20180311041056.GA5432@gateway.atrad.com.au>
References: <20180310204353.9584-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310204353.9584-1-kernel@kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 09:43:53PM +0100, Micha?? K??pie?? wrote:
> UNSUPPORTED_CMD was previously 0x80000000 (int), but commit 819cddae7cfa
> ("platform/x86: fujitsu-laptop: Clean up constants") changed it into an
> unsigned long due to BIT() being used to define it.  As call_fext_func()
> returns an int, 0x80000000 would get type promoted when compared to an
> unsigned long, which on a 64-bit system would cause it to become
> 0xffffffff80000000 due to sign extension.  This causes one logical
> condition in fujitsu-laptop to always be true and another one to always
> be false on 64-bit systems.  Fix this by reverting UNSUPPORTED_CMD back
> to an int.
> 
> This patch fixes the following smatch warnings:
> 
> drivers/platform/x86/fujitsu-laptop.c:763 acpi_fujitsu_laptop_leds_register() warn: always true condition '(call_fext_func(device, ((1 << (12)) | (1 << (0))), 2, (1 << (16)), 0) != (1 << (31))) => (s32min-s32max != 2147483648)'
> drivers/platform/x86/fujitsu-laptop.c:816 acpi_fujitsu_laptop_add() warn: impossible condition '(priv->flags_supported == (1 << (31))) => (0-2147483647,18446744071562067968-u64max == 2147483648)'
> 
> Fixes: 819cddae7cfa ("platform/x86: fujitsu-laptop: Clean up constants")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Micha?? K??pie?? <kernel@kempniu.pl>
> ---
> This fixes a bug introduced by a commit queued for 4.17, so it needs to
> be applied on top of for-next.
> 
>  drivers/platform/x86/fujitsu-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 13bcdfea5349..6f4a55a53ced 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -85,7 +85,7 @@
>  #define FUNC_BACKLIGHT			(BIT(12) | BIT(2))
>  
>  /* FUNC interface - responses */
> -#define UNSUPPORTED_CMD			BIT(31)
> +#define UNSUPPORTED_CMD			0x80000000
>  
>  /* FUNC interface - status flags */
>  #define FLAG_RFKILL			BIT(5)

This looks like a sensible, succinct solution to the regression.

Reviewed-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan
