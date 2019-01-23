Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C9C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226DC20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWAtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:49:21 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:50804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726678AbfAWAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:49:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 24C44180A8458;
        Wed, 23 Jan 2019 00:49:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pig12_515ffb1bfdc30
X-Filterd-Recvd-Size: 4746
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Jan 2019 00:49:19 +0000 (UTC)
Message-ID: <f6616b8d1983286a9df8e0b62849558487da3847.camel@perches.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
From:   Joe Perches <joe@perches.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     ogabbay@habana.ai
Date:   Tue, 22 Jan 2019 16:49:17 -0800
In-Reply-To: <20190123000057.31477-2-oded.gabbay@gmail.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
         <20190123000057.31477-2-oded.gabbay@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-23 at 02:00 +0200, Oded Gabbay wrote:
> This patch adds the habanalabs skeleton driver. The driver does nothing at
> this stage except very basic operations. It contains the minimal code to
> insmod and rmmod the driver and to create a /dev/hlX file per PCI device.

trivial notes:

> 
> diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
[]
> \ No newline at end of file

You should fixes these.  There are a least a couple of them.

> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
[]
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + */

Add #define pr_fmt(fmt) "habanalabs: " fmt

> +
> +#include "habanalabs.h"

or add it in this file


> +static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
> +				int minor, const struct file_operations *fops)
> +{
> +	int err, devno = MKDEV(hdev->major, minor);
> +	struct cdev *hdev_cdev = &hdev->cdev;
> +	char name[8];
> +
> +	sprintf(name, "hl%d", hdev->id);

Might overflow name one day

> +
> +	cdev_init(hdev_cdev, fops);
> +	hdev_cdev->owner = THIS_MODULE;
> +	err = cdev_add(hdev_cdev, devno, 1);
> +	if (err) {
> +		pr_err("habanalabs: Failed to add char device %s", name);

So #define pr_fmt can auto prefix these and this would be

		pr_err("Failed to add char device %s\n", name);

missing terminating '\n' btw

> +		goto err_cdev_add;
> +	}
> +
> +	hdev->dev = device_create(hclass, NULL, devno, NULL, "%s", name);
> +	if (IS_ERR(hdev->dev)) {
> +		pr_err("habanalabs: Failed to create device %s\n", name);

And this would be:
		pr_err("Failed to create device %s\n", name);


etc...

> +static int device_early_init(struct hl_device *hdev)
> +{
> +	switch (hdev->asic_type) {
> +	case ASIC_GOYA:
> +		sprintf(hdev->asic_name, "GOYA");

strcpy or perhaps better still as strlcpy

> +int hl_device_init(struct hl_device *hdev, struct class *hclass)
> +{
[]
> +	dev_notice(hdev->dev,
> +		"Successfully added device to habanalabs driver\n");

This is mostly aligned to open parenthesis, but perhaps
it could check with scripts/checkpatch.pl --strict and
see if you agree with anything it bleats.

> +int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr,
> +				u32 timeout_us, u32 *val)
> +{
> +	/*
> +	 * pReturnVal is defined as volatile because it points to HOST memory,
> +	 * which is being written to by the device. Therefore, we can't use
> +	 * locks to synchronize it and it is not a memory-mapped register space
> +	 */
> +	volatile u32 *pReturnVal = (volatile u32 *) addr;

It'd be nice to avoid hungarian and camelcase

> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
> +
> +	might_sleep();
> +
> +	for (;;) {
> +		*val = *pReturnVal;
> +		if (*val)
> +			break;
> +		if (ktime_compare(ktime_get(), timeout) > 0) {
> +			*val = *pReturnVal;
> +			break;
> +		}
> +		usleep_range((100 >> 2) + 1, 100);
> +	}
> +
> +	return (*val ? 0 : -ETIMEDOUT);

Unnecessary parentheses

> diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
[]
> +static struct pci_device_id ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
> +	{ 0, }
> +};

static const?

> diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
[]
> +struct hl_bd {
> +	__u64	ptr;
> +	__u32	len;
> +	union {
> +		struct {
> +			__u32	repeat:16;
> +			__u32	res1:8;
> +			__u32	repeat_valid:1;
> +			__u32	res2:7;
> +		};
> +		__u32	ctl;
> +	};
> +};

Maybe use the appropriate bit-endian __le<size> instead of __u<size>
with whatever cpu_to_le<size> / le<size>_to_cpu bits are necessary.


