Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC00C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4080D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAs/9kB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJKSO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeJKSO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:14:26 -0400
Received: from localhost (unknown [178.228.10.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C717320659;
        Thu, 11 Oct 2018 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539254864;
        bh=EU4OZqY7tBmLYqMNvStYwiEVrG1j2S7Pelz0BG81vWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAs/9kB4oyaS1sQZ7dtDOnxh7DdDvVYmo67vq5+e0SGq7xyJDx5qNhajiYI0ewKF9
         srE+sHCwLhPTZmVgnm1hm2BWB2yN8SCQ9ApbfV6+TalcWgKoqgDAOiIapVPsm9gD8t
         Eyv27VUQyYeUawPzBtVeGg7ucyqBwfNnM2jrQwNo=
Date:   Thu, 11 Oct 2018 12:47:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH v2 2/5] async: Add support for
 queueing on specific NUMA node
Message-ID: <20181011104740.GB30183@kroah.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230747.10609.15866.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010230747.10609.15866.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:08:21PM -0700, Alexander Duyck wrote:
> This patch introduces four new variants of the async_schedule_ functions
> that allow scheduling on a specific NUMA node.
> 
> The first two functions are async_schedule_near and
> async_schedule_near_domain which end up mapping to async_schedule and
> async_schedule_domain but provide NUMA node specific functionality. They
> replace the original functions which were moved to inline function
> definitions that call the new functions while passing NUMA_NO_NODE.
> 
> The second two functions are async_schedule_dev and
> async_schedule_dev_domain which provide NUMA specific functionality when
> passing a device as the data member and that device has a NUMA node other
> than NUMA_NO_NODE.
> 
> The main motivation behind this is to address the need to be able to
> schedule device specific init work on specific NUMA nodes in order to
> improve performance of memory initialization.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> 
> v1->v2:
>     Replaced call to queue_work_near with call to queue_work_node
> 
>  include/linux/async.h |   36 +++++++++++++++++++++++++++++++++---
>  kernel/async.c        |   47 ++++++++++++++++++++++-------------------------
>  2 files changed, 55 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/async.h b/include/linux/async.h
> index 6b0226bdaadc..1f6cb0d50263 100644
> --- a/include/linux/async.h
> +++ b/include/linux/async.h
> @@ -14,6 +14,8 @@
>  
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/numa.h>
> +#include <linux/device.h>
>  
>  typedef u64 async_cookie_t;
>  typedef void (*async_func_t) (void *data, async_cookie_t cookie);
> @@ -37,9 +39,37 @@ struct async_domain {
>  	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
>  				      .registered = 0 }
>  
> -extern async_cookie_t async_schedule(async_func_t func, void *data);
> -extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
> -					    struct async_domain *domain);
> +async_cookie_t async_schedule_near(async_func_t func, void *data,
> +				   int node);
> +async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
> +					  int node,
> +					  struct async_domain *domain);
> +
> +static inline async_cookie_t async_schedule(async_func_t func, void *data)
> +{
> +	return async_schedule_near(func, data, NUMA_NO_NODE);
> +}
> +
> +static inline async_cookie_t
> +async_schedule_domain(async_func_t func, void *data,
> +		      struct async_domain *domain)
> +{
> +	return async_schedule_near_domain(func, data, NUMA_NO_NODE, domain);
> +}
> +
> +static inline async_cookie_t
> +async_schedule_dev(async_func_t func, struct device *dev)
> +{
> +	return async_schedule_near(func, dev, dev_to_node(dev));
> +}
> +
> +static inline async_cookie_t
> +async_schedule_dev_domain(async_func_t func, struct device *dev,
> +			  struct async_domain *domain)
> +{
> +	return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
> +}

No kerneldoc for these functions?  We lost it for
async_schedule_domain() which used to be documented before this patch :(

thanks,

greg k-h
