Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA82C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7162147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cxn0TIWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfA2NZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:25:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfA2NZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:25:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so9664021pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGbd9FlQew8gsGNv/Xgm9xhO0xmJWMowaC4xsZZP7yY=;
        b=Cxn0TIWBAsHYOlURpxDsg/3ERpvMc8OhoR8R9OUUvx2FeE0L65jyWLxTa5+4Q6pWV1
         tuTQSIJoT58Q0KnBrhc7+AldTeCT98GMMnagr4K2dlc6SDu14Oj9b88TgRSe2B8ZRRGv
         hK0cwUsQTgLzqn6xL64dkDJDKAN8zfkGkUVnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGbd9FlQew8gsGNv/Xgm9xhO0xmJWMowaC4xsZZP7yY=;
        b=e0dPMWwagtafrofxC8Z+mH4AN4SKd0LdN/rmWJ8Yx6p9JWepyQpp0aAp76HtT6V2f0
         M2VRbS1OUECYySvYlSxIgBAQWVRdrxxk8MPEalnUzgNCRLrWumq/D70vFxKeWe5nGxGE
         1lchxBMKZgMIetig542/hBjUCaG9JBrrW2W86XpBjI+NXx6vVK9zR9FEFc3y4MBeA/eq
         NHNMwHcDVEoMtLAccAKcMrUPjB7eizOF4ZXOYM4BpyTU3reH3kZoAUFDVnZTJuZ6U6P0
         VQnanQvpPp4Ge6oK0JCJoXNLgpI4lZLzoh4g796/GAWN/k9yzxHBBHoR/7QFd187zmun
         2mjA==
X-Gm-Message-State: AJcUukfNP9gJs2MJuVyzDHo/8PI/tsQBPdD9MaVm447z+nGKgju6AWYl
        ahPUCMoz78buuQJ+DmUh8CC1prBPn/k=
X-Google-Smtp-Source: ALg8bN6nfbylqOgeihbdgnPLdWukd1GfnwaLrRGuhDsGJLn1Ry5DDCvOJ6PnXetLMRYkTBwsEEVmpA==
X-Received: by 2002:a65:624c:: with SMTP id q12mr23764054pgv.379.1548768336816;
        Tue, 29 Jan 2019 05:25:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id v15sm44146419pfn.94.2019.01.29.05.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:25:35 -0800 (PST)
Date:   Tue, 29 Jan 2019 21:25:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
Message-ID: <20190129132528.GA16669@leoy-ThinkPad-X240s>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:44:03AM +0530, Sai Prakash Ranjan wrote:
> Add UCI table and a helper macro for coresight CPU debug
> module. This patch adds the UCI entries for Krypo CPUs
> found on MSM8996 which shares the same PIDs as ETMs.
> 
> Without this, below error is observed on MSM8996:
> 
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> 
> Also add a helper macro to make adding CPU PIDs easier
> similar to ETM4X driver.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Looks good to me and tested on my Hikey board (though I cannot test
for a device with UCI ID):

Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

> ---
> This patch depends on UCI support by Mike Leach in below link:
>  https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
> ---
>  .../hwtracing/coresight/coresight-cpu-debug.c | 41 +++++++++++++------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 45b2460f3166..a126ed0b9a76 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,20 +655,35 @@ static int debug_remove(struct amba_device *adev)
>  	return 0;
>  }
>  
> +#define DEBUG_AMBA_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +	}
> +
> +static struct amba_cs_uci_id uci_id_debug[] = {
> +	{
> +		/*  CPU Debug UCI data */
> +		.devarch	= 0x47706a15,
> +		.devarch_mask	= 0xfff0ffff,
> +		.devtype	= 0x00000015,
> +	}
> +};
> +
> +#define DEBUG_AMBA_UCI_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= uci_id_debug,		\
> +	}
> +
>  static const struct amba_id debug_ids[] = {
> -	{       /* Debug for Cortex-A53 */
> -		.id	= 0x000bbd03,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A57 */
> -		.id	= 0x000bbd07,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A72 */
> -		.id	= 0x000bbd08,
> -		.mask	= 0x000fffff,
> -	},
> -	{ 0, 0 },
> +	DEBUG_AMBA_ID(0x000bbd03),		/* Cortex-A53 */
> +	DEBUG_AMBA_ID(0x000bbd07),		/* Cortex-A57 */
> +	DEBUG_AMBA_ID(0x000bbd08),		/* Cortex-A72 */
> +	DEBUG_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
> +	DEBUG_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
> +	{},
>  };
>  
>  static struct amba_driver debug_driver = {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
