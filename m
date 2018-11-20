Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947F42089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XzWwrijk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947F42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeKTK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:59:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43724 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeKTK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:59:03 -0500
Received: from [IPv6:2001:569:7bf7:d700:9172:ba9:c5c:760f] (node-1w7jr9qt31lmgamnl1tq70h73.ipv6.telus.net [IPv6:2001:569:7bf7:d700:9172:ba9:c5c:760f])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D3BCDF;
        Tue, 20 Nov 2018 01:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542673961;
        bh=Jucn3w5tybQLmzScKPfPPbopbaNHBUkDYhGgynChe0o=;
        h=From:Subject:Reply-To:To:Cc:References:Date:In-Reply-To:From;
        b=XzWwrijk0U8c7AsFFqsg0FJJjiVrpnUWW201ielJwo6Owt++rzqh8FdiT0ORxBP0d
         xgXfm13FtQBuyuYGgMeF/WQITd4FbqMeDMN8qBELjMWslRPwt0KKNCzYa1CTRW5LtX
         Ho1GG3VaRbKwMy6jzNexL1HvD5WPi3OkFx8Rsr2g=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v4 3/4] media: i2c: Add MAX9286 driver
Reply-To: kieran.bingham@ideasonboard.com
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, sakari.ailus@iki.fi
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
References: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
 <20181102154723.23662-4-kieran.bingham@ideasonboard.com>
 <5238fa80-7678-97a8-47ee-6a26970d862d@lucaceresoli.net>
 <07ee8a2c-81a8-ca32-96cf-67d6a883e3f5@ideasonboard.com>
 <e6143de9-f253-1a89-21e0-d1e2c0444e7b@lucaceresoli.net>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <417f5bc8-533d-2c2f-2325-3e728d53329b@ideasonboard.com>
Date:   Mon, 19 Nov 2018 16:32:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e6143de9-f253-1a89-21e0-d1e2c0444e7b@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

My apologies for my travel induced delay in responding here,



