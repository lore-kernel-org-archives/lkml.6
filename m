Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA012159B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA012159B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeI0LdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:33:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeI0LdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:33:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5DC9DE1F;
        Thu, 27 Sep 2018 05:16:37 +0000 (UTC)
Date:   Thu, 27 Sep 2018 07:16:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
Message-ID: <20180927051634.GA32508@kroah.com>
References: <20180926232055.31951-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926232055.31951-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:20:55PM -0700, Nathan Chancellor wrote:
> Clang emits the following warning:
> 
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> 'acpi_ids' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static const struct acpi_device_id acpi_ids[] = {
>                                    ^
> 1 warning generated.
> 
> Mark acpi_ids with the attribute __used, which makes it clear to Clang
> that we don't want this warning while not inhibiting Clang's dead code
> elimination from removing the unreferenced internal symbol when moving
> the data to the globally available symbol with MODULE_DEVICE_TABLE.
> 
> $ nm -S drivers/staging/rtl8723bs/os_dep/sdio_intf.o | grep acpi
> 0000000000000000 0000000000000040 R __mod_acpi__acpi_ids_device_table
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/169
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 6d02904de63f..7c03b69b8ed3 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
>  	{ SDIO_DEVICE(0x024c, 0xb723), },
>  	{ /* end: all zeroes */				},
>  };
> -static const struct acpi_device_id acpi_ids[] = {
> +static const struct acpi_device_id acpi_ids[] __used = {

Can't we put __used somewhere in the MODULE_DEVICE_TABLE() macro so we
don't have to go adding it to all individual entries?

thanks,

greg k-h
