Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93DC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF83520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="j80v/MO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF83520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeILVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:14:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:55442 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILVOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:14:10 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 128F65420DB; Wed, 12 Sep 2018 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536768538; bh=8QNGzoeneFaV0BTMFvfMB4hbUbzPaLIYeFwJBr+k5RE=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=j80v/MO+PKM5UGYSGohNwde9S5I7aiyuGbp+ChH4eN1VOfCVOdsfBnAsv8iqR3c6c
         FsIk+pcNfYbEWnkN29CcQQrqYJwNeGg/TvDZqXLP+8nhpTc6Kt3eeMNkrZQfhVMoJe
         RzVl+5r76kg3a/FJH1fJgz+S5aZDqTnhiw0WxmIE=
To:     linux@roeck-us.net
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values from  the devicetree
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 12 Sep 2018 10:08:58 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
Message-ID: <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-11 09:33, Guenter Roeck wrote:
> I cant put my finger on it but this seems wrong. As i said both src
> and sink should never be true at the same time. I also din’t
> understand why turning off src should power off your board. Ultimately
> my concern is that we may be just painting over the real problem, and
> that would be really bad to do with dt properties.
> 

I agree that this doesn't seem like the correct way of solving the 
problem. On this HW (Emcraft iMX8M BSB) I think the PTN5110 chip has 
been connected correctly so I'm assuming that it is some quirk of the 
PTN5110.

I didn't design the HW or the chip. This is a workaround for "quirky" 
hardware and there may be others that don't behave exactly as expected.

> Note that sending to groeck7@ makes it hard for me to see your emails
> and to reply. Using linux@roeck-us.net would be much better.
> 

Ok, I think that email was grabbed from the driver source.

> Guenter
> 
> Sent from my iPhone
> 
>> On Sep 11, 2018, at 7:59 AM, Angus Ainslie (Purism) <angus@akkea.ca> 
>> wrote:
>> 
>> If the board is being powered by USB disabling the source and sink
>> can remove power from the board. Allow the source and sink to be
>> initallized based on devicetree values.
>> 
>> Changed since V2:
>> 
>> Change the devicetree documentation.
>> Change the devicetree property names.
>> 
>> Changed since V1:
>> 
>> use devicetree values instead of hardcoded initialization.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>> .../devicetree/bindings/usb/typec-tcpci.txt        |  6 ++++++
>> drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
>> 2 files changed, 17 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt 
>> b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> index 0dd1469e7318..b07418ae6482 100644
>> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> @@ -15,6 +15,12 @@ Required sub-node:
>>   of connector node are specified in
>>   Documentation/devicetree/bindings/connector/usb-connector.txt
>> 
>> +Optional properties for usb-c-connector sub-node:
>> +- init-vbus-source: set the initalization value for vbus-source to 
>> true.
>> +  If this property is not present the initial value will be false.
>> +- init-vbus-sink: set the initalization value for vbus-sink to true.
>> +  If this property is not present the initial value will be false.
>> +
>> Example:
>> 
>> ptn5110@50 {
>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>> index ca7bedb46f7f..10c14ece3858 100644
>> --- a/drivers/usb/typec/tcpm.c
>> +++ b/drivers/usb/typec/tcpm.c
>> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port 
>> *port)
>> {
>>    int ret;
>> 
>> -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>> -    port->vbus_source = false;
>> -    port->vbus_charge = false;
>> +    ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, 
>> port->vbus_charge);
>>    return ret;
>> }
>> 
>> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port 
>> *port,
>>        return -EINVAL;
>>    port->port_type = port->typec_caps.type;
>> 
>> +    if (fwnode_property_present(fwnode, "init-vbus-source"))
>> +        port->vbus_source = true;
>> +    else
>> +        port->vbus_source = false;
>> +
>> +    if (fwnode_property_present(fwnode, "init-vbus-sink"))
>> +            port->vbus_charge = true;
>> +    else
>> +            port->vbus_charge = false;
>> +
>>    if (port->port_type == TYPEC_PORT_SNK)
>>        goto sink;
>> 
>> --
>> 2.17.1
>> 

