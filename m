Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F063C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F063C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeLFHce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:32:34 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:44698 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLFHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:32:33 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUo96-0003I1-AH from Jiada_Wang@mentor.com ; Wed, 05 Dec 2018 23:32:28 -0800
Received: from [172.30.112.134] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 5 Dec 2018 23:32:24 -0800
Subject: Re: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
 <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
 <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
 <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
 <011cfbf7-70d0-a649-52de-1689cdb5a10b@mentor.com>
 <871s6vjkaz.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <590d14cc-4d08-514a-6edc-2b4bad3c1993@mentor.com>
Date:   Thu, 6 Dec 2018 16:32:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871s6vjkaz.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/12/06 14:38, Kuninori Morimoto wrote:
> Hi Jiada
>
>> SMSTPCR922 controls input of two clocks "S0D1ϕ" and "S0D4ϕ",
> Ahh, OK I could check it via Block diagram.
> But it is "Module stop" for these, anyway.
> "Module stop" and "S0D1ϕ/S0D4ϕ" are completely different clocks.
Yes, "module stop" is different from "S0D1ϕ/S0D4ϕ",
both clk_i and avb_counter8's parent clock is same "module stop" clock,
which is <&cpg CPG_MOD 922>, it is a shared gate clock between
avb_counter8 and clk_i


>
>> "S0D4ϕ" is input to BRGA,
>> "S0D1ϕ" is input to avb_counter8
> It seems we need to update "clk_i" portion first for this purpose.
> Then, we need to consider about Gen2 vs Gen3, etc, etc...
> It seems we can't keep patch simple...
Yes, I know it's not simple, so I want to discuss with you,
how we can proceed on this topic,
by adding avb_counter8, rcar audio can support arbitrary clock rate,
which is a desired feature, IMO

>>> 3rd, we need to create new clock/handler for
>>> avb_counter8 / audio_clk_div3 / avb_div8 for "internal" purpose,
>>> and need to create avb_adg_syn[] clock for "external" purpose for EAVB/IF.
>>> Your code is creating / registering adg->clkavb[],
>>> but it is for avb_counter8 in my understanding.
>>> We don't need to register it as formal clock IMO.
>> I agree, besides avb_counter8 there are other clocks which need to be
>> added as you have mentioned,
>> in this patch-set, I only added avb_counter8, because I want to keep
>> the patch-set simple,
>> other clocks can be added later.
> No, No, No.
> avb_counter8 is just "internal" clock, and one of
> parent clock for avb_div8 which is needed for avb_adg_syn[].
> We need to control/register is avb_adg_syn[], not avb_counter8.
>
> Your approach on this patch is very "Quick-Hack".
> I have no objection for out-of-tree patches.
> But, "Quick-Hack approach with changing formal DT on upstream"
> is nightmare.
>
>> avb_counter8 is registered as formal clock is because,
>> there is use case that EAVB-IF may use avb_div8, and avb_counter8 is
>> input to avb_div8.
>> if keeps avb_counter8 'internal', I am not sure how EAVB-IF can set
>> clock rate for avb_counter8
> EAVB/IF driver setups avb_adg_syn[].
> Then, ADG considers/searchs avb_counter8/avb_div8/audio_clk_div3
> settings internally.
> Don't control avb_counter8 directly from EAVB.
OK, I think I understand your point,
which avb_counter8 / avb_div8/audio_clk_div3 need to be used,
only need to be considered by adg internally.

Thanks,
Jiada

> Best regards
> ---
> Kuninori Morimoto

