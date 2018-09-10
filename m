Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DB8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5B920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ljWkQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5B920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeIJShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:37:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIJShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:37:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so8814664plo.2;
        Mon, 10 Sep 2018 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vZUaM3FiqFI+nUSJfmO0PHyuYbDlh6UGWzlWupNSRmI=;
        b=E0ljWkQy69wu65OPKidBgMwQSmH5eJOftOrXszPhLBOuGVmvGiwU/NtxSuZd/Ea+t0
         t9GG/3sL6TUyyy7Imj2/JMp9/dauMz46p4cVuWH20uM4iCsKm0iRNOFVgoOWOgB8qiXh
         mTHyDsQ1Srvkt20GqkTT0LqwdgilungxDzfZc6tnzPIaq9sO0ahSp221BzEf0sfbgVZM
         /ozqvqw2EHRjO3SnFJxJPjAOvomaEnbfG3a7P/3BYpUN/vOpqYcOtYlwabCB9aDijq7x
         JEM22EdNMteSnLzkp7kqrCjICTQvZX8oIY3mp8oT4OMl2o9FWU9VASWHY/MRwHOz1TIN
         Ukug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vZUaM3FiqFI+nUSJfmO0PHyuYbDlh6UGWzlWupNSRmI=;
        b=P0nvF0tmDCzwJjYXHtN5E3M/bder/8xwjQr7i/3/xVzOGHY3kHHvcOsHOfrCmoYUTI
         r45Jm8JBZwin81eQcuSu0IapMC3tHBwNhxjrp3/F6cr4QYMibap8SuCBPnCQgRr9iZlE
         1Ef5HBT2xf3S1LrfS93njiZtPtC9H/pExWGPygrdvCpKJqhR2bekzM7QPWYibGqrxZCu
         e5DPy9E4cAOq30RCsP21MJnVsum8AzFKWzI1vbOfpuC2/x/Oz46k7g9Pj8KnAys/WT0f
         MX69KzCh+FHovGuDGUVPP5iPNRvxWFSwkIIBJORcLwquTHisQ635DzAr/EVgfVflDGbz
         50MQ==
X-Gm-Message-State: APzg51APSPzFEP731fbLVJTRb/rsezItzU+5ze/9xLbbn59ScfnVSZiw
        rZ5Q8AlokWF32nJ5lMuEOyM/2FFe
X-Google-Smtp-Source: ANB0VdYSh84NGdusEm9ebKXZLnsrsYS+hNDZL3bD/Oivo7daYc7xvJ7cvllvfRRO4vDk6FaMeJ8M6w==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3-v6mr22441140plp.75.1536587017026;
        Mon, 10 Sep 2018 06:43:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k23-v6sm18234602pgl.42.2018.09.10.06.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 06:43:35 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values from
 the devicetree
To:     Angus Ainslie <angus@akkea.ca>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     groeck7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
 <20180910073529.GL25121@kuha.fi.intel.com>
 <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
From:   Guenter Roeck <guenter@roeck-us.net>
Message-ID: <cf237e3a-30fb-a98d-ba2b-cf5485bdb5f6@roeck-us.net>
Date:   Mon, 10 Sep 2018 06:43:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 06:11 AM, Angus Ainslie wrote:
> Hi Heikki
>
> On 2018-09-10 01:35, Heikki Krogerus wrote:
>> On Sun, Sep 09, 2018 at 12:05:31PM -0600, Angus Ainslie (Purism) wrote:
>>> If the board is being powered by USB disabling the source and sink
>>> can remove power from the board. Allow the source and sink to be
>>> initallized based on devicetree values.
>>>
>>> Changed since V1:
>>>
>>> use devicetree values instead of hardcoded initialization.
>>>
>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>> ---
>>>  .../bindings/connector/usb-connector.txt           |  4 ++++
>>>  drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
>>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> index 8855bfcfd778..afe851a713c3 100644
>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> @@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
>>>    or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
>>>  - data-role: should be one of "host", "device", "dual"(DRD) if typec
>>>    connector supports USB data.
>>> +- init-vbus-source: set the initalization value for vbus-source to true.
>>> +  If this property is not present the initial value will be false.
>>> +- init-vbus-charge: set the initalization value for vbus-charge to true.
>>> +  If this property is not present the initial value will be false.
>>
>> If you put the description of those properties here, you are going to
>> need to rename them. Those describe tcpm specific properties, but to
>> that file you want to put descriptions of generic properties.
>>
>
> They are tcpm specific but need to go into the connector sub-node to get parsed correctly. Would something like below be better ?
>
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> index 0dd1469e7318..ae0a3e97d9b6 100644
> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> @@ -15,6 +15,12 @@ Required sub-node:
>    of connector node are specified in
>    Documentation/devicetree/bindings/connector/usb-connector.txt
>
> +Optional properties for usb-c-connector sub-node:
> +- init-vbus-source: set the initalization value for vbus-source to true.
> +  If this property is not present the initial value will be false.
> +- init-vbus-charge: set the initalization value for vbus-charge to true.
> +  If this property is not present the initial value will be false.
> +
>  Example:
>
>  ptn5110@50 {
>
>
>> Your problem is that you can not cope with a lose of VBUS as a sink,
>> right? For that you just need one boolean device property IMO.
>> Something like depend-on-vbus.
>
> I thought that it would better to be able to control each independently. With my specific hardware I need both defaulted to true but for another piece of HW just being able to control one of them might be sufficient.
>

Turns out the problem goes deeper: Only one of the two values is supposed to
be true at any given time. The system is either a sink (vbus_charge=true)
or a source (vbus_src=true), but it can not be both.

I think we first need to figure out what actually happens in your system; the
result from setting both values to true is that the initial request to set vbus
(either as source or as sink) should fail, unless the value is actually cleared
and the other value (supposed to be untouched) is set. This does not make
sense and warrants further debugging. Can you do that and let us know what
exactly actually happens and why your hardware needs that request to fail ?

Thanks,
Guenter

> Thanks
> Angus
>
>>
>>>  Required properties for usb-c-connector with power delivery support:
>>>  - source-pdos: An array of u32 with each entry providing supported power
>>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>>> index ca7bedb46f7f..7f5d4f209e07 100644
>>> --- a/drivers/usb/typec/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm.c
>>> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>>>  {
>>>      int ret;
>>>
>>> -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>>> -    port->vbus_source = false;
>>> -    port->vbus_charge = false;
>>> +    ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, port->vbus_charge);
>>>      return ret;
>>>  }
>>>
>>> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>>>          return -EINVAL;
>>>      port->port_type = port->typec_caps.type;
>>>
>>> +    if (fwnode_property_present(fwnode, "init-vbus-source"))
>>> +        port->vbus_source = true;
>>> +    else
>>> +        port->vbus_source = false;
>>> +
>>> +    if (fwnode_property_present(fwnode, "init-vbus-charge"))
>>> +            port->vbus_charge = true;
>>> +    else
>>> +            port->vbus_charge = false;
>>> +
>>>      if (port->port_type == TYPEC_PORT_SNK)
>>>          goto sink;
>>>
>>> -- 
>>> 2.17.1
>>
>> Thanks,
>
>

