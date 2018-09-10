Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7941C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F724206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="JjH8DTTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F724206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeIJSFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:05:44 -0400
Received: from node.akkea.ca ([192.155.83.177]:38054 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJSFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:05:44 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 046995420DB; Mon, 10 Sep 2018 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536585103; bh=HOl6YisnWcrnte8Vt3kXD+q7ASel3KYhWVAAC4Se2xI=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=JjH8DTTTwcynPJtnrT+ZFv3s/lP1QQkPG9ciVbHputR2p+cZypKxcKpV9heR5t1VK
         t/D00ui3JxJhkOhNp29wemS0MPqTpWFxq8P2lwdX1T395M0XQ91J46f0mz5s+vp1+Q
         keTaFWOZ4tJrYe0WDu96/zIddBfIzIz6gv1fIw3k=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values from  the devicetree
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Sep 2018 07:11:43 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     groeck7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180910073529.GL25121@kuha.fi.intel.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
 <20180910073529.GL25121@kuha.fi.intel.com>
Message-ID: <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki

On 2018-09-10 01:35, Heikki Krogerus wrote:
> On Sun, Sep 09, 2018 at 12:05:31PM -0600, Angus Ainslie (Purism) wrote:
>> If the board is being powered by USB disabling the source and sink
>> can remove power from the board. Allow the source and sink to be
>> initallized based on devicetree values.
>> 
>> Changed since V1:
>> 
>> use devicetree values instead of hardcoded initialization.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  .../bindings/connector/usb-connector.txt           |  4 ++++
>>  drivers/usb/typec/tcpm.c                           | 14 
>> +++++++++++---
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/connector/usb-connector.txt 
>> b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> index 8855bfcfd778..afe851a713c3 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
>>    or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
>>  - data-role: should be one of "host", "device", "dual"(DRD) if typec
>>    connector supports USB data.
>> +- init-vbus-source: set the initalization value for vbus-source to 
>> true.
>> +  If this property is not present the initial value will be false.
>> +- init-vbus-charge: set the initalization value for vbus-charge to 
>> true.
>> +  If this property is not present the initial value will be false.
> 
> If you put the description of those properties here, you are going to
> need to rename them. Those describe tcpm specific properties, but to
> that file you want to put descriptions of generic properties.
> 

They are tcpm specific but need to go into the connector sub-node to get 
parsed correctly. Would something like below be better ?

diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt 
b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
index 0dd1469e7318..ae0a3e97d9b6 100644
--- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
+++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
@@ -15,6 +15,12 @@ Required sub-node:
    of connector node are specified in
    Documentation/devicetree/bindings/connector/usb-connector.txt

+Optional properties for usb-c-connector sub-node:
+- init-vbus-source: set the initalization value for vbus-source to 
true.
+  If this property is not present the initial value will be false.
+- init-vbus-charge: set the initalization value for vbus-charge to 
true.
+  If this property is not present the initial value will be false.
+
  Example:

  ptn5110@50 {


> Your problem is that you can not cope with a lose of VBUS as a sink,
> right? For that you just need one boolean device property IMO.
> Something like depend-on-vbus.

I thought that it would better to be able to control each independently. 
With my specific hardware I need both defaulted to true but for another 
piece of HW just being able to control one of them might be sufficient.

Thanks
Angus

> 
>>  Required properties for usb-c-connector with power delivery support:
>>  - source-pdos: An array of u32 with each entry providing supported 
>> power
>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>> index ca7bedb46f7f..7f5d4f209e07 100644
>> --- a/drivers/usb/typec/tcpm.c
>> +++ b/drivers/usb/typec/tcpm.c
>> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port 
>> *port)
>>  {
>>  	int ret;
>> 
>> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
>> -	port->vbus_source = false;
>> -	port->vbus_charge = false;
>> +	ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, 
>> port->vbus_charge);
>>  	return ret;
>>  }
>> 
>> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port 
>> *port,
>>  		return -EINVAL;
>>  	port->port_type = port->typec_caps.type;
>> 
>> +	if (fwnode_property_present(fwnode, "init-vbus-source"))
>> +		port->vbus_source = true;
>> +	else
>> +		port->vbus_source = false;
>> +
>> +	if (fwnode_property_present(fwnode, "init-vbus-charge"))
>> +	        port->vbus_charge = true;
>> +	else
>> +	        port->vbus_charge = false;
>> +
>>  	if (port->port_type == TYPEC_PORT_SNK)
>>  		goto sink;
>> 
>> --
>> 2.17.1
> 
> Thanks,

