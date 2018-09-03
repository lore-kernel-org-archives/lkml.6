Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292F520652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292F520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeICTGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:06:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6526 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:06:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b8d49170000>; Mon, 03 Sep 2018 07:45:43 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Sep 2018 07:45:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Sep 2018 07:45:42 -0700
Received: from [10.26.11.205] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Sep
 2018 14:45:39 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Don't schedule DAPM work if
 already in target state
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1534520143-29266-1-git-send-email-jonathanh@nvidia.com>
 <20180828103911.GX32322@imbe.wolfsonmicro.main>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7cb856ee-c9e6-b54b-6d12-37bf4005e5c3@nvidia.com>
Date:   Mon, 3 Sep 2018 15:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828103911.GX32322@imbe.wolfsonmicro.main>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/08/18 11:39, Charles Keepax wrote:
> On Fri, Aug 17, 2018 at 04:35:43PM +0100, Jon Hunter wrote:
>> When dapm_power_widgets() is called, the dapm_pre_sequence_async() and
>> dapm_post_sequence_async() functions are scheduled for all DAPM contexts
>> (apart from the card DAPM context) regardless of whether the DAPM
>> context is already in the desired state. The overhead of this is not
>> insignificant and the more DAPM contexts there are the more overhead
>> there is.
>>
>> For example, on the Tegra124 Jetson TK1, when profiling the time taken
>> to execute the dapm_power_widgets() the following times were observed.
>>
>>   Times for function dapm_power_widgets() are (us):
>>      Min 23, Ave 190, Max 434, Count 39
>>
>> Here 'Count' is the number of times that dapm_power_widgets() has been
>> called. Please note that the above time were measured using ktime_get()
>> to log the time on entry and exit from dapm_power_widgets(). So it
>> should be noted that these times may not be purely the time take to
>> execute this function if it is preempted. However, after applying this
>> patch and measuring the time taken to execute dapm_power_widgets() again
>> a significant improvement is seen as shown below.
>>
>>   Times for function dapm_power_widgets() are (us):
>>      Min 4, Ave 16, Max 82, Count 39
>>
>> Therefore, optimise the dapm_power_widgets() function by only scheduling
>> the dapm_pre/post_sequence_async() work if the DAPM context is not in
>> the desired state.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
> 
> Looks ok to me:
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> Although that said the performance increase is pretty hard to
> measure on my systems.

If you can enable the function graph tracer, then you should be again to
profile the dapm_power_widgets() function with it as it will give you a
time for how long the function took [0].

Cheers
Jon

[0] https://lwn.net/Articles/370423/

-- 
nvpublic
