Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C28C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22CC2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22CC2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeIZMeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:34:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeIZMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:34:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DC671018;
        Wed, 26 Sep 2018 06:22:47 +0000 (UTC)
Date:   Wed, 26 Sep 2018 08:22:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Remove ACPI table declaration
Message-ID: <20180926062245.GA5937@kroah.com>
References: <20180926053910.26833-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926053910.26833-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:39:10PM -0700, Nathan Chancellor wrote:
> Clang warns that the acpi_id declaration is not going to be emitted
> in the final assembly:
> 
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> 'acpi_ids' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static const struct acpi_device_id acpi_ids[] = {
>                                    ^
> 1 warning generated.
> 
> This is because it's marked as static const and it is not used anywhere
> in this file. Doing a git grep on this driver for 'acpi' shows that this
> declaration has been unused since the driver's initial induction. Remove
> it since it's not doing anything.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/169
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 6d02904de63f..d473f9bd08c3 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -22,13 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
>  	{ SDIO_DEVICE(0x024c, 0xb723), },
>  	{ /* end: all zeroes */				},
>  };
> -static const struct acpi_device_id acpi_ids[] = {
> -	{"OBDA8723", 0x0000},
> -	{}
> -};
> -
>  MODULE_DEVICE_TABLE(sdio, sdio_ids);
> -MODULE_DEVICE_TABLE(acpi, acpi_ids);

You just removed the ability for the driver to be automatically loaded
if that acpi id is present.

Not good :(

I think you need to fix up your scripts, this is valid code...

greg k-h
