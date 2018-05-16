Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeEPRrg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:47:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42379 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeEPRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:47:34 -0400
X-Google-Smtp-Source: AB8JxZrJXK2gU0nmkn+anLwjdgJrMd1DWtWE8P8+f4uC3+SQQGEKoc5CqZOxfrghtBKFNK2T//4lSg==
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com> <20180516171528.GD21971@dtor-ws>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
Date: Wed, 16 May 2018 20:47:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516171528.GD21971@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 08:15 PM, Dmitry Torokhov wrote:
> Hi Oleksandr,
>
> On Mon, May 14, 2018 at 05:40:29PM +0300, Oleksandr Andrushchenko wrote:
>> @@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
>>   	if (!info->page)
>>   		goto error_nomem;
>>   
>> -	/* Set input abs params to match backend screen res */
>> -	abs = xenbus_read_unsigned(dev->otherend,
>> -				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
>> -	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
>> -						  XENKBD_FIELD_WIDTH,
>> -						  ptr_size[KPARAM_X]);
>> -	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
>> -						  XENKBD_FIELD_HEIGHT,
>> -						  ptr_size[KPARAM_Y]);
>> -	if (abs) {
>> -		ret = xenbus_write(XBT_NIL, dev->nodename,
>> -				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
>> -		if (ret) {
>> -			pr_warn("xenkbd: can't request abs-pointer\n");
>> -			abs = 0;
>> -		}
>> -	}
>> +	/*
>> +	 * The below are reverse logic, e.g. if the feature is set, then
>> +	 * do not expose the corresponding virtual device.
>> +	 */
>> +	with_kbd = !xenbus_read_unsigned(dev->nodename,
>> +					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
>>   
>> -	touch = xenbus_read_unsigned(dev->nodename,
>> -				     XENKBD_FIELD_FEAT_MTOUCH, 0);
>> -	if (touch) {
>> +	with_ptr = !xenbus_read_unsigned(dev->nodename,
>> +					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
>> +
>> +	/* Direct logic: if set, then create multi-touch device. */
>> +	with_mtouch = xenbus_read_unsigned(dev->nodename,
>> +					   XENKBD_FIELD_FEAT_MTOUCH, 0);
>> +	if (with_mtouch) {
>>   		ret = xenbus_write(XBT_NIL, dev->nodename,
>>   				   XENKBD_FIELD_REQ_MTOUCH, "1");
>>   		if (ret) {
>>   			pr_warn("xenkbd: can't request multi-touch");
>> -			touch = 0;
>> +			with_mtouch = 0;
>>   		}
>>   	}
> Does it make sense to still end up calling xenkbd_connect_backend() when
> all interfaces (keyboard, pointer, and multitouch) are disabled? Should
> we do:
>
> 	if (!(with_kbd || || with_ptr || with_mtouch))
> 		return -ENXIO;
>
> ?
It does make sense. Then we probably need to move all xenbus_read_unsigned
calls to the very beginning of the .probe, so no memory allocations are made
which will be useless if we return -ENXIO, e.g. something like

static int xenkbd_probe(struct xenbus_device *dev,
                   const struct xenbus_device_id *id)
{
     int ret, i;
     bool with_mtouch, with_kbd, with_ptr;
     struct xenkbd_info *info;
     struct input_dev *kbd, *ptr, *mtouch;

<read with_mtouch, with_kbd, with_ptr here>

if (!(with_kbd | with_ptr | with_mtouch))
         return -ENXIO;

Does the above looks ok?
> Thanks.
>
Thank you,
Oleksandr
