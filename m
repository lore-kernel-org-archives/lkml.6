Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809023FDF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5809023FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeGFHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:10:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:2702 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbeGFHKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:10:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 00:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,315,1526367600"; 
   d="scan'208";a="70094456"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 06 Jul 2018 00:10:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 06 Jul 2018 10:10:36 +0300
Date:   Fri, 6 Jul 2018 10:10:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] usb: typec: unlock dp->lock on error exit path, and
 also zero ret if successful
Message-ID: <20180706071036.GB8308@kuha.fi.intel.com>
References: <20180705133647.13016-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705133647.13016-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 02:36:47PM +0100, Colin King wrote:
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

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> V2: move the ret = 0 assignment to the declaration
> 
> ---
>  drivers/usb/typec/altmodes/displayport.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index ef12b15bd484..3f06e94771a7 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -333,7 +333,7 @@ configuration_store(struct device *dev, struct device_attribute *attr,
>  	u32 conf;
>  	u32 cap;
>  	int con;
> -	int ret;
> +	int ret = 0;
>  
>  	con = sysfs_match_string(configurations, buf);
>  	if (con < 0)
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

Thanks,

-- 
heikki
