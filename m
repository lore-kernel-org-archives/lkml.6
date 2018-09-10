Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24528C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFAD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ifLzgl4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFAD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIJT1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:27:11 -0400
Received: from node.akkea.ca ([192.155.83.177]:46892 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbeIJT1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:27:11 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 92AE45420DB; Mon, 10 Sep 2018 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536589968; bh=ePVdCf8fJ7tl+04eXbHTTaTqDqoclnIkhGZX6/WiIJ0=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=ifLzgl4e7285XBMTylDfHJpj5gKUn3+j2/N+0mCZven0WEtuTkMOEIbEBrmphSk41
         cmDpW6j3InxwOy2JTx3g29vFwW66qzITfgZC/7HeRqgCwJFX1VeqfmB4nEw9ycVZZy
         RutuajrMuZ2seRu6o4rQN0UBH3F2cDbxeKeFoxC4=
To:     Guenter Roeck <guenter@roeck-us.net>
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values from  the devicetree
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Sep 2018 08:32:48 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        groeck7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cf237e3a-30fb-a98d-ba2b-cf5485bdb5f6@roeck-us.net>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
 <20180910073529.GL25121@kuha.fi.intel.com>
 <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
 <cf237e3a-30fb-a98d-ba2b-cf5485bdb5f6@roeck-us.net>
Message-ID: <98e0f35924b3c1e9ce0f5fff602cdc01@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-10 07:43, Guenter Roeck wrote:
> On 09/10/2018 06:11 AM, Angus Ainslie wrote:
>> Hi Heikki
>> 
>> On 2018-09-10 01:35, Heikki Krogerus wrote:
>>> On Sun, Sep 09, 2018 at 12:05:31PM -0600, Angus Ainslie (Purism) 
>>> wrote:
>>>> If the board is being powered by USB disabling the source and sink
>>>> can remove power from the board. Allow the source and sink to be
>>>> initallized based on devicetree values.
>>>> 
>>>> Changed since V1:
>>>> 
>>>> use devicetree values instead of hardcoded initialization.
>>>> 
>>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>>> ---
>>>>  .../bindings/connector/usb-connector.txt           |  4 ++++
>>>>  drivers/usb/typec/tcpm.c                           | 14 
>>>> +++++++++++---
>>>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/connector/usb-connector.txt 
>>>> b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> index 8855bfcfd778..afe851a713c3 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> @@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
>>>>    or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
>>>>  - data-role: should be one of "host", "device", "dual"(DRD) if 
>>>> typec
>>>>    connector supports USB data.
>>>> +- init-vbus-source: set the initalization value for vbus-source to 
>>>> true.
>>>> +  If this property is not present the initial value will be false.
>>>> +- init-vbus-charge: set the initalization value for vbus-charge to 
>>>> true.
>>>> +  If this property is not present the initial value will be false.
>>> 
>>> If you put the description of those properties here, you are going to
>>> need to rename them. Those describe tcpm specific properties, but to
>>> that file you want to put descriptions of generic properties.
>>> 
>> 
>> They are tcpm specific but need to go into the connector sub-node to 
>> get parsed correctly. Would something like below be better ?
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt 
>> b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> index 0dd1469e7318..ae0a3e97d9b6 100644
>> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
>> @@ -15,6 +15,12 @@ Required sub-node:
>>    of connector node are specified in
>>    Documentation/devicetree/bindings/connector/usb-connector.txt
>> 
>> +Optional properties for usb-c-connector sub-node:
>> +- init-vbus-source: set the initalization value for vbus-source to 
>> true.
>> +  If this property is not present the initial value will be false.
>> +- init-vbus-charge: set the initalization value for vbus-charge to 
>> true.
>> +  If this property is not present the initial value will be false.
>> +
>>  Example:
>> 
>>  ptn5110@50 {
>> 
>> 
>>> Your problem is that you can not cope with a lose of VBUS as a sink,
>>> right? For that you just need one boolean device property IMO.
>>> Something like depend-on-vbus.
>> 
>> I thought that it would better to be able to control each 
>> independently. With my specific hardware I need both defaulted to true 
>> but for another piece of HW just being able to control one of them 
>> might be sufficient.
>> 
> 
> Turns out the problem goes deeper: Only one of the two values is 
> supposed to
> be true at any given time. The system is either a sink 
> (vbus_charge=true)
> or a source (vbus_src=true), but it can not be both.
> 

I agree but my hardware is being obstinant.

> I think we first need to figure out what actually happens in your 
> system; the
> result from setting both values to true is that the initial request to 
> set vbus
> (either as source or as sink) should fail, unless the value is actually 
> cleared
> and the other value (supposed to be untouched) is set. This does not 
> make
> sense and warrants further debugging. Can you do that and let us know 
> what
> exactly actually happens and why your hardware needs that request to 
> fail ?
> 

Neither call fails at the software level.

[    3.762504] (NULL device *): tcpci drivers/usb/typec/tcpci.c 
tcpci_register_port 557
[    3.830968] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_parse_config 534
[    3.849299] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c tcpci_init 
400
[    3.872283] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_set_pd_rx 265
[    3.879952] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_set_vbus 297 source 1 sink 1
[    3.879957] tcpci 0-0052: tcpci set source drivers/usb/typec/tcpci.c 
tcpci_set_vbus 327
[    3.916407] tcpci 0-0052: tcpci set sink drivers/usb/typec/tcpci.c 
tcpci_set_vbus 340

When the source gets disabled is when the board loses power.

[    3.762504] (NULL device *): tcpci drivers/usb/typec/tcpci.c 
tcpci_register_port 557
[    3.770603] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_parse_config 534
[    3.789508] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c tcpci_init 
400
[    3.799676] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_set_pd_rx 265
[    3.809322] tcpci 0-0052: tcpci drivers/usb/typec/tcpci.c 
tcpci_set_vbus 297 source 0 sink 1
[    3.817956] tcpci 0-0052: tcpci disable source 
drivers/usb/typec/tcpci.c tcpci_set_vbus 302
< board stops booting here>

I've added these prints for debugging

@@ -275,36 +293,64 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, 
bool source, bool sink)
         struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
         int ret;

-       /* Disable both source and sink first before enabling anything 
*/
+       dev_err(tcpci->dev, "tcpci %s %s %d source %d sink %d\n" , 
__FILE__,
+               __func__, __LINE__, source, sink );

+       /* Disable both source and sink first before enabling anything 
*/
         if (!source) {
+               dev_err(tcpci->dev, "tcpci disable source %s %s %d\n" , 
__FILE__,
+                       __func__, __LINE__ );
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_DISABLE_SRC_VBUS);
-               if (ret < 0)
+               if (ret < 0) {
+                       dev_err(tcpci->dev, "tcpci disable source failed 
%s %s %d\n" , __FILE__,
+                               __func__, __LINE__ );
                         return ret;
+               }
         }

         if (!sink) {
+               dev_err(tcpci->dev, "tcpci disable sink %s %s %d\n" , 
__FILE__,
+                       __func__, __LINE__ );
+
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_DISABLE_SINK_VBUS);
-               if (ret < 0)
+               if (ret < 0) {
+                       dev_err(tcpci->dev, "tcpci disable sink failed 
%s %s %d\n" , __FILE__,
+                               __func__, __LINE__ );
                         return ret;
+               }
         }

         if (source) {
+               dev_err(tcpci->dev, "tcpci set source %s %s %d\n" , 
__FILE__,
+                       __func__, __LINE__ );
+
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_SRC_VBUS_DEFAULT);
-               if (ret < 0)
+               if (ret < 0) {
+                       dev_err(tcpci->dev, "tcpci enable source failed 
%s %s %d\n" , __FILE__,
+                               __func__, __LINE__ );
                         return ret;
+               }
         }

         if (sink) {
+               dev_err(tcpci->dev, "tcpci set sink %s %s %d\n" , 
__FILE__,
+                       __func__, __LINE__ );
+
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_SINK_VBUS);
-               if (ret < 0)
+               if (ret < 0) {
+                       dev_err(tcpci->dev, "tcpci enable sink failed %s 
%s %d\n" , __FILE__,
+                               __func__, __LINE__ );
                         return ret;
+               }
         }

