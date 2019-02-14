Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C84222DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502660AbfBNQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:13:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:36278 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502641AbfBNQM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:12:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 08:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="299757660"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2019 08:12:55 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC, altera: Add missing of_node_put()
To:     Huang Zijiang <huang.zijiang@zte.com.cn>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn
References: <1550126347-27984-1-git-send-email-huang.zijiang@zte.com.cn>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <64c210a5-41d2-2f62-e3d5-ac9c14841858@linux.intel.com>
Date:   Thu, 14 Feb 2019 10:15:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550126347-27984-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/14/19 12:39 AM, Huang Zijiang wrote:
> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented here after the last
> usage.
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> ---
>   drivers/edac/altera_edac.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index c89d82a..1bcd778 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1046,14 +1046,17 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
>   			return -ENODEV;
>   		}
>   
> -		if (of_address_to_resource(sysmgr_np, 0, &res))
> +		if (of_address_to_resource(sysmgr_np, 0, &res)) {
> +			of_node_put(sysmgr_np);
>   			return -ENOMEM;
> +		}
>   
>   		/* Need physical address for SMCC call */
>   		base = res.start;
>   
>   		ecc_mgr_map = regmap_init(NULL, NULL, (void *)base,
>   					  &s10_sdram_regmap_cfg);
> +		of_node_put(sysmgr_np);
>   	}
>   	of_node_put(np_eccmgr);
>   	if (IS_ERR(ecc_mgr_map)) {
> 

Yes, I missed the error path. I mistakingly thought 
of_node_put(np_eccmgr) would catch the exit of both branches but I 
declared sysmgr_np instead of re-using np_eccmgr. I'll clean that up in 
a separate patch (actually this code will disappear when my combined 
sysmgr patchset is accepted upstream).

Thanks!

Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
