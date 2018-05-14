Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeENR3R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:29:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46057 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeENR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:29:15 -0400
X-Google-Smtp-Source: AB8JxZo35CV9/behbsaK3oJu5aQ1GVpRPaxlUhg8OTJNaa42xWaLN+mxC8L9PE13zhFVEbO4fyuP2Q==
From: =?UTF-8?q?Josef=20=C5=A0im=C3=A1nek?= <josef.simanek@gmail.com>
To: ming_qian@realsil.com.cn
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Josef=20=C5=A0im=C3=A1nek?= <josef.simanek@gmail.com>
Subject: RE: media: uvcvideo: Support realtek's UVC 1.5 device
Date: Mon, 14 May 2018 19:28:49 +0200
Message-Id: <20180514172849.27224-1-josef.simanek@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <1525831988-32017-1-git-send-email-ming_qian@realsil.com.cn>
References: <1525831988-32017-1-git-send-email-ming_qian@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The length of UVC 1.5 video control is 48, and it id 34 for UVC 1.1.
> Change it to 48 for UVC 1.5 device,
> and the UVC 1.5 device can be recognized.
> 
> More changes to the driver are needed for full UVC 1.5 compatibility.
> However, at least the UVC 1.5 Realtek RTS5847/RTS5852 cameras have
> been reported to work well.
> 
> Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Hello! I have sucessfully tested this patch on Kernel 4.16.1 (Fedora 28) with Dell XPS 9370
using following device (output from lsusb):

Bus 001 Device 002: ID 0bda:58f4 Realtek Semiconductor Corp.

You can also find related dmesg output at https://bugs.launchpad.net/dell-sputnik/+bug/1763748/comments/35

Tested-by: Josef Šimánek <josef.simanek@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index aa0082f..32dfb32 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -171,6 +171,8 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
>  	int ret;
>  
>  	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> +	if (stream->dev->uvc_version >= 0x0150)
> +		size = 48;
>  	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
>  			query == UVC_GET_DEF)
>  		return -EIO;
> @@ -259,6 +261,8 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
>  	int ret;
>  
>  	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> +	if (stream->dev->uvc_version >= 0x0150)
> +		size = 48;
>  	data = kzalloc(size, GFP_KERNEL);
>  	if (data == NULL)
>  		return -ENOMEM;
