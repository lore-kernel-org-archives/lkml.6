Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A43C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCD25B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDCD25B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030533AbeGBLaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:30:14 -0400
Received: from muru.com ([72.249.23.125]:49584 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965174AbeGBLaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:30:11 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8919C8047;
        Mon,  2 Jul 2018 11:33:06 +0000 (UTC)
Date:   Mon, 2 Jul 2018 04:30:08 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wlcore: Fix memory leak in
 wlcore_cmd_wait_for_event_or_timeout
Message-ID: <20180702113008.GV112168@atomide.com>
References: <20180628130809.GA8147@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628130809.GA8147@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gustavo A. R. Silva <gustavo@embeddedor.com> [180628 13:11]:
> In case memory resources for *events_vector* were allocated, release
> them before return.
> 
> Addresses-Coverity-ID: 1470194 ("Resource leak")
> Fixes: 4ec7cece87b3 ("wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for catching this one:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/net/wireless/ti/wlcore/cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
> index 836c616..9039687 100644
> --- a/drivers/net/wireless/ti/wlcore/cmd.c
> +++ b/drivers/net/wireless/ti/wlcore/cmd.c
> @@ -195,8 +195,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
>  	ret = pm_runtime_get_sync(wl->dev);
>  	if (ret < 0) {
>  		pm_runtime_put_noidle(wl->dev);
> -
> -		return ret;
> +		goto free_vector;
>  	}
>  
>  	do {
> @@ -232,6 +231,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
>  out:
>  	pm_runtime_mark_last_busy(wl->dev);
>  	pm_runtime_put_autosuspend(wl->dev);
> +free_vector:
>  	kfree(events_vector);
>  	return ret;
>  }
> -- 
> 2.7.4
> 
