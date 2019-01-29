Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB0C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B421738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfA2DN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:13:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbfA2DN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:13:56 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8661B7956AB434B4356A;
        Tue, 29 Jan 2019 11:13:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 11:13:52 +0800
Subject: Re: [PATCH 2/2] iwlwifi: Use struct_size() in kzalloc
To:     Joe Perches <joe@perches.com>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <luciano.coelho@intel.com>,
        <linuxwifi@intel.com>, <kvalo@codeaurora.org>
References: <20190128064432.17576-1-yuehaibing@huawei.com>
 <20190128064432.17576-3-yuehaibing@huawei.com>
 <9a66aa07870c729ad0e65ac26a2404fac879f290.camel@perches.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9206ae04-1649-fd7a-58f3-da88df729875@huawei.com>
Date:   Tue, 29 Jan 2019 11:13:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <9a66aa07870c729ad0e65ac26a2404fac879f290.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/29 5:57, Joe Perches wrote:
> On Mon, 2019-01-28 at 14:44 +0800, YueHaibing wrote:
>> Use struct_size() in kzalloc instead of the 'regd_to_copy'
> 
> There is also the use above that in the same function
> that could also be converted.
> 
> 	/* build a regdomain rule for every valid channel */
> 	size_of_regd =
> 		sizeof(struct ieee80211_regdomain) +
> 		num_of_ch * sizeof(struct ieee80211_reg_rule);
> 
> 	regd = kzalloc(size_of_regd, GFP_KERNEL);
> 	if (!regd)
> 		return ERR_PTR(-ENOMEM);

Thank you, will post v2.

> 
>> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> []
>> @@ -1093,7 +1093,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
>>  	const u8 *nvm_chan = cfg->nvm_type == IWL_NVM_EXT ?
>>  			     iwl_ext_nvm_channels : iwl_nvm_channels;
>>  	struct ieee80211_regdomain *regd, *copy_rd;
>> -	int size_of_regd, regd_to_copy;
>> +	int size_of_regd;
>>  	struct ieee80211_reg_rule *rule;
>>  	struct regdb_ptrs *regdb_ptrs;
>>  	enum nl80211_band band;
>> @@ -1193,10 +1193,8 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
>>  	 * Narrow down regdom for unused regulatory rules to prevent hole
>>  	 * between reg rules to wmm rules.
>>  	 */
>> -	regd_to_copy = sizeof(struct ieee80211_regdomain) +
>> -		valid_rules * sizeof(struct ieee80211_reg_rule);
>> -
>> -	copy_rd = kmemdup(regd, regd_to_copy, GFP_KERNEL);
>> +	copy_rd = kmemdup(regd, struct_size(regd, reg_rules, valid_rules),
>> +			  GFP_KERNEL);
>>  	if (!copy_rd)
>>  		copy_rd = ERR_PTR(-ENOMEM);
>>  
> 
> 
> .
> 

