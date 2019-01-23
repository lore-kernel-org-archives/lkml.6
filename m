Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F89FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0868F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfAWN4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:56:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfAWN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:56:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0CB552F66421CC22A1F;
        Wed, 23 Jan 2019 21:55:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 21:55:53 +0800
Subject: Re: [PATCH -next] usb: ftdi-elan: Fix if == else warnings in
 ftdi_elan_respond_engine
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20190123123442.5256-1-yuehaibing@huawei.com>
 <20190123124319.GB19703@kroah.com>
 <10d0f378-03ab-1855-1476-a39cf6b816ab@huawei.com>
 <20190123134147.GC24700@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <7c7b701b-42b6-51b6-95ea-e9c6b278e474@huawei.com>
Date:   Wed, 23 Jan 2019 21:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190123134147.GC24700@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/23 21:41, Greg KH wrote:
> On Wed, Jan 23, 2019 at 09:17:38PM +0800, YueHaibing wrote:
>> On 2019/1/23 20:43, Greg KH wrote:
>>> On Wed, Jan 23, 2019 at 08:34:42PM +0800, YueHaibing wrote:
>>>> ./drivers/usb/misc/ftdi-elan.c:972:10-12: WARNING: possible condition with no effect (if == else)
>>>> ./drivers/usb/misc/ftdi-elan.c:983:9-11: WARNING: possible condition with no effect (if == else)
>>>> ./drivers/usb/misc/ftdi-elan.c:2052:11-13: WARNING: possible condition with no effect (if == else)
>>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> You can not just provide the output of a tool as a changelog text,
>>> sorry.
>>>
>>> Please explain what those lines mean, and why you are making the change
>>> that you are.
>>
>> ok, will do that.
>>
>>>
>>>> ---
>>>>  drivers/usb/misc/ftdi-elan.c | 26 --------------------------
>>>>  1 file changed, 26 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
>>>> index 76c718a..257efac 100644
>>>> --- a/drivers/usb/misc/ftdi-elan.c
>>>> +++ b/drivers/usb/misc/ftdi-elan.c
>>>> @@ -915,7 +915,6 @@ static int ftdi_elan_respond_engine(struct usb_ftdi *ftdi)
>>>>  	int bytes_read = 0;
>>>>  	int retry_on_empty = 1;
>>>>  	int retry_on_timeout = 3;
>>>> -	int empty_packets = 0;
>>>>  read:{
>>>>  		int packet_bytes = 0;
>>>>  		int retval = usb_bulk_msg(ftdi->udev,
>>>> @@ -960,31 +959,6 @@ read:{
>>>>  			dev_err(&ftdi->udev->dev, "error = %d with packet_bytes = %d with total %d bytes%s\n",
>>>>  				retval, packet_bytes, bytes_read, diag);
>>>>  			return retval;
>>>> -		} else if (packet_bytes == 2) {
>>>> -			unsigned char s0 = ftdi->bulk_in_buffer[0];
>>>> -			unsigned char s1 = ftdi->bulk_in_buffer[1];
>>>> -			empty_packets += 1;
>>>> -			if (s0 == 0x31 && s1 == 0x60) {
>>>> -				if (retry_on_empty-- > 0) {
>>>> -					goto more;
>>>> -				} else
>>>> -					return 0;
>>>> -			} else if (s0 == 0x31 && s1 == 0x00) {
>>>> -				if (retry_on_empty-- > 0) {
>>>> -					goto more;
>>>> -				} else
>>>> -					return 0;
>>>> -			} else {
>>>> -				if (retry_on_empty-- > 0) {
>>>> -					goto more;
>>>> -				} else
>>>> -					return 0;
>>>> -			}
>>>> -		} else if (packet_bytes == 1) {
>>>> -			if (retry_on_empty-- > 0) {
>>>> -				goto more;
>>>> -			} else
>>>> -				return 0;
>>>
>>> Are you _sure_ that these lines are not needed and that the compiler is
>>> not really seeing them?  As it doesn't look that way to me, what am I
>>> missing?
>>
>> I checked and make sure that All these if/else if branch just do the same thing:
>>
>> 	if (retry_on_empty-- > 0) {
>> 		goto more;
>> 	} else
>> 		return 0;
>>
>> so it can be merged into the last else branch.
>>
>> Also the variable 'empty_packets' doesn't use in any place, except for self increment
> 
> Don't do two different things in the same patch :)

Thanks, I will split it into two.

> 
> 
> .
> 

