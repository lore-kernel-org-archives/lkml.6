Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9658520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9658520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeGTLaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:30:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:13543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeGTLaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:30:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 03:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,378,1526367600"; 
   d="scan'208";a="74038320"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Jul 2018 03:42:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Jul 2018 13:42:23 +0300
Date:   Fri, 20 Jul 2018 13:42:23 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS
 APDO selection
Message-ID: <20180720104223.GA13264@kuha.fi.intel.com>
References: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:36:19PM +0100, Adam Thomson wrote:
> There is a bug in the sink PDO search code when trying to select
> a PPS APDO. The current code actually sets the starting index for
> searching to whatever value 'i' is, rather than choosing index 1
> to avoid the first PDO (always 5V fixed). As a result, for sources
> which support PPS but whose PPS APDO index does not match with the
> supporting sink PPS APDO index for the platform, no valid PPS APDO
> will be found so this feature will not be permitted.
> 
> Sadly in testing, both Source and Sink capabilities matched up and
> this was missed. Code is now updated to correctly set the start
> index to 1, and testing with additional PPS capable sources show
> this to work as expected.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 74e0cda..4f1f421 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2238,7 +2238,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  			 * PPS APDO. Again skip the first sink PDO as this will
>  			 * always be 5V 3A.
>  			 */
> -			for (j = i; j < port->nr_snk_pdo; j++) {
> +			for (j = 1; j < port->nr_snk_pdo; j++) {
>  				pdo = port->snk_pdo[j];
>  
>  				switch (pdo_type(pdo)) {

Thanks,

-- 
heikki
