Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3946C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9767C208A4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9767C208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeH2LLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:11:32 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:33128 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:11:32 -0400
Received: from [109.168.11.45] (port=33458 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fuuho-003nQM-4A; Wed, 29 Aug 2018 09:15:56 +0200
Subject: Re: [PATCH 1/1] axi-i2s: set period size register
To:     Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180824160430.10222-2-luca@lucaceresoli.net>
 <b87937b6-da7c-76d7-5dd2-24909e648671@metafoo.de>
 <263e42b4-75a3-183c-894b-e485e387eccf@lucaceresoli.net>
 <f1845eab-ea85-5c2f-98c2-ac63a13ff68a@metafoo.de>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <00d6c06e-851e-9d8e-fa79-983e826b8d5b@lucaceresoli.net>
Date:   Wed, 29 Aug 2018 09:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f1845eab-ea85-5c2f-98c2-ac63a13ff68a@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/08/2018 18:51, Lars-Peter Clausen wrote:
> On 08/27/2018 06:22 PM, Luca Ceresoli wrote:
>> Hi,
>>
>> thanks for your feedback.
>>
>> [Adding Michal Simek (Xilinx maintainer) in Cc]
>>
>> On 27/08/2018 14:27, Lars-Peter Clausen wrote:
>>> On 08/24/2018 06:04 PM, Luca Ceresoli wrote:
>>>> The default value of the PERIOD_LEN register is 0 and results in
>>>> axi-i2s keeping TLAST always asserted in its AXI Stream output.
>>>>
>>>> When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
>>>> DMA generating an interrupt flood and ALSA produce a corrupted
>>>> recording. This is because AXI-DMA raises an interrupt whenever TLAST
>>>> is active.
>>>>
>>>> Fix by setting the PERIOD_LEN register as soon as the period is
>>>> known. This way TLAST is emitted once per period, and the DMA raises
>>>> interrupts correctly.
>>>
>>> The patch looks OK. But I'd prefer not to merge it if possible.
>>>
>>> We've done some early experiments with the Xilinx AXI-DMA, but it turned out
>>> to be to unreliable and we've abandoned support for it. One of the more
>>> critical issues was that you can't abort a DMA transfer. That means when
>>> audio capture is stopped the DMA will halt, but not complete the current
>>> transfer. Then when the next audio capture start the DMA will continue with
>>> the previous transfer. The observed effect of this was that the system would
>>> just crash randomly (Presumably due to memory corruption).
>>
>> Strange. I have done many capture experiments with arecord and didn't
>> run into such bad issues. I only have a much less serious problem
>> (garbage or old samples in the first few buffers), but no crashes.
>>
>> Michal, are you aware of these problems?
>>
>>> Have you considered using the ADI AXI-DMAC? That should work just fine.
>>
>> Not until today, because AXI-DMA is working here.
>>
>> I'd like to better understand what's going on before changing an IP that
>> is working. Do you have additional details about your setup? How do you
>> run your tests?
> 
> This was 4-5 years ago. A AXI-DMA with both TX and RX connected to the
> AXI-I2S.
> 
> It might be that back then I didn't have buffer prealloc enabled, so a
> new DMA buffer gets allocated for each transfer. Then you end up with
> use after free and the DMA overwriting freed (and maybe reused) memory.
> 
> It was bad enough that it was a lot easier to add PL330 support to the
> I2S peripheral. Not using Xilinx DMA for anything anymore has saved me
> from a lot of headache.

I kind of understand you. However since AXI-DMA it is working for me
with this patch, chances are that bug has been fixed in the meanwhile.

-- 
Luca
