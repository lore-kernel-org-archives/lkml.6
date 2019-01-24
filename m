Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3000C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8DF218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfAXJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:55:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:62197 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfAXJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:55:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 01:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,515,1539673200"; 
   d="scan'208";a="112274699"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.107]) ([10.239.13.107])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2019 01:55:19 -0800
Subject: Re: [kbuild-all] proc.c:undefined reference to `strcmp'
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>
Cc:     Olof Johansson <olof@lixom.net>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <201901221835.KyE294P1%fengguang.wu@intel.com>
 <CAMuHMdXmMM8xgGn23YkVHbrYe5108yqfM1Rrx8PJ9RmFNjOqTg@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <37a97697-f812-7db4-f48b-47fbccbc160b@intel.com>
Date:   Thu, 24 Jan 2019 17:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXmMM8xgGn23YkVHbrYe5108yqfM1Rrx8PJ9RmFNjOqTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/19 7:44 PM, Geert Uytterhoeven wrote:
> On Tue, Jan 22, 2019 at 11:11 AM kbuild test robot <lkp@intel.com> wrote:
>> It's probably a bug fix that unveils the link errors.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   47bfa6d9dc8c060bf56554a465c9031e286d2f80
>> commit: 35004f2e55807a1a1491db24ab512dd2f770a130 lib/genalloc.c: include vmalloc.h
>> date:   2 weeks ago
>> config: m68k-allmodconfig (attached as .config)
>> compiler: m68k-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout 35004f2e55807a1a1491db24ab512dd2f770a130
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=8.2.0 make.cross ARCH=m68k
>>
>> All errors (new ones prefixed by >>):
>>
>>     m68k-linux-gnu-ld: block/partitions/ldm.o: in function `ldm_partition':
>>     ldm.c:(.text+0x1900): undefined reference to `strcmp'
>>     m68k-linux-gnu-ld: ldm.c:(.text+0x1964): undefined reference to `strcmp'
>>     m68k-linux-gnu-ld: drivers/rtc/proc.o: in function `is_rtc_hctosys':
>>>> proc.c:(.text+0x18c): undefined reference to `strcmp'
>>     m68k-linux-gnu-ld: drivers/watchdog/watchdog_pretimeout.o: in function `watchdog_register_governor':
>>     watchdog_pretimeout.c:(.text+0x142): undefined reference to `strcmp'
>>     m68k-linux-gnu-ld: drivers/devfreq/devfreq.o: in function `try_then_request_governor':
>>     devfreq.c:(.text+0x9c6): undefined reference to `strcmp'
> I guess this bisection is a false positive. Have you just upgraded to gcc 8?

yes, we upgraded to gcc 8 recently.


> Gcc 8 replaces the strncmp() in is_rtc_hctosys() to strcmp().
> Will be fixed in v5.1 by
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?h=for-v5.1&id=28713169d879b67be2ef2f84dcf54905de238294

Thanks for your explanation. we'll blacklist it.

Best Regards,
Rong Chen


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
