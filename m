Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27226073
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="s6aKmISo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27226073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbeFYTkJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:40:09 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53572 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934940AbeFYTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gq0JTHj5D4u/GkseGQRegusXjQY6Q6Abq18139Rv0AM=; b=s6aKmISocxtbtepddjwWGvhb3p
        1QEVuCxxl2WNj5RiJTqYaQXtx1z5CAHnRPCzz4VbAYOpfepKS9PVY65llhcE/1IuzjXGsaIqkXjX8
        OniFurTsCrwUFVAoQ6Fmqz3MiGk15SKkqRkdMw158nuFbPd/J+zapKUigZ2wuuZUZtj+aH3zGvFNd
        mN4MpZs9iP8mMsxDTJfCKstF/T+3V0Qx24mfVX89DB5uUSfikxbVr5eKL1QBE7cJvhNB0o0YtS5kF
        2LvIuJ8YMc3q7vjy41XXXDfPZVhirZ8eS7y1xz0ebkebZa0qCsRgmWDLoe6eYHYeSQDFplyTgdn3a
        Zyv/FB2A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47576 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fXXLK-00Gp2V-RM; Mon, 25 Jun 2018 19:40:07 +0000
Date:   Mon, 25 Jun 2018 12:40:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] s390/boot: block uncompressed vmlinux booting attempts
Message-ID: <20180625194005.GA21023@roeck-us.net>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
 <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
 <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:09:19PM +0200, Vasily Gorbik wrote:
> Since uncompressed kernel image "vmlinux" elf file is not bootable under
> qemu anymore, add a check which would report that.
> 
> Qemu users are encouraged to use bzImage or
> arch/s390/boot/compressed/vmlinux instead.
> 
> The check relies on s390 linux entry point ABI definition, which is only
> present in bzImage and arch/s390/boot/compressed/vmlinux.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

With qemu:

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/boot/head.S         |  4 ++--
>  arch/s390/include/asm/setup.h |  3 ++-
>  arch/s390/kernel/early.c      | 12 ++++++++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
> index f09e792df495..f721913b73f1 100644
> --- a/arch/s390/boot/head.S
> +++ b/arch/s390/boot/head.S
> @@ -272,14 +272,14 @@ iplstart:
>  	.org	0x10000
>  ENTRY(startup)
>  	j	.Lep_startup_normal
> -	.org	0x10008
> +	.org	EP_OFFSET
>  #
>  # This is a list of s390 kernel entry points. At address 0x1000f the number of
>  # valid entry points is stored.
>  #
>  # IMPORTANT: Do not change this table, it is s390 kernel ABI!
>  #
> -	.ascii	"S390EP"
> +	.ascii	EP_STRING
>  	.byte	0x00,0x01
>  #
>  # kdump startup-code at 0x10010, running in 64 bit absolute addressing mode
> diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
> index be02f0558048..1d66016f4170 100644
> --- a/arch/s390/include/asm/setup.h
> +++ b/arch/s390/include/asm/setup.h
> @@ -9,7 +9,8 @@
>  #include <linux/const.h>
>  #include <uapi/asm/setup.h>
>  
> -
> +#define EP_OFFSET		0x10008
> +#define EP_STRING		"S390EP"
>  #define PARMAREA		0x10400
>  #define PARMAREA_END		0x11000
>  
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 827699eb48fa..45c5be3d8777 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -331,8 +331,20 @@ static void __init setup_boot_command_line(void)
>  	append_to_cmdline(append_ipl_scpdata);
>  }
>  
> +static void __init check_image_bootable(void)
> +{
> +	if (!memcmp(EP_STRING, (void *)EP_OFFSET, strlen(EP_STRING)))
> +		return;
> +
> +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");
> +	disabled_wait(0xbadb007);
> +}
> +
>  void __init startup_init(void)
>  {
> +	check_image_bootable();
>  	time_early_init();
>  	init_kernel_storage_key();
>  	lockdep_off();
> -- 
> ⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
> ⣿⢿⡿⣿ pacman edition
> 
