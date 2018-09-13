Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1EE2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="okIJ/38a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1EE2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIMQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:19:08 -0400
Received: from node.akkea.ca ([192.155.83.177]:40816 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMQTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:19:08 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 17E6B5420DB; Thu, 13 Sep 2018 11:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536837009; bh=gm0OX3swPHt663J0ZMffXaVOJm5IcXi33i56xsjPpsU=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=okIJ/38aB5EHpZM8UPZc1qeqLCtdnZaz903qqLBoUZl5wUveBnXgB75l0AWRNvNQh
         zWy0Ey2VOtMZK7X5Yw0+pEKZi0irXGZQWDDwPHH7TmREK0vGBFaDKHieQhESCdBscu
         /XxUsXlv8ZPAZrkQdFMQx0FiNVEwb1aQnwNIZ0W4=
To:     Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values from  the devicetree
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 13 Sep 2018 05:10:09 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     linux@roeck-us.net,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        peter.chen@nxp.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
 <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
 <20180912163259.GC3300@roeck-us.net>
 <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
Message-ID: <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-13 01:27, Peter Chen wrote:
> On Thu, Sep 13, 2018 at 12:35 AM Guenter Roeck <linux@roeck-us.net> 
> wrote:
>> 
>> On Wed, Sep 12, 2018 at 10:08:58AM -0600, Angus Ainslie wrote:
>> > On 2018-09-11 09:33, Guenter Roeck wrote:
>> > >I cant put my finger on it but this seems wrong. As i said both src
>> > >and sink should never be true at the same time. I also din’t
>> > >understand why turning off src should power off your board. Ultimately
>> > >my concern is that we may be just painting over the real problem, and
>> > >that would be really bad to do with dt properties.
>> > >
>> >
>> > I agree that this doesn't seem like the correct way of solving the problem.
>> > On this HW (Emcraft iMX8M BSB) I think the PTN5110 chip has been connected
>> > correctly so I'm assuming that it is some quirk of the PTN5110.
>> >
>> > I didn't design the HW or the chip. This is a workaround for "quirky"
>> > hardware and there may be others that don't behave exactly as expected.
>> >
>> 
>> I wouldn't be that sure about that. It may as well be that the tcpc 
>> driver
>> and/or the tcpm driver are doing something wrong when initializing.
>> 
>> I didn't really understand the logs you sent out earlier. It looked 
>> like
>> the system would loose power if the TCPC_CMD_DISABLE_SRC_VBUS command 
>> is
>> sent.  That doesn't really make sense to me since it indicates that 
>> the
>> chip sources power to the remote, and turning that off should not 
>> result
>> in a local loss of power.
>> 
>> Note that the chip is supposed to be able to report if it is sourcing 
>> vbus
>> and if VBUS is present, in the POWER_STATUS register. Another question 
>> is
>> the content of the ROLE_CONTROL register when the system boots, and 
>> the
>> DEVICE_CAPABILITIES settings.
>> 
>> Overall I suspect that we don't handle startup for your system 
>> correctly
>> in the tcpc driver. The ideal solution would be to find a solution 
>> which
>> does not require any devicetree properties, but to do that we'll need
>> to get a better understanding about your system's requirements.
>> 
>> Guenter
> 
> Hi Angus,
> 
> Would you please check if below patch can fix your issue?
> 
> staging: typec: don't do vbus source disable for dead battery
> 
> In PTN5110 design, DisableSourceVBUS command also disables the sink
> enable signal because the EN_SNK can be used to source higher voltage,
> and, there is only one TCPC command to disable sourcing voltage without
> telling whether to disable 5V or the high voltage, and to keep the
> design simple they designed the PTN5110 to disable both. with this
> fact, we use the flag drive_vbus to check if the source vbus enable was
> issued, if yes we then do vbus source disable, in dead battery case,
> we never did vbus source enable, so will not issue vbus source disable
> command.
> 

Thanks Peter, this sounds like the missing piece of information and I 
think some form of the code below will fix that.

There is still the issue that my board will need some way of controlling 
the initial state of vbus-sink.

@Guenter: would my initial patch be acceptable to set the default state 
of vbus-source and vbus-sink. Would you like some code to sanity check 
that both were not enabled at the same time ?

> Acked-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
>  drivers/staging/typec/tcpci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/typec/tcpci.c 
> b/drivers/staging/typec/tcpci.c
> index 2d4fbb8aac5e..7352207224b5 100644
> --- a/drivers/staging/typec/tcpci.c
> +++ b/drivers/staging/typec/tcpci.c
> @@ -381,9 +381,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc,
> bool source, bool sink)
>   struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>   int ret;
> 
> - /* Disable both source and sink first before enabling anything */
> -
> - if (!source) {
> + /* Only disable source if it was enabled */
> + if (!source && tcpci->drive_vbus) {
>   ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
>      TCPC_CMD_DISABLE_SRC_VBUS);
>   if (ret < 0)

The version of struct tcpci doesn't have a drive_vbus. Where should 
drive_vbus get set and cleared ?

Is this a more complete version of what you intended ?

diff --git a/drivers/usb/typec/tcpci.c b/drivers/usb/typec/tcpci.c
index ac6b418b15f1..d6168163df7b 100644
--- a/drivers/usb/typec/tcpci.c
+++ b/drivers/usb/typec/tcpci.c
@@ -28,6 +28,7 @@ struct tcpci {
         struct regmap *regmap;

         bool controls_vbus;
+       bool drive_vbus;

         struct tcpc_dev tcpc;
         struct tcpci_data *data;
@@ -277,7 +278,9 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, 
bool source, bool sink)

         /* Disable both source and sink first before enabling anything 
*/

-       if (!source) {
+       if (!source && tcpci->drive_vbus) {
+               tcpci->drive_vbus = false;
+
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_DISABLE_SRC_VBUS);
                 if (ret < 0)
@@ -292,6 +295,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, 
bool source, bool sink)
         }

         if (source) {
+               tcpci->drive_vbus = true;
+
                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
                                    TCPC_CMD_SRC_VBUS_DEFAULT);
                 if (ret < 0)
@@ -503,6 +508,7 @@ struct tcpci *tcpci_register_port(struct device 
*dev, struct tcpci_data *data)
         tcpci->dev = dev;
         tcpci->data = data;
         tcpci->regmap = data->regmap;
+       tcpci->drive_vbus = false;

         tcpci->tcpc.init = tcpci_init;
         tcpci->tcpc.get_vbus = tcpci_get_vbus;



