Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6039FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3075C20881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548426436;
	bh=J2x2iDpthiQgEhMEVxCpzRzHjAA8HVumOH3mGj+R5eU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JYp1U3LaMMPjcyA9vVY3srB9ukPeD/MnMGhyUgxbIlBSCXM5XzmS0LpRoCWN20Dk1
	 OrLN/bmqyVyJZ0LUIkWzScmprscvS9Q4VFthXmns0gGoLt4M8GPd6rr2vpMai/N5Sv
	 EP8A7EClK0PD4rnzjwIOJlfmj2FGofh2gmD/h6wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAYO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfAYO1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:27:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A9920881;
        Fri, 25 Jan 2019 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548426433;
        bh=J2x2iDpthiQgEhMEVxCpzRzHjAA8HVumOH3mGj+R5eU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bf3L+4L2CV2fAJoSGS0hyszZ22xD2ivFj4FGmlkqlzoahFuwkHWEsMKIinVvPJBzB
         2Sfk0qk6j8EuUQiWALaBcUaAv+z8WXV3hl8az+zid7L/Ese97u2bOIx1WcVE1w19CK
         Urp7Sr2fTaReBDDeym3oQPGGFo96KcdwFx4w9QOY=
Subject: Re: [PATCH] usbip: Fix vep_free_request() null pointer checks on
 input args
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190119081708.GA8204@kroah.com>
 <0b87d2b7-3200-7f6f-c4ee-e9e1fe6161fe@kernel.org>
 <20190125080227.GA21576@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0d292f37-0584-2d95-605f-7741e845c73f@kernel.org>
Date:   Fri, 25 Jan 2019 07:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125080227.GA21576@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/19 1:02 AM, Greg KH wrote:
> On Tue, Jan 22, 2019 at 04:05:28PM -0700, shuah wrote:
>> On 1/19/19 1:17 AM, Greg KH wrote:
>>> On Fri, Jan 18, 2019 at 02:29:30PM -0700, Shuah Khan wrote:
>>>> From: Shuah Khan <shuah@kernel.org>
>>>>
>>>> Fix vep_free_request() to return when usb_ep and usb_request are null
>>>> instead of calling WARN_ON.
>>>>
>>>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>>>> ---
>>>>    drivers/usb/usbip/vudc_dev.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
>>>> index 1634d8698e15..bfc8218e3fb6 100644
>>>> --- a/drivers/usb/usbip/vudc_dev.c
>>>> +++ b/drivers/usb/usbip/vudc_dev.c
>>>> @@ -297,7 +297,7 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
>>>>    {
>>>>    	struct vrequest *req;
>>>> -	if (WARN_ON(!_ep || !_req))
>>>> +	if (!_ep || !_req)
>>>
>>> It's impossible for _ep to be NULL in this callback (see
>>> usb_ep_free_request() for where this is called from to prove that), so I
>>> don't think you need to check that.  It's almost impossible for _req to
>>> be NULL, so you might as well leave that check in.
>>>
>>
>> Yes. ep can never be null here in vep_free_request(). I will leave
>> this alone.
> 
> You can drop the !_ep check at the least, no need to check something
> that is impossible to hit :)
> 

Thanks. I will do that.

-- Shuah
