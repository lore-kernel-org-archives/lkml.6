Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F03C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA2206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIJM2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:28:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:58106 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbeIJM2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:28:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 00:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="88641967"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 10 Sep 2018 00:35:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Sep 2018 10:35:29 +0300
Date:   Mon, 10 Sep 2018 10:35:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     groeck7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values
 from the devicetree
Message-ID: <20180910073529.GL25121@kuha.fi.intel.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909180531.28092-1-angus@akkea.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 12:05:31PM -0600, Angus Ainslie (Purism) wrote:
> If the board is being powered by USB disabling the source and sink
> can remove power from the board. Allow the source and sink to be
> initallized based on devicetree values.
> 
> Changed since V1:
> 
> use devicetree values instead of hardcoded initialization.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../bindings/connector/usb-connector.txt           |  4 ++++
>  drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> index 8855bfcfd778..afe851a713c3 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
>    or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
>  - data-role: should be one of "host", "device", "dual"(DRD) if typec
>    connector supports USB data.
> +- init-vbus-source: set the initalization value for vbus-source to true.
> +  If this property is not present the initial value will be false.
> +- init-vbus-charge: set the initalization value for vbus-charge to true.
> +  If this property is not present the initial value will be false.

If you put the description of those properties here, you are going to
need to rename them. Those describe tcpm specific properties, but to
that file you want to put descriptions of generic properties.

Your problem is that you can not cope with a lose of VBUS as a sink,
right? For that you just need one boolean device property IMO.
Something like depend-on-vbus.

>  Required properties for usb-c-connector with power delivery support:
>  - source-pdos: An array of u32 with each entry providing supported power
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index ca7bedb46f7f..7f5d4f209e07 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>  {
>  	int ret;
>  
> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
> -	port->vbus_source = false;
> -	port->vbus_charge = false;
> +	ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, port->vbus_charge);
>  	return ret;
>  }
>  
> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		return -EINVAL;
>  	port->port_type = port->typec_caps.type;
>  
> +	if (fwnode_property_present(fwnode, "init-vbus-source"))
> +		port->vbus_source = true;
> +	else
> +		port->vbus_source = false;
> +
> +	if (fwnode_property_present(fwnode, "init-vbus-charge"))
> +	        port->vbus_charge = true;
> +	else
> +	        port->vbus_charge = false;
> +
>  	if (port->port_type == TYPEC_PORT_SNK)
>  		goto sink;
>  
> -- 
> 2.17.1

Thanks,

-- 
heikki
