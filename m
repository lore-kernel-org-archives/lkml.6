Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D09C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EC620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EC620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeK0AcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:32:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:48995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0AcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:32:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 05:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="283369811"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2018 05:37:58 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRH5J-0001Rm-0s; Mon, 26 Nov 2018 15:37:57 +0200
Date:   Mon, 26 Nov 2018 15:37:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dvhart@infradead.org, andy@infradead.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 -next] platform/x86: intel-ips: fix 'passing zero to
 PTR_ERR()' warning
Message-ID: <20181126133757.GJ10650@smile.fi.intel.com>
References: <20181126131948.18160-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126131948.18160-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:19:48PM +0800, YueHaibing wrote:
> Fix a static code checker warning:
> drivers/platform/x86/intel_ips.c:1314
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> drivers/platform/x86/intel_ips.c:1328
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> 
> If error occurs,debugfs_create_dir/debugfs_create_file
> return NULL while debugfs is enabled, which should not
> passing to PTR_ERR.
> 

Thanks for a patch.
Though the better approach as Greg KH explained [1] is to get rid of unnecessary checks.

[1]: https://lkml.org/lkml/2015/8/15/114

> Fixes: aa7ffc01d254 ("x86 platform driver: intelligent power sharing driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2:Fix typo in patch log and title
> ---
>  drivers/platform/x86/intel_ips.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a..a5d1a68 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1311,8 +1311,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
>  
>  	ips->debug_root = debugfs_create_dir("ips", NULL);
>  	if (!ips->debug_root) {
> -		dev_err(ips->dev, "failed to create debugfs entries: %ld\n",
> -			PTR_ERR(ips->debug_root));
> +		dev_err(ips->dev, "failed to create debugfs entries\n")
>  		return;
>  	}
>  
> @@ -1325,8 +1324,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
>  					  ips->debug_root, node,
>  					  &ips_debugfs_ops);
>  		if (!ent) {
> -			dev_err(ips->dev, "failed to create debug file: %ld\n",
> -				PTR_ERR(ent));
> +			dev_err(ips->dev, "failed to create debug file\n");
>  			goto err_cleanup;
>  		}
>  	}
> -- 
> 2.7.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko


