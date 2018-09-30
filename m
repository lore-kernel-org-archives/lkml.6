Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A7C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F4F206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbcWU27V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F4F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeJAEjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34665 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeJAEjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so7773085pfi.1;
        Sun, 30 Sep 2018 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRM1OXrPkFsI1cKWtC5pGl//a2XVd1QcAQfa2Bmgt6Q=;
        b=tbcWU27VY1XoVHvTg4lSpepeF/6ReBzORBwVL+EG9DYYVRib9wZQq7s70qQn+pQjtk
         ss+Pyz961YAo3fqWvCFaHTYjFwcIUbeUdjUSeAnlDijjeRb1I2X02IxEe4l8wj0K47lW
         kwiA0klcsmzMPlPDE3helQ5tnTdh3nR/EJ2E51lg1cvhc5rQE/XDRgMOWwYCA3Na2Skr
         mg0VQNE7EHOv1+bXqxzf+VfOUycQ8x9ckxcaq5wjSZOheMlEqwd+mUbCkt967QgWrOCA
         XrdGHUX9MylbrSoe7Fgb7TMRndvmKWDjDGsaz/vQSgWEsrvbcbx3eIfke1dbbT91UTzF
         i7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRM1OXrPkFsI1cKWtC5pGl//a2XVd1QcAQfa2Bmgt6Q=;
        b=HL1vZ85YTP40JHTqIaWpNsYt1UejCoG79rgbJaQKWYp4rQau877oh2/y1XESA8JOgs
         NYDiC8SzLoVgOSNEwRGyCD/sSgnej72dKzSAGhd1Hj9yMPa9Erh2wUebcuhU/HnzFO4O
         rdm3JSJvOyUMsfue/KAaS2CFNU6n+8YdEz54nAmncebOPNv1hyWdpIw/EjDcaE8wPVDu
         PnGDUvkKCCPrh6Axge+DjDlPKadWjy+3YpJNDvglfbelklZHO/YsAZBpfF4NR5gpWc44
         GQ7RNqGh742aFZaqOcEj/hB0gY3RAXmVabjz7JxgpWiECycq7TojCB1Cz7vh2H7XY6yV
         V0kw==
X-Gm-Message-State: ABuFfojUqCemHz7ldNw5UPhaR6WxggB6BrfGKR2GW9BOx+MC5W7nc17U
        JFnGWZgLbxpx6BTKuJrBlagY4lPr
X-Google-Smtp-Source: ACcGV631IOt5QGDrQ/daOkaG8nbw+a5hLwON9Xiicd/Qmi+orefbA3/EXaxHiIrk4hPIE6k2n5Gf6w==
X-Received: by 2002:a17:902:6a:: with SMTP id 97-v6mr8560769pla.276.1538345080287;
        Sun, 30 Sep 2018 15:04:40 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r1-v6sm13987108pff.145.2018.09.30.15.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:04:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] [PATCH v2 2/3] usb: typec: tcpm: Do not disconnect
 link for self powered devices
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180928234703.15970-1-badhri@google.com>
 <20180928234703.15970-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b9c66b15-7af3-a987-1299-dded17b5683e@roeck-us.net>
Date:   Sun, 30 Sep 2018 15:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928234703.15970-2-badhri@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:47 PM, Badhri Jagan Sridharan wrote:
> During HARD_RESET the data link is disconnected.
> For self powered device, the spec is advising against doing that.
> 
>>From USB_PD_R3_0
> 7.1.5 Response to Hard Resets
> Device operation during and after a Hard Reset is defined as follows:
> Self-powered devices Should Not disconnect from USB during a Hard Reset
> (see Section 9.1.2).
> Bus powered devices will disconnect from USB during a Hard Reset due to the
> loss of their power source.
> 
> Tackle this by letting TCPM know whether the device is self or bus powered.
> 
> This overcomes unnecessary port disconnections from hard reset.
> Also, speeds up the enumeration time when connected to Type-A ports.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---------
> Version history:
> 
> V2:
> Based on feedback from heikki.krogerus@linux.intel.com
> - self_powered added to the struct tcpm_port which is populated from
>    a. "connector" node of the device tree in tcpm_fw_get_caps()
>    b. "self_powered" node of the tcpc_config in tcpm_copy_caps
> 
> Based on feedbase from linux@roeck-us.net
> - Code was refactored
> - SRC_HARD_RESET_VBUS_OFF sets the link state to false based
>    on self_powered flag
> 
> V1 located here:
> https://lkml.org/lkml/2018/9/13/94
> ---
>   drivers/usb/typec/tcpm.c | 12 ++++++++++--
>   include/linux/usb/tcpm.h |  1 +
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 4f1f4215f3d6e..c3ac0e46106b4 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -317,6 +317,9 @@ struct tcpm_port {
>   	/* Deadline in jiffies to exit src_try_wait state */
>   	unsigned long max_wait;
>   
> +	/* port belongs to a self powered device */
> +	bool self_powered;
> +
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *dentry;
>   	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -3257,7 +3260,8 @@ static void run_state_machine(struct tcpm_port *port)
>   	case SRC_HARD_RESET_VBUS_OFF:
>   		tcpm_set_vconn(port, true);
>   		tcpm_set_vbus(port, false);
> -		tcpm_set_roles(port, false, TYPEC_SOURCE, TYPEC_HOST);
> +		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
> +			       TYPEC_HOST);
>   		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>   		break;
>   	case SRC_HARD_RESET_VBUS_ON:
> @@ -3270,7 +3274,8 @@ static void run_state_machine(struct tcpm_port *port)
>   		memset(&port->pps_data, 0, sizeof(port->pps_data));
>   		tcpm_set_vconn(port, false);
>   		tcpm_set_charge(port, false);
> -		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> +		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
> +			       TYPEC_DEVICE);
>   		/*
>   		 * VBUS may or may not toggle, depending on the adapter.
>   		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> @@ -4409,6 +4414,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return -EINVAL;
>   	port->operating_snk_mw = mw / 1000;
>   
> +	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> +
>   	return 0;
>   }
>   
> @@ -4717,6 +4724,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
>   	port->typec_caps.prefer_role = tcfg->default_role;
>   	port->typec_caps.type = tcfg->type;
>   	port->typec_caps.data = tcfg->data;
> +	port->self_powered = port->tcpc->config->self_powered;
>   
>   	return 0;
>   }
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 7e7fbfb84e8e3..50c74a77db55c 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -89,6 +89,7 @@ struct tcpc_config {
>   	enum typec_port_data data;
>   	enum typec_role default_role;
>   	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
> +	bool self_powered;	/* port belongs to a self powered device */
>   
>   	const struct typec_altmode_desc *alt_modes;
>   };
> 

