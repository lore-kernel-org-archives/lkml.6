Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB580C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764B620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764B620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeKJAyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:54:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:22194 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJAyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:54:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 07:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="84598946"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2018 07:13:42 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gL8Td-0006Fu-Cw; Fri, 09 Nov 2018 17:13:41 +0200
Date:   Fri, 9 Nov 2018 17:13:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 6/6] device property: Remove struct property_set
Message-ID: <20181109151341.GX10650@smile.fi.intel.com>
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
 <20181109142138.54770-7-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109142138.54770-7-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 05:21:38PM +0300, Heikki Krogerus wrote:
> Replacing struct property_set with the software nodes that
> were just introduced.
> 
> The API and functionality for adding properties to devices
> remains the same, however, the goal is to convert the
> drivers to use the API for software nodes when the device
> has no real firmware node, and use the old API only when
> "extra" build-in properties are needed.
> 

Much better, thanks!
One minor comment below.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c | 332 ++--------------------------------------
>  1 file changed, 17 insertions(+), 315 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index e20642759c67..240cd0f40605 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -18,198 +18,6 @@
>  #include <linux/etherdevice.h>
>  #include <linux/phy.h>
>  
> -struct property_set {
> -	struct device *dev;
> -	struct fwnode_handle fwnode;
> -	const struct property_entry *properties;
> -};
> -
> -static const struct fwnode_operations pset_fwnode_ops;
> -
> -static inline bool is_pset_node(const struct fwnode_handle *fwnode)
> -{
> -	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
> -}
> -
> -#define to_pset_node(__fwnode)						\
> -	({								\
> -		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
> -									\
> -		is_pset_node(__to_pset_node_fwnode) ?			\
> -			container_of(__to_pset_node_fwnode,		\
> -				     struct property_set, fwnode) :	\
> -			NULL;						\
> -	})
> -
> -static const struct property_entry *
> -pset_prop_get(const struct property_set *pset, const char *name)
> -{
> -	const struct property_entry *prop;
> -
> -	if (!pset || !pset->properties)
> -		return NULL;
> -
> -	for (prop = pset->properties; prop->name; prop++)
> -		if (!strcmp(name, prop->name))
> -			return prop;
> -
> -	return NULL;
> -}
> -
> -static const void *property_get_pointer(const struct property_entry *prop)
> -{
> -	switch (prop->type) {
> -	case DEV_PROP_U8:
> -		if (prop->is_array)
> -			return prop->pointer.u8_data;
> -		return &prop->value.u8_data;
> -	case DEV_PROP_U16:
> -		if (prop->is_array)
> -			return prop->pointer.u16_data;
> -		return &prop->value.u16_data;
> -	case DEV_PROP_U32:
> -		if (prop->is_array)
> -			return prop->pointer.u32_data;
> -		return &prop->value.u32_data;
> -	case DEV_PROP_U64:
> -		if (prop->is_array)
> -			return prop->pointer.u64_data;
> -		return &prop->value.u64_data;
> -	case DEV_PROP_STRING:
> -		if (prop->is_array)
> -			return prop->pointer.str;
> -		return &prop->value.str;
> -	default:
> -		return NULL;
> -	}
> -}
> -
> -static const void *pset_prop_find(const struct property_set *pset,
> -				  const char *propname, size_t length)
> -{
> -	const struct property_entry *prop;
> -	const void *pointer;
> -
> -	prop = pset_prop_get(pset, propname);
> -	if (!prop)
> -		return ERR_PTR(-EINVAL);
> -	pointer = property_get_pointer(prop);
> -	if (!pointer)
> -		return ERR_PTR(-ENODATA);
> -	if (length > prop->length)
> -		return ERR_PTR(-EOVERFLOW);
> -	return pointer;
> -}
> -
> -static int pset_prop_read_u8_array(const struct property_set *pset,
> -				   const char *propname,
> -				   u8 *values, size_t nval)
> -{
> -	const void *pointer;
> -	size_t length = nval * sizeof(*values);
> -
> -	pointer = pset_prop_find(pset, propname, length);
> -	if (IS_ERR(pointer))
> -		return PTR_ERR(pointer);
> -
> -	memcpy(values, pointer, length);
> -	return 0;
> -}
> -
> -static int pset_prop_read_u16_array(const struct property_set *pset,
> -				    const char *propname,
> -				    u16 *values, size_t nval)
> -{
> -	const void *pointer;
> -	size_t length = nval * sizeof(*values);
> -
> -	pointer = pset_prop_find(pset, propname, length);
> -	if (IS_ERR(pointer))
> -		return PTR_ERR(pointer);
> -
> -	memcpy(values, pointer, length);
> -	return 0;
> -}
> -
> -static int pset_prop_read_u32_array(const struct property_set *pset,
> -				    const char *propname,
> -				    u32 *values, size_t nval)
> -{
> -	const void *pointer;
> -	size_t length = nval * sizeof(*values);
> -
> -	pointer = pset_prop_find(pset, propname, length);
> -	if (IS_ERR(pointer))
> -		return PTR_ERR(pointer);
> -
> -	memcpy(values, pointer, length);
> -	return 0;
> -}
> -
> -static int pset_prop_read_u64_array(const struct property_set *pset,
> -				    const char *propname,
> -				    u64 *values, size_t nval)
> -{
> -	const void *pointer;
> -	size_t length = nval * sizeof(*values);
> -
> -	pointer = pset_prop_find(pset, propname, length);
> -	if (IS_ERR(pointer))
> -		return PTR_ERR(pointer);
> -
> -	memcpy(values, pointer, length);
> -	return 0;
> -}
> -
> -static int pset_prop_count_elems_of_size(const struct property_set *pset,
> -					 const char *propname, size_t length)
> -{
> -	const struct property_entry *prop;
> -
> -	prop = pset_prop_get(pset, propname);
> -	if (!prop)
> -		return -EINVAL;
> -
> -	return prop->length / length;
> -}
> -
> -static int pset_prop_read_string_array(const struct property_set *pset,
> -				       const char *propname,
> -				       const char **strings, size_t nval)
> -{
> -	const struct property_entry *prop;
> -	const void *pointer;
> -	size_t array_len, length;
> -
> -	/* Find out the array length. */
> -	prop = pset_prop_get(pset, propname);
> -	if (!prop)
> -		return -EINVAL;
> -
> -	if (!prop->is_array)
> -		/* The array length for a non-array string property is 1. */
> -		array_len = 1;
> -	else
> -		/* Find the length of an array. */
> -		array_len = pset_prop_count_elems_of_size(pset, propname,
> -							  sizeof(const char *));
> -
> -	/* Return how many there are if strings is NULL. */
> -	if (!strings)
> -		return array_len;
> -
> -	array_len = min(nval, array_len);
> -	length = array_len * sizeof(*strings);
> -
> -	pointer = pset_prop_find(pset, propname, length);
> -	if (IS_ERR(pointer))
> -		return PTR_ERR(pointer);
> -
> -	memcpy(strings, pointer, length);
> -
> -	return array_len;
> -}
> -
>  struct fwnode_handle *dev_fwnode(struct device *dev)
>  {
>  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> @@ -217,51 +25,6 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
>  
> -static bool pset_fwnode_property_present(const struct fwnode_handle *fwnode,
> -					 const char *propname)
> -{
> -	return !!pset_prop_get(to_pset_node(fwnode), propname);
> -}
> -
> -static int pset_fwnode_read_int_array(const struct fwnode_handle *fwnode,
> -				      const char *propname,
> -				      unsigned int elem_size, void *val,
> -				      size_t nval)
> -{
> -	const struct property_set *node = to_pset_node(fwnode);
> -
> -	if (!val)
> -		return pset_prop_count_elems_of_size(node, propname, elem_size);
> -
> -	switch (elem_size) {
> -	case sizeof(u8):
> -		return pset_prop_read_u8_array(node, propname, val, nval);
> -	case sizeof(u16):
> -		return pset_prop_read_u16_array(node, propname, val, nval);
> -	case sizeof(u32):
> -		return pset_prop_read_u32_array(node, propname, val, nval);
> -	case sizeof(u64):
> -		return pset_prop_read_u64_array(node, propname, val, nval);
> -	}
> -
> -	return -ENXIO;
> -}
> -
> -static int
> -pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
> -				       const char *propname,
> -				       const char **val, size_t nval)
> -{
> -	return pset_prop_read_string_array(to_pset_node(fwnode), propname,
> -					   val, nval);
> -}
> -
> -static const struct fwnode_operations pset_fwnode_ops = {
> -	.property_present = pset_fwnode_property_present,
> -	.property_read_int_array = pset_fwnode_read_int_array,
> -	.property_read_string_array = pset_fwnode_property_read_string_array,
> -};
> -
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> @@ -721,82 +484,25 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
>  
> -/**
> - * pset_free_set - releases memory allocated for copied property set
> - * @pset: Property set to release
> - *
> - * Function takes previously copied property set and releases all the
> - * memory allocated to it.
> - */
> -static void pset_free_set(struct property_set *pset)
> -{
> -	if (!pset)
> -		return;
> -
> -	property_entries_free(pset->properties);
> -	kfree(pset);
> -}
> -
> -/**
> - * pset_copy_set - copies property set
> - * @pset: Property set to copy
> - *
> - * This function takes a deep copy of the given property set and returns
> - * pointer to the copy. Call device_free_property_set() to free resources
> - * allocated in this function.
> - *
> - * Return: Pointer to the new property set or error pointer.
> - */
> -static struct property_set *pset_copy_set(const struct property_set *pset)
> -{
> -	struct property_entry *properties;
> -	struct property_set *p;
> -
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> -	if (!p)
> -		return ERR_PTR(-ENOMEM);
> -
> -	properties = property_entries_dup(pset->properties);
> -	if (IS_ERR(properties)) {
> -		kfree(p);
> -		return ERR_CAST(properties);
> -	}
> -
> -	p->properties = properties;
> -	return p;
> -}
> -
>  /**
>   * device_remove_properties - Remove properties from a device object.
>   * @dev: Device whose properties to remove.
>   *
>   * The function removes properties previously associated to the device
> - * secondary firmware node with device_add_properties(). Memory allocated
> - * to the properties will also be released.
> + * firmware node with device_add_properties(). Memory allocated to the
> + * properties will also be released.
>   */
>  void device_remove_properties(struct device *dev)
>  {

> -	struct fwnode_handle *fwnode;
> -	struct property_set *pset;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  
> -	fwnode = dev_fwnode(dev);

I think you may leave these lines (except pset one) as in the original code.

>  	if (!fwnode)
>  		return;
> -	/*
> -	 * Pick either primary or secondary node depending which one holds
> -	 * the pset. If there is no real firmware node (ACPI/DT) primary
> -	 * will hold the pset.
> -	 */
> -	pset = to_pset_node(fwnode);
> -	if (pset) {
> -		set_primary_fwnode(dev, NULL);
> -	} else {
> -		pset = to_pset_node(fwnode->secondary);
> -		if (pset && dev == pset->dev)
> -			set_secondary_fwnode(dev, NULL);
> +
> +	if (is_software_node(fwnode->secondary)) {
> +		fwnode_remove_software_node(fwnode->secondary);
> +		set_secondary_fwnode(dev, NULL);
>  	}
> -	if (pset && dev == pset->dev)
> -		pset_free_set(pset);
>  }
>  EXPORT_SYMBOL_GPL(device_remove_properties);
>  
> @@ -806,26 +512,22 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
>   * @properties: Collection of properties to add.
>   *
>   * Associate a collection of device properties represented by @properties with
> - * @dev as its secondary firmware node. The function takes a copy of
> - * @properties.
> + * @dev. The function takes a copy of @properties.
> + *
> + * WARNING: The callers should not use this function if it is known that there
> + * is no real firmware node associated with @dev! In that case the callers
> + * should create a software node and assign it to @dev directly.
>   */
>  int device_add_properties(struct device *dev,
>  			  const struct property_entry *properties)
>  {
> -	struct property_set *p, pset;
> -
> -	if (!properties)
> -		return -EINVAL;
> -
> -	pset.properties = properties;
> +	struct fwnode_handle *fwnode;
>  
> -	p = pset_copy_set(&pset);
> -	if (IS_ERR(p))
> -		return PTR_ERR(p);
> +	fwnode = fwnode_create_software_node(properties, NULL);
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
>  
> -	p->fwnode.ops = &pset_fwnode_ops;
> -	set_secondary_fwnode(dev, &p->fwnode);
> -	p->dev = dev;
> +	set_secondary_fwnode(dev, fwnode);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_add_properties);
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko


