Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC50C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4145420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeIZHP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:15:56 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47672 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIZHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:15:56 -0400
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g4yGq-0006Xv-9L from Steve_Longerbeam@mentor.com ; Tue, 25 Sep 2018 18:05:40 -0700
Received: from [172.30.1.115] (147.34.91.1) by svr-orw-mbx-02.mgc.mentorg.com
 (147.34.90.202) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 25 Sep
 2018 18:05:37 -0700
Subject: Re: [PATCH v6 02/17] media: v4l2: async: Allow searching for asd of
 any type
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Steve Longerbeam <slongerbeam@gmail.com>,
        <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sebastian Reichel <sre@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-3-git-send-email-steve_longerbeam@mentor.com>
 <20180924140604.23e2b56f@coco.lan>
 <a8ea673c-a519-81e8-35b1-9d4a224dcbf5@mentor.com>
 <20180925192045.59c83e3d@coco.lan>
From:   Steve Longerbeam <steve_longerbeam@mentor.com>
Message-ID: <36fd43b2-695d-b990-bec2-c4d88ccb8e88@mentor.com>
Date:   Tue, 25 Sep 2018 18:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925192045.59c83e3d@coco.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/25/2018 03:20 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 25 Sep 2018 14:04:21 -0700
> Steve Longerbeam <steve_longerbeam@mentor.com> escreveu:
>
>>>   
>>>> @@ -392,12 +406,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>>>>    		case V4L2_ASYNC_MATCH_CUSTOM:
>>>>    		case V4L2_ASYNC_MATCH_DEVNAME:
>>>>    		case V4L2_ASYNC_MATCH_I2C:
>>>> -			break;
>>>>    		case V4L2_ASYNC_MATCH_FWNODE:
>>>> -			if (v4l2_async_notifier_fwnode_has_async_subdev(
>>>> -				    notifier, asd->match.fwnode, i)) {
>>>> +			if (v4l2_async_notifier_has_async_subdev(
>>>> +				    notifier, asd, i)) {
>>>>    				dev_err(dev,
>>>> -					"fwnode has already been registered or in notifier's subdev list\n");
>>>> +					"asd has already been registered or in notifier's subdev list\n");
>>> Please, never use "asd" on messages printed to the user. While someone
>>> may understand it while reading the source code, for a poor use,
>>> "asd" is just a random sequence of 3 characters.
>> I will change the message to read:
>>
>> "subdev descriptor already listed in this or other notifiers".
> Perfect!

But the error message is removed in the subsequent patch
"[PATCH 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev".

I could bring it back as a dev_dbg() in v4l2_async_notifier_asd_valid(), but
this shouldn't be a dev_err() anymore since it is up to the media platform
to decide whether an already existing subdev descriptor is an error.

Steve


