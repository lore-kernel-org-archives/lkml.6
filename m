Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD0C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024E21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8024E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGLQEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:04:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:33773 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbeGLQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:04:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 08:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="215491532"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2018 08:54:06 -0700
Received: from jlee24-mobl.amr.corp.intel.com (unknown [10.254.75.127])
        by linux.intel.com (Postfix) with ESMTP id A4137580146;
        Thu, 12 Jul 2018 08:54:05 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
 <s5hsh4o8nq1.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0f437d5d-5857-a608-8d8f-345c832a0ee1@linux.intel.com>
Date:   Thu, 12 Jul 2018 10:54:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <s5hsh4o8nq1.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/18 10:42 AM, Takashi Iwai wrote:
> On Thu, 12 Jul 2018 17:26:00 +0200,
> Pierre-Louis Bossart wrote:
>>
>> On 7/11/18 3:43 AM, Srinivas Kandagatla wrote:
>>> This patch aims at add achieving dynamic behaviour of audio card when
>>> the dependent components disappear and reappear.
>>>
>>> With this patch the card is removed if any of the dependent component
>>> is removed and card is added back if the dependent component comes back.
>>> All this is done using component framework and matching based on
>>> component name.
>>
>> Humm, no real comment on this patch proper but rather on how userspace
>> would deal with this dynamic behavior?
>> We had similar opens when we worked on the BYT/CHT HDMI stuff and
>> ended-up with quite a few issues in userspace (PulseAudio mainly)
>> related to dynamic behavior at the kernel level as a result of
>> plug/unplug. Also not sure how an Android HAL would deal with a card
>> disappearing temporarily if DSP resources become unavailable or
>> unresponsive. Any thoughts or guidance you might think of?
> 
> Was the card-level register / unregister really problematic with PA?

I don't recall exactly. There were multiple implementations over time, 
one with the card created on plug-in, one where the PCM devices became 
available/unavailable based on plug-in, overall all of them introduced 
issues

> It's basically similar as the hotplug like USB, so I thought it would
> work as is.

Such transitions would probably not break userspace but they result from 
an explicit user action. The DSP going off and back is less clear, you 
might want the system to wait before triggering re-routing to different 
outputs, etc.

Again I wasn't trying to push back but rather ask what the side effects 
of this patch might be for userspace.

