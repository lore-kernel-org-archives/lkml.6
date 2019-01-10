Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356D920651
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C81DTwd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfAJMNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:13:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16149 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfAJMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:13:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3736e20000>; Thu, 10 Jan 2019 04:13:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 04:13:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 04:13:40 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 12:13:38 +0000
Subject: Re: [PATCH] ASoC: core: Fix deferral of machine drivers
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>
References: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
 <20190109183605.GH10405@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <44a64e6e-c9ec-8eba-60fe-eda092250d82@nvidia.com>
Date:   Thu, 10 Jan 2019 12:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109183605.GH10405@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547122402; bh=QW/UqJlk4eW9p142XtnkIXZJkvbgA9kiQh2CgGf6xEI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=C81DTwd8+mua7xsC4NUS7KO6PMixg/krlSZmdBW64f1Q2gJOHrnqmGndmJtAj3trd
         X1325PSYy7bNu3zYGBeSEVXabjgRgkQ/M2LiakRYZTQ9+9494N2usvo4BU3nzhraPs
         vAayigUqJENPMbAlu2Zmq08cfJFqhHjwAs3u9fUGUQ4PpW9KTwAdR5OzAcElyCApgU
         tR1irGD0DwmUZXHGOt6gSH58M0Ph80Al6mcKsca2GiWWqtRPVVeJufySexQ1V7nOGa
         +LDAQkQQ9Ik4F2s7BOnfWbWJxYvt67WiA7RodrcwqDj9SfKyb0EtNk4GEjp5s7miMQ
         LR15nAhjIRpRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2019 18:36, Mark Brown wrote:
> On Tue, Jan 08, 2019 at 05:28:14PM +0000, Jon Hunter wrote:
> 
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -925,7 +925,7 @@ struct snd_soc_dai_link {
>>  	 */
>>  	const char *platform_name;
>>  	struct device_node *platform_of_node;
>> -	struct snd_soc_dai_link_component *platform;
>> +	struct snd_soc_dai_link_component platform;
>>  
>>  	int id;	/* optional ID for machine driver link identification */
>>  
> 
> This breaks the build for the SCU cards (and we needs a little rebase
> against another fix I just merged, though I did do that when applying).

Sorry I still don't see the build break, can you point me to it?

> I do think that this is going to be the safest thing to do for v5.0, it
> can always be reverted later on when it's not needed but it seems clear
> that a better fix is going to be way too invasive for the -rcs.  Can you
> respin and retest please?

Yes will do. I do wonder if we should be concerned about
snd_soc_init_multicodec() as well? Looks like it could have a different
problem if a machine driver already allocated the memory for the codec
link component.

Cheers
Jon

-- 
nvpublic
