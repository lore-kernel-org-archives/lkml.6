Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBUBzJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:55:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:40429 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeBUBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="176826660"
Subject: Re: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
 return value with autoneg off.
To: Benjamin Poirier <bpoirier@suse.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180220061200.17708-1-bpoirier@suse.com>
From: "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <1908e13b-3706-08d7-9ebb-5774b7d7cfb4@intel.com>
Date: Tue, 20 Feb 2018 17:55:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220061200.17708-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2018 22:12, Benjamin Poirier wrote:
> When autoneg is off, the .check_for_link callback functions clear the
> get_link_status flag and systematically return a "pseudo-error". This means
> that the link is not detected as up until the next execution of the
> e1000_watchdog_task() 2 seconds later.
> 
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>   drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 31277d3bb7dc..ff308b05d68c 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1602,7 +1602,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>   	 * we have already determined whether we have link or not.
>   	 */
>   	if (!mac->autoneg)
> -		return -E1000_ERR_CONFIG;
> +		return 1;
>   
>   	/* Auto-Neg is enabled.  Auto Speed Detection takes care
>   	 * of MAC speed/duplex configuration.  So we only need to
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index f457c5703d0c..db735644b312 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -450,7 +450,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>   	 * we have already determined whether we have link or not.
>   	 */
>   	if (!mac->autoneg)
> -		return -E1000_ERR_CONFIG;
> +		return 1;
>   
>   	/* Auto-Neg is enabled.  Auto Speed Detection takes care
>   	 * of MAC speed/duplex configuration.  So we only need to
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
