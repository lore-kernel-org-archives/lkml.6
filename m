Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8FAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B673C2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qOkNQUVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B673C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIIT0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:26:40 -0400
Received: from node.akkea.ca ([192.155.83.177]:55434 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeIIT0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:26:40 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id CDA445420DB; Sun,  9 Sep 2018 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536503806; bh=erbLE6RX/STUjLD4B+fUMThshyEyiVlzXi9ubTHY4lE=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=qOkNQUVVPl0EFpK8XlRMyLvjWHlGJpStSNyiP1P+R/0gqjy0haLL+0SpmbLuOnLjU
         hY3D8rE6BM7c8sxLfujTd/RQhvi0oJCUxOUlOy3bX+tw+hloUDyzion2xHA0d98s0H
         uvho3HstRgHuyYFxchd2NCbSK7W/P+Igz4RoMi24=
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] usb: typec: don't disable sink or source on  initialization
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 09 Sep 2018 08:36:46 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
In-Reply-To: <690375f9-b721-51d5-7292-59acff44af7c@roeck-us.net>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180907103438.GI25121@kuha.fi.intel.com>
 <0adff11c-4836-4035-39a7-1cd2ea3ff74d@roeck-us.net>
 <00ed8e5a4ae0dd40181b8de534684960@www.akkea.ca>
 <690375f9-b721-51d5-7292-59acff44af7c@roeck-us.net>
Message-ID: <363bd1128780d8de8e560b1b82ce361a@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-09 08:20, Guenter Roeck wrote:
> On 09/09/2018 07:08 AM, Angus Ainslie wrote:
>> Hi Guenter
>> 
>> On 2018-09-07 06:55, Guenter Roeck wrote:
>>> On 09/07/2018 03:34 AM, Heikki Krogerus wrote:
>>>> +Guenter
>>>> 
>>>> On Thu, Sep 06, 2018 at 01:26:44PM -0600, Angus Ainslie (Purism) 
>>>> wrote:
>>>>> If the board is being powered by USB disabling the source and sink
>>>>> can remove power from the board. Default to source and sink 
>>>>> enabled.
>>>>> 
>>> 
>>> Seems to me that might violate the specification, and cause trouble 
>>> for systems
>>> where vbus has to be off initially. It may be better to provide this 
>>> kind of
>>> information as configuration parameter instead of imposing it on 
>>> everyone.
>>> 
>> 
>> It felt like it would not be the correct thing to do either. I've 
>> tried re-arranging the code in tcpci.c to enable the sink before 
>> disabling the source but the only way I found to not disable the power 
>> was by setting both of those to true.
>> 
>> What about adding some device tree entries for the initial vbus state 
>> and default to false if they are not present ?
>> 
>> init-vbus-source and init-vbus-charge ?
>> 
> 
> Yes, I think we should do something along that line. Another question 
> is
> if we could or should optionally pull the current state from the low 
> level
> driver, but that may be secondary.
> 

I thought of trying to do that but from reading the "PTN5110N PD PHY 
application programming guide" there didn't seem to be a direct way to 
read those parameters.

> Thanks,
> Guenter
> 
>> Angus
>> 
>>> Guenter
>>> 
>>>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>>>> ---
>>>>>   drivers/usb/typec/tcpm.c | 8 +++++---
>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>>>>> index ca7bedb46f7f..a1b819cf31da 100644
>>>>> --- a/drivers/usb/typec/tcpm.c
>>>>> +++ b/drivers/usb/typec/tcpm.c
>>>>> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port 
>>>>> *port)
>>>>>   {
>>>>>       int ret;
>>>>>   -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>>>>> -    port->vbus_source = false;
>>>>> -    port->vbus_charge = false;
>>>>> +    /* default to source and sink enabled in case USB is our only 
>>>>> power
>>>>> +     * source */
>>> 
>>> I am personally in favor of standard multi-line comments.
>>> 
>>>>> +    ret = port->tcpc->set_vbus(port->tcpc, true, true);
>>>>> +    port->vbus_source = true;
>>>>> +    port->vbus_charge = true;
>>>>>       return ret;
>>>>>   }
>>>> 
>> 
>> 

