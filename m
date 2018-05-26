Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031111AbeEZFe0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 01:34:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41805 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeEZFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 01:34:25 -0400
X-Google-Smtp-Source: AB8JxZp0DU2UvKADdIL+qzWbISE171rPoKuiuW/ygd4qVhFT/Esmk4eY0TPaMpmZfdJaLchWD1xMEw==
Date: Sat, 26 May 2018 13:34:10 +0800
From: Leo Yan <leo.yan@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH] arm64: dts: hikey: Fix eMMC corruption regression
Message-ID: <20180526053410.GA15256@leoy-ThinkPad-X240s>
References: <1527304247-12868-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527304247-12868-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 08:10:47PM -0700, John Stultz wrote:
> This patch is a partial revert of commit
> abd7d0972a19 ("arm64: dts: hikey: Enable HS200 mode on eMMC")
> 
> which has been causing eMMC corruption on my HiKey board.
> 
> Symptoms usually looked like:
> 
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> ...
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc0: new HS200 MMC card at address 0001
> ...
> dwmmc_k3 f723d000.dwmmc0: Unexpected command timeout, state 3
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> print_req_error: I/O error, dev mmcblk0, sector 8810504
> Aborting journal on device mmcblk0p10-8.
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
> mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
> EXT4-fs error (device mmcblk0p10): ext4_journal_check_start:61: Detected aborted journal
> EXT4-fs (mmcblk0p10): Remounting filesystem read-only
> 
> And quite often this would result in a disk that wouldn't properly
> boot even with older kernels.

I tested this patch on the kernel 4.17.0-rc5, I don't see booting
issue with this patch.

Tested-by: Leo Yan <leo.yan@linaro.org>

> It seems the max-frequency property added by the above patch is
> causing the problem, so remove it.

Should Cc this patch to stable kernel mailing list as fixing?

> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 724a0d3..edb4ee0 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -299,7 +299,6 @@
>  		/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
>  
>  		dwmmc_0: dwmmc0@f723d000 {
> -			max-frequency = <150000000>;
>  			cap-mmc-highspeed;
>  			mmc-hs200-1_8v;
>  			non-removable;
> -- 
> 2.7.4
> 
