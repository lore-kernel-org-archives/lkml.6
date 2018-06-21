Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF02C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44E720837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFUNQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:16:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:17671 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753948AbeFUNQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:16:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 06:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="51128684"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2018 06:16:40 -0700
Subject: Re: [PATCH V2 1/7] mmc: sdhci: add sd host v4 mode
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-2-git-send-email-zhang.chunyan@linaro.org>
 <1f3e7e87-be4e-37ab-af46-1c4e5dd79a1d@intel.com>
 <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <38c47bf5-d320-7767-59c1-958d1bbb6dc9@intel.com>
Date:   Thu, 21 Jun 2018 16:15:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/18 14:14, Chunyan Zhang wrote:
> On 21 June 2018 at 18:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 15/06/18 05:04, Chunyan Zhang wrote:
>>> For SD host controller version 4.00 or later ones, there're two
>>> modes of implementation - Version 3.00 compatible mode or
>>> Version 4 mode.  This patch introduces a flag to record this.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>>  drivers/mmc/host/sdhci.h | 6 ++++++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 2ededa7f..cf5695f 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>>>       v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>>>       host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>>>
>>> +     if (host->version >= SDHCI_SPEC_400) {
>>> +             if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
>>> +                     SDHCI_CTRL_V4_MODE)
>>> +                     host->v4_mode = true;
>>> +     }
>>
>> At this point the host controller has just been reset which would mean it
>> must be in version 3 compatibility mode, which would mean this code doesn't
>> do anything.
> 
> Why is it version 3 mode at this point?

According to the specification, reset clears RW fields to zero.

> 
> I've tested this code on the sd host controller which was introduced
> in 6/7 in this patch-set, the result showed that it was v4_mode.
> Moreover without this patch, the Spreadtrum's sdhci driver in patch
> 6/7 couldn't work.
> 
> Am I missing something here?

It seems the Spreadtrum controller doesn't clear the "Host Version 4 Enable"
bit upon software reset for all.

Also this seems the wrong way around.  The driver should decide whether or
not to use V4 mode and then the "Host Version 4 Enable" bit should be set
accordingly.

V4 has been around so long that we can't just enable all supporting hardware
without risking the possibility it will break some platform.  So I suggest
adding a function sdhci_enable_v4_mode() which is called during probe.

> 
> Best,
> Chunyan
> 
>>
>>> +
>>>       if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>               return;
>>>
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index c95b0a4..128b0ba 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -184,6 +184,7 @@
>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>> +#define  SDHCI_CTRL_V4_MODE          0x1000
>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>
>>>  #define SDHCI_CAPABILITIES   0x40
>>> @@ -270,6 +271,8 @@
>>>  #define   SDHCI_SPEC_100     0
>>>  #define   SDHCI_SPEC_200     1
>>>  #define   SDHCI_SPEC_300     2
>>> +#define   SDHCI_SPEC_400     3
>>> +#define   SDHCI_SPEC_410     4
>>>
>>>  /*
>>>   * End of controller registers.
>>> @@ -551,6 +554,9 @@ struct sdhci_host {
>>>       u32                     sdma_boundary;
>>>
>>>       unsigned long private[0] ____cacheline_aligned;
>>> +
>>> +     /* Host Version 4 Enable */
>>> +     bool                    v4_mode;
>>>  };
>>>
>>>  struct sdhci_ops {
>>>
>>
> 

