Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474E9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwZAg6KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474E9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeK0Svf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbeK0Sve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:51:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB77E20873;
        Tue, 27 Nov 2018 07:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543305273;
        bh=ffHr4xFhwTXXSL2MeJ2XeiPCWnQFnEqI3BzFc9gIAZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwZAg6KZ9de9X+D7gFTYYg0yjcX5d9e6FDT/wojVRXFkROrvQp+4kWlLGYkQagGWt
         TX9Z0kAvDb3rWYVCMZj///ir+8Z3KirzmMGAQqLjmoiUjaPhD4fHIPgIxu2InIvXIZ
         8hZ/6q/iNre34XagYpu2JW8IXcCGpmCVQa+30/ww=
Date:   Tue, 27 Nov 2018 08:54:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v4 1/7] fieldbus_dev: add Fieldbus Device
 subsystem.
Message-ID: <20181127075431.GG13965@kroah.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121150709.6030-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:07:03AM -0500, thesven73@gmail.com wrote:
> +static struct attribute *fieldbus_attrs[] = {
> +	&dev_attr_enabled.attr,
> +	&dev_attr_card_name.attr,
> +	&dev_attr_fieldbus_id.attr,
> +	&dev_attr_read_area_size.attr,
> +	&dev_attr_write_area_size.attr,
> +	&dev_attr_online.attr,
> +	&dev_attr_fieldbus_type.attr,
> +	NULL,
> +};
> +
> +static umode_t fieldbus_is_visible(struct kobject *kobj, struct attribute *attr,
> +				int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct fieldbus_dev *fb = dev_get_drvdata(dev);
> +	umode_t mode = attr->mode;
> +
> +	if (attr == &dev_attr_enabled.attr) {
> +		mode = 0;
> +		if (fb->enable_get)
> +			mode |= 0444;
> +		if (fb->simple_enable_set)
> +			mode |= 0200;
> +	}
> +
> +	return mode;
> +}
> +
> +static const struct attribute_group fieldbus_group = {
> +	.attrs = fieldbus_attrs,
> +	.is_visible = fieldbus_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(fieldbus);

Why not just use ATTRIBUTE_GROUPS()?

> +static int __fieldbus_dev_register(struct fieldbus_dev *fb)
> +{
> +	dev_t devno;
> +	int err;
> +
> +	if (!fb)
> +		return -EINVAL;
> +	if (!fb->read_area || !fb->write_area || !fb->fieldbus_id_get)
> +		return -EINVAL;
> +	fb->id = ida_simple_get(&fieldbus_ida, 0, MAX_FIELDBUSES, GFP_KERNEL);
> +	if (fb->id < 0)
> +		return fb->id;
> +	devno = MKDEV(MAJOR(fieldbus_devt), fb->id);
> +	init_waitqueue_head(&fb->dc_wq);
> +	cdev_init(&fb->cdev, &fieldbus_fops);
> +	err = cdev_add(&fb->cdev, devno, 1);
> +	if (err) {
> +		pr_err("fieldbus_dev%d unable to add device %d:%d\n",
> +			fb->id, MAJOR(fieldbus_devt), fb->id);
> +		goto err_cdev;
> +	}

Why do you have a static cdev?

> +	fb->dev = device_create(&fieldbus_class, fb->parent, devno, fb,
> +				"fieldbus_dev%d", fb->id);
> +	if (IS_ERR(fb->dev)) {
> +		err = PTR_ERR(fb->dev);
> +		goto err_dev_create;
> +	}
> +	fb->online_sd = sysfs_get_dirent(fb->dev->kobj.sd, "online");

Ick, what?  Why?  Why are you messing around with a raw sysfs attribute?

Also, you are creating sysfs files and you are not documenting any of
them in Documentation/ABI/ which is not allowed.  Please add that to
this patch for the next round.

thanks,

greg k-h
