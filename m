Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx49m2ZMPVRJntgdZ+r6uDxOxMx3ZypM4mf0cYBBcVWSy5BY1IcolHDZ4QmHI0HepOlu4EdXh
ARC-Seal: i=1; a=rsa-sha256; t=1523880585; cv=none;
        d=google.com; s=arc-20160816;
        b=P8mV2tgH4BhyB4ObHyFQFJkISdReIogAyaCcabz7CmXY5RfPe9ZF7MqT7C7pgAaDlD
         /Pr8zLqaHjEBGlnf826WM61lLtvryxGegiYzDGrHmGEejSC2hyD3uPGjRVzLmz4r3QtA
         89iLvvLAlV6pn44QrRHZjS2jgKOZB6NNJi4Gg2OirqKI5GJzZi725BZ09aOgp5AroeVV
         5fq8fOVFFs4agZfZlrDQLb12WVOF2j2XFT0jEDVOfIHcuuJrosSlbDgGasnuGHbmqX5D
         GxLW8jLaRCjuEcgqaJuSsfS55qmbb5CyuLp5oJdWI9Jhi3piwTA7aa649Gzvqzrpws4L
         ydHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+tOMYz75FSdLvt5SwWwPaAwegjE90Sse7gRmJfM8e+0=;
        b=fgovM2US9AQIHv25/gFSXm897qoNPORM8BOkH+jtcMvnfwo4VnfjzKFrQEFkN3yDpE
         b8kDdwH8V0526nKikw3jO9Nru3MbugMklFpJaCA6IbiMJxZ7fKwW0Wps40nGlcbBZtk0
         lE7EMCps0ua9jhCLpy2xFVOTiU/BH/bFiiyDu1KdTzFzuO7MTlV0F+ppLZj8p+LHXzH1
         9z9USsJ0w6tGl9mD+XwLt/Z+BzZ/oloxh7Ocfns1SYQ9TcQKt9jMzrmlrz+46z5KCL8d
         E3Dbb0lbMdVHfk7Ly9w8SK7sb6W3iOUhRh3zt0fyQx6UzKJ/OPEu6te5CrOUfQTj+Cxu
         XeNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=E1+1a3az;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=E1+1a3az;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Mon, 16 Apr 2018 13:09:30 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Rob Landley <rob@landley.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	tglx@linutronix.de, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] Replace unnecessary perl with sed, printf, and the shell
 $(( )) operator.
Message-ID: <20180416120930.GS16141@n2100.armlinux.org.uk>
References: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597502519965840402?=
X-GMAIL-MSGID: =?utf-8?q?1597904609384889998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 08:38:37PM -0500, Rob Landley wrote:
> You can build a kernel in a cross compiling environment that doesn't have perl
> in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
>  arch/arm/boot/compressed/Makefile |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..33ebeb2 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -117,11 +117,10 @@ ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
>  asflags-y := -DZIMAGE
>  
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> -KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> -		perl -e 'while (<>) { \
> -			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
> -			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
> -		}; printf "%d\n", $$bss_end - $$bss_start;')
> +KBSS_SZ := $(shell echo $$(($$(printf '%d+%d' $$( \
> +		$(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> +		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
> +		       -e 's/^\([^ ]*\) B __bss_stop$$/0x\1/p') ) )) )

This looks more complicated than necessary, and therefore less readable.
What's wrong with:

KBSS_SZ := $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
		       -e 's/^\([^ ]*\) B __bss_stop$$/+0x\1/p') ))

The sed command produces output such as:

-0xc0955e58
+0xc10b0f9c

which the shell is then able to evaluate and produce a decimal number.
This seems to work fine with both bash and dash.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
