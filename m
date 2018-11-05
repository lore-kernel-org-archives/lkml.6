Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E87DC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4742120685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4742120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeKEX5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:57:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:57668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbeKEX5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:57:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:37:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="86796944"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2018 06:37:32 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gJg0R-0005mo-NB; Mon, 05 Nov 2018 16:37:31 +0200
Date:   Mon, 5 Nov 2018 16:37:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/4] device property: Introduce fwnode_name()
Message-ID: <20181105143731.GK10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:17:24PM +0300, Heikki Krogerus wrote:
> This helper returns the name of the node. The name is
> primarily expected to be returned from a new fwnode
> operation meant for this purpose, but when no name is
> returned, the helper will also attempt to read a device
> property "name".
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 18 ++++++++++++++++++
>  include/linux/fwnode.h   |  1 +
>  include/linux/property.h |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..1e4eb7ab2b84 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1156,6 +1156,24 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_handle_put);
>  
> +/**
> + * fwnode_name - Get the name of a device node
> + * @fwnode: Pointer to the device node.
> + *
> + * Returns the node name of @fwnode. If @fwnode does not have a "unit name",
> + * this code will also attempt to read a string property named "name".
> + */
> +const char *fwnode_name(const struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_call_ptr_op(fwnode, name);
> +
> +	if (!name)
> +		fwnode_call_int_op(fwnode, property_read_string_array,
> +				   "name", &name, 1);

Is it going to be extended in the future?

Otherwise I would rather go with (few more LOCs, yes)

	const char *name;

	name = fwnode_call_ptr_op(fwnode, name);
	if (name)
		return name;

	fwnode_call_int_op(fwnode, property_read_string_array, "name", &name, 1);
	return name;

> +	return name;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_name);
> +
>  /**
>   * fwnode_device_is_available - check if a device is available for use
>   * @fwnode: Pointer to the fwnode of the device.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index faebf0ca0686..2e445fed4df4 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -72,6 +72,7 @@ struct fwnode_reference_args {
>  struct fwnode_operations {
>  	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
>  	void (*put)(struct fwnode_handle *fwnode);
> +	const char *(*name)(const struct fwnode_handle *fwnode);
>  	bool (*device_is_available)(const struct fwnode_handle *fwnode);
>  	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
>  					     const struct device *dev);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ac8a1ebc4c1b..44781d37dd96 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -109,6 +109,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
> +const char *fwnode_name(const struct fwnode_handle *fwnode);
> +
>  int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
>  
>  unsigned int device_get_child_node_count(struct device *dev);
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko


