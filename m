Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1CA20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1CA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbeKGQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:31:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:7297 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeKGQbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:31:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 23:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="104107044"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.185.23.11]) ([10.185.23.11])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2018 23:01:58 -0800
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Change watchdog task to be
 delayed work
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        "David S. Miller" <davem@davemloft.net>
References: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <512ee04d-2699-6eb0-e9e3-fd867671c7b7@intel.com>
Date:   Wed, 7 Nov 2018 09:01:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2018 02:17, Robert Eshleman wrote:
> This completes a pending TODO to use queue_delayed_work() instead of
> schedule_work().
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 16a73bd..a387b21 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -39,6 +39,8 @@ static int debug = -1;
>   module_param(debug, int, 0);
>   MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>   
> +struct workqueue_struct *e1000e_workqueue;
> +
>   static const struct e1000_info *e1000_info_tbl[] = {
>   	[board_82571]		= &e1000_82571_info,
>   	[board_82572]		= &e1000_82572_info,
> @@ -5137,9 +5139,9 @@ static void e1000_watchdog(struct timer_list *t)
>   	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
>   
>   	/* Do the rest outside of interrupt context */
> -	schedule_work(&adapter->watchdog_task);
> +	struct delayed_work *dwork = to_delayed_work(&adapter->watchdog_task);
>   
> -	/* TODO: make this use queue_delayed_work() */
> +	queue_delayed_work(e1000e_workqueue, dwork, 1);
>   }
>   
>   static void e1000_watchdog_task(struct work_struct *work)
> @@ -7572,6 +7574,13 @@ static int __init e1000_init_module(void)
>   		e1000e_driver_version);
>   	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
>   
> +	e1000e_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> +					   e1000e_driver_name);
> +	if (!e1000e_workqueue) {
> +		pr_err("%s: Failed to create workqueue\n", e1000e_driver_name);
> +		return -ENOMEM;
> +	}
> +
>   	return pci_register_driver(&e1000_driver);
>   }
>   module_init(e1000_init_module);
> @@ -7585,6 +7594,7 @@ module_init(e1000_init_module);
>   static void __exit e1000_exit_module(void)
>   {
>   	pci_unregister_driver(&e1000_driver);
> +	destroy_workqueue(e1000e_workqueue);
>   }
>   module_exit(e1000_exit_module);
>   
> 
Hello,
What is benefit of using 'delayed_work' mechanism instead of 
'schedue_work'? Some improvement in the driver behavior?
Thanks,
Sasha
