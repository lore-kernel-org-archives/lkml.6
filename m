Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE19C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCD206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBCD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeJAQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:30:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:18648 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729076AbeJAQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:30:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="94962764"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2018 02:53:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Oct 2018 12:53:54 +0300
Date:   Mon, 1 Oct 2018 12:53:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] [PATCH v2 2/3] usb: typec: tcpm: Do not disconnect
 link for self powered devices
Message-ID: <20181001095354.GB15780@kuha.fi.intel.com>
References: <20180928234703.15970-1-badhri@google.com>
 <20180928234703.15970-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928234703.15970-2-badhri@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:47:02PM -0700, Badhri Jagan Sridharan wrote:
> During HARD_RESET the data link is disconnected.
> For self powered device, the spec is advising against doing that.
> 
> >From USB_PD_R3_0
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

Could you rebase these on top of the latest usb-next. These are not
going to apply cleanly on top of it because tcpm.c and all port
drivers are now in their own directory drivers/usb/typec/tcpm/.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---------
> Version history:
> 
> V2:
> Based on feedback from heikki.krogerus@linux.intel.com
> - self_powered added to the struct tcpm_port which is populated from
>   a. "connector" node of the device tree in tcpm_fw_get_caps()
>   b. "self_powered" node of the tcpc_config in tcpm_copy_caps
> 
> Based on feedbase from linux@roeck-us.net
> - Code was refactored
> - SRC_HARD_RESET_VBUS_OFF sets the link state to false based
>   on self_powered flag
> 
> V1 located here:
> https://lkml.org/lkml/2018/9/13/94
> ---
>  drivers/usb/typec/tcpm.c | 12 ++++++++++--
>  include/linux/usb/tcpm.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 4f1f4215f3d6e..c3ac0e46106b4 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -317,6 +317,9 @@ struct tcpm_port {
>  	/* Deadline in jiffies to exit src_try_wait state */
>  	unsigned long max_wait;
>  
> +	/* port belongs to a self powered device */
> +	bool self_powered;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -3257,7 +3260,8 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SRC_HARD_RESET_VBUS_OFF:
>  		tcpm_set_vconn(port, true);
>  		tcpm_set_vbus(port, false);
> -		tcpm_set_roles(port, false, TYPEC_SOURCE, TYPEC_HOST);
> +		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
> +			       TYPEC_HOST);
>  		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>  		break;
>  	case SRC_HARD_RESET_VBUS_ON:
> @@ -3270,7 +3274,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
>  		tcpm_set_charge(port, false);
> -		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> +		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
> +			       TYPEC_DEVICE);
>  		/*
>  		 * VBUS may or may not toggle, depending on the adapter.
>  		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> @@ -4409,6 +4414,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		return -EINVAL;
>  	port->operating_snk_mw = mw / 1000;
>  
> +	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> +
>  	return 0;
>  }
>  
> @@ -4717,6 +4724,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
>  	port->typec_caps.prefer_role = tcfg->default_role;
>  	port->typec_caps.type = tcfg->type;
>  	port->typec_caps.data = tcfg->data;
> +	port->self_powered = port->tcpc->config->self_powered;
>  
>  	return 0;
>  }
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 7e7fbfb84e8e3..50c74a77db55c 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -89,6 +89,7 @@ struct tcpc_config {
>  	enum typec_port_data data;
>  	enum typec_role default_role;
>  	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
> +	bool self_powered;	/* port belongs to a self powered device */
>  
>  	const struct typec_altmode_desc *alt_modes;
>  };

Thanks,

-- 
heikki
