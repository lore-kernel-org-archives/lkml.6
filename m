Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB32ECDFD4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12967217C5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYdCFGbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12967217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeIMWpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:45:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43979 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:45:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so3059572pgb.10;
        Thu, 13 Sep 2018 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uefWUhv7obd3UYC8eLfwJerY+wdGZFxXlv089BpB5zg=;
        b=JYdCFGbCUdeNSasnpHVc5rWoB35d2qAXq9TgnXnwxpE3jDw6TNI5ibVfx7GE42Q26J
         Jkk+Qzo4RPIlQAhkgfq1rhQtUqqWKv3IT8NL454Dxz+7cRe6np1J2AiIVzdGOlLWMg5r
         p55o+IWzz5Z+C7Cg3lNNZ81QLg65qZ8G4mPNTGeM1lELNs969lo7PYtqdObRj/MXROR9
         9bk09wWC3p/ddHjD/A/csxHJhI+XoTqWVUDZBG5aot/po1AFNPwVPBH/00HywBXrRp4A
         bVLa3ODvX7d2s5UN1WczGgHz0cPkDZF03OVbVZcTFbIkGnYUZF0kid+GdwO7NuQB8q6H
         NePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uefWUhv7obd3UYC8eLfwJerY+wdGZFxXlv089BpB5zg=;
        b=Rlt5YvPJWd30+xbEN+tOK1Tb4p9pHzM4ltguXwvyr1EdpQ2jzkkou1USTIHCGUULil
         Hw2MIdK+KE35QeEWUu/nzFs16BKFxVEEPMzzO4N3o5evHrghDpQfwWQM8TjzRrCBYvwN
         s/gy40pjgtVtLNmJVBZYAbxqasr7SNEtEtc4ipZK2weEB976MvXCeEbjuHJaaYnAa7M0
         SpeLEle7LdS0ttoB+aXjpb2B1dZgNyjaz97nMZ7nLGS+4wJnlG/pY1C8TF8Fa3e3pl0D
         xvoJyeVX+kkboKAzmuG+K3BBmmbp5Q6XTEL4d741hH0AiLj8oBSfikHQ45EI0xtDBgVs
         2oFQ==
X-Gm-Message-State: APzg51BSqdu2LLxPfa0JEznxq7dIPL5ebd+1JxmXQuPVYPO2u7baM1id
        GlT42ScKzWZy+KzKOR+szHM=
X-Google-Smtp-Source: ANB0Vda4UnDZ4SjUcF6XjiSoOxXS5/Nk7ZM/3alOfBtkqJe9I+us/FVdcjKTFfwiOukEDF29jEQV+Q==
X-Received: by 2002:a63:9a02:: with SMTP id o2-v6mr6326522pge.440.1536860094048;
        Thu, 13 Sep 2018 10:34:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y86-v6sm6456748pfk.84.2018.09.13.10.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 10:34:53 -0700 (PDT)
Date:   Thu, 13 Sep 2018 10:34:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Peter Chen <hzpeterchen@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        peter.chen@nxp.com, jun.li@nxp.com
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values
 from  the devicetree
Message-ID: <20180913173452.GA10115@roeck-us.net>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
 <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
 <20180912163259.GC3300@roeck-us.net>
 <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
 <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:10:09AM -0600, Angus Ainslie wrote:
> >
> >staging: typec: don't do vbus source disable for dead battery
> >
> >In PTN5110 design, DisableSourceVBUS command also disables the sink
> >enable signal because the EN_SNK can be used to source higher voltage,
> >and, there is only one TCPC command to disable sourcing voltage without
> >telling whether to disable 5V or the high voltage, and to keep the
> >design simple they designed the PTN5110 to disable both. with this
> >fact, we use the flag drive_vbus to check if the source vbus enable was
> >issued, if yes we then do vbus source disable, in dead battery case,
> >we never did vbus source enable, so will not issue vbus source disable
> >command.
> >
> 
> Thanks Peter, this sounds like the missing piece of information and I think
> some form of the code below will fix that.
> 
> There is still the issue that my board will need some way of controlling the
> initial state of vbus-sink.
> 
> @Guenter: would my initial patch be acceptable to set the default state of
> vbus-source and vbus-sink. Would you like some code to sanity check that
> both were not enabled at the same time ?
> 
Seems to me this is indeed a chip specific problem. I don't think a fix belongs
into the tcpm code. As mentioned before, the current status (ie drive_vbus)
should be readable from the chip. I am not sure though if we should add a
PTN5110 specific quirk to the driver to handle the situation. I am concerned
that fixing this as suggested below for PTN5110 may cause trouble with other
chips. Maybe not, but I'd rather be cautious.

Thanks,
Guenter

> >Acked-by: Peter Chen <peter.chen@nxp.com>
> >Signed-off-by: Li Jun <jun.li@nxp.com>
> >---
> > drivers/staging/typec/tcpci.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
> >index 2d4fbb8aac5e..7352207224b5 100644
> >--- a/drivers/staging/typec/tcpci.c
> >+++ b/drivers/staging/typec/tcpci.c
> >@@ -381,9 +381,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc,
> >bool source, bool sink)
> >  struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> >  int ret;
> >
> >- /* Disable both source and sink first before enabling anything */
> >-
> >- if (!source) {
> >+ /* Only disable source if it was enabled */
> >+ if (!source && tcpci->drive_vbus) {
> >  ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
> >     TCPC_CMD_DISABLE_SRC_VBUS);
> >  if (ret < 0)
> 
> The version of struct tcpci doesn't have a drive_vbus. Where should
> drive_vbus get set and cleared ?
> 
> Is this a more complete version of what you intended ?
> 
> diff --git a/drivers/usb/typec/tcpci.c b/drivers/usb/typec/tcpci.c
> index ac6b418b15f1..d6168163df7b 100644
> --- a/drivers/usb/typec/tcpci.c
> +++ b/drivers/usb/typec/tcpci.c
> @@ -28,6 +28,7 @@ struct tcpci {
>         struct regmap *regmap;
> 
>         bool controls_vbus;
> +       bool drive_vbus;
> 
>         struct tcpc_dev tcpc;
>         struct tcpci_data *data;
> @@ -277,7 +278,9 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool
> source, bool sink)
> 
>         /* Disable both source and sink first before enabling anything */
> 
> -       if (!source) {
> +       if (!source && tcpci->drive_vbus) {
> +               tcpci->drive_vbus = false;
> +
>                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
>                                    TCPC_CMD_DISABLE_SRC_VBUS);
>                 if (ret < 0)
> @@ -292,6 +295,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool
> source, bool sink)
>         }
> 
>         if (source) {
> +               tcpci->drive_vbus = true;
> +
>                 ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
>                                    TCPC_CMD_SRC_VBUS_DEFAULT);
>                 if (ret < 0)
> @@ -503,6 +508,7 @@ struct tcpci *tcpci_register_port(struct device *dev,
> struct tcpci_data *data)
>         tcpci->dev = dev;
>         tcpci->data = data;
>         tcpci->regmap = data->regmap;
> +       tcpci->drive_vbus = false;
> 
>         tcpci->tcpc.init = tcpci_init;
>         tcpci->tcpc.get_vbus = tcpci_get_vbus;
> 
> 
> 
