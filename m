Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE13C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17262147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfKVAW3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17262147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeGLMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbeGLMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:49:16 -0400
Received: from localhost (unknown [171.61.95.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FCC20875;
        Thu, 12 Jul 2018 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531399192;
        bh=b/kpYa9LeVkOMlboycirJswtSWcp+Nll6j9CyYTuxFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfKVAW3i/GKV0xEAeSRLZcqbRH5HJlD0gZFjf1H92c1lZlh2nSveEK3U0Y/9pV6s/
         HeAS8jJpDcrzZLV2h1d64ILovBi+U8zMCed2LX1msppgxVUW4K0BgvA/Qqf44Niu0Q
         CqawTUyWxIMoIBKm5g8V8o9RpMFUin9XaJKrHr/M=
Date:   Thu, 12 Jul 2018 18:09:42 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org
Subject: Re: [PATCH] ASoC: core: add support to card re-bind/unbind using
 component framework
Message-ID: <20180712123942.GV3219@vkoul-mobl>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <20180712105910.GU3219@vkoul-mobl>
 <c4eae2f4-8094-bf09-abed-bfd7a0428f34@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4eae2f4-8094-bf09-abed-bfd7a0428f34@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-18, 13:02, Srinivas Kandagatla wrote:
> Thanks Vinod for taking look at this!
> 
> On 12/07/18 11:59, Vinod wrote:
> > On 11-07-18, 09:43, Srinivas Kandagatla wrote:
> > > This patch aims at add achieving dynamic behaviour of audio card when
> > > the dependent components disappear and reappear.
> > > 
> > > With this patch the card is removed if any of the dependent component
> > > is removed and card is added back if the dependent component comes back.
> > > All this is done using component framework and matching based on
> > > component name.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > Looks fine mostly, some nitpicks below:
> > 
> > > ---
> > > 
> > > During discussion regarding card re-binding when components unregister
> > > and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
> > > that component framework can be added into core to provide this feature.
> > > 
> > > With this new changes the card will re-bind once the dependent component
> > > re-registers after unregistering. This works based on the match done
> > > from component name using component framework.
> > > 
> > > I have tested this patch with qdsp start-stop usecase for more than 10000
> > > times in loop on Qcom platforms.
> > > 
> > > I will send qdsp side cleanup patches once I get some feedback on this patch.
> > > 
> > > 
> > >   include/sound/soc.h  |  5 ++++
> > >   sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
> > >   2 files changed, 70 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/sound/soc.h b/include/sound/soc.h
> > > index 870ba6b64817..b94149d29c0d 100644
> > > --- a/include/sound/soc.h
> > > +++ b/include/sound/soc.h
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/workqueue.h>
> > >   #include <linux/interrupt.h>
> > >   #include <linux/kernel.h>
> > > +#include <linux/component.h>
> > >   #include <linux/regmap.h>
> > >   #include <linux/log2.h>
> > >   #include <sound/core.h>
> > > @@ -1088,6 +1089,10 @@ struct snd_soc_card {
> > >   	struct work_struct deferred_resume_work;
> > > +	/* component framework related */
> > > +	bool components_added;
> > > +	struct component_match *match;
> > > +
> > >   	/* lists of probed devices belonging to this card */
> > >   	struct list_head component_dev_list;
> > > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > > index 6d33634b934b..377ed8e67686 100644
> > > --- a/sound/soc/soc-core.c
> > > +++ b/sound/soc/soc-core.c
> > > @@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
> > >   #endif
> > > +static int snd_soc_card_comp_compare(struct device *dev, void *data)
> > 
> > Why not make last arg as name and avoid void *
> > 
> 
> I can rename argument "data" to "name", but I can not change the prototype
> of the compare callback expected by component framework.

oh yes the data type can't be changed.

> 
> > > +{
> > > +	struct snd_soc_component *component = NULL;
> > > +	struct snd_soc_component *t;
> > 
> > why do you need two variables for this
> 
> We need two because one is iterator and other is find.
> 
> if we use just one we will endup with valid iterator item which may not have
> matched dev.
> 
> Or I can re-organize/simplify the code like this:
> 
> static int snd_soc_card_comp_compare(struct device *dev, void *name)
> {
>         struct snd_soc_component *t;
> 
>         lockdep_assert_held(&client_mutex);
>         list_for_each_entry(t, &component_list, list) {
>                 if (dev == t->dev) {
>                         if (!strcmp(t->name, name))
>                                 return 1;
>                 }
>         }
> 
>         return 0;
> }

looks better :)

> 
> > > +
> > > +	lockdep_assert_held(&client_mutex);
> > > +	list_for_each_entry(t, &component_list, list) {
> > > +		if (dev == t->dev) {
> > > +			component = t;
> > 
> > you can skip this line and use t in below code.
> > 
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (component && !strcmp(component->name, data))
> > 
> 
> 
> > strncmp?
> 
> AFAIU, strcmp should be safe here as component->name is generated/sanitized
> by core and would be of max len of NAME_SIZE.
> core uses strcmp in may places. Any particular reason you want me to move to
> strncmp?

I agree that name is generated but I don't trust strings :)

-- 
~Vinod
