Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91B206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeIZNZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:25:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:25:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E25EA107C;
        Wed, 26 Sep 2018 07:14:01 +0000 (UTC)
Date:   Wed, 26 Sep 2018 09:13:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe
 unused
Message-ID: <20180926071359.GA22855@kroah.com>
References: <20180926070208.16924-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926070208.16924-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> Clang emits the following warning:
> 
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> 'acpi_ids' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static const struct acpi_device_id acpi_ids[] = {
>                                    ^
> 1 warning generated.
> 
> Mark the declaration as maybe unused like a few other instances of this
> construct in the kernel.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/169
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 6d02904de63f..3285bf36291b 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
>  	{ SDIO_DEVICE(0x024c, 0xb723), },
>  	{ /* end: all zeroes */				},
>  };
> -static const struct acpi_device_id acpi_ids[] = {
> +static const struct acpi_device_id acpi_ids[] __maybe_unused = {

But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
macro does a functional thing.  Why is gcc not reporting an issue with
this and clang is?

thanks,

greg k-h
