Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55C207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4l7kq+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B55C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJZDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJZDX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:23:27 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B52207DD;
        Thu, 25 Oct 2018 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540493370;
        bh=o/mRkzAhRO4GIX20tTOsk4BiwBB1WBSSxQUKxSDAnQw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a4l7kq+A9BXgXgyVjuaMHVXzcwqPTyLNv3jMfapkdgLYczQsLeNdXwbecKFc1PiXz
         HEYVIfllI1Xwm8BUn3rJy86vXGvMhaXXx35NUOHfFsaNQzTAsx6Fb5/OBlQ55035eb
         Zki5qyFeulRAkp8d+ehZipWMtFGUNONhItx0V6dE=
Subject: Re: [PATCH] usbip: tools: fix atoi() on non-null terminated string
To:     Colin King <colin.king@canonical.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181016180343.5620-1-colin.king@canonical.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <82ed890f-f544-ce88-9509-f4eedafe4a91@kernel.org>
Date:   Thu, 25 Oct 2018 12:49:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016180343.5620-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 10/16/2018 12:03 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the call to atoi is being passed a single char string
> that is not null terminated, so there is a potential read overrun
> along the stack when parsing for an integer value.  Fix this by
> instead using a 2 char string that is initialized to all zeros
> to ensure that a 1 char read into the string is always terminated
> with a \0.
> 
> Detected by cppcheck:
> "Invalid atoi() argument nr 1. A nul-terminated string is required."
> 
> Fixes: 3391ba0e2792 ("usbip: tools: Extract generic code to be shared with vudc backend")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/usb/usbip/libsrc/usbip_host_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
> index dc93fadbee96..d79c7581b175 100644
> --- a/tools/usb/usbip/libsrc/usbip_host_common.c
> +++ b/tools/usb/usbip/libsrc/usbip_host_common.c
> @@ -43,7 +43,7 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
>  	int size;
>  	int fd;
>  	int length;
> -	char status;
> +	char status[2] = { 0 }>  	int value = 0;
>  
>  	size = snprintf(status_attr_path, sizeof(status_attr_path),
> @@ -61,14 +61,14 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
>  		return -1;
>  	}
>  
> -	length = read(fd, &status, 1);
> +	length = read(fd, status, 1);
>  	if (length < 0) {
>  		err("error reading attribute %s", status_attr_path);
>  		close(fd);
>  		return -1;
>  	}
>  
> -	value = atoi(&status);
> +	value = atoi(status);
>  
>  	return value;
>  }
> 

Thanks for the patch. Looks good to me.

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
