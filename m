Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1048ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA0C2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA0C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeISUsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:48:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:47042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbeISUsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:48:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 08:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="91474295"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 19 Sep 2018 08:10:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Sep 2018 18:10:26 +0300
Date:   Wed, 19 Sep 2018 18:10:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180919151026.GB11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917181603.125492-3-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> Several drivers rely on having notion of sub-nodes when describing
> hardware, let's allow static board-defined properties also have it.
> 
> The board files will then attach properties to devices in the following
> fashion:
> 
> 	device_add_properties(&board_platform_device.dev,
> 			      main_device_props);
> 	device_add_child_properties(&board_platform_device.dev,
> 				    dev_fwnode(&board_platform_device.dev),
> 				    child1_device_props);
> 	device_add_child_properties(&board_platform_device.dev,
> 				    dev_fwnode(&board_platform_device.dev),
> 				    child2_device_props);
> 	...
> 	platform_device_register(&board_platform_device.dev);
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/pset_property.c | 110 +++++++++++++++++++++++++++++++----
>  include/linux/property.h     |   4 ++
>  2 files changed, 102 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> index 08ecc13080ae..63f2377aefe8 100644
> --- a/drivers/base/pset_property.c
> +++ b/drivers/base/pset_property.c
> @@ -18,6 +18,11 @@ struct property_set {
>  	struct device *dev;
>  	struct fwnode_handle fwnode;
>  	const struct property_entry *properties;
> +
> +	struct property_set *parent;
> +	/* Entry in parent->children list */
> +	struct list_head child_node;
> +	struct list_head children;

Add

        const char *name;

and you can implement also pset_get_named_child_node().

>  };
>  
>  static const struct fwnode_operations pset_fwnode_ops;
> @@ -283,10 +288,47 @@ pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
>  					   val, nval);
>  }
>  
> +struct fwnode_handle *pset_fwnode_get_parent(const struct fwnode_handle *fwnode)
> +{
> +	struct property_set *pset = to_pset_node(fwnode);
> +
> +	return pset ? &pset->parent->fwnode : NULL;
> +}
> +
> +struct fwnode_handle *
> +pset_fwnode_get_next_subnode(const struct fwnode_handle *fwnode,
> +			     struct fwnode_handle *child)
> +{
> +	const struct property_set *pset = to_pset_node(fwnode);
> +	struct property_set *first_child;
> +	struct property_set *next;
> +
> +	if (!pset)
> +		return NULL;
> +
> +	if (list_empty(&pset->children))
> +		return NULL;
> +
> +	first_child = list_first_entry(&pset->children, struct property_set,
> +				       child_node);
> +
> +	if (child) {
> +		next = list_next_entry(to_pset_node(child), child_node);
> +		if (next == first_child)
> +			return NULL;
> +	} else {
> +		next = first_child;
> +	}
> +
> +	return &next->fwnode;
> +}
> +
>  static const struct fwnode_operations pset_fwnode_ops = {
>  	.property_present = pset_fwnode_property_present,
>  	.property_read_int_array = pset_fwnode_read_int_array,
>  	.property_read_string_array = pset_fwnode_property_read_string_array,
> +	.get_parent = pset_fwnode_get_parent,
> +	.get_next_child_node = pset_fwnode_get_next_subnode,
>  };
>  
>  static void property_entry_free_data(const struct property_entry *p)
> @@ -439,24 +481,31 @@ EXPORT_SYMBOL_GPL(property_entries_free);
>   */
>  static void pset_free_set(struct property_set *pset)
>  {
> +	struct property_set *child, *next;
> +
>  	if (!pset)
>  		return;
>  
> +	list_for_each_entry_safe(child, next, &pset->children, child_node) {
> +		list_del(&child->child_node);
> +		pset_free_set(child);
> +	}
> +
>  	property_entries_free(pset->properties);
>  	kfree(pset);
>  }
>  
>  /**
> - * pset_copy_set - copies property set
> - * @pset: Property set to copy
> + * pset_create_set - creates property set.
> + * @src: property entries for the set.
>   *
> - * This function takes a deep copy of the given property set and returns
> - * pointer to the copy. Call device_free_property_set() to free resources
> - * allocated in this function.
> + * This function takes a deep copy of the given property entries and creates
> + * property set. Call pset_free_set() to free resources allocated in this
> + * function.
>   *
>   * Return: Pointer to the new property set or error pointer.
>   */
> -static struct property_set *pset_copy_set(const struct property_set *pset)
> +static struct property_set *pset_create_set(const struct property_entry *src)
>  {
>  	struct property_entry *properties;
>  	struct property_set *p;
> @@ -465,7 +514,11 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  
> -	properties = property_entries_dup(pset->properties);
> +	INIT_LIST_HEAD(&p->child_node);
> +	INIT_LIST_HEAD(&p->children);
> +	p->fwnode.ops = &pset_fwnode_ops;
> +
> +	properties = property_entries_dup(src);
>  	if (IS_ERR(properties)) {
>  		kfree(p);
>  		return ERR_CAST(properties);
> @@ -521,20 +574,53 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
>  int device_add_properties(struct device *dev,
>  			  const struct property_entry *properties)
>  {
> -	struct property_set *p, pset;
> +	struct property_set *p;
>  
>  	if (!properties)
>  		return -EINVAL;
>  
> -	pset.properties = properties;
> -
> -	p = pset_copy_set(&pset);
> +	p = pset_create_set(properties);
>  	if (IS_ERR(p))
>  		return PTR_ERR(p);
>  
> -	p->fwnode.ops = &pset_fwnode_ops;
>  	set_secondary_fwnode(dev, &p->fwnode);
>  	p->dev = dev;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_add_properties);
> +
> +/**
> + * device_add_child_properties - Add a collection of properties to a device object.
> + * @dev: Device to add properties to.

@parent: missing

> + * @properties: Collection of properties to add.
> + *
> + * Associate a collection of device properties represented by @properties as a
> + * child of given @parent firmware node.  The function takes a copy of
> + * @properties.
> + */
> +struct fwnode_handle *
> +device_add_child_properties(struct device *dev,

device_add_child_properties(struct device *dev, const char *child_name,

> +			    struct fwnode_handle *parent,
> +			    const struct property_entry *properties)
> +{
> +	struct property_set *p;
> +	struct property_set *parent_pset;
> +
> +	if (!properties)
> +		return ERR_PTR(-EINVAL);
> +
> +	parent_pset = to_pset_node(parent);
> +	if (!parent_pset)
> +		return ERR_PTR(-EINVAL);
> +
> +	p = pset_create_set(properties);
> +	if (IS_ERR(p))
> +		return ERR_CAST(p);
> +
> +	p->dev = dev;

        p->name = kstrdup_const(child_name, GFP_KERNEL);

You'll need to kfree_const(pset->name) in pset_free_set() of course.

> +	p->parent = parent_pset;
> +	list_add_tail(&p->child_node, &parent_pset->children);
> +
> +	return &p->fwnode;
> +}
> +EXPORT_SYMBOL_GPL(device_add_child_properties);


Br,

-- 
heikki
