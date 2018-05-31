Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeEaLkH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:40:07 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:42278 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeEaLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:40:03 -0400
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
Date: Thu, 31 May 2018 13:21:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528100302.722883806@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.05.2018 um 12:05 schrieb Greg Kroah-Hartman:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> [ Upstream commit a7aa75a2a7dba32594291a71c3704000a2fd7089 ]
>
> The base of the TLMM gpiochip should not be statically defined as 0, fix
> this to not artificially restrict the existence of multiple pinctrl-msm
> devices.
>
> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-msm.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -818,7 +818,7 @@ static int msm_gpio_init(struct msm_pinc
>   		return -EINVAL;
>   
>   	chip = &pctrl->chip;
> -	chip->base = 0;
> +	chip->base = -1;
>   	chip->ngpio = ngpio;
>   	chip->label = dev_name(pctrl->dev);
>   	chip->parent = pctrl->dev;

this patch creates a regression for me. on ipq8064 the systems gpios now 
start somewhere in the sky

new layout

lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip373 -> 
../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip373
lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip408 -> 
../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip408
lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip443 -> 
../../devices/platform/soc/800000.pinmux/gpio/gpiochip443


before the patch

lrwxrwxrwx    1 root     root             0 Jan  1  1970 gpiochip0 -> 
../../devices/platform/soc/800000.pinmux/gpio/gpiochip0
lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip442 -> 
../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip442
lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip477 -> 
../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip477


this broke my userspace gpio handling. i can override this, but still it 
doesnt look correct since there is a hole at the beginng likelly 
reserved by unused arm gpios

>
>
>
