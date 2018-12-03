Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC920848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BC920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLCTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:08:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:2937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeLCTIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:08:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 11:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="95786235"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2018 11:08:29 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gTtZz-00050E-Th; Mon, 03 Dec 2018 21:08:27 +0200
Date:   Mon, 3 Dec 2018 21:08:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dvhart@infradead.org, andy@infradead.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH -next] platform/x86: intel-ips: remove unnecessary checks
 in ips_debugfs_init
Message-ID: <20181203190827.GX10650@smile.fi.intel.com>
References: <20181127030938.18160-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127030938.18160-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:09:38AM +0800, YueHaibing wrote:
> As Greg KH explained in:
> https://lkml.org/lkml/2015/8/15/114
> 
> There no need to check the return value of debugfs_create_file/
> debugfs_create_dir.
> 
> This also fix static code checker warnings:
> 
> drivers/platform/x86/intel_ips.c:1314
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> drivers/platform/x86/intel_ips.c:1328
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> 

Pushed to my review and testing queue, thanks!

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/platform/x86/intel_ips.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a..5c5dc82 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1310,32 +1310,17 @@ static void ips_debugfs_init(struct ips_driver *ips)
>  	int i;
>  
>  	ips->debug_root = debugfs_create_dir("ips", NULL);
> -	if (!ips->debug_root) {
> -		dev_err(ips->dev, "failed to create debugfs entries: %ld\n",
> -			PTR_ERR(ips->debug_root));
> -		return;
> -	}
>  
>  	for (i = 0; i < ARRAY_SIZE(ips_debug_files); i++) {
> -		struct dentry *ent;
>  		struct ips_debugfs_node *node = &ips_debug_files[i];
>  
>  		node->ips = ips;
> -		ent = debugfs_create_file(node->name, S_IFREG | S_IRUGO,
> -					  ips->debug_root, node,
> -					  &ips_debugfs_ops);
> -		if (!ent) {
> -			dev_err(ips->dev, "failed to create debug file: %ld\n",
> -				PTR_ERR(ent));
> -			goto err_cleanup;
> -		}
> +		debugfs_create_file(node->name, S_IFREG | S_IRUGO,
> +				    ips->debug_root, node,
> +				    &ips_debugfs_ops);
>  	}
>  
>  	return;
> -
> -err_cleanup:
> -	ips_debugfs_cleanup(ips);
> -	return;
>  }
>  #endif /* CONFIG_DEBUG_FS */
>  
> -- 
> 2.7.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko


