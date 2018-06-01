Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeFAHSn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:18:43 -0400
Received: from out3-6.antispamcloud.com ([185.201.18.6]:36398 "EHLO
        out3-6.antispamcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAHSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:18:39 -0400
Subject: Re: [PATCH] clk-si544: Properly round requested frequency to nearest
 match
To: Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
References: <1527775435-5017-1-git-send-email-mike.looijmans@topic.nl>
 <152778087117.144038.3582001993053198941@swboyd.mtv.corp.google.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <9eaa65c3-f8e0-1302-5f49-8691c244476d@topic.nl>
Date: Fri, 1 Jun 2018 07:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152778087117.144038.3582001993053198941@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.131
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5r9cX7d0E0pSmrYiMJvJ0Yd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOySBiUVAo7M+WU0lEyRRks5TYi2bf0F0JzgUQ/o6tR7CH2xp8BLc2xfyGUReD7IRgMuo
 PNmBu5wVqhAQ6VH7FR5vB8Ty6g+FyzfFbzv9RE4O7uDjV/sFUXQr+CDrNQuIHisenvNkIa5eS4fe
 f1Y2alRBpc/AiUjjK788fU1YN0ZFVLG/25onNpwa+ByvFZCukbioU1e16IxUJLZ20ReX1bSp7pY0
 L5pp3fDuFSg2SYy1PLhBThvdgyPN49yzDQzRHZ1ADIXb0X8MOc3DMDrpJuIVflRGywoBz+5hbQ/s
 FhsyiS4woUF3QYRfv0lM+BhCsIrOlnL/a7KjnP5Hd6yMsCbRznB9DlkKm0lqN1vc7spph6jSHIe4
 VXxtDnjvWUcv7bCquybs+d6GQBTweXSeZTet88+TKwCVbxP7bG35YtS/A1aO0ASgODHLSquIn2D3
 FxUS9itywBHw11Tnbe8A27oXcX+Q8IPcDAV+XJAqOPGsIrv3F28sfojuZI3S+Bdc3hPcpGyeyPXK
 NTABBN67jV7JvFCbAD7w3FUirQwmJIqD2OUMeHyTpNN0eXybX/w7/zx9n66RP1VFiaFDjn9cDcHZ
 szXM9E0rSZ6DYSZ9sVWyzkrDpoKksaEmuaV+tvWccjBPMweEfXdRqRZp93SkMI76Gew4jH22624b
 XqDj0nE6rZP91y05kcM4rUQDMJLwZevhZeWkyT5O19IxDu/Usp9PvhkSot3yX0Uz6/z7iRxNUfeU
 gb1nUNrY+0gXqtBMoHySCtPKGxZweDwDkCxc/cEfujaNYeNuUhiQ95d9cuRjKB5tUZrCDc4lRQd8
 Udft2JqB1Pg2DwMyBXjvFZ3riYfrjuU3A3io6xJmD59iFVkbCTX3JKFeiQgrXHKzO43hOtbJmRbX
 Xxp17+3XmYsZ9cANN0fnQvHVcIPRLyVf8IQO8AUy9furwzjHps/+CPPDQ1/5Sm5eelhAONyCNjuY
 9ynMp/dVTyLMh7dk8LXAwYzo2WzVz5mV8lzCe6PnAUlYyg==
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 31-05-18 17:34, Stephen Boyd wrote:
> Quoting Mike Looijmans (2018-05-31 07:03:55)
>> The si544 driver had a rounding problem that using the result of clk_round_rate
>> may set the clock to yet another rate, for example:
>> clk_round_rate(195000000) = 194999999
>> clk_round_rate(194999999) = 194999998
>>
>> Clients would expect that after clk_set_rate(clk, freq2=clk_round_rate(clk, freq)) the
>> chip will be running at exactly freq2.
>>
>> The problem was in the calculation of the feedback divider, it was always rounded
>> down instead of to the nearest possible VCO value.
>>
>> After this change, the following holds true for any supported frequency:
>> actual_freq = clk_round_rate(clk, freq);
>> clk_set_rate(clk, actual_freq);
>> clk_round_rate(clk, actual_freq) == actual_freq && clk_get_rate(clk) == actual_freq
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> Any fixes tag? I can slap
> 
> Fixes: 953cc3e81170 ("clk: Add driver for the si544 clock generator chip")
> 
> on to the patch here.
> 

I think that would be good, yes. Slap it on.


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
