Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4402081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfBVNXO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:23:14 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:35352 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfBVNXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:23:14 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 5D62515632; Fri, 22 Feb 2019 13:23:12 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3] platform: set of_node in platform_device_register_full()
References: <20190221112935.4538-1-mans@mansr.com>
        <CAJZ5v0h+nEQ8VyBUS5qc=UCX_mDdwioJPfmCT++mGsJyHqO0_Q@mail.gmail.com>
Date:   Fri, 22 Feb 2019 13:23:12 +0000
In-Reply-To: <CAJZ5v0h+nEQ8VyBUS5qc=UCX_mDdwioJPfmCT++mGsJyHqO0_Q@mail.gmail.com>
        (Rafael J. Wysocki's message of "Fri, 22 Feb 2019 10:16:33 +0100")
Message-ID: <yw1x5ztcvtxb.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Feb 21, 2019 at 12:29 PM Mans Rullgard <mans@mansr.com> wrote:
>>
>> If the provided fwnode is an OF node, set dev.of_node as well.
>>
>> Also add an of_node_reused flag to struct platform_device_info and copy
>> this to the new device.  This is needed to avoid pinctrl settings being
>> requested twice.  See 4e75e1d7dac9 ("driver core: add helper to reuse a
>> device-tree node") for a longer explanation.
>>
>> Some drivers are just shims that create extra "glue" devices with the
>> DT device as parent and have the real driver bind to these.  In these
>> cases, the glue device needs to get a reference to the original DT node
>> in order for the main driver to access properties and child nodes.
>>
>> For example, the sunxi-musb driver creates such a glue device using
>> platform_device_register_full().  Consequently, devices attached to
>> this USB interface don't get associated with DT nodes, if present,
>> the way they do with EHCI.
>>
>> This change will allow sunxi-musb and similar drivers to easily
>> propagate the DT node to child devices as required.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> Generally
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> but I'm a bit concerned about the existing users of
> platform_device_register_full() who may pass a valid DT fwnode to it
> and not expect of_node to be set.  Arguably, they should expect it to
> be set, but then there may be some fallout resulting from this change.

I did a quick search, and found three drivers using
platform_device_register_full() that pass an fwnode that isn't
explicitly an ACPI handle.

The Cadence MACB and pxa2xx-spi drivers both set fwnode in their PCI
glue.  Near as I can tell, setting of_node as a result should be
harmless.  If someone has a devicetree describing the PCI topology,
these drivers would start picking properties set there just as they do
when using a platform bus.  One could argue that this is the correct
behaviour.

The third case is Qcom HIDMA management driver.  It contains this code
fragment:

	for_each_available_child_of_node(np, child) {
		struct platform_device *new_pdev;

		/* irrelevant code */

		memset(&pdevinfo, 0, sizeof(pdevinfo));
		pdevinfo.fwnode = &child->fwnode;
		pdevinfo.parent = pdev_parent ? &pdev_parent->dev : NULL;
		pdevinfo.name = child->name;
		pdevinfo.id = object_counter++;
		pdevinfo.res = res;
		pdevinfo.num_res = 3;
		pdevinfo.data = NULL;
		pdevinfo.size_data = 0;
		pdevinfo.dma_mask = DMA_BIT_MASK(64);
		new_pdev = platform_device_register_full(&pdevinfo);
		if (IS_ERR(new_pdev)) {
			ret = PTR_ERR(new_pdev);
			goto out;
		}
		of_node_get(child);
		new_pdev->dev.of_node = child;
		of_dma_configure(&new_pdev->dev, child, true);
		/*
		 * It is assumed that calling of_msi_configure is safe on
		 * platforms with or without MSI support.
		 */
		of_msi_configure(&new_pdev->dev, child);
		of_node_put(child);
	}

This already looks rather weird.  It manually sets of_node of the new
device _after_ it has been added.  The reason this works at all is that
the matching driver hasn't been registered yet.  This, to me, is
slightly confusing, if not actually broken.  Worse is that the of_node
is copied without an of_node_get() to match the of_node_put() in
platform_device_put(), should it ever be called.  Moreover, these
devices are not removed if the module is unloaded or if there is an
error partway through the loop.

That said, it doesn't seem like setting of_node in
platform_device_register_full() should cause any (new) problems here.

-- 
Måns Rullgård
