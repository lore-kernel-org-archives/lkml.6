Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F7CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49A32147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7QRz3Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49A32147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeGLLIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeGLLIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:08:21 -0400
Received: from localhost (unknown [171.61.95.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07256208E2;
        Thu, 12 Jul 2018 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531393159;
        bh=WbU5JORQjEG+e3E0XIiRUQG/CmRjm9Ub7e6QRX3iZhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7QRz3UtPjZ0Zqs5SGIZlFQmOwCBvxLZKxoP7uik8mwaQA9qNryE6JtEuPcq+ROMT
         iH52f8Y73kl1L5dl1ZSE6do2UF9BVW2bKR8de5Th0HGFr56mcroLLwJ3OIjWOXTqgw
         k8B/GBgGsZhAWzFptlI0QvPUd6kjFhw5+ne4BVEw=
Date:   Thu, 12 Jul 2018 16:29:10 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org
Subject: Re: [PATCH] ASoC: core: add support to card re-bind/unbind using
 component framework
Message-ID: <20180712105910.GU3219@vkoul-mobl>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 09:43, Srinivas Kandagatla wrote:
> This patch aims at add achieving dynamic behaviour of audio card when
> the dependent components disappear and reappear.
> 
> With this patch the card is removed if any of the dependent component
> is removed and card is added back if the dependent component comes back.
> All this is done using component framework and matching based on
> component name.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Looks fine mostly, some nitpicks below:

> ---
> 
> During discussion regarding card re-binding when components unregister
> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
> that component framework can be added into core to provide this feature.
> 
> With this new changes the card will re-bind once the dependent component
> re-registers after unregistering. This works based on the match done
> from component name using component framework.
> 
> I have tested this patch with qdsp start-stop usecase for more than 10000
> times in loop on Qcom platforms.
> 
> I will send qdsp side cleanup patches once I get some feedback on this patch.
> 
> 
>  include/sound/soc.h  |  5 ++++
>  sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 870ba6b64817..b94149d29c0d 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -17,6 +17,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/component.h>
>  #include <linux/regmap.h>
>  #include <linux/log2.h>
>  #include <sound/core.h>
> @@ -1088,6 +1089,10 @@ struct snd_soc_card {
>  
>  	struct work_struct deferred_resume_work;
>  
> +	/* component framework related */
> +	bool components_added;
> +	struct component_match *match;
> +
>  	/* lists of probed devices belonging to this card */
>  	struct list_head component_dev_list;
>  
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 6d33634b934b..377ed8e67686 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
>  
>  #endif
>  
> +static int snd_soc_card_comp_compare(struct device *dev, void *data)

Why not make last arg as name and avoid void *

> +{
> +	struct snd_soc_component *component = NULL;
> +	struct snd_soc_component *t;

why do you need two variables for this
> +
> +	lockdep_assert_held(&client_mutex);
> +	list_for_each_entry(t, &component_list, list) {
> +		if (dev == t->dev) {
> +			component = t;

you can skip this line and use t in below code.

> +			break;
> +		}
> +	}
> +
> +	if (component && !strcmp(component->name, data))

strncmp?

-- 
~Vinod