> 
> 
> Takashi
> 
>>
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>
>>> During discussion regarding card re-binding when components unregister
>>> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
>>> that component framework can be added into core to provide this feature.
>>>
>>> With this new changes the card will re-bind once the dependent component
>>> re-registers after unregistering. This works based on the match done
>>> from component name using component framework.
>>>
>>> I have tested this patch with qdsp start-stop usecase for more than 10000
>>> times in loop on Qcom platforms.
>>>
>>> I will send qdsp side cleanup patches once I get some feedback on this patch.
>>>
>>>
>>>    include/sound/soc.h  |  5 ++++
>>>    sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>>    2 files changed, 70 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>>> index 870ba6b64817..b94149d29c0d 100644
>>> --- a/include/sound/soc.h
>>> +++ b/include/sound/soc.h
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/workqueue.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/kernel.h>
>>> +#include <linux/component.h>
>>>    #include <linux/regmap.h>
>>>    #include <linux/log2.h>
>>>    #include <sound/core.h>
>>> @@ -1088,6 +1089,10 @@ struct snd_soc_card {
>>>      	struct work_struct deferred_resume_work;
>>>    +	/* component framework related */
>>> +	bool components_added;
>>> +	struct component_match *match;
>>> +
>>>    	/* lists of probed devices belonging to this card */
>>>    	struct list_head component_dev_list;
>>>    diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>>> index 6d33634b934b..377ed8e67686 100644
>>> --- a/sound/soc/soc-core.c
>>> +++ b/sound/soc/soc-core.c
>>> @@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
>>>      #endif
>>>    +static int snd_soc_card_comp_compare(struct device *dev, void
>>> *data)
>>> +{
>>> +	struct snd_soc_component *component = NULL;
>>> +	struct snd_soc_component *t;
>>> +
>>> +	lockdep_assert_held(&client_mutex);
>>> +	list_for_each_entry(t, &component_list, list) {
>>> +		if (dev == t->dev) {
>>> +			component = t;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (component && !strcmp(component->name, data))
>>> +		return 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
>>>    			      struct snd_soc_component *component)
>>>    {
>>>    	struct snd_soc_rtdcom_list *rtdcom;
>>>    	struct snd_soc_rtdcom_list *new_rtdcom;
>>> +	char *cname;
>>>      	for_each_rtdcom(rtd, rtdcom) {
>>>    		/* already connected */
>>> @@ -300,6 +320,13 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
>>>      	list_add_tail(&new_rtdcom->list, &rtd->component_list);
>>>    +	if (!rtd->card->components_added) {
>>> +		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
>>> +				       "%s", component->name);
>>> +		component_match_add(rtd->card->dev, &rtd->card->match,
>>> +				    snd_soc_card_comp_compare, cname);
>>> +	}
>>> +
>>>    	return 0;
>>>    }
>>>    @@ -835,6 +862,28 @@ static bool soc_is_dai_link_bound(struct
>>> snd_soc_card *card,
>>>    	return false;
>>>    }
>>>    +static int snd_soc_card_comp_bind(struct device *dev)
>>> +{
>>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>>> +
>>> +	if (card->instantiated)
>>> +		return 0;
>>> +
>>> +	return snd_soc_register_card(card);
>>> +}
>>> +
>>> +static void snd_soc_card_comp_unbind(struct device *dev)
>>> +{
>>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>>> +
>>> +	snd_soc_unregister_card(card);
>>> +}
>>> +
>>> +static const struct component_master_ops snd_soc_card_comp_ops = {
>>> +	.bind = snd_soc_card_comp_bind,
>>> +	.unbind = snd_soc_card_comp_unbind,
>>> +};
>>> +
>>>    static int soc_bind_dai_link(struct snd_soc_card *card,
>>>    	struct snd_soc_dai_link *dai_link)
>>>    {
>>> @@ -2108,6 +2157,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>>>      	card->instantiated = 1;
>>>    	snd_soc_dapm_sync(&card->dapm);
>>> +	if (!card->components_added) {
>>> +		component_master_add_with_match(card->dev,
>>> +						&snd_soc_card_comp_ops,
>>> +						card->match);
>>> +		card->components_added = true;
>>> +	}
>>>    	mutex_unlock(&card->mutex);
>>>    	mutex_unlock(&client_mutex);
>>>    @@ -3098,11 +3153,6 @@ static void
>>> snd_soc_component_cleanup(struct snd_soc_component *component)
>>>      static void snd_soc_component_del_unlocked(struct
>>> snd_soc_component *component)
>>>    {
>>> -	struct snd_soc_card *card = component->card;
>>> -
>>> -	if (card)
>>> -		snd_soc_unregister_card(card);
>>> -
>>>    	list_del(&component->list);
>>>    }
>>>    @@ -3169,8 +3219,17 @@ int snd_soc_add_component(struct device
>>> *dev,
>>>      	snd_soc_component_add(component);
>>>    +	ret = component_add(dev, NULL);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
>>> +		goto err_comp;
>>> +	}
>>> +
>>>    	return 0;
>>>    +err_comp:
>>> +	soc_remove_component(component);
>>> +	snd_soc_unregister_dais(component);
>>>    err_cleanup:
>>>    	snd_soc_component_cleanup(component);
>>>    err_free:
>>> @@ -3218,6 +3277,7 @@ static int __snd_soc_unregister_component(struct device *dev)
>>>    	mutex_unlock(&client_mutex);
>>>      	if (found) {
>>> +		component_del(dev, NULL);
>>>    		snd_soc_component_cleanup(component);
>>>    	}
>>>    
>>>
>>
>>

