Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfAQH5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:57:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:37579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbfAQH5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:57:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 23:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="115335287"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.185.23.11]) ([10.185.23.11])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2019 23:57:44 -0800
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix cyclic resets at link up
 with active tx
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <154747257030.250168.12931902291381446144.stgit@buzz>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <031e1689-e133-5398-ad00-8f45f679ffff@intel.com>
Date:   Thu, 17 Jan 2019 09:57:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <154747257030.250168.12931902291381446144.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/2019 15:29, Konstantin Khlebnikov wrote:
> I'm seeing series of e1000e resets (sometimes endless) at system boot
> if something generates tx traffic at this time. In my case this is
> netconsole who sends message "e1000e 0000:02:00.0: Some CPU C-states
> have been disabled in order to enable jumbo frames" from e1000e itself.
> As result e1000_watchdog_task sees used tx buffer while carrier is off
> and start this reset cycle again.
> 
> [   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
> [   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [   27.174495] 8021q: 802.1Q VLAN Support v1.8
> [   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
> [   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
> [   30.898564] netpoll: netconsole: local port 6666
> [   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
> [   30.898567] netpoll: netconsole: interface 'eth1'
> [   30.898568] netpoll: netconsole: remote port 6666
> [   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
> [   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
> [   30.917747] console [netcon0] enabled
> [   30.917749] netconsole: network logging started
> [   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> 
> This patch flushes tx buffers only once when carrier is off
> rather than at each watchdog iteration.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c |   15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 189f231075c2..d10083beec83 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5309,8 +5309,13 @@ static void e1000_watchdog_task(struct work_struct *work)
>   			/* 8000ES2LAN requires a Rx packet buffer work-around
>   			 * on link down event; reset the controller to flush
>   			 * the Rx packet buffer.
> +			 *
> +			 * If the link is lost the controller stops DMA, but
> +			 * if there is queued Tx work it cannot be done.  So
> +			 * reset the controller to flush the Tx packet buffers.
>   			 */
> -			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
> +			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
> +			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
>   				adapter->flags |= FLAG_RESTART_NOW;
>   			else
>   				pm_schedule_suspend(netdev->dev.parent,
> @@ -5333,14 +5338,6 @@ static void e1000_watchdog_task(struct work_struct *work)
>   	adapter->gotc_old = adapter->stats.gotc;
>   	spin_unlock(&adapter->stats64_lock);
>   
> -	/* If the link is lost the controller stops DMA, but
> -	 * if there is queued Tx work it cannot be done.  So
> -	 * reset the controller to flush the Tx packet buffers.
> -	 */
> -	if (!netif_carrier_ok(netdev) &&
> -	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
> -		adapter->flags |= FLAG_RESTART_NOW;
> -
>   	/* If reset is necessary, do it outside of interrupt context. */
>   	if (adapter->flags & FLAG_RESTART_NOW) {
>   		schedule_work(&adapter->reset_task);
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
What is the HW setup you encountered this issue? Could you try to 
disable the jumbo frame and recheck? We cannot allow the low CPU states 
when the jumbo feature is enabled. This is HW design.
We will try to review this patch next week. Please, be patient.
