Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54242C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C97820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C97820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeJPUsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:48:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:26310 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPUsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:48:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 05:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="81622272"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2018 05:57:44 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gCOut-0007IJ-O3; Tue, 16 Oct 2018 15:57:43 +0300
Date:   Tue, 16 Oct 2018 15:57:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] drivers: base: Introducing software nodes to the
 firmware node framework
Message-ID: <20181016125743.GX15943@smile.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181012113934.29942-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012113934.29942-4-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:39:32PM +0300, Heikki Krogerus wrote:
> Software node is a new struct fwnode_handle type that can be
> used to describe devices in kernel (software). It is meant
> to complement fwnodes representing real firmware nodes when
> they are incomplete (for example missing device properties)
> and to supply the primary fwnode when the firmware lacks
> hardware description for a device completely.
> 
> The software node type is really meant to replace the
> currently used "property_set" struct fwnode_handle type. The
> handling of struct property_set is glued to the generic
> device property handling code, and it is not possible to
> create a struct property_set independently from a device
> that it is bind to. struct property_set is only created when
> device properties are added to already initialized struct
> device, and control of it is only possible from the generic
> property handling code.
> 
> Software nodes are instead designed to be created
> independently from the device entries (struct device). It
> makes them much more flexible, as then the device meant to
> be bind to the node can be created at a later time, and from
> another location. It is also possible to bind multiple
> devices to a single software node if needed.
> 
> The software node implementation also includes support for
> node hierarchy, which was the main motivation for this
> commit. The node hierarchy was something that was requested
> for the struct property_set, but it did not seem reasonable
> to try to extend the property_set support for that purpose.
> struct property_set was really meant only for device
> property handling like the name suggests.
> 
> Support for struct property_set is not yet removed in this
> commit, but it will be in the following one.

> +static int property_entry_read_string_array(const struct property_entry *props,
> +					    const char *propname,
> +					    const char **strings, size_t nval)
> +{
> +	const struct property_entry *prop;
> +	const void *pointer;
> +	size_t array_len, length;
> +
> +	/* Find out the array length. */
> +	prop = property_entry_get(props, propname);
> +	if (!prop)
> +		return -EINVAL;
> +

> +	if (!prop->is_array)
> +		/* The array length for a non-array string property is 1. */
> +		array_len = 1;
> +	else
> +		/* Find the length of an array. */
> +		array_len = property_entry_count_elems_of_size(props, propname,
> +							  sizeof(const char *));

I understand where it comes from, but here we may use positive condition.

> +
> +	/* Return how many there are if strings is NULL. */
> +	if (!strings)
> +		return array_len;
> +
> +	array_len = min(nval, array_len);
> +	length = array_len * sizeof(*strings);
> +
> +	pointer = property_entry_find(props, propname, length);
> +	if (IS_ERR(pointer))
> +		return PTR_ERR(pointer);
> +
> +	memcpy(strings, pointer, length);
> +
> +	return array_len;
> +}

> +struct fwnode_handle *
> +software_node_get_next_child(const struct fwnode_handle *fwnode,
> +			     struct fwnode_handle *child)
> +{
> +	struct software_node *p = to_software_node(fwnode);
> +	struct software_node *c = to_software_node(child);
> +
> +	if (list_empty(&p->children) ||
> +	    (c && list_is_last(&c->entry, &p->children)))
> +		return NULL;
> +
> +	if (c)
> +		c = list_next_entry(c, entry);
> +	else
> +		c = list_first_entry(&p->children, struct software_node, entry);
> +	return &c->fwnode;
> +}

> +static ssize_t software_node_property_show(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   char *buf)
> +{
> +	struct software_node *swnode = kobj_to_swnode(kobj);
> +	const struct property_entry *prop;
> +
> +	for (prop = swnode->properties; prop->name; prop++)
> +		if (prop->name == attr->attr.name)
> +			break;
> +
> +	if (prop->is_array)
> +		return property_array_show(prop, buf);
> +
> +	/* boolean property */
> +	if (!prop->length)
> +		return sprintf(buf, "1\n");
> +
> +	switch (prop->type) {

> +	case DEV_PROP_U8:
> +		return sprintf(buf, "%u\n", prop->value.u8_data);

I would expect same base for all numbers.

> +	case DEV_PROP_U16:
> +		return sprintf(buf, "0x%x\n", prop->value.u16_data);
> +	case DEV_PROP_U32:
> +		return sprintf(buf, "0x%x\n", prop->value.u32_data);
> +	case DEV_PROP_U64:
> +		return sprintf(buf, "0x%llx\n", prop->value.u64_data);
> +	case DEV_PROP_STRING:
> +		return sprintf(buf, "%s\n", prop->value.str);
> +	default:
> +		break;
> +	}

I just realize that we might need to export type of the node as well.
How can we distinguish string "251" from a number?

> +
> +	return -EINVAL;
> +}

> +}

> +#define NODE_NAME_MAXSIZE	11

sizeof(int) = 4 (32 bits), so, 32 * 3 / 10 ~= 10. On top are "node" and '\0'.
Thus, I would rather put 16 here. Or limit the maximum for ida_simple_get().

> +struct fwnode_handle *
> +fwnode_create_software_node(const struct property_entry *properties,
> +			    const struct fwnode_handle *parent)
> +{
> +	char node_name[NODE_NAME_MAXSIZE];
> +	struct software_node *p = NULL;
> +	struct software_node *swnode;
> +	int ret;
> +
> +	if (parent) {
> +		if (IS_ERR(parent))
> +			return ERR_CAST(parent);
> +		if (!is_software_node(parent))
> +			return ERR_PTR(-EINVAL);
> +		p = to_software_node(parent);
> +	}
> +
> +	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
> +	if (!swnode)
> +		return ERR_PTR(-ENOMEM);
> +

> +	swnode->id = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
> +				    GFP_KERNEL);

> +	if (swnode->id < 0) {
> +		kfree(swnode);
> +		return ERR_PTR(swnode->id);
> +	}
> +
> +	sprintf(node_name, "node%d", swnode->id);
> +
> +	swnode->kobj.kset = swnode_kset;
> +	swnode->fwnode.ops = &software_node_ops;
> +
> +	ida_init(&swnode->child_ids);
> +	INIT_LIST_HEAD(&swnode->entry);
> +	INIT_LIST_HEAD(&swnode->children);
> +	swnode->parent = p;
> +
> +	if (p)
> +		list_add_tail(&swnode->entry, &p->children);
> +
> +	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> +				   p ? &p->kobj : NULL, node_name);
> +	if (ret) {
> +		kobject_put(&swnode->kobj);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = software_node_register_properties(swnode, properties);
> +	if (ret) {
> +		kobject_put(&swnode->kobj);
> +		return ERR_PTR(ret);
> +	}
> +
> +	kobject_uevent(&swnode->kobj, KOBJ_ADD);
> +	return &swnode->fwnode;
> +}


-- 
With Best Regards,
Andy Shevchenko


