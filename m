Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C82082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4C82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeKBWgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:36:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:18950 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBWgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:36:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 06:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="104738383"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 02 Nov 2018 06:28:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 02 Nov 2018 15:28:47 +0200
Date:   Fri, 2 Nov 2018 15:28:47 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, jackp@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: typec: tcpm: charge current handling for
 sink during hard reset
Message-ID: <20181102132847.GC6543@kuha.fi.intel.com>
References: <20181001194501.58338-1-badhri@google.com>
 <20181001194501.58338-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001194501.58338-3-badhri@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:45:01PM -0700, Badhri Jagan Sridharan wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --------
> Changes in V3:
> Rebase on top of usb-next
> 
> Changes in V2:
> Based on feedback of jackp@codeaurora.org
> - vsafe_5v_hard_reset flag from tcpc_config is removed
> - Patch only differentiates between pd port partner and non-pd port
> partner
> 
> V1 version of the patch is here:
> https://lkml.org/lkml/2018/9/14/11
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c3ac0e46106b..c25a69922ee6 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3273,7 +3273,8 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_HARD_RESET_SINK_OFF:
>  		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
> -		tcpm_set_charge(port, false);
> +		if (port->pd_capable)
> +			tcpm_set_charge(port, false);
>  		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
>  			       TYPEC_DEVICE);
>  		/*
> @@ -3305,6 +3306,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * Similar, dual-mode ports in source mode should transition
>  		 * to PE_SNK_Transition_to_default.
>  		 */
> +		if (port->pd_capable) {
> +			tcpm_set_current_limit(port,
> +					       tcpm_get_current_limit(port),
> +					       5000);
> +			tcpm_set_charge(port, true);
> +		}
>  		tcpm_set_attached_state(port, true);
>  		tcpm_set_state(port, SNK_STARTUP, 0);
>  		break;
> -- 
> 2.19.0.605.g01d371f741-goog

thanks,

-- 
heikki
