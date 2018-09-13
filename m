Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312DE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUFo9Oiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312DE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIMXBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:01:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42523 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeIMXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:01:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so3084961pgp.9;
        Thu, 13 Sep 2018 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=90po67prlVphdK5eSerWZXN2rX1xSrjDLjGgaGYfCcE=;
        b=HUFo9OiqVmXrEQazo9QOzQ0Uyen9PlMUsUzgJUJe8KFN4zaoswhg2GwMfh5g8UMbNN
         MrjO6ZorMiup5d+3VUDdIGpUUb2AiTMjDkxOTXbhJshyFam1jb+M28D7FNDUspXwzT05
         ONmtQHVDdzHo7w4XU4ND9hI1VNUSPYmGXY5uKSjeTnp7go6pI2sTJb/Jps+gFAQQ+xvJ
         9uVF0pwTH9/WZV+eBPOzJxZoL2ml9M1RLHT4G4r/BkqrjE1IerW0lGMbygG5v8sTUOrI
         0Dg+BWLQQEwwyVqOPSCX0kxzS32EF/CyIVpbbfPJKLDxTmNCvsVHt085JN0XZekQSsxr
         J+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=90po67prlVphdK5eSerWZXN2rX1xSrjDLjGgaGYfCcE=;
        b=mqttcsk6wIEWvfn1tR8MCoL5ZTAXT4Tmt3SkdA4McmNt4/fIxuC1n+dSapP+XSMJUd
         ZM8FQbPykTGc0XkWJr5OU0RPN9fFnsD0bjZiVZE0rNrOeTzJ3OZWL1pTIBZH6Rsj33h0
         cfhz6HN5nujLkTjiT5kNEHWMcV/zL4U8Lm42gx4x0tzKVOfvlon7ymrQ2uktNHQFgvzL
         82YZBvdRe4irzghiX6YKxHa7vh5jcldff3PL+zDtAcUZ5UcI56Xg2nR+xnNbmc1RS/st
         NF6UtXx583MUnYr6E2sO1qrt9xP2fZ4lwyBtvRx8R1MXvPdIpY8/uwS/K9DOd6tDyT8/
         eLEw==
X-Gm-Message-State: APzg51A9I1R/BSvJxcJ/wso/xkW7qCBsiiSomMlF/ClRkPgJtHz2owUO
        mwwIC7h9CXdBT3Kk4/5BmCfFhPI9
X-Google-Smtp-Source: ANB0VdaBVaNXhLevEHOfDqea1bp9QSw4LvGye3fP3P+wNwD34OxulQVKsJiQOXEvoTle3UIehLsaNg==
X-Received: by 2002:a62:9f4c:: with SMTP id g73-v6mr8512126pfe.142.1536861070522;
        Thu, 13 Sep 2018 10:51:10 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 82-v6sm6110565pfw.159.2018.09.13.10.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 10:51:09 -0700 (PDT)
Date:   Thu, 13 Sep 2018 10:51:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] typec: tcpm: Do not disconnect link for self powered
 devices
Message-ID: <20180913175108.GA11749@roeck-us.net>
References: <20180913021113.18150-1-badhri@google.com>
 <20180913132408.GC19329@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913132408.GC19329@kuha.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:24:08PM +0300, Heikki Krogerus wrote:
> +Guenter
> 
> On Wed, Sep 12, 2018 at 07:11:12PM -0700, Badhri Jagan Sridharan wrote:
> > During HARD_RESET the data link is disconnected.
> > For self powered device, the spec is advising against doing that.
> > 
> > >From USB_PD_R3_0
> > 7.1.5 Response to Hard Resets
> > Device operation during and after a Hard Reset is defined as follows:
> > Self-powered devices Should Not disconnect from USB during a Hard Reset
> > (see Section 9.1.2).
> > Bus powered devices will disconnect from USB during a Hard Reset due to the
> > loss of their power source.
> > 
> > Tackle this by letting TCPM know whether the device is self or bus powered.
> > 
> > This overcomes unnecessary port disconnections from hard reset.
> > Also, speeds up the enumeration time when connected to Type-A ports.
> > 
> > Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm.c | 6 +++++-
> >  include/linux/usb/tcpm.h | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index 4f1f4215f3d6..a4e0c027a2a9 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -3270,7 +3270,11 @@ static void run_state_machine(struct tcpm_port *port)
> >  		memset(&port->pps_data, 0, sizeof(port->pps_data));
> >  		tcpm_set_vconn(port, false);
> >  		tcpm_set_charge(port, false);
> > -		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> > +
> > +		if (port->tcpc->config->self_powered)
> 
> Add a member for that flag to the struct tcpm_port, and check that
> here instead. I'll explain why below.
> 
> > +			tcpm_set_roles(port, true, TYPEC_SINK, TYPEC_DEVICE);
> > +		else
> > +			tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> > 

Maybe I am missing something, but
		tcpm_set_roles(port, port->self_powered,
			       TYPEC_SINK, TYPEC_DEVICE);
should accomplish the same (assuming the flag is moved to tcpm_port).

Does the code at SRC_HARD_RESET_VBUS_OFF: also have to be changed,
or only SNK_HARD_RESET_SINK_OFF: ? In other words, does this only
apply if the port is a sink, or also if is is source ?

Guenter

> >  		/*
> >  		 * VBUS may or may not toggle, depending on the adapter.
> >  		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index 7e7fbfb84e8e..50c74a77db55 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -89,6 +89,7 @@ struct tcpc_config {
> >  	enum typec_port_data data;
> >  	enum typec_role default_role;
> >  	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
> > +	bool self_powered;	/* port belongs to a self powered device */
> 
> I'm not sure we should add any more members to that structure, but
> maybe it's not a problem for now. We can't quite yet get rid of that
> structure.
> 
> You do need to introduce a new device property already. Then read the
> value for that new member you added to struct tcpm_port in
> tcpm_fw_get_caps() and in tcpm_copy_caps().
> 
> 
> Thanks,
> 
> -- 
> heikki
