Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59821582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC59821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI0QmL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:42:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42161 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeI0QmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:42:11 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2E8D7CF16A;
        Thu, 27 Sep 2018 12:31:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address() and
 fwnode_get_bd_address()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180926113625.GM11965@kuha.fi.intel.com>
Date:   Thu, 27 Sep 2018 12:24:33 +0200
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DCD95AC8-D216-4CCE-B305-605A25B6B23A@holtmann.org>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
 <20180926113625.GM11965@kuha.fi.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

>> +/**
>> + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
>> + *                         firmware node
>> + * @fwnode:	Pointer to the firmware node
>> + * @bd_addr:	Pointer to struct to store the BD address in
>> + *
>> + * Search the firmware node for 'local-bd-address'.
>> + *
>> + * All-zero BD addresses are rejected, because those could be properties
>> + * that exist in the firmware tables, but were not updated by the firmware. For
>> + * example, the DTS could define 'local-bd-address', with zero BD addresses.
>> + */
>> +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr)
>> +{
>> +	bdaddr_t ba;
>> +	int ret;
>> +
>> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
>> +					    (u8 *)&ba, sizeof(bdaddr_t));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (is_zero_ether_addr((u8 *)&ba))
>> +		return -ENODATA;
>> +
>> +	memcpy(bd_addr, &ba, sizeof(bdaddr_t));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(fwnode_get_bd_address);
>> +
>> +/**
>> + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
>> + *                         given device
>> + * @dev:	Pointer to the device
>> + * @bd_addr:	Pointer to struct to store the BD address in
>> + */
>> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
>> +{
>> +	return fwnode_get_bd_address(dev_fwnode(dev), bd_addr);
>> +}
>> +EXPORT_SYMBOL_GPL(device_get_bd_address);
> 
> Let's not fill property.c with framework specific helper functions any
> more!
> 
> Those functions are completely bluetooth specific, so they do not
> belong here. The fact that some other framework already managed to
> slip their helpers in does not justify others to do the same.

so? The firmware guys decided to put MAC addresses and BD addresses into the firmware. So you have to deal with that.

Moving this into the Bluetooth subsystem is as pointless. I rather keep the accessor function to firmware specific data in one place and not spread around the whole tree. Especially once this is also provided via ACPI or some other means. I assumed that is what the whole device_get part was suppose to abstract.

Regards

Marcel

