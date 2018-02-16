Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AH8x226qTh3tuF0M0Is2i92SNYCU/k4RZsyvUPy/DIOwwSYvljy9/24c43bR3ObhkKlT48DphMdf
ARC-Seal: i=1; a=rsa-sha256; t=1518787190; cv=none;
        d=google.com; s=arc-20160816;
        b=Ver7LDlzChTCM4W+b9ZETQtYHTdgg7wJtVaTKMA0NfVj4WslSbaAFK7fHbcYgfi55Z
         ffhp3YPPoiz0OhjaEwzgJxSsMLS2OdUvX9cVPn7JJjFIOj8yTOMqayNtvG6opCsI2bRC
         V7PB0nwHddbmrj6/YL3RMmtMC73BfQdGqGxu5t7sbkFZanlp7u8fb5tKds+9h/j1TYrM
         xtUcFBRICfp5a8YrL0r3Lam32GNfa51NIHHQ1SSYRVvzOw27+STpgDzfveGnuhC98VLI
         w/mvzY24YhGU+Z2S11IpBvI7A4f665nPzVUMSMBfR21VR/TkTxuOCgMeMAAOqmoO+ZYc
         wAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=epJoRIpeQaRfOV0Ls0E0VdRl9PRoL+Sz36ZKmXreNfg=;
        b=GIa1m6xcTl0+WxPabFSJ+RyW7D0qSDASikRbxK8+Zympq+OwWw6yjWwYqx5LzRB0A6
         YrE3gGfxXOBHvB41SsOB5ieh6CrdNWWh63pGirdjYyTbZTpjBChIzXnWdhw/yyLwYYhG
         kI9VePO7PR5PwxkWzDz7AJLUjxTuMpOgj3ELViBRIoe+yjh+xoQOFxF1eTe1HG4yRl1n
         aI8Ia4gvgmfMFFFdcllldrvS/5slih4tKf9ed4IGHJ7pIa3GNbhyV21+2UXEzpex5ilY
         XqKRxx28ot9glzgxC0RxgAbmKx0QZxT6SpyPGT+aSViuIW/akFcMpW+z1SeQ48irOE1m
         ENZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31363781"
Date: Fri, 16 Feb 2018 15:19:45 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/12] usb: typec: tcpm: Set USB role switch to device
 mode when configured as such
Message-ID: <20180216131945.GK1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-6-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554247058605060?=
X-GMAIL-MSGID: =?utf-8?q?1592563797288279095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:44AM +0100, Hans de Goede wrote:
> Setting the mux to MUX_NONE and the switch to USB_SWITCH_DISCONNECT when
> the data-role is device is not correct. Plenty of devices support
> operating as USB device through a (separate) USB device controller.
> 
> We really need 2 different versions of USB_SWITCH_CONNECT,
> USB_SWITCH_CONNECT_HOST and USB_SWITCH_DEVICE. Rather then modifying the
> tcpc_usb_switch enum for this, simply remove it and switch to the
> usb_role enum which provides exactly this, this will save use needing to
> convert betweent the 2 enums when calling an usb-role-switch driver later.
> 
> Besides switching to the usb_role type, this commit also actually sets the
> mux to TYPEC_MUX_USB and the switch to USB_ROLE_DEVICE instead of setting
> both to none when the data-role is device.
> 
> This commit also makes tcpm_reset_port() call tcpm_mux_set(port,
> TYPEC_MUX_NONE, USB_ROLE_NONE) so that the mux and switch
> do _not_ stay in their last mode after a detach.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I'm happy with this, but Guenter should also check tcpm changes.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm.c | 22 +++++++++++-----------
>  include/linux/usb/tcpm.h |  8 ++------
>  2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 7cd28b700a7f..00ca2822432f 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -618,15 +618,15 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>  EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
>  
>  static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
> -			enum tcpc_usb_switch config)
> +			enum usb_role usb_role)
>  {
>  	int ret = 0;
>  
> -	tcpm_log(port, "Requesting mux mode %d, config %d, polarity %d",
> -		 mode, config, port->polarity);
> +	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
> +		 mode, usb_role, port->polarity);
>  
>  	if (port->tcpc->mux)
> -		ret = port->tcpc->mux->set(port->tcpc->mux, mode, config,
> +		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
>  					   port->polarity);
>  
>  	return ret;
> @@ -742,14 +742,15 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
>  static int tcpm_set_roles(struct tcpm_port *port, bool attached,
>  			  enum typec_role role, enum typec_data_role data)
>  {
> +	enum usb_role usb_role;
>  	int ret;
>  
>  	if (data == TYPEC_HOST)
> -		ret = tcpm_mux_set(port, TYPEC_MUX_USB,
> -				   TCPC_USB_SWITCH_CONNECT);
> +		usb_role = USB_ROLE_HOST;
>  	else
> -		ret = tcpm_mux_set(port, TYPEC_MUX_NONE,
> -				   TCPC_USB_SWITCH_DISCONNECT);
> +		usb_role = USB_ROLE_DEVICE;
> +
> +	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2096,7 +2097,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
>  out_disable_pd:
>  	port->tcpc->set_pd_rx(port->tcpc, false);
>  out_disable_mux:
> -	tcpm_mux_set(port, TYPEC_MUX_NONE, TCPC_USB_SWITCH_DISCONNECT);
> +	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
>  	return ret;
>  }
>  
> @@ -2140,6 +2141,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	tcpm_init_vconn(port);
>  	tcpm_set_current_limit(port, 0, 0);
>  	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
> +	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
>  	tcpm_set_attached_state(port, false);
>  	port->try_src_count = 0;
>  	port->try_snk_count = 0;
> @@ -2190,8 +2192,6 @@ static int tcpm_snk_attach(struct tcpm_port *port)
>  static void tcpm_snk_detach(struct tcpm_port *port)
>  {
>  	tcpm_detach(port);
> -
> -	/* XXX: (Dis)connect SuperSpeed mux? */
>  }
>  
>  static int tcpm_acc_attach(struct tcpm_port *port)
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index ca1c0b57f03f..268721bff2c1 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -16,6 +16,7 @@
>  #define __LINUX_USB_TCPM_H
>  
>  #include <linux/bitops.h>
> +#include <linux/usb/role.h>
>  #include <linux/usb/typec.h>
>  #include "pd.h"
>  
> @@ -97,11 +98,6 @@ struct tcpc_config {
>  	const struct typec_altmode_desc *alt_modes;
>  };
>  
> -enum tcpc_usb_switch {
> -	TCPC_USB_SWITCH_CONNECT,
> -	TCPC_USB_SWITCH_DISCONNECT,
> -};
> -
>  /* Mux state attributes */
>  #define TCPC_MUX_USB_ENABLED		BIT(0)	/* USB enabled */
>  #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
> @@ -118,7 +114,7 @@ enum tcpc_mux_mode {
>  
>  struct tcpc_mux_dev {
>  	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
> -		   enum tcpc_usb_switch usb_config,
> +		   enum usb_role usb_role,
>  		   enum typec_cc_polarity polarity);
>  	bool dfp_only;
>  	void *priv_data;
> -- 
> 2.14.3

Thanks,

-- 
heikki
