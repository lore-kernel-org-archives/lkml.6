Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BB921773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECZD20Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfAJOTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:19:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35276 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfAJOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:19:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so12319453wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/DJ4xzURs+oXeO7mYae7kTiEpfNzOK0nTghLvbn8nAQ=;
        b=ECZD20JsdmYy5x8r5pjDz9WsHgD/evKFCchiVnyUWNoux9NLLjF5MDIDhRYX15vfp0
         BRBfZZKLuSCva20szdtrbd3OQh3KANBykbytxQqKD7jnPgmErP7dyPFWerVQKeTkFic3
         gzwX88KbIpWNmBPOykOrjo/VEumroogkjKWjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/DJ4xzURs+oXeO7mYae7kTiEpfNzOK0nTghLvbn8nAQ=;
        b=cd258/HBCRQ80Lv2gZnMdT29VRXDs49sbxtMTxfxr4dM8pd83R+VAXqZjmiUp9F15C
         f0Z30aoV3iR6zqEqHFpBu0y4qhuJm/2Ij4orBIdf6KBXT2zsW3fHMEy/jChN/QS17rM/
         r1kAQ6LU52TxQDhwwNhGGNtVhovQLgUaI+cXrxwikRTE9JukQVZqtqqfAGM34WaKhjjK
         ZL4jNfEBItGPSp10wMZ2SEg0gnIYEgkYDN1xOIUfVe3CfmNkHEzYn+boB6WRUe4u2TSi
         pli5gHaQGB6Nbb0UQ9Xgi7l8AJ3mca60XdIgm2z3Te9y9GjLqZjeMIBxGQ5UEjTt5i66
         90dg==
X-Gm-Message-State: AJcUuke2m/nTKe1niX6OfcLqYSqQM3seiHwiI4kF6b1jVUnnki7mRf0r
        1ZkrKM1RNShyEUjuA1v5aqiwkA==
X-Google-Smtp-Source: ALg8bN7Otc5CAGVJNcTfv3E0q8Q4FdndAxI3Ok4cYPW6HORgOjtUbj8Khrg6Tckx0iCxYsmXGVVmdA==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr9421063wme.94.1547129959298;
        Thu, 10 Jan 2019 06:19:19 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o8sm52974566wrx.15.2019.01.10.06.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 06:19:18 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        evgreen@chromium.org, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        bjorn.andersson@linaro.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com>
 <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
 <6923d6ed-e357-b083-1830-8396d788efe5@linaro.org>
 <CAJZ5v0jZMqFwYgnfRz04ELLRk=0U8Uv=acw0t9Azxk_HYL0gSQ@mail.gmail.com>
 <9a3aae02-c7e0-97e3-2330-af4fccee6c14@linaro.org>
 <20181211065808.GB5161@kroah.com>
 <199be960-032a-d72d-4293-820e23a15b7a@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b21d13df-7c0b-4c6d-e3c7-6ab285579ed5@linaro.org>
