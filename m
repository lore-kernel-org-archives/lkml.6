Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0D8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E32820847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E32820847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeGENSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:18:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:36300 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753690AbeGENSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:18:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 06:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="69859195"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 05 Jul 2018 06:18:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Jul 2018 16:18:01 +0300
Date:   Thu, 5 Jul 2018 16:18:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: typec: unlock dp->lock on error exit path,
 and also zero ret if successful
Message-ID: <20180705131801.GD15989@kuha.fi.intel.com>
References: <20180704124611.9852-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704124611.9852-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:46:11PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> One of the error handling paths forgets to unlock dp->lock on the error
> exit path leading to a potential lock-up.  Also the return path for a
> successful call to the function configuration_store can return an
> uninitialized error return code if dp->alt->active is false, so ensure
> ret is zeroed on the successful exit path to avoid garbage being returned.
> 
> Detected by CoverityScan, CID#1471597 ("Unitialized scalar variable")
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index ef12b15bd484..9a637c2b4460 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -349,8 +349,10 @@ configuration_store(struct device *dev, struct device_attribute *attr,
>  	cap = DP_CAP_CAPABILITY(dp->alt->vdo);
>  
>  	if ((con == DP_CONF_DFP_D && !(cap & DP_CAP_DFP_D)) ||
> -	    (con == DP_CONF_UFP_D && !(cap & DP_CAP_UFP_D)))
> -		return -EINVAL;
> +	    (con == DP_CONF_UFP_D && !(cap & DP_CAP_UFP_D))) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
>  
>  	conf = dp->data.conf & ~DP_CONF_DUAL_D;
>  	conf |= con;
> @@ -362,6 +364,7 @@ configuration_store(struct device *dev, struct device_attribute *attr,
>  	}
>  
>  	dp->data.conf = conf;
> +	ret = 0;

Could you set the value when the variable is introduced:

        int ret = 0;


Thank you,

-- 
heikki
