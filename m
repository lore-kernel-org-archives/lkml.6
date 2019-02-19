Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C18EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B1D21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBSHmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:42:46 -0500
Received: from olimex.com ([184.105.72.32]:39524 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfBSHmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:42:46 -0500
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:42:42 -0800
Subject: Re: [PATCH v2 1/8] leds: Add support for AXP20X CHGLED
To:     Pavel Machek <pavel@ucw.cz>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-2-stefan@olimex.com>
 <20190215155732.nmtshldcjk2qyhx4@flea> <20190215183239.GB3280@amd>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <5fdac512-947d-fd46-d953-22d6fc837423@olimex.com>
Date:   Tue, 19 Feb 2019 09:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215183239.GB3280@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/19 8:32 PM, Pavel Machek wrote:
> Hi!
>
>> On Fri, Feb 15, 2019 at 01:50:06PM +0200, Stefan Mavrodiev wrote:
>>> +static ssize_t control_store(struct device *dev, struct device_attribute *attr,
>>> +			     const char *buf, size_t size)
>>> +{
>>> +	struct led_classdev *cdev = dev_get_drvdata(dev);
>>> +	struct axp20x_led *priv = to_axp20x_led(cdev);
>>> +	unsigned long val;
>>> +	int ret;
>>> +
>>> +	ret = kstrtoul(buf, 0, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/**
>>> +	 * Supported values are:
>>> +	 *   - 0 : Manual control
>>> +	 *   - 1 : Charger control
>>> +	 */
> ...
>>> +static struct attribute *axp20x_led_attrs[] = {
>>> +	&dev_attr_control.attr,
>>> +	&dev_attr_mode.attr,
>>> +	NULL,
>>> +};
>>> +ATTRIBUTE_GROUPS(axp20x_led);
>> I can't really say whether adding sysfs handles for this is the right
>> thing to do, but if it is you should document the interface.
> It is not. See "Add Intel Cherry Trail Whiskey Cove PMIC LEDs" thread
> in the last few days.

What I understood is that there will be changes in the LED core, exporting
a new sysfs entry "hw_control". Then I should set HW_CONTROL flag for the
device and add hw_control_get/set callback functions. And this can happen
when the LED core is updated. Right?

However I didn't understand how (in my case) hardware controlled pattern
will be selected?

Best regards,
Stefan Mavrodiev

>>> +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
>>> +		priv->ctrl = AXP20X_CHGLED_CTRL_CHARGER;
>>> +		priv->mode = (value < 2) ? value : 0;
>>> +	} else {
>>> +		priv->ctrl = AXP20X_CHGLED_CTRL_MANUAL;
>>> +	}
>> I'm not sure we want to make this a property of the device
>> tree. Changing the device tree isn't an option for some users, so we
>> need to make sure we can change it even if we can't change the device
>> tree.
> We want this to be configurable at run time. It can get default from
> the device tree.
>
> If we go for the "hardware" trigger, you'll get it for free.
>
> Best regards,
> 								Pavel
