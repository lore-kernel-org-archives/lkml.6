Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967938AbeE2XTH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:19:07 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:39025 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965084AbeE2XTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:19:06 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:8957:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12740:12760:12895:13069:13095:13181:13229:13311:13357:13439:14181:14659:14721:14777:21080:21433:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: light81_89666080e2e5a
X-Filterd-Recvd-Size: 2054
Message-ID: <56a8f4d988151f94950b355dba6ab83b5dfdb9c2.camel@perches.com>
Subject: Re: [PATCH] mdio-mux-gpio: Remove VLA usage
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Pramod Kumar <pramod.kumar@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 16:19:02 -0700
In-Reply-To: <20180529225901.GA30464@beast>
References: <20180529225901.GA30464@beast>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 15:59 -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the values buffer during the callback instead of putting it
> on the stack.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
[]
> diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
[]
> @@ -26,18 +26,23 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
>  				   void *data)
>  {
>  	struct mdio_mux_gpio_state *s = data;
> -	int values[s->gpios->ndescs];
> +	int *values;
>  	unsigned int n;
>  
>  	if (current_child == desired_child)
>  		return 0;
>  
> +	values = kmalloc_array(s->gpios->ndescs, sizeof(*values), GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;

This function previously only returned 0
and now it can return -ENOMEM.

How do you know all the indirect callers
via the switch_fn stored in mdio_mux_init
can handle the new return value?

If you have explored these code paths, it
would be good to explain that in the commit
message.
