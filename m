Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C7C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E60920853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E60920853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeINGKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:10:12 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:50580 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeINGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:10:11 -0400
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g0cQh-0001AL-B4 from Steve_Longerbeam@mentor.com ; Thu, 13 Sep 2018 17:57:51 -0700
Received: from [172.30.90.76] (147.34.91.1) by svr-orw-mbx-02.mgc.mentorg.com
 (147.34.90.202) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Sep
 2018 17:57:48 -0700
Subject: Re: [PATCH v6 06/17] media: v4l2-fwnode: Add a convenience function
 for registering subdevs with notifiers
To:     jacopo mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Steve Longerbeam <slongerbeam@gmail.com>,
        <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        open list <linux-kernel@vger.kernel.org>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-7-git-send-email-steve_longerbeam@mentor.com>
 <20180913103727.GB28160@w540>
 <20180913124425.h5vfjyr3b44j4nxv@paasikivi.fi.intel.com>
 <20180913125857.GC11509@w540>
From:   Steve Longerbeam <steve_longerbeam@mentor.com>
Message-ID: <eed4fef0-aecb-29c1-15d3-a7ab22364629@mentor.com>
Date:   Thu, 13 Sep 2018 17:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913125857.GC11509@w540>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,


On 09/13/2018 05:58 AM, jacopo mondi wrote:
> Hi Sakari,
>
> On Thu, Sep 13, 2018 at 03:44:25PM +0300, Sakari Ailus wrote:
>> Hi Jacopo,
>>
>> On Thu, Sep 13, 2018 at 12:37:27PM +0200, jacopo mondi wrote:
>>> Hi Steve,
>>>
>>> On Mon, Jul 09, 2018 at 03:39:06PM -0700, Steve Longerbeam wrote:
>>>> Adds v4l2_async_register_fwnode_subdev(), which is a convenience function
>>>> for parsing a sub-device's fwnode port endpoints for connected remote
>>>> sub-devices, registering a sub-device notifier, and then registering
>>>> the sub-device itself.
>>>>
>>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>>> ---
>>>> Changes since v5:
>>>> - add call to v4l2_async_notifier_init().
>>>> Changes since v4:
>>>> - none
>>>> Changes since v3:
>>>> - remove support for port sub-devices, such sub-devices will have to
>>>>    role their own.
>>>> Changes since v2:
>>>> - fix error-out path in v4l2_async_register_fwnode_subdev() that forgot
>>>>    to put device.
>>>> Changes since v1:
>>>> - add #include <media/v4l2-subdev.h> to v4l2-fwnode.h for
>>>>    'struct v4l2_subdev' declaration.
>>>> ---
>>>>   drivers/media/v4l2-core/v4l2-fwnode.c | 64 +++++++++++++++++++++++++++++++++++
>>>>   include/media/v4l2-fwnode.h           | 38 +++++++++++++++++++++
>>>>   2 files changed, 102 insertions(+)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
>>>> index 67ad333..94d867a 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
>>>> @@ -872,6 +872,70 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor_common);
>>>>
>>>> +int v4l2_async_register_fwnode_subdev(
>>> The meat of this function is to register a subdev with a notifier,
>>> so I would make it clear in the function name which is otherwise
>>> misleading

Yes, I struggled with how to name this function without making it
ridiculously long.

>>>
>>>> +	struct v4l2_subdev *sd, size_t asd_struct_size,
>>>> +	unsigned int *ports, unsigned int num_ports,
>>>> +	int (*parse_endpoint)(struct device *dev,
>>>> +			      struct v4l2_fwnode_endpoint *vep,
>>>> +			      struct v4l2_async_subdev *asd))
>>>> +{
>>>> +	struct v4l2_async_notifier *notifier;
>>>> +	struct device *dev = sd->dev;
>>>> +	struct fwnode_handle *fwnode;
>>>> +	int ret;
>>>> +
>>>> +	if (WARN_ON(!dev))
>>>> +		return -ENODEV;
>>>> +
>>>> +	fwnode = dev_fwnode(dev);
>>>> +	if (!fwnode_device_is_available(fwnode))
>>>> +		return -ENODEV;
>>>> +
>>>> +	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
>>>> +	if (!notifier)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	v4l2_async_notifier_init(notifier);
>>>> +
>>>> +	if (!ports) {
>>>> +		ret = v4l2_async_notifier_parse_fwnode_endpoints(
>>>> +			dev, notifier, asd_struct_size, parse_endpoint);
>>>> +		if (ret < 0)
>>>> +			goto out_cleanup;
>>>> +	} else {
>>>> +		unsigned int i;
>>>> +
>>>> +		for (i = 0; i < num_ports; i++) {
>>> It's not particularly exciting to iterate on pointers received from
>>> callers without checking for num_ports first.
>> The loop is not executed if num_ports is zero, so I don't see a problem
>> with that.
>>
> I know this is internal drivers API and failures are meant to be
> catched early in development, but what if the actual number of ports
> identifiers is < then the num_ports parameter?

see below.

>
>>> Also the caller has to allocate an array of "ports" and keep track of it
>>> just to pass it to this function

I agree that it is cumbersome to require callers to allocate a ports
array. Perhaps the ports array and num_ports could be replaced by a
u64 bit mask, but that would limit port ID's to 0 - 63.


Steve


>>>   and I don't see a way to set the
>>> notifier's ops before the notifier gets registered here below.
>> True; this can be seen as an omission but quite a few drivers have no need
>> for this either. It could be added later on --- I think it'd make perfect
>> sense.
>>
> In a 'notifier configuration' structure that gather these and existing
> function parameters together as you suggested...
>
>>>> +			ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
>>>> +				dev, notifier, asd_struct_size,
>>>> +				ports[i], parse_endpoint);
>>>> +			if (ret < 0)
>>>> +				goto out_cleanup;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ret = v4l2_async_subdev_notifier_register(sd, notifier);
>>>> +	if (ret < 0)
>>>> +		goto out_cleanup;
>>>> +
>>>> +	ret = v4l2_async_register_subdev(sd);
>>>> +	if (ret < 0)
>>>> +		goto out_unregister;
>>>> +
>>>> +	sd->subdev_notifier = notifier;
>>> This is set already by v4l2_async_subdev_notifier_register()
>> The same pattern is actually present in
>> v4l2_async_register_subdev_sensor_common(). It's used in unregistration
>> that can only happen after the registration, i.e. this function, has
>> completed.
>>
>>> In general, I have doubts this function is really needed. It requires
>>> the caller to reserve memory just to pass down a list of intergers,
>>> and there is no way to set subdev ops.
>>>
>>> Could you have a look at how drivers/media/platform/rcar-vin/rcar-csi2.c
>>> registers a subdevice and an associated notifier and see if in your
>>> opinion it can be implemented in the same way in your imx csi/csi2 driver,
>>> or you still like this one most?
>> I was actually thinking of changing this later on a bit. I came to think of
>> this after picking up the patchset to my tree... oh well.
>>
>> This function is meant for cases where you have multiple ports. That's not
>> working very nicely at the moment, and even with my patches, you can't pass
>> default configuration to e.g. v4l2_async_notifier_parse_fwnode_endpoints().
>> So there's definitely work to do. I'd like to move the details of parsing
>> out of drivers; every driver is doing almost the same but just in a little
>> bit different way.
>>
> I see...
>
>> The arguments should to be put into a struct. That way we get rid of a very
>> long series of hard-to-read function arguments, as well as we don't need to
>> change every caller when the function gets something new and interesting to
>> do.
>>
>> Right now the entire patchset is so big (40 patches) that I'd prefer to get
>> it in unless serious issues are found, and proceed the development on top.
>>
> Sure, please go ahead and thanks for the reply.
>
> Cheers
>     j
>
>> --
>> Kind regards,
>>
>> Sakari Ailus
>> sakari.ailus@linux.intel.com

