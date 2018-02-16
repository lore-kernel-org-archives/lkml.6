Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965692AbeBPME0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:04:26 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61346 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965642AbeBPMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:04:23 -0500
Subject: Re: [PATCH v3 0/2] phy: rockchip-emmc: fixes emmc-phy power on failed
 with rk3399 SoCs
To: Caesar Wang <wxt@rock-chips.com>
References: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
CC: Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56548710-6b9a-85bc-85de-221ae748d83c@ti.com>
Date: Fri, 16 Feb 2018 17:33:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 11 January 2018 08:10 AM, Caesar Wang wrote:
> Hi Kishon,
> 
> Since the Shawn isn't available, I take over this series patches for now.
> 
> As the original bug had tracked on https://issuetracker.google.com/71561742.
> In some cases, the mmc phy power on failed during booting up.
> The log as below:
> ...
> [   2.375333] rockchip_emmc_phy_power: caldone timeout.
> [    2.377815] phy phy-ff770000.syscon:phy@f780.4: phy poweron failed --> -110
> ...
> [    2.489295] mmc0: mmc_select_hs400es failed, error -110
> [    2.489302] mmc0: error -110 whilst initialising MMC card
> ..
> 
> The actual emulate, the wait 5us for calpad busy trimming, that's no enough.
> We need give the enough margin for it.
> 
> Verified on url =
>         https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
> This series patches can apply and bring up with kernel-next on rk3399 chromebook.

merged now, thanks!

-Kishon
> 
> -Caesar
> 
> 
> Changes in v3:
> - As Doug commented on both upstream and gerrit.
>   Change "5, 50" to "0, 50", and the message of print.
> - As Doug commented on https://patchwork.kernel.org/patch/10154797,
>   Change "1, 50" to "0, 50".
> 
> Changes in v2:
> - print the return valut with regmap_read_poll_timeout failing.
> - As Brian commented on https://patchwork.kernel.org/patch/10139891/,
>   changed the note and added to print error value with
>   regmap_read_poll_timeout API.
> 
> Shawn Lin (2):
>   phy: rockchip-emmc: retry calpad busy trimming
>   phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy
> 
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 60 +++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 32 deletions(-)
> 
