Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4952084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I7fyq4rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfAKIn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:43:29 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10592 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfAKIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:43:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c38571d0001>; Fri, 11 Jan 2019 00:43:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Jan 2019 00:43:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Jan 2019 00:43:27 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 08:43:25 +0000
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
 <44a64e6e-c9ec-8eba-60fe-eda092250d82@nvidia.com>
 <20190110164835.GF9541@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <96f2e729-8ec2-44ee-448c-255c07c068b9@nvidia.com>
Date:   Fri, 11 Jan 2019 08:43:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110164835.GF9541@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547196190; bh=5pcftrVeWBzWp7XI8Y7Iqk9O1htsm06nDe6veZvMQHw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I7fyq4rPS3pTAQcFn6xV+mxLvj32/4I8OtCZVGHZtedXK6Mu3bpKtQFPw4IntQOkZ
         vPLKVAxuVVjf+IYMNdcbbL3mBDrXsdXUaunJ3OES6AhXFOpq16oYyiovDurquo+bid
         a1C5itGhKY5u+aMexpz7TSjpE15SglFuFVPkW2frZwvYKpS7oW6V2L3e3XUXuSOUXE
         zGrBR5s7xGfWr4dHCt0QgPRo3dDJA+8va8ofFfg0qYJA8K21M0IV9XpA39zysMCBKx
         bGPJSAU0Mz5iFrVWlP7oxH4ekXoQzV/MDphBv0NR0k8VCY/pRIovjvqideix+fZMgQ
         9H6JSaqKI5VjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/01/2019 16:48, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 12:13:36PM +0000, Jon Hunter wrote:
>> On 09/01/2019 18:36, Mark Brown wrote:
>>> On Tue, Jan 08, 2019 at 05:28:14PM +0000, Jon Hunter wrote:
> 
>>>> -	struct snd_soc_dai_link_component *platform;
>>>> +	struct snd_soc_dai_link_component platform;
> 
>>> This breaks the build for the SCU cards (and we needs a little rebase
>>> against another fix I just merged, though I did do that when applying).
> 
>> Sorry I still don't see the build break, can you point me to it?
> 
> I'd need to find your patch again and fix the rebase issue.  It was
> assigning a pointer to a platform IIRC.

Sorry I still don't see it. Happen to recall the config you were using
to build? I tried enabling the various SH soundcards (which I believe
the SCU card is under).

Jon

-- 
nvpublic
