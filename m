Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeEQCpE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 22:45:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:55196 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeEQCpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 22:45:03 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <0376656116e2da21f8a20ed8fa562d22>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: block: propagate correct returned value in
 mmc_rpmb_ioctl
To: Mathieu Malaterre <malat@debian.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20180516192022.23541-1-malat@debian.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <316ca15c-86f2-f052-c307-ba12eea7b579@rock-chips.com>
Date: Thu, 17 May 2018 10:45:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516192022.23541-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/5/17 3:20, Mathieu Malaterre wrote:
> In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device") a
> new function `mmc_rpmb_ioctl` was added. The final return is simply
> returning a value of `0` instead of propagating the correct return code.
> 
> Discovered during a compilation with W=1, silence the following gcc warning
> 
>    drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 

Good catch! But hey, which gcc are you using now? Mine, gcc-linaro-
6.3.1-2017.05-x86_64_aarch64-linux-gnu, with W=1 doesn't warn about
this. And it's worth backporting to stable.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/mmc/core/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9e923cd1d80e..38a7586b00cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp, unsigned int cmd,
>   		break;
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   #ifdef CONFIG_COMPAT
> 
