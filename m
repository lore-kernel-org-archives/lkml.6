Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E6FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A8823F16
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H4cDDFlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8823F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGFNBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:01:08 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42746 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeGFNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uzocKREWoHbqMoJpGSZimyjbeTtUgl4/1925mIMB84A=; b=H4cDDFlvkCkiUJ0PMxLIF+QY9
        jNeb1q5it+TzPAnkwi0dOpnywxbfAvNFpCzDe24u8jzhgTZ5eZz3IIuOsStL26Zu61z/hA3c0JZV/
        Yf5deIi8mfHZhn+ujYegADptZo9nPHM5uLGUX2onxa0MEoI1v6QVABDLv8Jm+CADpOFPI=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:54488)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbQM8-0005sx-4b; Fri, 06 Jul 2018 14:01:00 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbQM5-00028a-EM; Fri, 06 Jul 2018 14:00:57 +0100
Date:   Fri, 6 Jul 2018 14:00:55 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: fix modsign build error
Message-ID: <20180706130055.GY17271@n2100.armlinux.org.uk>
References: <20180706124900.3294525-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706124900.3294525-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:48:47PM +0200, Arnd Bergmann wrote:
> The asm/module.h header file can not be included standalone, which
> breaks the module signing code after a recent change:
> 
> In file included from kernel/module-internal.h:13,
>                  from kernel/module_signing.c:17:
> arch/arm/include/asm/module.h:37:27: error: 'struct module' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
> 
> This adds a forward declaration of struct module to make it all work.
> 
> Fixes: f314dfea16a0 ("modsign: log module name in the event of an error")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We used to have a general rule that where an asm/foo.h header and
linux/foo.h header exists, and the linux/foo.h includes the asm/foo.h,
then the linux/foo.h header will be used for including in .c files
rather than the asm/ version of the same.  Is there a reason why
that can't be done here?

That said, adding this is no bad thing.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
> I guess it would be useful if Jessica can pick this change up
> in her tree that introduced the warning.
> ---
>  arch/arm/include/asm/module.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 89ad0596033a..9e81b7c498d8 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -34,6 +34,7 @@ struct mod_arch_specific {
>  #endif
>  };
>  
> +struct module;
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
>  
>  /*
> -- 
> 2.9.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
