Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F13C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBCB20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBCB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeLDMt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:49:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:44654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeLDMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:49:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 04:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="97928343"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2018 04:49:27 -0800
Subject: Re: [PATCH] sdhci: fix the fake timeout bug
To:     "Du, Alek" <alek.du@intel.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org
References: <20181130150028.732896d8@xdu1-mobl>
 <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl>
 <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
 <20181201134251.26573207@xdu1-mobl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b349ed24-cfa4-8b85-7069-d328f41f4827@intel.com>
Date:   Tue, 4 Dec 2018 14:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181201134251.26573207@xdu1-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/18 7:42 AM, Du, Alek wrote:
> On Fri, 30 Nov 2018 16:40:04 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> So you are saying this only happens under virtualization?
>>
> 
> Yes, I saw the issue under ACRN virtualization Service OS (4.19 kernel).
> But theoretically it can happen in other case when scheduling is not
> that good. (due to bad driver or other high priority task)
> 
> 
>>>
>>> Please look at the sdhci_enable_clk() below, there is a window in
>>> clock stabilization check. The first check is to check status
>>> register, the second check is to check if time passed. That's why I
>>> can capture a case that after time passed, the actually clock
>>> control register indicated that clock is stable. So the error
>>> handling is wrong...  
>>
>> Sure, but "Internal clock never stabilised." is not one of the
>> errors you listed.
> 
> Sorry my bad not listing all the error log:
> 
> Case 1. clock stabilization timeout: (the below clock control dump shows clock is good)
> [159525.255629] mmc1: Internal clock never stabilised.
> [159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> [159525.256277] mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [159525.256523] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [159525.256752] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000000
> [159525.256979] mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> [159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> 
> Case 2. Reset timeout: (the same check window in sdhci_reset())
> [ 7639.968613] mmc1: Reset 0x4 never completed.
> 
> Case 3. Hardware interrupt timeout
> [ 1049.561728] mmc1: Timeout waiting for hardware interrupt.
> 
>>
>>>
>>> Also the sdhci_send_command commands is not in spin lock There is a
>>> windows between mod_timer and real command send...  
>>
>> What code path does not have a spin lock?
> Ouch my bad, the sdhci_send_command are called either from spinlock or IRQ handler,
> so this part is good ...
> 
> I'll send a new patch to cover case 1 and case 2 if you agree.

Please do the mod_timer case also, but please make it a separate patch.
Prior to v4.18 it was essentially a 10-second timer, without a
preemptible gap afterwards, so extremely unlikely to timeout
prematurely, hence:

Fixes: fc1fa1b7db275 ("mmc: sdhci: Program a relatively accurate SW timeout value")
Cc: stable@vger.kernel.org      # v4.18+
