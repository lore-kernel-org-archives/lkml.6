Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B58C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9EB20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9EB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIMSd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:33:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:43688 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIMSd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:33:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 06:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,369,1531810800"; 
   d="scan'208";a="89700336"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 13 Sep 2018 06:24:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Sep 2018 16:24:08 +0300
Date:   Thu, 13 Sep 2018 16:24:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] typec: tcpm: Do not disconnect link for self powered
 devices
Message-ID: <20180913132408.GC19329@kuha.fi.intel.com>
References: <20180913021113.18150-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913021113.18150-1-badhri@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Guenter

On Wed, Sep 12, 2018 at 07:11:12PM -0700, Badhri Jagan Sridharan wrote:
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
> Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> ---
>  drivers/usb/typec/tcpm.c | 6 +++++-
>  include/linux/usb/tcpm.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 4f1f4215f3d6..a4e0c027a2a9 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -3270,7 +3270,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
>  		tcpm_set_charge(port, false);
> -		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> +
> +		if (port->tcpc->config->self_powered)

Add a member for that flag to the struct tcpm_port, and check that
here instead. I'll explain why below.

> +			tcpm_set_roles(port, true, TYPEC_SINK, TYPEC_DEVICE);
> +		else
> +			tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> 
>  		/*
>  		 * VBUS may or may not toggle, depending on the adapter.
>  		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 7e7fbfb84e8e..50c74a77db55 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -89,6 +89,7 @@ struct tcpc_config {
>  	enum typec_port_data data;
>  	enum typec_role default_role;
>  	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
> +	bool self_powered;	/* port belongs to a self powered device */

I'm not sure we should add any more members to that structure, but
maybe it's not a problem for now. We can't quite yet get rid of that
structure.

You do need to introduce a new device property already. Then read the
value for that new member you added to struct tcpm_port in
tcpm_fw_get_caps() and in tcpm_copy_caps().


Thanks,

-- 
heikki