On 14/11/2018 02:04, Luca Ceresoli wrote:
> Hi Kieran,
> 
> On 14/11/18 01:46, Kieran Bingham wrote:
>> Hi Luca,
>>
>> Thank you for your review,
>>
>> On 13/11/2018 14:49, Luca Ceresoli wrote:
>>> Hi Kieran, All,
>>>
>>> below a few minor questions, and a big one at the bottom.
>>>
>>> On 02/11/18 16:47, Kieran Bingham wrote:
>>>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>>
>>>> The MAX9286 is a 4-channel GMSL deserializer with coax or STP input and
>>>> CSI-2 output. The device supports multicamera streaming applications,
>>>> and features the ability to synchronise the attached cameras.
>>>>
>>>> CSI-2 output can be configured with 1 to 4 lanes, and a control channel
>>>> is supported over I2C, which implements an I2C mux to facilitate
>>>> communications with connected cameras across the reverse control
>>>> channel.
>>>>
>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>>
>>> [...]
>>>
>>>> +struct max9286_device {
>>>> +	struct i2c_client *client;
>>>> +	struct v4l2_subdev sd;
>>>> +	struct media_pad pads[MAX9286_N_PADS];
>>>> +	struct regulator *regulator;
>>>> +	bool poc_enabled;
>>>> +	int streaming;
>>>> +
>>>> +	struct i2c_mux_core *mux;
>>>> +	unsigned int mux_channel;
>>>> +
>>>> +	struct v4l2_ctrl_handler ctrls;
>>>> +
>>>> +	struct v4l2_mbus_framefmt fmt[MAX9286_N_SINKS];
>>>
>>> 5 pads, 4 formats. Why does the source node have no fmt?
>>
>> The source pad is a CSI2 link - so a 'frame format' would be inappropriate.
> 
> Ok, thanks for the clarification.
> 
>>>> +static int max9286_probe(struct i2c_client *client,
>>>> +			 const struct i2c_device_id *did)
>>>> +{
>>>> +	struct max9286_device *dev;
>>>> +	unsigned int i;
>>>> +	int ret;
>>>> +
>>>> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>> +	if (!dev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev->client = client;
>>>> +	i2c_set_clientdata(client, dev);
>>>> +
>>>> +	for (i = 0; i < MAX9286_N_SINKS; i++)
>>>> +		max9286_init_format(&dev->fmt[i]);
>>>> +
>>>> +	ret = max9286_parse_dt(dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	dev->regulator = regulator_get(&client->dev, "poc");
>>>> +	if (IS_ERR(dev->regulator)) {
>>>> +		if (PTR_ERR(dev->regulator) != -EPROBE_DEFER)
>>>> +			dev_err(&client->dev,
>>>> +				"Unable to get PoC regulator (%ld)\n",
>>>> +				PTR_ERR(dev->regulator));
>>>> +		ret = PTR_ERR(dev->regulator);
>>>> +		goto err_free;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * We can have multiple MAX9286 instances on the same physical I2C
>>>> +	 * bus, and I2C children behind ports of separate MAX9286 instances
>>>> +	 * having the same I2C address. As the MAX9286 starts by default with
>>>> +	 * all ports enabled, we need to disable all ports on all MAX9286
>>>> +	 * instances before proceeding to further initialize the devices and
>>>> +	 * instantiate children.
>>>> +	 *
>>>> +	 * Start by just disabling all channels on the current device. Then,
>>>> +	 * if all other MAX9286 on the parent bus have been probed, proceed
>>>> +	 * to initialize them all, including the current one.
>>>> +	 */
>>>> +	max9286_i2c_mux_close(dev);
>>>> +
>>>> +	/*
>>>> +	 * The MAX9286 initialises with auto-acknowledge enabled by default.
>>>> +	 * This means that if multiple MAX9286 devices are connected to an I2C
>>>> +	 * bus, another MAX9286 could ack I2C transfers meant for a device on
>>>> +	 * the other side of the GMSL links for this MAX9286 (such as a
>>>> +	 * MAX9271). To prevent that disable auto-acknowledge early on; it
>>>> +	 * will be enabled later as needed.
>>>> +	 */
>>>> +	max9286_configure_i2c(dev, false);
>>>> +
>>>> +	ret = device_for_each_child(client->dev.parent, &client->dev,
>>>> +				    max9286_is_bound);
>>>> +	if (ret)
>>>> +		return 0;
>>>> +
>>>> +	dev_dbg(&client->dev,
>>>> +		"All max9286 probed: start initialization sequence\n");
>>>> +	ret = device_for_each_child(client->dev.parent, NULL,
>>>> +				    max9286_init);
>>>
>>> I can't manage to like this initialization sequence, sorry. If at all
>>> possible, each max9286 should initialize itself independently from each
>>> other, like any normal driver.
>>
>> Yes, I think we're in agreement here, but unfortunately this section is
>> a workaround for the fact that our devices share a common address space.
>>
>> We (currently) *must* disable both devices before we start the
>> initialisation process for either on our platform currently...
> 
> The model I proposed in my review to patch 1/4 (split remote physical
> address from local address pool) allows to avoid this workaround.


Having just talked this through with Jacopo I think I see that we have
two topics getting intertwined here too.

 - Address translation so that we can separate the camera addressing

 - our 'device_is_bound/device_for_each_child()' workaround which lets
   us make sure the buses are closed before we power on any camera
   device.


For the upstream process of this driver - I will remove the
'device_is_bound()/device_for_each_child()' workarounds.


It is /ugly/ and needs more consideration, but I believe we do still
need it (or something similar) for our platform currently.



The other side of that is the address translation. I think I was wrong
earlier and may have said we have address translation on both sides.


I think I now see that we only have some minimal translation for two
addresses on the remote (max9271) side, not the local (max9286) side.

We have the ability to reprogram addresses through, and that's what we
are using.


There's a lot more local discussion going on here that I may have missed
so I hope Jacopo, Niklas, or Laurent may add more here if relevant :)




>> That said - I think this section needs to be removed from the upstream
>> part at least for now. I think we should probably carry this
>> 'workaround' separately.
>>
>> This part is the core issue that I talked about in my presentation at
>> ALS-Japan [0]
>>
>>  [0] https://sched.co/EaXa
> 
> Oh, interesting, I hadn't noticed that you gave this talk -- at the same
> conference as Vladimir's talk! No video recording apparently, but are
> slides available at least?

Hrm ... I was sure I uploaded to the conference so that they should have
been available on that URL - but they are not showing.

They are available here:

	https://www.slideshare.net/KieranBingham/gmsl-in-linux

(Please excuse the incorrect date on the first slide :D)

I had put a proposal in to give this talk again at ELCE but
unfortunately it didn't get accepted.

Seems it really would have been useful to have a slot. Lets hope next
ELCE is too late and we work out a good system by then :)


>>> First, it requires that each chip on the remote side can configure its
>>> own slave address. Not all chips do.
>>>
>>> Second, using a static i2c address map does not scale well and limits
>>> hotplugging, as I discussed in my reply to patch 1/4. The problem should
>>> be solvable cleanly if the MAX9286 supports address translation like the
>>> TI chips.
>>
>> I don't think we can treat GMSL as hot-pluggable currently ... But as we
>> discussed - I see that we should think about this for FPD-Link
> 
> I've been mixing hotplug and DT overlays and that generated confusion,
> sorry. My point exists even with no hotplug, see the reply to patch 1/4.


Ok - I understand how you were using the terminology / analogy's now.
Lets move back to patch 1/4 :)


-- 
Regards
--
Kieran