+       dev_err(tcpci->dev, "tcpci %s %s %d source %d sink %d\n" , 
__FILE__,
+               __func__, __LINE__, source, sink );
+
         return 0;
  }


> Thanks,
> Guenter
> 
>> Thanks
>> Angus
>> 
>>> 
>>>>  Required properties for usb-c-connector with power delivery 
>>>> support:
>>>>  - source-pdos: An array of u32 with each entry providing supported 
>>>> power
>>>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>>>> index ca7bedb46f7f..7f5d4f209e07 100644
>>>> --- a/drivers/usb/typec/tcpm.c
>>>> +++ b/drivers/usb/typec/tcpm.c
>>>> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port 
>>>> *port)
>>>>  {
>>>>      int ret;
>>>> 
>>>> -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>>>> -    port->vbus_source = false;
>>>> -    port->vbus_charge = false;
>>>> +    ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, 
>>>> port->vbus_charge);
>>>>      return ret;
>>>>  }
>>>> 
>>>> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port 
>>>> *port,
>>>>          return -EINVAL;
>>>>      port->port_type = port->typec_caps.type;
>>>> 
>>>> +    if (fwnode_property_present(fwnode, "init-vbus-source"))
>>>> +        port->vbus_source = true;
>>>> +    else
>>>> +        port->vbus_source = false;
>>>> +
>>>> +    if (fwnode_property_present(fwnode, "init-vbus-charge"))
>>>> +            port->vbus_charge = true;
>>>> +    else
>>>> +            port->vbus_charge = false;
>>>> +
>>>>      if (port->port_type == TYPEC_PORT_SNK)
>>>>          goto sink;
>>>> 
>>>> -- 2.17.1
>>> 
>>> Thanks,
>> 
>> 

