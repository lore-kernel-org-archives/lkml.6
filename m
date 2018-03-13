Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeCMKc7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:32:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40086 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeCMKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:32:56 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-38x: add support for missing clocks
References: <20180308090300.23544-1-richard.genoud@gmail.com>
        <87h8pq4s92.fsf@bootlin.com> <877eqm4s68.fsf@bootlin.com>
        <ce834e07-5151-bb5a-b880-244e44e2ef08@gmail.com>
Date: Tue, 13 Mar 2018 11:32:29 +0100
In-Reply-To: <ce834e07-5151-bb5a-b880-244e44e2ef08@gmail.com> (Richard
        Genoud's message of "Tue, 13 Mar 2018 11:20:35 +0100")
Message-ID: <87k1ug1d1e.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
 
 On mar., mars 13 2018, Richard Genoud <richard.genoud@gmail.com> wrote:

> On 08/03/2018 14:23, Gregory CLEMENT wrote:
>> Hi,
>>  
>>  On jeu., mars 08 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>> 
>>> Hi Richard,
>>>  
>>>  On jeu., mars 08 2018, Richard Genoud <richard.genoud@gmail.com> wrote:
>>>
>>>> Clearfog boards can come with a CPU clocked at 1600MHz (commercial)
>>>> or 1333MHz (industrial).
>>>>
>>>> They have also some dip-switches to select a different clock (666, 800,
>>>> 1066, 1200).
>>>
>>> The patch looks goo and it will also be usefull for any other board
>>> using these frequencies, thanks for this. I have only one small comment,
>>> see below.
>> 
>> 
>> I forgot to mention that you can add my
>> 
>> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> 
>> Thanks,
>> 
>> Gregory
>> 
>>>
>>>
>>>>
>>>> The funny thing is that the recovery button is on the MPP34 fq selector.
>>>> So, when booting an industrial board with this button down, the frequency
>>>> 666MHz is selected (and the kernel didn't boot).
>>>>
>>>> This patch add all the missing clocks.
>>>>
>>>> The only mode I didn't test is 2GHz (uboot found 4294MHz instead :/ ).
>>>>
>>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>>> ---
>>>>  drivers/clk/mvebu/armada-38x.c | 14 +++++++-------
>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mvebu/armada-38x.c b/drivers/clk/mvebu/armada-38x.c
>>>> index 394aa6f03f01..9ff4ea63932d 100644
>>>> --- a/drivers/clk/mvebu/armada-38x.c
>>>> +++ b/drivers/clk/mvebu/armada-38x.c
>>>> @@ -46,11 +46,11 @@ static u32 __init armada_38x_get_tclk_freq(void __iomem *sar)
>>>>  }
>>>>  
>>>>  static const u32 armada_38x_cpu_frequencies[] __initconst = {
>>>> -	0, 0, 0, 0,
>>>> -	1066 * 1000 * 1000, 0, 0, 0,
>>>> +	666 * 1000 * 1000,  0, 800 * 1000 * 1000, 0,
>>>> +	1066 * 1000 * 1000, 0, 1200 * 1000 * 1000, 0,
>>>>  	1332 * 1000 * 1000, 0, 0, 0,
>>>>  	1600 * 1000 * 1000, 0, 0, 0,
>>>> -	1866 * 1000 * 1000,
>>>> +	1866 * 1000 * 1000, 0, 0, 2000 * 1000 * 1000,
>>>
>>> Maybe you could add a comment here to say that the 2GHz mode didn't have
>>> been tested.
> Well, if I add a comment there saying "2GHz mode hasn't been tested",
> I'm afraid it will stay there forever, even after being tested.
> (if it's working, nobody will look at it, and if it's not, it's in the
> commit message anyway).

OK fair enough.

>
> I was also thinking that this could go in -stable since it fixes a hang.
> In this case, commit 9593f4f56cf5 ("clk: mvebu: armada-38x: add support for 1866MHz variants")
> should also go with it.

In this case you have to send a new version of your patch with the cc:
stabale and Fixes: tags.

Gregory

>
>
>
> Thanks !
>
>>>
>>> Thanks,
>>> Gregory
>>>
>>>
>>>>  };
>>>>  
>>>>  static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
>>>> @@ -76,11 +76,11 @@ static const struct coreclk_ratio armada_38x_coreclk_ratios[] __initconst = {
>>>>  };
>>>>  
>>>>  static const int armada_38x_cpu_l2_ratios[32][2] __initconst = {
>>>> -	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>> -	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>> -	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>> +	{1, 2}, {0, 1}, {1, 2}, {0, 1},
>>>> +	{1, 2}, {0, 1}, {1, 2}, {0, 1},
>>>>  	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>> +	{1, 2}, {0, 1}, {0, 1}, {1, 2},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>> @@ -91,7 +91,7 @@ static const int armada_38x_cpu_ddr_ratios[32][2] __initconst = {
>>>>  	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>> -	{1, 2}, {0, 1}, {0, 1}, {0, 1},
>>>> +	{1, 2}, {0, 1}, {0, 1}, {7, 15},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>>  	{0, 1}, {0, 1}, {0, 1}, {0, 1},
>>>
>>> -- 
>>> Gregory Clement, Bootlin (formerly Free Electrons)
>>> Embedded Linux and Kernel engineering
>>> http://bootlin.com
>> 
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
