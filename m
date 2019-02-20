Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51D520700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfBTHjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:39:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:26220 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfBTHjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:39:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 23:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="148284631"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 19 Feb 2019 23:39:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Feb 2019 09:39:49 +0200
Date:   Wed, 20 Feb 2019 09:39:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: typec: mux: fix an unsigned less than zero
 check
Message-ID: <20190220073949.GB27637@kuha.fi.intel.com>
References: <20190219151918.13114-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219151918.13114-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 03:19:18PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The checks of a negative nval indicating an error an never be true
> as nval is currently a size_t which is of course unsigned and hence
> never less than zero. Fix this by making nval an int.
> 
> Detected by CoverityScan, CID#1476863 ("Unsigned compared against 0) 
> and CID#1476948 ("Loop bound")
> 
> Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/typec/mux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index b94e2920eb38..64d2ed3fecb8 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -126,10 +126,9 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
>  {
>  	const struct typec_altmode_desc *desc = data;
>  	struct typec_mux *mux;
> -	size_t nval;
>  	bool match;
>  	u16 *val;
> -	int i;
> +	int i, nval;
>  
>  	if (!con->fwnode) {
>  		list_for_each_entry(mux, &mux_list, entry)
> -- 
> 2.20.1

This one has already a fix:
https://lkml.org/lkml/2019/2/19/56

thanks,

-- 
heikki
