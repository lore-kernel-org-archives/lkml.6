Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC757C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7F320837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7F320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:44:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:35138 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGPop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:44:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 07:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="127997968"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Dec 2018 07:44:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 07 Dec 2018 17:44:41 +0200
Date:   Fri, 7 Dec 2018 17:44:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Message-ID: <20181207154441.GA30561@kuha.fi.intel.com>
References: <20181206030227.9507-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206030227.9507-1-kyletso@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:02:27AM +0800, Kyle Tso wrote:
> Current matching rules ensure that the voltage range of selected Source
> Capability is entirely within the range defined in one of the Sink
> Capabilities. This is reasonable but not practical because Sink may not
> support wide range of voltage when sinking power while Source could
> advertise its capabilities in raletively wider range. For example, a
> Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
> will not be selected if the Sink requires 5V-12V@3A PPS power. However,
> the Sink could work well if the requested voltage range in RDOs is
> 5V-11V@3A.
> 
> To improve the usability, change the matching rules to what listed
> below:
> a. The Source PDO is selectable if any portion of the voltage range
>    overlaps one of the Sink PDO's voltage range.
> b. The maximum operational voltage will be the lower one between the
>    selected Source PDO and the matching Sink PDO.
> c. The maximum power will be the maximum operational voltage times the
>    maximum current defined in the selected Source PDO
> d. Select the Source PDO with the highest maximum power
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3620efee2688..3001df7bd602 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  	unsigned int i, j, max_mw = 0, max_mv = 0;
>  	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
>  	unsigned int min_snk_mv, max_snk_mv;
> -	u32 pdo;
> +	unsigned int max_op_mv;
> +	u32 pdo, src, snk;
>  	unsigned int src_pdo = 0, snk_pdo = 0;
>  
>  	/*
> @@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  					continue;
>  				}
>  
> -				if (max_src_mv <= max_snk_mv &&
> -				    min_src_mv >= min_snk_mv) {
> +				if (min_src_mv <= max_snk_mv &&
> +				    max_src_mv >= min_snk_mv) {
> +					max_op_mv = min(max_src_mv, max_snk_mv);
> +					src_mw = (max_op_mv * src_ma) / 1000;
>  					/* Prefer higher voltages if available */
>  					if ((src_mw == max_mw &&
> -					     min_src_mv > max_mv) ||
> +					     max_op_mv > max_mv) ||
>  					    src_mw > max_mw) {
>  						src_pdo = i;
>  						snk_pdo = j;
>  						max_mw = src_mw;
> -						max_mv = max_src_mv;
> +						max_mv = max_op_mv;
>  					}
>  				}
>  			}
> @@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  	}
>  
>  	if (src_pdo) {
> -		pdo = port->source_caps[src_pdo];
> -
> -		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
> -		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
> -		port->pps_data.max_curr =
> -			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
> +		src = port->source_caps[src_pdo];
> +		snk = port->snk_pdo[snk_pdo];
> +
> +		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
> +					      pdo_pps_apdo_min_voltage(snk));
> +		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
> +					      pdo_pps_apdo_max_voltage(snk));
> +		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
>  		port->pps_data.out_volt =
> -			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> +			min(port->pps_data.max_volt, port->pps_data.out_volt);
>  		port->pps_data.op_curr =
>  			min(port->pps_data.max_curr, port->pps_data.op_curr);
>  	}
> -- 
> 2.20.0.rc2.403.gdbc3b29805-goog

-- 
heikki
