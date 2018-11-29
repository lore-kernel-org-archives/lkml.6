Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA8BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2CD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2CD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeK2Vyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:54:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:5769 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeK2Vys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:54:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 02:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="95704925"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2018 02:49:49 -0800
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com>
 <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com>
 <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d9091e09-da8d-5fd2-0957-30d34c2a0e21@intel.com>
Date:   Thu, 29 Nov 2018 12:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/18 11:59 AM, Chunyan Zhang wrote:
> Hi Adrian,
> 
> On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
>>> On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
>>>>> Some standard SD host controllers can support both external dma
>>>>> controllers as well as ADMA/SDMA in which the SD host controller
>>>>> acts as DMA master. TI's omap controller is the case as an example.
>>>>>
>>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>>>> the host controller but does not have any support for external DMA
>>>>> controllers implemented using dmaengine, meaning that custom code is
>>>>> needed for any systems that use an external DMA controller with SDHCI.
>>>>
>>>> I still think you probably need to reset the DMA if there are transfer
>>>> errors - perhaps you could comment on that.  Also there are some comments below.
>>>
>>> With regard to "transfer error", do you mean if
>>> sdhci_external_dma_setup() failed?
>>
>> No, I mean any error interrupt that can leave the DMA uncompleted.  For
>> SDHCI, resetting the data circuit cleans that up, but presumably something
>> is needed for external DMA?
> 
> Yes, it should need a dmaengine_terminate_all().
> 
> How about adding that at here (I will wrap it up of course):
> https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553

Yes except we really need to reverse
	if (host->flags & SDHCI_REQ_USE_DMA) {
	}
	if (sdhci_needs_reset(host, mrq)) {
	}
so that we do not unmap before killing the dma

Perhaps you could send that as a separate patch.

> Is there somewhere else I'm missing?

Testing ;-)
