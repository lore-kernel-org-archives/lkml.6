Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D5A20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeL1AZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:25:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeL1AZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:25:51 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59D2914E0982C;
        Thu, 27 Dec 2018 16:25:51 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:25:50 -0800 (PST)
Message-Id: <20181227.162550.173701726860933882.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, linux-net-drivers@solarflare.com,
        ecree@solarflare.com, bkenward@solarflare.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfc: checks status of efx_mcdi_rpc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226050517.74381-1-kjlu@umn.edu>
References: <20181226050517.74381-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:25:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 23:05:17 -0600

> efx_mcdi_rpc() could fail. The fix checks its status and issues an error
> message if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/sfc/mcdi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index dfad93fca0a6..9486e6534dea 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -1819,6 +1819,9 @@ void efx_mcdi_set_id_led(struct efx_nic *efx, enum efx_led_mode mode)
>  
>  	rc = efx_mcdi_rpc(efx, MC_CMD_SET_ID_LED, inbuf, sizeof(inbuf),
>  			  NULL, 0, NULL);
> +	if (rc)
> +		netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n",
> +				__func__, rc);

"__func__" did not fail, efx_mcdi_rpc() did.
