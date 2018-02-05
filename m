Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeBESUs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:20:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:33538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752738AbeBESUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:20:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="28959109"
Date: Mon, 5 Feb 2018 11:20:39 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: remove redundant assignment to pointer 'dev'
Message-ID: <20180205182039.GA7891@linux.intel.com>
References: <20180205140852.14110-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205140852.14110-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:08:52PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer dev is being assigned a value that is never read, it is being
> re-assigned the same value later on, hence the initialization is redundant
> and can be removed.
> 
> Cleans up clang warning:
> drivers/nvdimm/pfn_devs.c:307:17: warning: Value stored to 'dev' during
> its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>

More importantly this fixes a potential NULL pointer dereference.  nd_pfn
is checked for NULL a few lines down, but we would have crashed here trying to
get nd_pfn->dev.

We can append the above info to the changelog when we apply.

> ---
>  drivers/nvdimm/pfn_devs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index f5c4e8c6e29d..2f4d18752c97 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -304,7 +304,7 @@ static const struct attribute_group *nd_pfn_attribute_groups[] = {
>  struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
>  		struct nd_namespace_common *ndns)
>  {
> -	struct device *dev = &nd_pfn->dev;
> +	struct device *dev;
>  
>  	if (!nd_pfn)
>  		return NULL;
> -- 
> 2.15.1
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
