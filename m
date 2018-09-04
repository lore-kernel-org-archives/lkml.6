Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D405C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAD120869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAD120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIDKb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:31:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:54102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeIDKb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:31:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 23:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="67344163"
Received: from sgjhaver-mobl2.amr.corp.intel.com ([10.249.254.175])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2018 23:07:48 -0700
Message-ID: <78daed5d33990c816c7e947173a1ca12eaa27efb.camel@intel.com>
Subject: Re: [PATCH] iwlwifi: pcie: make array 'prop' static, shrinks object
 size
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Colin King <colin.king@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 09:07:47 +0300
In-Reply-To: <20180821102109.1630-1-colin.king@canonical.com>
References: <20180821102109.1630-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 11:21 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array prop on the stack but instead make it static.
> Makes the object code smaller by 30 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   80138	  15382	    576	  96096	  17760	drivers/net/wireless/intel/iwlwifi/pcie/trans.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   79948	  15542	    576	  96066	  17742	drivers/net/wireless/intel/iwlwifi/pcie/trans.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 7d319b6863fe..c7daf666ee21 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -1947,7 +1947,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
>  	struct iwl_trans_pcie_removal *removal =
>  		container_of(wk, struct iwl_trans_pcie_removal, work);
>  	struct pci_dev *pdev = removal->pdev;
> -	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
> +	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
>  
>  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
>  	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);

Thanks! I pushed this to our internal tree and it will reach upstream
following our normal process.

--
Luca.

