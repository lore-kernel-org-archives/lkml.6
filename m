Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703320862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8703320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbeKFCit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:38:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:23088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbeKFCit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:38:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 09:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="93824909"
Received: from patelp1x-mobl3.amr.corp.intel.com (HELO [10.252.130.246]) ([10.252.130.246])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2018 09:18:08 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
 <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
Date:   Mon, 5 Nov 2018 11:18:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5h1s7z35t8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> We have this ("strange") lines over the drivers:
>>>
>>> config BAR
>>> depends on FOO || FOO=n
>>>
>>> which guarantees that FOO will be not module when BAR is built-in.
>> That's what I normally use, but I could not figure this one out.
>> One problem is that SND_SOC_ALL_CODECS selects
>> SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
>> may be =m, causing the failure for
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.
>>
>> It might work with a separate dummy symbol:
>>
>> config SND_SOC_HDAC_HDA_FORCE
>>           tristate
>>           depends on SND_SOC_ALL_CODECS != n
>>           default SND_SOC_INTEL_SKYLAKE
>>           select SND_SOC_HDAC_HDA
>>
>> This would make SND_SOC_HDAC_HDA built-in even
>> with SND_SOC_ALL_CODECS=m and
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=n
>>
>> It seems a bit ugly, and would need some testing.
> The mixture of depends and select is often more confusing, so IMO, we
> should align with only select as Pierre's suggestion, in this
> particular case.

I tried to avoid re-adding a "depends on" which we tried to remove last 
year, but there is still a conditional statement which assumes a very 
specific evaluation order.

1. SKYLAKE is enabled as m or y

2. that enables some machine drivers (through an if statement), some of 
which might select HDA audio

3. the selections done within the SKYLAKE config are conditional on the 
outcome of #2.

it seems to work but I don't know if it's by design or an accident :-). 
One could argue it's a hidden "depends on".


