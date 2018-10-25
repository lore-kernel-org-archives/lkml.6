Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26C7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1E420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeJYPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:42:03 -0400
Received: from blingelement.com ([204.11.58.44]:51931 "EHLO
        linux-outbound-1.webhostbox.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbeJYPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:42:03 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 11:42:02 EDT
Received: from bh-25.webhostbox.net (unknown [172.16.210.78])
        by linux-outbound-1.webhostbox.net (Postfix) with ESMTP id 45F15241501;
        Thu, 25 Oct 2018 05:08:45 +0000 (GMT)
Received: from [127.0.0.1] (port=54726 helo=bh-25.webhostbox.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <linux@roeck-us.net>)
        id 1gFZYJ-00CNvK-9O; Thu, 25 Oct 2018 06:55:35 +0000
Received: from 81.145.148.99 ([81.145.148.99]) by cp2.active-venture.com
 (Horde Framework) with HTTP; Thu, 25 Oct 2018 06:55:31 +0000
Date:   Thu, 25 Oct 2018 06:55:31 +0000
Message-ID: <20181025065531.Horde.JhVAJU3eOlwYcSJ57tV4I5-@cp2.active-venture.com>
From:   linux@roeck-us.net
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] hwmon: (core) Inherit power properties to hdev
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
 <20181024193402.16698-2-nicoleotsuka@gmail.com>
 <20181025001301.Horde.VCevVrrSs6rOyXT41xiPOzW@cp2.active-venture.com>
 <20181025010116.GA4543@Asurada-Nvidia.nvidia.com>
 <20181025013349.GA7569@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20181025013349.GA7569@Asurada-Nvidia.nvidia.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Nicolin Chen <nicoleotsuka@gmail.com>:

> On Wed, Oct 24, 2018 at 06:01:16PM -0700, Nicolin Chen wrote:
>> On Thu, Oct 25, 2018 at 12:13:01AM +0000, linux@roeck-us.net wrote:
>>
>> > > +	if (dev) {
>> > > +		hdev->driver = dev->driver;
>> > > +		hdev->power = dev->power;
>> > > +		hdev->pm_domain = dev->pm_domain;
>> > > +		hdev->of_node = dev->of_node;
>> > > +	}
>> >
>> > We'l need to dig into this more; I suspect it may be  
>> inappropriate to do this.
>> > With this change, every hwmon driver supporting (runtime ?) suspend/resume
>> > will have the problem worked around in #5, and that just seems wrong.
>>
>> Hmm..that's true...thanks for catching it.
>>
>> Actually I am not sure the reason of having a child device in
>> the core, but could we use the parent dev pointer in the hwmon
>> core as hwmon_dev upon confirming parent dev pointer != NULL?
>
> I just noticed that it is used to link to hwmon class. So this

Exactly.

> won't work then. I guess it'd be safer to ignore the problem of
> the power node, i.e. using parent dev pointer for pm runtime.
>
It might be worthwhile looking up how other virtal devices handle
this problem. Maybe the hwmon code could have its own suspend/resume
callbacks. Not sure how to make that work, though, and what those
callbacks would (have to) do.

Guenter

> Thanks
> Nicolin
>
>> The problem here is that the power directory under each hwmon
>> directory is tied to the hwmon_dev pointer, not to the parent
>> dev pointer, and the hwmon core creates all sysfs nodes based
>> on the child node. So those nodes under power directory won't
>> be valid unless we copy all pm information, especially PM ops.
>>
>> There is an option of ignoring this problem though, while all
>> hwmon drivers will need to be careful of mixing using the dev
>> pointers. So it'd be a lot of easier if we could just use the
>> original dev pointer in the core since we mainly just need to
>> create sysfs nodes.
>>
>> Another way of doing this might be to pass down the PM pointer
>> via _info structure instead of linking it to the parent driver,
>> which then will forbid all hwmon drivers having its own PM ops
>> callbacks -- the very opposite way of this patch, and it does
>> not sound fully reasonable and feasible to me...
>>
>> What do you think about?
>>
>> Thanks
>> Nicolin



