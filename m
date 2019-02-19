Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55933C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD9B2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBSKBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:01:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55036 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:01:44 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 3c96f183483145db; Tue, 19 Feb 2019 11:01:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Implement get_named_child_node fwnode callback
Date:   Tue, 19 Feb 2019 11:00:17 +0100
Message-ID: <1695920.3PekvGoq6c@aspire.rjw.lan>
In-Reply-To: <20190213115549.81917-1-heikki.krogerus@linux.intel.com>
References: <20190213115549.81917-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 13, 2019 12:55:49 PM CET Heikki Krogerus wrote:
> This makes it possible to support drivers that use
> fwnode_get_named_child_node() and device_get_named_child_node()
> functions.
> 
> The node name is for now taken from a device property named
> "name". That mimics the old style of naming of the nodes in
> devicetree (though with modern flattened DT, the name is
> matched against the actual node-name, it used to be done
> with a property "name"). In Open Firmware DT the "name"
> property is also still being used.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 89ad8dee6ad5..1fad9291f6aa 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -499,6 +499,28 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
>  	return &c->fwnode;
>  }
>  
> +static struct fwnode_handle *
> +software_node_get_named_child_node(const struct fwnode_handle *fwnode,
> +				   const char *childname)
> +{
> +	struct software_node *swnode = to_software_node(fwnode);
> +	const struct property_entry *prop;
> +	struct software_node *child;
> +
> +	if (!swnode || list_empty(&swnode->children))
> +		return NULL;
> +
> +	list_for_each_entry(child, &swnode->children, entry) {
> +		prop = property_entry_get(child->properties, "name");
> +		if (!prop)
> +			continue;
> +		if (!strcmp(childname, prop->value.str)) {
> +			kobject_get(&child->kobj);
> +			return &child->fwnode;
> +		}
> +	}
> +	return NULL;
> +}
>  
>  static const struct fwnode_operations software_node_ops = {
>  	.get = software_node_get,
> @@ -508,6 +530,7 @@ static const struct fwnode_operations software_node_ops = {
>  	.property_read_string_array = software_node_read_string_array,
>  	.get_parent = software_node_get_parent,
>  	.get_next_child_node = software_node_get_next_child,
> +	.get_named_child_node = software_node_get_named_child_node,
>  };
>  
>  /* -------------------------------------------------------------------------- */
> 

Applied, thanks!


