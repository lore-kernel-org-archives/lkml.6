Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeBSSRf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:17:35 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36248 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeBSSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:17:33 -0500
X-Google-Smtp-Source: AH8x2260qNHlphvJfC6IDl1kmd6sTRimRav38g2GBWY5wi9oJ14wkrkXGoGcJOVU4XOciAxXqST/dg==
Date: Mon, 19 Feb 2018 10:03:27 -0800
In-Reply-To: <83d6bd0da9254d868d3f713bd3bc282c@www.loen.fr>
References: <20170301183257.6554-1-f.fainelli@gmail.com> <83d6bd0da9254d868d3f713bd3bc282c@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH fixes v3] pinctrl: Really force states during  suspend/resume
To: Marc Zyngier <maz@misterjones.org>
CC: linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com,
        linux-gpio@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <913ED32F-36F8-4F31-9221-263DD5599FB2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JIHdGt005946

On February 19, 2018 9:25:26 AM PST, Marc Zyngier <maz@misterjones.org> wrote:
>Hi all,
>
>On 2017-03-01 18:32, Florian Fainelli wrote:
>> In case a platform only defaults a "default" set of pins, but not a
>> "sleep" set of pins, and this particular platform suspends and 
>> resumes
>> in a way that the pin states are not preserved by the hardware, when 
>> we
>> resume, we would call pinctrl_single_resume() -> 
>> pinctrl_force_default()
>> -> pinctrl_select_state() and the first thing we do is check that the
>> pins state is the same as before, and do nothing.
>>
>> In order to fix this, decouple the actual state change from
>> pinctrl_select_state() and move it pinctrl_commit_state(), while 
>> keeping
>> the p->state == state check in pinctrl_select_state() not to change 
>> the
>> caller assumptions. pinctrl_force_sleep() and pinctrl_force_default()
>> are updated to bypass the state check by calling 
>> pinctrl_commit_state().
>>
>> Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states
>> per device")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Changes in v3:
>>
>> - move the state check to pinctrl_select_state
>>
>> Changes in v2:
>>
>> - rename __pinctrl_select_state to pinctrl_commit_state
>>
>>  drivers/pinctrl/core.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>> index fb38e208f32d..735d8f7f9d71 100644
>> --- a/drivers/pinctrl/core.c
>> +++ b/drivers/pinctrl/core.c
>> @@ -992,19 +992,16 @@ struct pinctrl_state
>> *pinctrl_lookup_state(struct pinctrl *p,
>>  EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
>>
>>  /**
>> - * pinctrl_select_state() - select/activate/program a pinctrl state 
>> to HW
>> + * pinctrl_commit_state() - select/activate/program a pinctrl state 
>> to HW
>>   * @p: the pinctrl handle for the device that requests configuration
>>   * @state: the state handle to select/activate/program
>>   */
>> -int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state 
>> *state)
>> +static int pinctrl_commit_state(struct pinctrl *p, struct
>> pinctrl_state *state)
>>  {
>>  	struct pinctrl_setting *setting, *setting2;
>>  	struct pinctrl_state *old_state = p->state;
>>  	int ret;
>>
>> -	if (p->state == state)
>> -		return 0;
>> -
>>  	if (p->state) {
>>  		/*
>>  		 * For each pinmux setting in the old state, forget SW's record
>> @@ -1068,6 +1065,19 @@ int pinctrl_select_state(struct pinctrl *p,
>> struct pinctrl_state *state)
>>
>>  	return ret;
>>  }
>> +
>> +/**
>> + * pinctrl_select_state() - select/activate/program a pinctrl state 
>> to HW
>> + * @p: the pinctrl handle for the device that requests configuration
>> + * @state: the state handle to select/activate/program
>> + */
>> +int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state 
>> *state)
>> +{
>> +	if (p->state == state)
>> +		return 0;
>> +
>> +	return pinctrl_commit_state(p, state);
>> +}
>>  EXPORT_SYMBOL_GPL(pinctrl_select_state);
>>
>>  static void devm_pinctrl_release(struct device *dev, void *res)
>> @@ -1236,7 +1246,7 @@ void pinctrl_unregister_map(struct pinctrl_map
>> const *map)
>>  int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
>>  {
>>  	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
>> -		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
>> +		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
>> @@ -1248,7 +1258,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
>>  int pinctrl_force_default(struct pinctrl_dev *pctldev)
>>  {
>>  	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_default))
>> -		return pinctrl_select_state(pctldev->p, pctldev->hog_default);
>> +		return pinctrl_commit_state(pctldev->p, pctldev->hog_default);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(pinctrl_force_default);

Hey Marc,

>
>I don't often go back over a year worth of LKML, but since this patch 
>recently landed in mainline as 981ed1bfbc6c, I though I'd use it as an 
>anchor to report the following:
>
>It turns out that this patch completely breaks resume on my 
>rk3399-based Chromebook. Most things are timing out, the box is 
>unusable. And since this is my everyday tool, I'm mildly grumpy. Please
>
>don't break my toys! ;-) Reverting this patch on top of 4.16-rc2 makes 
>me productive again...
>
>More seriously, I have no idea what's wrong here. It could be a 
>SoC-related issue, hence Heiko on Cc. I'm happy to test any idea you 
>could have.

Can you indicate which DTS file is used for your Chromebook model? Sorry about the breakage.

-- 
Florian
