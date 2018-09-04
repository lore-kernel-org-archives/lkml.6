Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10BA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10BA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIDKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:50:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:42574 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeIDKuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:50:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 23:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="68183605"
Received: from sgjhaver-mobl2.amr.corp.intel.com ([10.249.254.175])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2018 23:26:27 -0700
Message-ID: <8771557a6d74a81b9d2bb32b0a1f65c811875c96.camel@intel.com>
Subject: Re: [PATCH] iwlwifi: d3: use struct_size() in kzalloc()
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Tue, 04 Sep 2018 09:26:26 +0300
In-Reply-To: <20180824011540.GA25716@embeddedor.com>
References: <20180824011540.GA25716@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 20:15 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
>         void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 79bdae9..6960318 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -1769,8 +1769,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>  		n_matches = 0;
>  	}
>  
> -	net_detect = kzalloc(sizeof(*net_detect) +
> -			     (n_matches * sizeof(net_detect->matches[0])),
> +	net_detect = kzalloc(struct_size(net_detect, matches, n_matches),
>  			     GFP_KERNEL);
>  	if (!net_detect || !n_matches)
>  		goto out_report_nd;
> @@ -1785,8 +1784,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>  		for (j = 0; j < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN; j++)
>  			n_channels += hweight8(fw_match->matching_channels[j]);
>  
> -		match = kzalloc(sizeof(*match) +
> -				(n_channels * sizeof(*match->channels)),
> +		match = kzalloc(struct_size(match, channels, n_channels),
>  				GFP_KERNEL);
>  		if (!match)
>  			goto out_report_nd;

Thanks! I applied this to our internal tree and it will reach the
mainline following our normal process.

--
Cheers,
Luca.