Date:   Thu, 10 Jan 2019 16:19:14 +0200
MIME-Version: 1.0
In-Reply-To: <199be960-032a-d72d-4293-820e23a15b7a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/17/18 13:17, Georgi Djakov wrote:
> Hi Greg,
> 
> On 12/11/18 08:58, Greg Kroah-Hartman wrote:
>> On Mon, Dec 10, 2018 at 04:50:00PM +0200, Georgi Djakov wrote:
>>> On 12/10/18 13:00, Rafael J. Wysocki wrote:
>>>> On Mon, Dec 10, 2018 at 11:18 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> On 12/10/18 11:04, Rafael J. Wysocki wrote:
>>>>>> On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
>>>>>>>> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
>>>>>>>>> graphics, modem). These cores are talking to each other and can generate a
>>>>>>>>> lot of data flowing through the on-chip interconnects. These interconnect
>>>>>>>>> buses could form different topologies such as crossbar, point to point buses,
>>>>>>>>> hierarchical buses or use the network-on-chip concept.
>>>>>>>>>
>>>>>>>>> These buses have been sized usually to handle use cases with high data
>>>>>>>>> throughput but it is not necessary all the time and consume a lot of power.
>>>>>>>>> Furthermore, the priority between masters can vary depending on the running
>>>>>>>>> use case like video playback or CPU intensive tasks.
>>>>>>>>>
>>>>>>>>> Having an API to control the requirement of the system in terms of bandwidth
>>>>>>>>> and QoS, so we can adapt the interconnect configuration to match those by
>>>>>>>>> scaling the frequencies, setting link priority and tuning QoS parameters.
>>>>>>>>> This configuration can be a static, one-time operation done at boot for some
>>>>>>>>> platforms or a dynamic set of operations that happen at run-time.
>>>>>>>>>
>>>>>>>>> This patchset introduce a new API to get the requirement and configure the
>>>>>>>>> interconnect buses across the entire chipset to fit with the current demand.
>>>>>>>>> The API is NOT for changing the performance of the endpoint devices, but only
>>>>>>>>> the interconnect path in between them.
>>>>>>>>
>>>>>>>> For what it's worth, we are ready to land this in Chrome OS. I think
>>>>>>>> this series has been very well discussed and reviewed, hasn't changed
>>>>>>>> much in the last few spins, and is in good enough shape to use as a
>>>>>>>> base for future patches. Georgi's also done a great job reaching out
>>>>>>>> to other SoC vendors, and there appears to be enough consensus that
>>>>>>>> this framework will be usable by more than just Qualcomm. There are
>>>>>>>> also several drivers out on the list trying to add patches to use this
>>>>>>>> framework, with more to come, so it made sense (to us) to get this
>>>>>>>> base framework nailed down. In my experiments this is an important
>>>>>>>> piece of the overall power management story, especially on systems
>>>>>>>> that are mostly idle.
>>>>>>>>
>>>>>>>> I'll continue to track changes to this series and we will ultimately
>>>>>>>> reconcile with whatever happens upstream, but I thought it was worth
>>>>>>>> sending this note to express our "thumbs up" towards this framework.
>>>>>>>
>>>>>>> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
>>>>>>> it to the tree if all looks good.
>>>>>>
>>>>>> I'm honestly not sure if it is ready yet.
>>>>>>
>>>>>> New versions are coming on and on, which may make such an impression,
>>>>>> but we had some discussion on it at the LPC and some serious questions
>>>>>> were asked during it, for instance regarding the DT binding introduced
>>>>>> here.  I'm not sure how this particular issue has been addressed here,
>>>>>> for example.
>>>>>
>>>>> There have been no changes in bindings since v4 (other than squashing
>>>>> consumer and provider bindings into a single patch and fixing typos).
>>>>>
>>>>> The last DT comment was on v9 [1] where Rob wanted confirmation from
>>>>> other SoC vendors that this works for them too. And now we have that
>>>>> confirmation and there are patches posted on the list [2].
>>>>
>>>> OK
>>>>
>>>>> The second thing (also discussed at LPC) was about possible cases where
>>>>> some consumer drivers can't calculate how much bandwidth they actually
>>>>> need and how to address that. The proposal was to extend the OPP
>>>>> bindings with one more property, but this is not part of this patchset.
>>>>> It is a future step that needs more discussion on the mailing list. If a
>>>>> driver really needs some bandwidth data now, it should be put into the
>>>>> driver and not in DT. After we have enough consumers, we can discuss
>>>>> again if it makes sense to extract something into DT or not.
>>>>
>>>> That's fine by me.
>>>>
>>>> Admittedly, I have some reservations regarding the extent to which
>>>> this approach will turn out to be useful in practice, but I guess as
>>>> long as there is enough traction, the best way to find out it to try
>>>> and see. :-)
>>>>
>>>> From now on I will assume that this series is going to be applied by Greg.
>>>
>>> That was the initial idea, but the problem is that there is a recent
>>> change in the cmd_db API (needed by the sdm845 provider driver), which
>>> is going through arm-soc/qcom/drivers. So either Greg pulls also the
>>> qcom-drivers-for-4.21 tag from Andy or the whole series goes via Olof
>>> and Arnd. Maybe there are other options. I don't have any preference and
>>> don't want to put extra burden on any maintainers, so i am ok with what
>>> they prefer.
>>
>> Let me take the time later this week to review the code, which I haven't
>> done in a while...
>>
> 
> When you get a chance to review, please keep in mind that the latest
> version is v12 (from 08.Dec). The same is also available in linux-next
> with no reported issues.

The dependencies for this patchset have been already merged in v5.0-rc1,
so i was wondering if this can still go into -rc2? Various patches that
use this API are already posted and having it sooner will make dealing
with dependencies and merge paths a bit easier during the next merge
window. Or i can just rebase and resend everything targeting v5.1.

Thanks,
Georgi
