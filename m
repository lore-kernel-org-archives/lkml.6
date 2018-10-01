Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE548C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885DA2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885DA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJBBv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:51:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56107 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBBv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:51:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id BA0B12152B;
        Mon,  1 Oct 2018 19:12:14 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B2crq_J6NSqf; Mon,  1 Oct 2018 19:12:14 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 5E22C2142B;
        Mon,  1 Oct 2018 19:12:02 +0000 (UTC)
Subject: Re: [PATCH] usbip: fix vhci_hcd controller counting
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-usb@vger.kernel.org, jdieter@gmail.com,
        Shuah Khan <shuah@kernel.org>
References: <20180920202942.208509-1-zenczykowski@gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <91b66186-9e1c-6fc4-1e51-0f346725c4cf@kernel.org>
Date:   Mon, 1 Oct 2018 13:11:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920202942.208509-1-zenczykowski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 02:29 PM, Maciej Żenczykowski wrote:
> From: Maciej Żenczykowski <maze@google.com>
> 
> Without this usbip fails on a machine with devices
> that lexicographically come after vhci_hcd.
> 
> ie.
>   $ ls -l /sys/devices/platform
>   ...
>   drwxr-xr-x. 4 root root    0 Sep 19 16:21 serial8250
>   -rw-r--r--. 1 root root 4096 Sep 19 23:50 uevent
>   drwxr-xr-x. 6 root root    0 Sep 20 13:15 vhci_hcd.0
>   drwxr-xr-x. 4 root root    0 Sep 19 16:22 w83627hf.656
> 
> Because it detects 'w83627hf.656' as another vhci_hcd controller,
> and then fails to be able to talk to it.
> 
> Note: this doesn't actually fix usbip's support for multiple
> controllers... that's still broken for other reasons
> ("vhci_hcd.0" is hardcoded in a string macro), but is enough to
> actually make it work on the above machine.
> 
> See also:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1631148
> 
> Cc: Jonathan Dieter <jdieter@gmail.com>
> Cc: Valentina Manea <valentina.manea.m@gmail.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Maciej Żenczykowski <zenczykowski@gmail.com>
> ---
>  tools/usb/usbip/libsrc/vhci_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
> index 4204359c9fee..8159fd98680b 100644
> --- a/tools/usb/usbip/libsrc/vhci_driver.c
> +++ b/tools/usb/usbip/libsrc/vhci_driver.c
> @@ -150,7 +150,7 @@ static int get_nports(struct udev_device *hc_device)
>  
>  static int vhci_hcd_filter(const struct dirent *dirent)
>  {
> -	return strcmp(dirent->d_name, "vhci_hcd") >= 0;
> +	return !strncmp(dirent->d_name, "vhci_hcd.", 9);
>  }
>  
>  static int get_ncontrollers(void)
> 

Thanks for the patch. Looks good to me.

Greg! Can you please pick this up.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>


thanks,
-- Shuah





thanks,
-- Shuah
