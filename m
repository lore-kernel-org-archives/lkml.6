Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D88C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3B421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548198333;
	bh=wIjHHbv4me3X0FW0Vb80ZBbvIkLZuPhT8K2RJTM8UtM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pL8mIeIEqyF+TChOwiyKt/eB61Lb7rqq/L7GJE4+jMNniU+ca70ar6dxv9unFBPWb
	 wc4MWyjeACB1YzJGmps9vflzHLCdIFoFhMlL/emiHl6BChrh2sWQeZfQYCHJs/OBrN
	 QoIbWTnk6BpNvCi/MBaODcYmPhdx5H622JUg7sJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfAVXFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfAVXFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:05:30 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B3B21726;
        Tue, 22 Jan 2019 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548198329;
        bh=wIjHHbv4me3X0FW0Vb80ZBbvIkLZuPhT8K2RJTM8UtM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aFsCJCArY+zcIim5kskpN+R2oDJ3QHV2JqsxT7AM2zQU2ofkrtqaLhc4MU0XkV5Th
         ID3OI6Uh/lz6pppu6lh9A3fIzXDgMQ/dQZPjr7af1WsfyyRRhMmpgFHoPuwao7XQg/
         AFpE3Sl5VI05LR3zX4hedqUNhtD7HryL+pDOymBY=
Subject: Re: [PATCH] usbip: Fix vep_free_request() null pointer checks on
 input args
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190119081708.GA8204@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0b87d2b7-3200-7f6f-c4ee-e9e1fe6161fe@kernel.org>
Date:   Tue, 22 Jan 2019 16:05:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190119081708.GA8204@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 1:17 AM, Greg KH wrote:
> On Fri, Jan 18, 2019 at 02:29:30PM -0700, Shuah Khan wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Fix vep_free_request() to return when usb_ep and usb_request are null
>> instead of calling WARN_ON.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/usb/usbip/vudc_dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
>> index 1634d8698e15..bfc8218e3fb6 100644
>> --- a/drivers/usb/usbip/vudc_dev.c
>> +++ b/drivers/usb/usbip/vudc_dev.c
>> @@ -297,7 +297,7 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
>>   {
>>   	struct vrequest *req;
>>   
>> -	if (WARN_ON(!_ep || !_req))
>> +	if (!_ep || !_req)
> 
> It's impossible for _ep to be NULL in this callback (see
> usb_ep_free_request() for where this is called from to prove that), so I
> don't think you need to check that.  It's almost impossible for _req to
> be NULL, so you might as well leave that check in.
> 

Yes. ep can never be null here in vep_free_request(). I will leave
this alone.

thanks,
-- Shuah



