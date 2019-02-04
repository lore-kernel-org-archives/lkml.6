Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E23C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80E2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MSbJTlMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfBDJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:53:42 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8431 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfBDJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:53:42 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c580b850001>; Mon, 04 Feb 2019 01:53:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 01:53:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 Feb 2019 01:53:40 -0800
Received: from [10.26.11.58] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 4 Feb
 2019 09:53:35 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <mkumard@nvidia.com>,
        <rlokhande@nvidia.com>, <sharadg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
Date:   Mon, 4 Feb 2019 09:53:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204084555.GF19087@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549273989; bh=gLbLspNeEzv9ButkuNnbODVIuU9VPPeri6Pdu5V0dcI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MSbJTlMdxeXYJXskqSL0acmkTIP7RgmHNxcWbuyckTFnse1OkCIjfuHHlk22bbK/d
         2sCXAkcmztHPVaOxaYZmfFV6b0tqJZlfwXR1Uj4eoY3iuP63YVx6HiZ2uPtfjCnOCX
         Fl4XaPhd4CtvtwbII0UyRu2bLsD0SieJUK4rI1Q0U5XdGzxOZDixf55sEKecnU1sZw
         qz2ZzwoRPh+4NCiePOhbFHDadqNc92G9hcMGDnb8Ms7S1rTm3sUCdF6ABH8F426ill
         fcmLDKUJLIBfDirhj9HZN2nR0f3Z8ktKGZMkXlp1yqVht4qO0+YizxV2vTw6mGY/EG
         3IOW8kWCErExQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2019 08:45, Thierry Reding wrote:

...

> The idea was, as I was saying below, to reuse dev_pm_ops even if
> !CONFIG_PM. So pm_runtime_enable() could be something like this:
> 
> 	pm_runtime_enable(dev)
> 	{
> 		if (!CONFIG_PM)
> 			if (dev->pm_ops->resume)
> 				dev->pm_ops->resume(dev);
> 
> 		...
> 	}
> 
> But that's admittedly somewhat of a stretch. This could of course be
> made somewhat nicer by adding an explicit variant, say:
> 
> 	pm_runtime_enable_foo(dev)
> 	{
> 		if (!CONFIG_PM && dev->pm_ops->resume)
> 			return dev->pm_ops->resume(dev);
> 
> 		return 0;
> 	}
> 
> Maybe the fact that I couldn't come up with a good name is a good
> indication that this is a bad idea...

How about some new APIs called ...

pm_runtime_enable_get()
pm_runtime_enable_get_sync()
pm_runtime_put_disable() (implies a put_sync)

... and in these APIs we add ...

pm_runtime_enable_get(dev)
{
	if (!CONFIG_PM && dev->pm_ops->resume)
		return dev->pm_ops->resume(dev);

	pm_runtime_enable(dev);
	return pm_runtime_get(dev);
}

>>> This would be somewhat tricky because drivers
>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>>> that would result in an empty structure if !CONFIG_PM, but we could
>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>>> never be compiled out for this kind of case. Or such drivers could even
>>> manually set .runtime_suspend and .runtime_resume to make sure they're
>>> always populated.
>>>
>>> Another way out of this would be to make sure we never run into the case
>>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>>> should always be available. But is it guaranteed that runtime PM for the
>>> devices is functional in that case? From a cursory look at the code it
>>> would seem that way.
>>
>> If you select PM, then all of the requisite code should be there.
> 
> We do this on 64-bit ARM, but there had been some pushback when we had
> proposed to do the same thing on 32-bit ARM. I think there were two
> concerns:
> 
> 	1) select PM would force the setting for all platforms on multi-
> 	   platforms builds
> 
> 	2) prevents anyone from disabling PM for debugging purposes
> 
> 1) no longer seems to be valid because Rockchip already selects PM
> unconditionally. I'm not sure if 2) is valid anymore either. I haven't
> run a build with !PM in a very long time and I wouldn't be surprised if
> that was completely broken.
> 
> Maybe we need to try this again since a couple of years have elapsed and
> runtime PM support on Tegra is much more mature at this point.
> 
>> Alternatively, you can make the driver depend on PM.
> 
> That's probably the easiest way out, but to be honest I think I'd prefer
> to just enforce PM and keep things simple.
> 
> Jon, any objections?

None, but seems overkill just for this case.

Cheers
Jon

-- 
nvpublic
