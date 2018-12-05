Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53765C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B444213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHLkfnQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B444213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeLEKRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeLEKRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:17:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9336920659;
        Wed,  5 Dec 2018 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544005022;
        bh=rP+OpeHCUahFgYKl2Eey7epdZBodjVeeH/3leWGOIxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHLkfnQaPKTqWllMjj36F6zRRWcC8VDnBzC1h85uxV0lpcfpaE3Qw1cdYwTMYAsVz
         brxK3c94PgVx9rdo3XdqDZuVyTgrFd8FBuTObAgpqdN2UHjFVa1eohl7k85WxOAxc1
         SRtZ9GjlXlF1eFuTgBjjXqmDH+O1FL/DY15XkdaI=
Date:   Wed, 5 Dec 2018 11:16:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20181205101659.GA27058@kroah.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204220224.27324-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:02:19PM -0500, Sven Van Asbroeck wrote:
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-fieldbus-dev
> @@ -0,0 +1,63 @@
> +What:		/sys/class/fieldbus_dev/fieldbus_devX/card_name

Here's a good example of your naming being a bit too "verbose" :)

There is no need to name your devices with the same prefix as your
class.  Just make it:
	/sys/class/fieldbus/XXX/card_name

And why is this a class and not just a "normal" device and bus?  Devices
live on busses, not generally as a class.  Can your devices live on
different types of busses (USB, PCI, etc.)?

But, if you really just want to leave this as a "class", then just call
it "fieldbus" and make it simple.  You are only exposing the
"fieldbus-specific" type of attributes here, so that's probably good
enough for now.

> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -187,4 +187,5 @@ obj-$(CONFIG_TEE)		+= tee/
>  obj-$(CONFIG_MULTIPLEXER)	+= mux/
>  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
>  obj-$(CONFIG_SIOX)		+= siox/
> +obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus/
>  obj-$(CONFIG_GNSS)		+= gnss/

Why not after gnss?

> --- /dev/null
> +++ b/drivers/fieldbus/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for fieldbus_dev drivers.
> +#
> +
> +obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus_dev_core.o

Why not just "fieldbus.o"?

> +static ssize_t online_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct fieldbus_dev *fb = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",

Nit, sysfs attributes are always so small that you don't need to care
about the size of the buffer because you "always" know that you will not
overflow it.

So this can just be a simple:
	return sprintf(buf, "%s\n", ...);

> +		fb->online ? "online" : "offline");
> +}
> +static DEVICE_ATTR_RO(online);
> +
> +static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct fieldbus_dev *fb = dev_get_drvdata(dev);
> +
> +	if (!fb->enable_get)
> +		return -EINVAL;
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +		fb->enable_get(fb) ? ctrl_enabled : ctrl_disabled);
> +}

New line?

> +static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t n)
> +{
> +	struct fieldbus_dev *fb = dev_get_drvdata(dev);
> +	int err;
> +
> +	if (!fb->simple_enable_set) {
> +		n = -ENOTSUPP;
> +	} else if (sysfs_streq(buf, ctrl_enabled)) {

Why not just have the normal "0/1" type of parsing?  We have a function
for it already, kstrtobool().

thanks,

greg k-h
