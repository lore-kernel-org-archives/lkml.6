Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5262F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548160244;
	bh=/tdz5jx5P4MR0Ip7xP+VsFJc0N/i1Ftq5Gsfd0eawZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lxe5pGh4dLD/W07aN+sEQN8K7WpCZ+tmrcyoWEZ21M1iaWL02x6iCSHxUfiz1VKrd
	 F5JOJL+4gudyZbCPaFuwU9Emeq+4XHpPBXEVDErCOvZaewyXqUXPsgp9ubNDlisHXh
	 YA+m5ST36VUtmZ+w3kK4qtnZAkAKO5cDIjprjdyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAVMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfAVMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:30:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6774120870;
        Tue, 22 Jan 2019 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548160240;
        bh=/tdz5jx5P4MR0Ip7xP+VsFJc0N/i1Ftq5Gsfd0eawZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkkuiPEloXynq8kKCJZ2ZjdEHEPydhxiZhFKS8Fct1r1PO/jMahdD2o2bhQyYmh/C
         Zbmmo46qJiO2ZUG+lTsKxhCI940+EbF78ru6u1PcPQqmklDkMKff1gSfnDQVKL4bdt
         t5pqasijRbD35tg6kj8crVSR097xaln4XV3z3xTY=
Date:   Tue, 22 Jan 2019 13:30:38 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drivers/base: add sysfs entries for suppliers and
 consumers
Message-ID: <20190122123038.GB2736@kroah.com>
References: <1545311096-29321-1-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545311096-29321-1-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:05:11PM +0000, Ioana Ciornei wrote:
> Instead of scraping dmesg for messages such as 'Linked as a consumer to'
> or 'Dropping the link to' export two new sysfs entries in the device
> folder that contain a list of the consumer and supplier devices.

What is userspace going to do with that information?  Why does it care?

> 
> Also, lower the log level of the prints since the same information
> is available in the sysfs entries.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
>   - lower the log level of prints
> Changes in v2:
>   - add documentation entries for the new sysfs files
> 
>  Documentation/ABI/testing/sysfs-devices-links | 13 +++++++
>  drivers/base/core.c                           | 52 ++++++++++++++++++++++++---
>  2 files changed, 60 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-links
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-links b/Documentation/ABI/testing/sysfs-devices-links
> new file mode 100644
> index 0000000..d3951c5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-links
> @@ -0,0 +1,13 @@
> +What:		/sys/devices/.../consumers
> +Date:		December 2018
> +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> +Description:
> +		Read-only attribute that lists the current "consumers" of
> +		a specific device.
> +
> +What:		/sys/devices/.../suppliers
> +Date:		December 2018
> +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> +Description:
> +		Read-only attribute that lists the current "suppliers" of
> +		a specific device.
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a4ced33..5339bcf 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -301,7 +301,7 @@ struct device_link *device_link_add(struct device *consumer,
>  	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
>  	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
>  
> -	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
> +	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
>  
>   out:
>  	device_pm_unlock();
> @@ -327,8 +327,8 @@ static void __device_link_del(struct kref *kref)
>  {
>  	struct device_link *link = container_of(kref, struct device_link, kref);
>  
> -	dev_info(link->consumer, "Dropping the link to %s\n",
> -		 dev_name(link->supplier));
> +	dev_dbg(link->consumer, "Dropping the link to %s\n",
> +		dev_name(link->supplier));
>  
>  	if (link->flags & DL_FLAG_PM_RUNTIME)
>  		pm_runtime_drop_link(link->consumer);
> @@ -342,8 +342,8 @@ static void __device_link_del(struct kref *kref)
>  {
>  	struct device_link *link = container_of(kref, struct device_link, kref);
>  
> -	dev_info(link->consumer, "Dropping the link to %s\n",
> -		 dev_name(link->supplier));
> +	dev_dbg(link->consumer, "Dropping the link to %s\n",
> +		dev_name(link->supplier));
>  
>  	if (link->flags & DL_FLAG_PM_RUNTIME)
>  		pm_runtime_drop_link(link->consumer);
> @@ -1117,6 +1117,34 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(online);
>  
> +static ssize_t suppliers_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct device_link *link;
> +	size_t count = 0;
> +
> +	list_for_each_entry(link, &dev->links.suppliers, c_node)
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
> +				   dev_name(link->supplier));
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(suppliers);
> +
> +static ssize_t consumers_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct device_link *link;
> +	size_t count = 0;
> +
> +	list_for_each_entry(link, &dev->links.consumers, s_node)
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
> +				   dev_name(link->consumer));

sysfs is supposed to be one value per file, this violates that.  I don't
like that at all, now this file has to be parsed by userspace.

> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(consumers);

Turn these into an attribute group, so you can add them all at once?

And do you really need these for _EVERY_ device in the system?  That
feels like a lot of extra files for almost no users.


> +
>  int device_add_groups(struct device *dev, const struct attribute_group **groups)
>  {
>  	return sysfs_create_groups(&dev->kobj, groups);
> @@ -1288,8 +1316,20 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_groups;
>  	}
>  
> +	error = device_create_file(dev, &dev_attr_suppliers);
> +	if (error)
> +		goto err_remove_online;
> +
> +	error = device_create_file(dev, &dev_attr_consumers);
> +	if (error)
> +		goto err_remove_suppliers;

These should be added in device_add(), not burried down in
device_add_attrs, which is there to add the attributes that the
bus/class wants to have added to the device.

But I still don't know why this is needed, or who is going to use it, or
what they are going to be used for...

thanks,

greg k-h
