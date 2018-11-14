Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC86C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEC3223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEC3223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeKNRxZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:53:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60764 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:53:25 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6EC98CEEAF;
        Wed, 14 Nov 2018 08:58:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181113170128.0f59ef0e@kemnade.info>
Date:   Wed, 14 Nov 2018 08:51:17 +0100
Cc:     Rob Herring <robh@kernel.org>, sebastian.reichel@collabora.com,
        hns@goldelico.com, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: 8BIT
Message-Id: <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
 <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux>
 <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
 <20181112222726.73m2oca7hankvcjs@earth.universe>
 <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
 <20181113170128.0f59ef0e@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

>>>>> Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.info>:
>>>>> On Sun, 11 Nov 2018 03:46:48 +0100
>>>>> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:  
>>>>>> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:  
>>>>>>> This is a first try to be able to use h4 devices specified in
>>>>>>> the devicetree, so you do not need to call hciattach and
>>>>>>> it can be automatically probed.
>>>>>>> 
>>>>>>> Of course, proper devicetree bindings documentation is
>>>>>>> missing. And also you would extend that by regulator/
>>>>>>> enable gpio settings.
>>>>>>> 
>>>>>>> But before proceeding further it should be checked if the
>>>>>>> general way of doing things is right.
>>>>>>> 
>>>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>>>> ---  
>>>>>> 
>>>>>> Patch looks good to me, just one note
>>>>>> 
>>>>> I found one thing myself:
>>>>> Shouldn't we have a generic compatible string like "generic-h4".
>>>>> ehci-platform.c has for example:
>>>>>       { .compatible = "generic-ehci", },  
>>>> 
>>>> There might be differences in h4 compatible devices (e.g. default
>>>> baud rate) so that I would not bet there a "generic-h4" suffices
>>>> in the long run.  
>> 
>> It will not because that doesn't define clocks, resets, gpios,
>> supplies, etc. and the interactions of all those.
>> 
> well, we need a simple supply being on when the device is on.
> Nothing more.
> 
>>> My suggestion is to use this in DT:
>>> 
>>> compatible = "wi2wi,w2cbw003-bluetooth", "<something generic>";
>>> 
> That would be my slight preference here.
> 
>>> The driver can start with supporting just the generic compatible
>>> string. If somebody finds some incompatible differences, the driver
>>> can add a custom handler for the wi2wi chip without breaking DT
>>> ABI.  
>> 
>> Any idea how many H4 devices there are? Somehow I doubt there are that
>> many to be unmanageable.
>> 
> Well, many devices are h4 devices with some more or less important
> vendor-specific commands. Well, "hciattach any" uses simple h4 protocol.
> 
> those firmware download commands and they have their own drivers.
> Most devices I had used bluetooth uart from the command line with, were
> simple enough. The other question is whether those devices will run a
> modern kernel.
> 
> No strong opinion here. 

doing the firmware load from user space via some magic tool is no longer going to work smoothly. It will be actually almost impossible with serdev. However I did post btuart.c driver which is pretty much just plain H:4. You would still somehow define the default baudraute since just picking 115200 is not always going to work.

Btw. I see nothing standing in the way of merging btuart.c driver and then go from there. Either I dig this out and submit or someone else does.

Regards

Marcel

