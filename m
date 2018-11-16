Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A60208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A60208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbeKPRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:23:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:37359 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeKPRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:23:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 23:12:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,239,1539673200"; 
   d="scan'208";a="106755661"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2018 23:12:36 -0800
Subject: Re: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage
 switching
To:     Evan Green <evgreen@chromium.org>, vbadigan@codeaurora.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org,
        Doug Anderson <dianders@google.com>, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayali <sayalil@codeaurora.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, vviswana@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
 <dcb4a579-b308-76c0-7cc3-22bb95147470@codeaurora.org>
 <9a4708c8-cc43-a690-7ef7-da351eb1f967@codeaurora.org>
 <CAE=gft7VCzVDS+hDQUiXh=76ytkg4Djf8kZXtESsQsxoPJrwXA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b559d156-3c59-ba1a-1a09-7406f979abb1@intel.com>
Date:   Fri, 16 Nov 2018 09:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7VCzVDS+hDQUiXh=76ytkg4Djf8kZXtESsQsxoPJrwXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 1:17 AM, Evan Green wrote:
> On Wed, Nov 14, 2018 at 6:36 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>>
>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>> index b001cf4..3c28152 100644
>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>> @@ -524,6 +524,7 @@ struct sdhci_host {
>>>>>          bool pending_reset;     /* Cmd/data reset is pending */
>>>>>          bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>>>>>          bool v4_mode;           /* Host Version 4 Enable */
>>>>> +       bool vqmmc_enabled;     /* Vqmmc is enabled */
>>>> I still don't love this, since it doesn't mean what it says. Everyone
>>>> else that has a vqmmc_enabled member uses it to actually mean "vqmmc
>>>> is enabled", but this doesn't mean that. For example, you don't clear
>>>> this when you disable the regulator in patch 3, so this would be set
>>>> even if the regulator is disabled, and you don't set it when sdhci
>>>> enables the regulator, so the regulator is on when this flag is not
>>>> set.
>>>>
>> Hi Evan
>>
>> This flag is meant to say "disable vqmmc *only* if it is enabled by host
>> driver (sdhci_host)".
>> If host driver doesn't enable vqmmc (enabled by platfrm driver) or if it
>> fails to enable it, then don't call disable vqmmc.
>>
>> Agree with you, the present name is not conveying its purpose.
>> It must be something like "vqmmc_enabled_by_host".
>>
>> Please let me know if you have any suggestions on this name.
> 
> Yeah. Maybe vqmmc_pltfrm_controlled? Or vqmmc_enabled_by_platfrm as
> you suggested?

"pltfrm" doesn't mean anything here.  Just change the comment "vqmmc enabled
in sdhci.c"
