Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3924C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE92145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBJPla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:41:30 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:35202 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfBJPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:41:30 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1AFfHlu071760;
        Mon, 11 Feb 2019 00:41:17 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 11 Feb 2019 00:41:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1AFfHZB071756
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Feb 2019 00:41:17 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
References: <20190130235022.21949-1-katsuhiro@katsuster.net>
 <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <079d43be-0643-a55b-5d88-3e5e900529ed@katsuster.net>
Date:   Mon, 11 Feb 2019 00:41:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks a lot for your review. I choose clk_hw_can_set_parent_rate()
macro and fix typo and patch description. And I post v2 patch.

Best Regards,
Katsuhiro Suzuki

On 2019/02/07 4:40, Stephen Boyd wrote:
> +Heiko because it mentions Rockchip
> 
> Quoting Katsuhiro Suzuki (2019-01-30 15:50:22)
>> Custom approximation of fractional-divider may not need parent clock
>> rate checking. For example Rockchip SoCs work fine using grand parent
>> clock rate even if target rate is greater than parent.
>>
>> This patch removes parent clock rate check from custom approximation.
>>
>> For detailied example, clock tree of Rockchip I2S audio hardware.
> 
> s/detailied/detailed/
> 
>>    - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
>>      Initialize divider value is 1.
> 
> s/Initialize/Initial/
> 
>>    - A i2s1_frac is fractional divider can divide input to x/y, x and
>>      y are 16bit integer.
>>    - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>>
>> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
>> GPLL --> |          | ,--------------'    |          |
>>                        `--> i2s1_frac ---> |          |
>>
>> Clock mux system try to choose suitable one from i2s1_div and
>> i2s1_frac for master clock (MCLK) of I2S1.
>>
>> Bad scenario as follows:
>>    - Try to set MCLK to 8.192MHz (32kHz audio replay)
>>      Candidate setting is
>>      - i2s1_div : GPLL / 60           = 8.192MHz
>>      i2s1_div is same as target clock rate, so mux choose this.
>>      i2s1_div output rate is changed 491.52MHz -> 8.192MHz
>>
>>    - After that try to set to 11.2896MHz (44.1kHz audio replay)
>>      Candidate settings are
>>      - i2s1_div : CPLL / 107 = 11.214945MHz
>>      - i2s1_frac: i2s1_div   = 8.192MHz
>>        This is because clk_fd_round_rate() thinks target rate
>>        (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
>>        and returns parent clock rate.
>>      Clock mux system choose i2s1_div, but this clock rate is not
>>      acceptable for I2S driver, so users cannot replay audio.
>>
>> Expected behavior is:
>>    - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>>      Candidate settings are
>>      - i2s1_div : CPLL / 107          = 11.214945MHz
>>      - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
>>                   (change i2s1_div to GPLL / 1 = 491.52MHz)
>>        If apply this commit, clk_fd_round_rate() calls custom
>>        approximate function of Rockchip even if target rate is higher
>>        than parent. Custom function changes both grand parent
>>        (i2s1_div) and parent (i2s_frac) settings at same time.
> 
> Can you indicate what that function is? Is this merged upstream or
> something you're developing now?
> 
>>      Clock mux system can choose i2s1_frac and audio works fine.
> 
> I think this last paragraph from "If apply this commit" can be
> unindented from the expected behavior section.
> 
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   drivers/clk/clk-fractional-divider.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
>> index 545dceec0bbf..b0fc5509e0ff 100644
>> --- a/drivers/clk/clk-fractional-divider.c
>> +++ b/drivers/clk/clk-fractional-divider.c
>> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>>          unsigned long m, n;
>>          u64 ret;
>>   
>> -       if (!rate || rate >= *parent_rate)
>> +       if (!rate)
>>                  return *parent_rate;
> 
> Ok. I think it would be clearer if we had
> 
> 	unsigned long flags = clk_hw_get_flags()
> 
> 	if (!rate ||
> 	    !(flags & CLK_SET_PARENT_RATE) && rate >= *parent_rate)
> 
> indicating that the parent of the clk isn't expected to change rate so
> we can only achieve that much frequency. Plus some sort of comment to
> this effect would be helpful too.
> 
> We could also introduce macros to check clk flags. Then it would read
> nicer:
> 
> 	if (!rate || clk_hw_can_set_parent_rate(hw) && rate >= ...)
> 
> 
> 

