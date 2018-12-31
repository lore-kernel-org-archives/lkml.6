Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87327C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6720828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeLaPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:22:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:24866 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLaPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:22:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 07:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,423,1539673200"; 
   d="scan'208";a="111184179"
Received: from mumar-mobl1.amr.corp.intel.com (HELO [10.252.139.191]) ([10.252.139.191])
  by fmsmga007.fm.intel.com with ESMTP; 31 Dec 2018 07:22:01 -0800
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Azat Khuzhin <dohardgopro@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de>
 <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de>
 <CAAW1UO_YDtddPk7-b=c03crPAOL33YWtu_q225um_hxh4SVYtA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <47137843-14fc-f6d0-4372-a9ef2456cab8@linux.intel.com>
Date:   Mon, 31 Dec 2018 09:22:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAW1UO_YDtddPk7-b=c03crPAOL33YWtu_q225um_hxh4SVYtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/31/18 7:43 AM, Azat Khuzhin wrote:
>> +/* CFL and later models, preferring ASoC when DSP is available */
>> +#define IS_CFL_PLUS(pci)            \
>> +       ((pci)->vendor == 0x8086 &&  \
>> +        ((pci)->device == 0xa348 || \
>> +         (pci)->device == 0x9dc8 || \
>> +         (pci)->device == 0x34c8))
>> +
>>   static char *driver_short_names[] = {
>>          [AZX_DRIVER_ICH] = "HDA Intel",
>>          [AZX_DRIVER_PCH] = "HDA Intel PCH",
>> @@ -2056,7 +2063,7 @@ static int azx_probe(struct pci_dev *pci,
>>          if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
>>                  switch (skl_pci_binding) {
>>                  case SND_SKL_PCI_BIND_AUTO:
>> -                       if (pci->class != 0x040300) {
>> +                       if (pci->class != 0x040300 && IS_CFL_PLUS(pci)) {
>>                                  dev_info(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
>>                                  return -ENODEV;
>>                          }
> lenovo thinkpad carbon 6th gen - no sound after this patch, and this
> patch should fix sound issue for it (not tested, just checking the
> condition and pci attrs)
> But what interesting is that I cannot remove snd_soc_skl module
> without reboot (to adjust "pci_binding=1" so make sound works),
> because kernel hang after short period doing it:
>
> # rmmod snd_soc_skl_ssp_clk
> # rmmod snd_soc_skl
>
> WARN_ON triggered on rmmod:

This is unfortunately a known issue with this driver, Takashi and I had 
a couple of email threads on this. Even without errors removing the 
module doesn't seem to release all resources. I don't like this at all, 
and for the Sound Open Firmware (SOF) driver I mandated module 
load-unload as a functional requirement along with zero warnings w/ 
Sparse, Coccinelle and friends, but on this legacy code I am afraid 
there is no simple fix - at least not in a merge window or a single 
kernel cycle.


