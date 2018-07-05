Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A3CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074BD24137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074BD24137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeGENKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:10:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:33501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbeGENKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:10:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 06:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="69857964"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 05 Jul 2018 06:10:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Jul 2018 16:10:01 +0300
Date:   Thu, 5 Jul 2018 16:10:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: typec: fix dereference before null check on
 adev
Message-ID: <20180705131001.GC15989@kuha.fi.intel.com>
References: <20180704123406.9496-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704123406.9496-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:34:06PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer adev is being dereferenced before it is being sanity
> checked with a null pointer check, hence it is possible for
> a null pointer dereference to occur.  Fix this by dereferencing
> adev only once it is null checked.
> 
> Detected by CoverityScan, CID#1471598 ("Dereference before null check")
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 999d7904172a..95a2b10127db 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -51,7 +51,7 @@ static int typec_altmode_set_state(struct typec_altmode *adev, int state)
>  int typec_altmode_notify(struct typec_altmode *adev,
>  			 unsigned long conf, void *data)
>  {
> -	bool is_port = is_typec_port(adev->dev.parent);
> +	bool is_port;
>  	struct altmode *altmode;
>  	struct altmode *partner;
>  	int ret;
> @@ -64,6 +64,7 @@ int typec_altmode_notify(struct typec_altmode *adev,
>  	if (!altmode->partner)
>  		return -ENODEV;
>  
> +	is_port = is_typec_port(adev->dev.parent);
>  	partner = altmode->partner;
>  
>  	ret = typec_altmode_set_mux(is_port ? altmode : partner, (u8)conf);

Thanks,

-- 
heikki
