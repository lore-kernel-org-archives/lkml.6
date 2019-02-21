Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB62086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBUH6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:58:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51136 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:58:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6584227F822
Subject: Re: [PATCH -next] platform/chrome: Fix off-by-one error in
 wilco_ec/debugfs.c
To:     Nick Crews <ncrews@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Duncan Laurie <dlaurie@chromium.org>
References: <20190220215826.44366-1-ncrews@chromium.org>
 <a0cf4649-e06f-aded-55ad-893560c2414a@collabora.com>
 <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <412c051b-2f9b-9d92-2480-ef493d26b9c2@collabora.com>
Date:   Thu, 21 Feb 2019 08:58:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/2/19 23:15, Nick Crews wrote:
> Hi Enric,
> 
> On Wed, Feb 20, 2019 at 3:06 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Nick,
>>
>> Thanks for the patch.
>>
>> On 20/2/19 22:58, Nick Crews wrote:
>>> Before, in debugfs.c it was possible to supply only the message type,
>>> and not supply any other arguments when sending raw commands. However,
>>> this is never used by the EC, and it led to an underflow error. Now,
>>> just don't allow too short of a command, we will never need
>>> that anyways.
>>>
>>> Fixes: 46c7fd06f8c9 ("platform/chrome: wilco_ec: Add support for raw commands in debugfs")
>>
>> As this is -next material I'd like to squash the fix if you don't mind.
> 
> 
> Please do. Fixing something after it's already in the tree was a new
> process for me,
> so I tried to copy other people's examples. Please let me know
> if there's anything else I should do something different next time.
> 

Squashed and pushed for 5.1

Thanks,
 Enric


> Nick
> 
>>
>> -- Enric
>>
>>> Signed-off-by: Nick Crews <ncrews@chromium.org>
>>> ---
>>>  drivers/platform/chrome/wilco_ec/debugfs.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
>>> index 46ff3b6c46c7..c090db2cd5be 100644
>>> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
>>> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
>>> @@ -136,8 +136,8 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
>>>       ret = parse_hex_sentence(buf, kcount, request_data, TYPE_AND_DATA_SIZE);
>>>       if (ret < 0)
>>>               return ret;
>>> -     /* Need at least two bytes for message type */
>>> -     if (ret < 2)
>>> +     /* Need at least two bytes for message type and one for command */
>>> +     if (ret < 3)
>>>               return -EINVAL;
>>>
>>>       /* Clear response data buffer */
>>> @@ -145,7 +145,7 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
>>>
>>>       msg.type = request_data[0] << 8 | request_data[1];
>>>       msg.flags = WILCO_EC_FLAG_RAW;
>>> -     msg.command = ret > 2 ? request_data[2] : 0;
>>> +     msg.command = request_data[2];
>>>       msg.request_data = ret > 3 ? request_data + 3 : 0;
>>>       msg.request_size = ret - 3;
>>>       msg.response_data = debug_info->raw_data;
>>>
