Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31443C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050D220842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfBYKLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:11:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBYKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:11:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5D55E27EB98
Subject: Re: [PATCH -next] platform/chrome: Fix Kconfig dependencies for
 wilco_ec
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        sfr@canb.auug.org.au, cychiang@chromium.org, broonie@kernel.org,
        alsa-devel@alsa-project.org
References: <20190220221128.48476-1-ncrews@chromium.org>
 <420e6e26-6270-e577-6bbc-3ebe884168b5@infradead.org>
 <765ebb17-4523-d915-bdce-9ecde26836f0@collabora.com>
 <9ac9ee8e-cd7a-10e4-e176-428344e980a6@infradead.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e30adf98-143b-a9fb-3675-c356bdf31ad0@collabora.com>
Date:   Mon, 25 Feb 2019 11:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9ac9ee8e-cd7a-10e4-e176-428344e980a6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the report

On 22/2/19 17:50, Randy Dunlap wrote:
> On 2/20/19 11:57 PM, Enric Balletbo i Serra wrote:
>> Hi,
>>
>> On 21/2/19 0:09, Randy Dunlap wrote:
>>> On 2/20/19 2:11 PM, Nick Crews wrote:
>>>> In the initial version of the Wilco EC Driver, the
>>>> dependency order was wrong. It before was possible to
>>>> select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
>>>> having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
>>>> WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
>>>> other way around.
>>>>
>>>> Fixes: 1733c32834e5d1 ("platform/chrome: Add new driver for Wilco EC")
>>>> Signed-off-by: Nick Crews <ncrews@chromium.org>
>>>
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>>>
>>
>> As this is [-next] material I squashed that commit and queued for 5.1
> 
> Hi,
> 
> on linux-next of 20190222, I now see this build error + Kconfig warnings:
> 
> (this is on i386; randconfig file is attached)
> 
> WARNING: unmet direct dependencies detected for SND_SOC_CROS_EC_CODEC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MFD_CROS_EC [=n]
>   Selected by [y]:
>   - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y]


This error seems to be introduced by following commit.

commit 74c6ecf4194ebed285b29964a950e0cd7414fe19
Author: Cheng-Yi Chiang <cychiang@chromium.org>
Date:   Mon Feb 18 12:18:19 2019 +0800

    ASoC: qcom: Kconfig: select dmic for sdm845

    sdm845 uses dmic on EC so it should select CROS_EC_CODEC.

    Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

The problem is that this commit selects CROS_EC_CODEC but the CROS_EC_CODEC
depends on MFD_CROS_EC which is not selected.

A question for Cheng-Yi, I suppose that the answer is yes but worth ask because
I don't know about this device. Is the sdm845 a chromebook with and embedded
controller right?

Thanks,
Enric

> 
> ld: sound/soc/codecs/cros_ec_codec.o: in function `ec_command_no_resp':
> cros_ec_codec.c:(.text+0x50): undefined reference to `cros_ec_cmd_xfer_status'
> ld: sound/soc/codecs/cros_ec_codec.o: in function `mic_gain_get':
> cros_ec_codec.c:(.text+0x5a8): undefined reference to `cros_ec_cmd_xfer_status'
> 
> 
> 
