Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeDKIeI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:34:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38805 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeDKIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:34:03 -0400
X-Google-Smtp-Source: AIpwx4/1UtF7AKRe2HvqP06IIcr5EEQfMwiODqZpuzDcDoBveXWIgrNVLp5/PRGu5OKHPw5uVkaBrA==
Subject: Re: [PATCH 1/2] ide: pdc202xx_new: Replace mdelay with usleep_range
 in detect_pll_input_clock
To: Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        frankt@promise.com, andre@linux-ide.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523433162-3910-1-git-send-email-baijiaju1990@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7558e956-62bd-39b9-6ff1-4d5f7ee2c9a3@cogentembedded.com>
Date: Wed, 11 Apr 2018 11:33:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523433162-3910-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/11/2018 10:52 AM, Jia-Ju Bai wrote:

> detect_pll_input_clock() is never called in atomic context.
> 
> detect_pll_input_clock() is only called by init_chipset_pdcnew(), which
> is set as ".init_chipset" in struct ide_port_info.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, detect_pll_input_clock()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   drivers/ide/pdc202xx_new.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
> index b33646b..6afa66d 100644
> --- a/drivers/ide/pdc202xx_new.c
> +++ b/drivers/ide/pdc202xx_new.c
> @@ -258,7 +258,7 @@ static long detect_pll_input_clock(unsigned long dma_base)
>   	outb(scr1 | 0x40, dma_base + 0x03);
>   
>   	/* Let the counter run for 10 ms. */
> -	mdelay(10);
> +	usleep_range(10);

    This function takes 2 arguments.

[...]

MBR, Sergei
