Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A33C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613702075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613702075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJaAS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:18:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:45585 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeJaAS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:18:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 08:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86471608"
Received: from dbbernha-mobl.amr.corp.intel.com (HELO [10.254.77.95]) ([10.254.77.95])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2018 08:25:01 -0700
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     duffydack73@gmail.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mogens-jensen@protonmail.com
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <d21fe935-5732-7f8c-2c26-3fc3969b4c1c@redhat.com>
 <CAHp75Ve8FjHLYkq1uXhen40DDj8DJa42vXXs83qDimigcH-=DA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4399344e-712b-c54f-492d-2cbdaad509d6@linux.intel.com>
Date:   Tue, 30 Oct 2018 10:25:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve8FjHLYkq1uXhen40DDj8DJa42vXXs83qDimigcH-=DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/30/18 10:03 AM, Andy Shevchenko wrote:
> On Tue, Oct 30, 2018 at 4:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 30-10-18 15:38, Dean Wallace wrote:
>>> Excellent work Hans.  Compiled 4.19 with
>>> 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch, sound
>>> works as before.
>>>
>>> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done
>>> /sys/kernel/debug/clk/pmc_plt_clk_0:
>>> /sys/kernel/debug/clk/pmc_plt_clk_1:
>>> /sys/kernel/debug/clk/pmc_plt_clk_2:
>>> /sys/kernel/debug/clk/pmc_plt_clk_3:
>>> /sys/kernel/debug/clk/pmc_plt_clk_4:
>>> /sys/kernel/debug/clk/pmc_plt_clk_5:
>> Ok, so as I expected the Swanky is using pmc_plt_clk_0
>> as mclk instead of pmc_plt_clk_3. Now the question
>> becomes is this true for all the designs using the
>> max98090 codec?
>> 1) Unconditionally use pmc_plt_clk_0 as mclk (as my test patch does)
>> in the cht_bsw_max98090_ti.c machine driver
> I don't know the details, but the main question here indeed do we ever
> had a working example of that machine with CLK #3 in use?
yes, Rambi/Orco (Baytrail based).
>
> P.S. I would go your first proposal until the opposite will be proved.
>
