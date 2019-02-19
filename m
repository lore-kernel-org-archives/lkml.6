Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1724C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8382146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfBSNYx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:24:53 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:36778 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfBSNYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:24:53 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id A0CD81630C; Tue, 19 Feb 2019 13:24:51 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: skip interfaces disabled in devicetree
References: <20190216170452.10884-1-mans@mansr.com>
        <20190219131149.GA20719@kroah.com>
Date:   Tue, 19 Feb 2019 13:24:51 +0000
In-Reply-To: <20190219131149.GA20719@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 19 Feb 2019 14:11:49 +0100")
Message-ID: <yw1xftsjykpo.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sat, Feb 16, 2019 at 05:04:52PM +0000, Mans Rullgard wrote:
>> If an interface has an associated devicetree node with status disabled,
>> do not register the device.  This is useful for boards with a built-in
>> multifunction USB device where some functions are broken or otherwise
>> undesired.
>> 
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/usb/core/message.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
>> index bfa5eda0cc26..6b45d4835e41 100644
>> --- a/drivers/usb/core/message.c
>> +++ b/drivers/usb/core/message.c
>> @@ -2007,6 +2007,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>>  	for (i = 0; i < nintf; ++i) {
>>  		struct usb_interface *intf = cp->interface[i];
>>  
>> +		if (intf->dev.of_node &&
>> +		    !of_device_is_available(intf->dev.of_node))
>> +			continue;
>
> Shouldn't you at least print some message out saying you are skipping
> this?  Odds are this is going to cause regressions in devices that were
> not expecting this, right?  So pointing them at why their devices now no
> longer work would be good :)

They will only be skipped if there is a device tree node for the
interface _and_ it has and explicit status = "disabled" property.
The default is still to create devices for all interfaces.

That said, printing a message is probably a good idea anyway.  Would
"info" level be appropriate for this?

-- 
Måns Rullgård
