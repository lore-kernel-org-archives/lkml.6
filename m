Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032319AbeEZR7K (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 13:59:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59766 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032112AbeEZR7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 13:59:07 -0400
Subject: Re: [PATCH] arm64: dts: hikey: Fix eMMC corruption regression
To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1527304247-12868-1-git-send-email-john.stultz@linaro.org>
CC: Ryan Grachek <ryan@edited.us>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>, Leo Yan <leo.yan@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B09A060.3040209@hisilicon.com>
Date: Sat, 26 May 2018 18:58:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1527304247-12868-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.85]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018/5/26 4:10, John Stultz wrote:
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
> 
> It seems the max-frequency property added by the above patch is
> causing the problem, so remove it.
> 
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Thanks!
Applied to the hisilicon fix tree.

Best Regards,
Wei

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
> 
