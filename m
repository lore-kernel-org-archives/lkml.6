Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87670C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2AB2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2AB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIEO7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:59:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57533 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIEO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:59:33 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fxV4I-0004NT-9N; Wed, 05 Sep 2018 12:29:50 +0200
Message-ID: <1536143389.4084.4.camel@pengutronix.de>
Subject: Re: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 12:29:49 +0200
In-Reply-To: <1536131342-28041-2-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-2-git-send-email-nava.manne@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> This Patch Adds reset API's to support release, assert
> and status functionalities by using firmware interface.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-None.
> Changes for v2:
> 		-New Patch.
> 
>  drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++++++++++
>  2 files changed, 176 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 7ccedf0..639c72f 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -447,6 +447,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  	return ret;
>  }
>  
> +/**
> + * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
> + * @reset:		Reset to be configured
> + * @assert_flag:	Flag stating should reset be asserted (1) or
> + *			released (0)
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +				  const enum zynqmp_pm_reset_action assert_flag)
> +{
> +	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
> +				   0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_reset_get_status - Get status of the reset
> + * @reset:      Reset whose status should be returned
> + * @status:     Returned status
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
> +				      u32 *status)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
> +				  0, 0, ret_payload);
> +	*status = ret_payload[1];

It doesn't really matter here, but in general I'd skip writing output
arguments in case of error.
For all I know, the result returned in ret_payload could be undefined.

regards
Philipp
