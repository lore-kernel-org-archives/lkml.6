Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A88C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991252082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E3WeafnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991252082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeLKL1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:27:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42418 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeLKL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:27:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBBR4wX005874;
        Tue, 11 Dec 2018 05:27:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544527624;
        bh=X5khX2ZoCCT4BojmQacfvqL3XksKsVSGtPdhuhshOyM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E3WeafnOVvp1LsNC0OIVvbyOoSuosN5dEH3Ymrmi6uE5H+0+FzFH6MF/N6LSmrTeP
         Qr8N3+lc52zhwsygnXc8cbmy9cuKx/vwv5qdkuteuDPmP+xZ+VLmphb1kwJGaa7Auy
         Tajrj4FSeINO5HyfH6MnPpYqw+1n4z2paSREu/Rk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBBR49j053037
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 05:27:04 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 05:27:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 05:27:03 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBBQwOo014997;
        Tue, 11 Dec 2018 05:26:58 -0600
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
To:     Peter Chen <hzpeterchen@gmail.com>, <rogerq@ti.com>
CC:     <pawell@cadence.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <balbi@kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com>
Date:   Tue, 11 Dec 2018 16:56:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 7:42 AM, Peter Chen wrote:
>>> +static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
>>> +                                         struct usb_endpoint_descriptor *desc,
>>> +                                         struct usb_ss_ep_comp_descriptor *comp_desc)
>>> +{
>>> +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>> +     struct cdns3_endpoint *priv_ep;
>>> +     unsigned long flags;
>>> +
>>> +     priv_ep = cdns3_find_available_ss_ep(priv_dev, desc);
>>> +     if (IS_ERR(priv_ep)) {
>>> +             dev_err(&priv_dev->dev, "no available ep\n");
>>> +             return NULL;
>>> +     }
>>> +
>>> +     dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
>>> +
>>> +     spin_lock_irqsave(&priv_dev->lock, flags);
>>> +     priv_ep->endpoint.desc = desc;
>>> +     priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
>>> +     priv_ep->type = usb_endpoint_type(desc);
>>> +
>>> +     list_add_tail(&priv_ep->ep_match_pending_list,
>>> +                   &priv_dev->ep_match_list);
>>> +     spin_unlock_irqrestore(&priv_dev->lock, flags);
>>> +     return &priv_ep->endpoint;
>>> +}
>> Why do you need a custom match_ep?
>> doesn't usb_ep_autoconfig suffice?
>>
>> You can check if EP is claimed or not by checking the ep->claimed flag.
>>
> It is a special requirement for this IP, the EP type and MaxPacketSize
> changing can't be done at runtime, eg, at ep->enable. See below commit
> for detail.
> 
>     usb: cdns3: gadget: configure all endpoints before set configuration
> 
>     Cadence IP has one limitation that all endpoints must be configured
>     (Type & MaxPacketSize) before setting configuration through hardware
>     register, it means we can't change endpoints configuration after
>     set_configuration.
> 
>     In this patch, we add non-control endpoint through usb_ss->ep_match_list,
>     which is added when the gadget driver uses usb_ep_autoconfig to configure
>     specific endpoint; When the udc driver receives set_configurion request,
>     it goes through usb_ss->ep_match_list, and configure all endpoints
>     accordingly.
> 
>     At usb_ep_ops.enable/disable, we only enable and disable endpoint through
>     ep_cfg register which can be changed after set_configuration, and do
>     some software operation accordingly.

All this should be part of comments in code along with information about
controller versions which suffer from the errata.

Is there a version of controller available which does not have the
defect? Is there a future plan to fix this?

If any of that is yes, you probably want to handle this with runtime
detection of version (like done with DWC3_REVISION_XXX macros).
Sometimes the hardware-read versions themselves are incorrect, so its
better to introduce a version specific compatible too like
"cdns,usb-1.0.0" (as hinted to by Rob Herring as well).

Thanks,
Sekhar
