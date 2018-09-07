Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708582077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708582077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIGPPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:52862 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeIGPPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 03:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="87997650"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2018 03:34:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 07 Sep 2018 13:34:38 +0300
Date:   Fri, 7 Sep 2018 13:34:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] usb: typec: don't disable sink or source on
 initialization
Message-ID: <20180907103438.GI25121@kuha.fi.intel.com>
References: <20180906192644.24587-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906192644.24587-1-angus@akkea.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Guenter

On Thu, Sep 06, 2018 at 01:26:44PM -0600, Angus Ainslie (Purism) wrote:
> If the board is being powered by USB disabling the source and sink
> can remove power from the board. Default to source and sink enabled.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/usb/typec/tcpm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index ca7bedb46f7f..a1b819cf31da 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>  {
>  	int ret;
>  
> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
> -	port->vbus_source = false;
> -	port->vbus_charge = false;
> +	/* default to source and sink enabled in case USB is our only power
> +	 * source */
> +	ret = port->tcpc->set_vbus(port->tcpc, true, true);
> +	port->vbus_source = true;
> +	port->vbus_charge = true;
>  	return ret;
>  }

-- 
heikki
