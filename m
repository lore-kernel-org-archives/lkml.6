Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E49C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6506208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6506208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIXNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:38:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:35203 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeIXNiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:38:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 00:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,296,1534834800"; 
   d="scan'208";a="92683590"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 24 Sep 2018 00:35:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Sep 2018 10:35:43 +0300
Date:   Mon, 24 Sep 2018 10:35:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH] usb: typec: tcpm: Fix APDO PPS order checking to be
 based on voltage
Message-ID: <20180924073542.GI11965@kuha.fi.intel.com>
References: <20180921150411.8BEE73FBE5@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150411.8BEE73FBE5@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:04:11PM +0100, Adam Thomson wrote:
> Current code mistakenly checks against max current to determine
> order but this should be max voltage. This commit fixes the issue
> so order is correctly determined, thus avoiding failure based on
> a higher voltage PPS APDO having a lower maximum current output,
> which is actually valid.
> 
> Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Code based on usb-testing branch (ae8a2ca8a2215c7e31e6d874f7303801bb15fbb)
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4f1f421..c11b3be 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1430,8 +1430,8 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>  				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
>  					break;
>  
> -				if (pdo_pps_apdo_max_current(pdo[i]) <
> -				    pdo_pps_apdo_max_current(pdo[i - 1]))
> +				if (pdo_pps_apdo_max_voltage(pdo[i]) <
> +				    pdo_pps_apdo_max_voltage(pdo[i - 1]))
>  					return PDO_ERR_PPS_APDO_NOT_SORTED;
>  				else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
>  					  pdo_pps_apdo_min_voltage(pdo[i - 1]) &&
> -- 
> 1.9.1

Thanks,

-- 
heikki
