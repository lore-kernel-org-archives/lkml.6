Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B09C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157B120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeIJVBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:01:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeIJVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:01:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471F61596;
        Mon, 10 Sep 2018 09:06:50 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD2F3F557;
        Mon, 10 Sep 2018 09:06:49 -0700 (PDT)
Date:   Mon, 10 Sep 2018 17:06:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: add a getter for power of
 performance states
Message-ID: <20180910160638.GA14835@e107155-lin>
References: <20180903102439.24012-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903102439.24012-1-quentin.perret@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 11:24:39AM +0100, Quentin Perret wrote:
> The SCMI protocol can be used to get power estimates from firmware
> corresponding to each performance state of a device. Although these power
> costs are already managed by the SCMI firmware driver, they are not
> exposed to any external subsystem yet.
> 
> Fix this by adding a new get_power() interface to the exisiting perf_ops
> defined for the SCMI protocol.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
> v2: rebased on 4.19-rc2
> ---
>  drivers/firmware/arm_scmi/perf.c | 28 ++++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h    |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 721e6c57beae..272abd2cb3f0 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -421,6 +421,33 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
>  	return ret;
>  }
>  
> +static int scmi_dvfs_power_get(const struct scmi_handle *handle, u32 domain,
> +			       unsigned long *freq, unsigned long *power)

I feel the name "power_get" gives me feeling that it refers to instant
power than the computed value. At least in scmi interface, freq_get
provides current value of running frequency. I am not sure of the
consistency in the naming in other subsystems.

Does it makes sense to name it "scmi_dvfs_est_power_get" as it actually
refers to estimated power cost ?

> +{
> +	struct scmi_perf_info *pi = handle->perf_priv;
> +	struct perf_dom_info *dom;
> +	unsigned long opp_freq;
> +	int idx, ret = -EINVAL;
> +	struct scmi_opp *opp;
> +
> +	dom = pi->dom_info + domain;
> +	if (!dom)
> +		return -EIO;
> +
> +	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
> +		opp_freq = opp->perf * dom->mult_factor;
> +		if (opp_freq < *freq)
> +			continue;
> +
> +		*freq = opp_freq;
> +		*power = opp->power;
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static struct scmi_perf_ops perf_ops = {
>  	.limits_set = scmi_perf_limits_set,
>  	.limits_get = scmi_perf_limits_get,
> @@ -431,6 +458,7 @@ static struct scmi_perf_ops perf_ops = {
>  	.device_opps_add = scmi_dvfs_device_opps_add,
>  	.freq_set = scmi_dvfs_freq_set,
>  	.freq_get = scmi_dvfs_freq_get,
> +	.power_get = scmi_dvfs_power_get,

same here s/.power_get/.est_power_get/

>  };
>  
>  static int scmi_perf_protocol_init(struct scmi_handle *handle)
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f4c9fc0fc755..2ecbd2c5a249 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -91,6 +91,8 @@ struct scmi_clk_ops {
>   *	to sustained performance level mapping
>   * @freq_get: gets the frequency for a given device using sustained frequency
>   *	to sustained performance level mapping
> + * @power_get: gets the power dissipated for a given performance domain at a

s/power dissipated/estimated power cost/

--
Regards,
Sudeep
