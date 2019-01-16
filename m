Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E97206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391899AbfAPMBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:01:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60872 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389730AbfAPMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:01:49 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8933e761e9deb9c0; Wed, 16 Jan 2019 13:01:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2 pm: clk: fix a missing check of clk_prepare
Date:   Wed, 16 Jan 2019 13:00:54 +0100
Message-ID: <1699761.45DYuq6sLL@aspire.rjw.lan>
In-Reply-To: <20190105195845.5453-1-pakki001@umn.edu>
References: <20190105195845.5453-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, January 5, 2019 8:58:45 PM CET Aditya Pakki wrote:
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message and change the clock_entry_status to
> PCE_STATUS_ERROR
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/base/power/clock_ops.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 5a42ae4078c2..732764becafe 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -65,10 +65,15 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>  	if (IS_ERR(ce->clk)) {
>  		ce->status = PCE_STATUS_ERROR;
>  	} else {
> -		clk_prepare(ce->clk);
> -		ce->status = PCE_STATUS_ACQUIRED;
> -		dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
> -			ce->clk, ce->con_id);
> +		if (clk_prepare(ce->clk)) {
> +			ce->status = PCE_STATUS_ERROR;
> +			dev_err(dev, "clk_prepare failed\n");
> +		} else {
> +			ce->status = PCE_STATUS_ACQUIRED;
> +			dev_dbg(dev,
> +				"Clock %pC con_id %s managed by runtime PM.\n",
> +				ce->clk, ce->con_id);
> +		}
>  	}
>  }
>  
> 

Applied (with some minor modifications), thanks!


