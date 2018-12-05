Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB57120672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB57120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeLEMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:16:45 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:48756 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:16:45 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUW6F-00068W-91 from Jiada_Wang@mentor.com ; Wed, 05 Dec 2018 04:16:19 -0800
Received: from [172.30.112.81] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Dec
 2018 04:16:15 -0800
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
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
Date:   Wed, 5 Dec 2018 21:16:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

Thanks for your comments

On 2018/12/05 17:58, Kuninori Morimoto wrote:
> Hi Jiada
>
>> There are AVB Counter Clocks in ADG, each clock has 12bits integral
>> and 8 bits fractional dividers which operates with S0D1ϕ clock.
>>
>> This patch registers 8 AVB Counter Clocks when clock-cells of
>> rcar_sound node is 2,
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>
>> +static void clk_avb_div_write(struct rsnd_adg *adg, u32 data, unsigned int idx)
> (snip)
>> +static u32 clk_avb_div_read(struct rsnd_adg *adg, unsigned int idx)
> As I mentioned before, I think we can avoid confusable parameter by
>
> 	static void clk_avb_div_write(struct clk_avb *avb, u32 data)
> 	static u32 clk_avb_div_read(struct clk_avb)	
>
> 	div = clk_avb_div_read(avb);
> 	clk_avb_div_write(avb, val | div);
right, I forgot to update this, will address it in next version
>> +static struct clk *clk_register_avb(struct device *dev, struct rsnd_adg *adg,
>> +				    unsigned int id, spinlock_t *lock)
>> +{
>> +	struct clk_init_data init;
>> +	struct clk_avb *avb;
>> +	struct clk *clk;
>> +	char name[8];
>> +	const char *parent_name;
>> +
>> +	if (IS_ERR(adg->clkadg))
>> +		return ERR_PTR(-ENODEV);
> I think adg->clkadg will never hit to IS_ERR().
> It will have NULL or correct pointer.
right, will update this in next version
> 	clk = devm_clk_get(dev, "adg");
> 	if (!IS_ERR(clk))
> 		adg->clkadg = clk;
>
> And this "adg" clock is strange.
> see below
>
>> +	avb = devm_kzalloc(dev, sizeof(*avb), GFP_KERNEL);
>> +	if (!avb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	parent_name = __clk_get_name(adg->clkadg);
> This parent_name is very strange to me.
> AVB parent clk is "AUDIO_CLK_A/B/C/I" (= clk_a/b/c/i in this driver)
> or "AUDIO_CLK_OUT_A/B/C/D" (= audio_clkout/1/2/3 in this driver).
> And we don't have "adg" clock.
> Please double check it.
I have some local device-tree change, which expends 'adg' register range 
and add
"adg" clock to rcar_sound node which refer to newly added 'adg' clock 
(S0D1ϕ) in this patch-set

the change looks like the following

                         compatible =  "renesas,rcar_sound-r8a7795", 
"renesas,rcar_sound-gen3";
                         reg =   <0 0xec500000 0 0x1000>, /* SCU */
-                               <0 0xec5a0000 0 0x100>,  /* ADG */
+                               <0 0xec5a0000 0 0x140>,  /* ADG */
                                 <0 0xec540000 0 0x1000>, /* SSIU */
                                 <0 0xec541000 0 0x280>,  /* SSI */
                                 <0 0xec740000 0 0x200>;  /* Audio DMAC 
peri peri*/
                         reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";

-                       clocks = <&cpg CPG_MOD 1005>,
+                       clocks = <&cpg CPG_MOD 922>, <&cpg CPG_MOD 1005>,
                                  <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
                                  <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
                                  <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
@@ -1856,7 +1856,7 @@
                                  <&audio_clk_a>, <&audio_clk_b>,
                                  <&audio_clk_c>,
                                  <&cpg CPG_CORE R8A7795_CLK_S0D4>;
-                       clock-names = "ssi-all",
+                       clock-names = "adg", "ssi-all",
                                       "ssi.9", "ssi.8", "ssi.7", "ssi.6",
                                       "ssi.5", "ssi.4", "ssi.3", "ssi.2",
                                       "ssi.1", "ssi.0",

Thanks,
Jiada

> Best regards
> ---
> Kuninori Morimoto

