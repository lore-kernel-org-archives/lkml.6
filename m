Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367EB2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367EB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJCRtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:49:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:49:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ACD8E263976
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event in get_next_event_xfer
To:     Emil Karlson <jekarlson@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        lee.jones@linaro.org, bleung@chromium.org, olof@lixom.net,
        linux-kernel@vger.kernel.org
References: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
 <20180928170818.32124-1-jekarlson@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <84a0aba3-0793-1659-c70c-d5ece650f832@collabora.com>
Date:   Wed, 3 Oct 2018 13:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928170818.32124-1-jekarlson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

Many thanks to catch this and fix. Some comments below.

You missed to add the v2, please send the next patch with v3 prefix.

On 28/9/18 19:08, Emil Karlson wrote:
> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. Use ret as memcpy len to fix this.
>

That's fine

> drivers/platform/chrome/cros_ec_proto.c:509
> get_next_event_xfer uses ret from cros_ec_cmd_xfer for memcpy for msg->data len
> drivers/platform/chrome/cros_ec_proto.c:445
> cros_ec_cmd_xfer gets ret from send_command
> drivers/platform/chrome/cros_ec_proto.c:93
> send_command gets ret from bus specific xfer_fn
> drivers/mfd/cros_ec_spi.c:598
> cros_ec_cmd_xfer_spi copies len amount to ec_msg->data and returns len as ret
> drivers/mfd/cros_ec_i2c.c:267
> cros_ec_cmd_xfer_i2c copies len amount to ec_msg->data and returns len as ret
> 
> so msg->data length is always the same as ret.
> 

Instead of describe the different calls involved and the returns. I'd explain
why using ret fixes the issue.

> Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")
> Signed-off-by: Emil Karlson <jekarlson@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 398393ab5df8..b6fd4838f60f 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -520,7 +520,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  	ret = cros_ec_cmd_xfer(ec_dev, msg);
>  	if (ret > 0) {
>  		ec_dev->event_size = ret - 1;
> -		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> +		memcpy(&ec_dev->event_data, msg->data, ret);
>  	}
>  
>  	return ret;
> 

After thinking a bit more on this I think that how you fixed this is really
clear. I was wondering if the downstream solution would be better but as is
really late and will be good have this as urgent fix for the coming release I am
happy with it. We can always send follow up patches to sync with the downstream
version if is preferred.

Neil, can you give us your Tested-by to have the make sure this doesn't break
with protocol v1, I don't have such hardware.

Benson, will be really good have this merged in this rc. Are you fine with this
solution?

BTW, you can add my in next version.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
