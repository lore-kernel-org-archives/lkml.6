Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CBFC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E835206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRyXLARO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E835206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeJAEjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45709 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJAEjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so7731351pfi.12;
        Sun, 30 Sep 2018 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BCtDRbPpWNAbLzuGx/IPRoOEY7DN8dAqkoA1/6COUVc=;
        b=JRyXLAROoBtj+XDaLm4rnM8eVq7ffxiNPbjEE+foFzKHImsteR7tKIcoEu+8xVK+2o
         Vlt37s3JSsVn+1FcQSzxa6tAOBztu6Ge10za0BVpan37hHDRsuSQDZo85lnSxf3fJP3T
         aHhTIJzdTCOIaLTvBCiAna4XHmECNjfcYURO1dY0WlFRjFahrBXZJOaAu0B0C/WF4fti
         rtsELifuahnEoHiZQgNRPEuzmQjj+q0Rhu2Bu2B0Fw1hhVO5IhBCPb0Tz7kwjCqM0x88
         Pa8qH9xghtsbIbrySVZMYq6Jhmq3ZoQvht8+gjPyIc0ttRh5XFg2VsEfJjkwPxu4XJX7
         2xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCtDRbPpWNAbLzuGx/IPRoOEY7DN8dAqkoA1/6COUVc=;
        b=n7bJovnhwLepOIJ4kMQHRZRkYTr2TgtLwUcdYyE19njLpHVNeuGOgu70qNpRzFM5iu
         XMFAPpIhXz85MAP/GxvtniCU6eZjtgm9vtwviSeIaUqGU/YSHNAZAchrOyyViloMuRzz
         FbbNewVG4wPuo/88SSPYDjqmL5n9KerkiChcIcZLE68CWS2FX36A9FTUBCeU+jVkA7Uz
         p78t8bkbuJAP9R+ofBfIrmrrGI85qu2Jj+EjZ5emu2WWeOJ8Dnq70mLeXuO109zyq0sX
         jSk7nqFSHghCoFgAGt0Yqjmz+/7B3E5Uz8w0hW7nB1PMjhuxRNjk01RVhRVn9KtjbsBl
         ms7w==
X-Gm-Message-State: ABuFfoi7DDAnhctwpwlHQltZwtisRIrd2gBhiyyvl+sJnNoWGrlBwJFv
        rog3/pQsE3aDVqMxElZdJOEZ8NDQ
X-Google-Smtp-Source: ACcGV62vK0uc/CznlaqD1e7i6Brg2ByGJb8Fr/bxp/EjPGNQosYnTi0e4aoNfsX4A+7r2rbK1XLHPg==
X-Received: by 2002:a62:e70a:: with SMTP id s10-v6mr8544101pfh.124.1538345106581;
        Sun, 30 Sep 2018 15:05:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g6-v6sm15697956pgg.7.2018.09.30.15.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:05:06 -0700 (PDT)
Subject: Re: [PATCH 3/3] [PATCH v2 3/3] usb: typec: tcpm: charge current
 handling for sink during hard reset
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
 <20180928234703.15970-3-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8cdd5aed-4439-40b3-d258-966542a4b1a5@roeck-us.net>
Date:   Sun, 30 Sep 2018 15:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928234703.15970-3-badhri@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:47 PM, Badhri Jagan Sridharan wrote:
> During the initial connect to a non-pd port, sink would hard reset
> twice before deeming that the port partner is non-pd. TCPM sets the
> the charge path to false during the hard reset. This causes unnecessary
> connects/disconnects of charge path and makes port take longer to
> charge from the non-pd ports. Avoid this by not setting the charge path
> to false unless the partner has already identified to be pd capable.
> 
> When partner is a pd port, set the charge path to false in
> SNK_HARD_RESET_SINK_OFF. Set the current limits to default value based
> of CC pull up and resume the charge path when port enters
> SNK_HARD_RESET_SINK_ON.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> --------
> Changes in V2:
> Based on feedback of jackp@codeaurora.org
> - vsafe_5v_hard_reset flag from tcpc_config is removed
> - Patch only differentiates between pd port partner and non-pd port
> partner
> 
> V1 version of the patch is here:
> https://lkml.org/lkml/2018/9/14/11
> ---
>   drivers/usb/typec/tcpm.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index c3ac0e46106b4..c25a69922ee6a 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -3273,7 +3273,8 @@ static void run_state_machine(struct tcpm_port *port)
>   	case SNK_HARD_RESET_SINK_OFF:
>   		memset(&port->pps_data, 0, sizeof(port->pps_data));
>   		tcpm_set_vconn(port, false);
> -		tcpm_set_charge(port, false);
> +		if (port->pd_capable)
> +			tcpm_set_charge(port, false);
>   		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
>   			       TYPEC_DEVICE);
>   		/*
> @@ -3305,6 +3306,12 @@ static void run_state_machine(struct tcpm_port *port)
>   		 * Similar, dual-mode ports in source mode should transition
>   		 * to PE_SNK_Transition_to_default.
>   		 */
> +		if (port->pd_capable) {
> +			tcpm_set_current_limit(port,
> +					       tcpm_get_current_limit(port),
> +					       5000);
> +			tcpm_set_charge(port, true);
> +		}
>   		tcpm_set_attached_state(port, true);
>   		tcpm_set_state(port, SNK_STARTUP, 0);
>   		break;
> 

