Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11566C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1220827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE1220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJ3UJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:09:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:56946 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeJ3UJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:09:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 04:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="85674177"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2018 04:15:58 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>, Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_th: Fix a missing-check bug
In-Reply-To: <CAAa=b7fnx01565vUuturXLefLjsfUwGpD8Zh1bZZnrkSQ=wWpg@mail.gmail.com>
References: <1539956812-11300-1-git-send-email-wang6495@umn.edu> <CAAa=b7fnx01565vUuturXLefLjsfUwGpD8Zh1bZZnrkSQ=wWpg@mail.gmail.com>
Date:   Tue, 30 Oct 2018 13:15:57 +0200
Message-ID: <871s877kia.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wenwen Wang <wang6495@umn.edu> writes:

> Hello,
>
> Can anyone confirm this bug? Thanks!

Commonly this burden lies with the author of the patch. If you fix a
bug, you need to be able to demonstrate it. If it's a mere hypothesis,
there needs to be a detailed analysis of how exactly can this be
exploited and what is the potential outcome of an exploit.

Some other questions that arise from looking at the patch, for example,
does gcc actually generate different code as a result of this patch?

> On Fri, Oct 19, 2018 at 8:47 AM Wenwen Wang <wang6495@umn.edu> wrote:
>>
>> In msc_data_sz(), the 'valid_dw' field of the msc block descriptor 'bdesc'
>> is firstly checked to see whether the descriptor has a valid data width. If
>> yes, i.e., 'bdesc->valid_dw' is not 0, the data size of this descriptor
>> will be returned. It is worth noting that the data size is calculated from
>> 'bdesc->valid_dw'. The problem here is that 'bdesc' actually points to a
>> consistent DMA region, which is allocated through dma_alloc_coherent() in
>> msc_buffer_win_alloc(). Given that the device also has the permission to
>> access this DMA region, it is possible that a malicious device controlled
>> by an attacker can modify the 'valid_dw' field after the if statement but
>> before the return statement in msc_data_sz(). Through this way, the
>> device

So, I *guess* you're assuming that an IOMMU will stop the malicious
device from overwriting the kernel code directly, so instead they're
reduced to breaking the driver's assumptions about the HW behavior, and
that is the reason why patches like this are sent in the first
place. This train of thought needs to be explained. Now, if we start
defending ourselves against malicious hardware, we need a comprehensive
analysis of possible attack vectors and their consequences. I'm not
convinced that it needs to be done in the first place, but if it does,
it sure needs to be better than grepping for a potential load after
validation.

>> can bypass the check and supply unexpected data width.
>>
>> This patch copies the 'valid_dw' field to a local variable and then
>> performs the check and the calculation on the local variable to avoid the
>> above issue.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  drivers/hwtracing/intel_th/msu.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
>> index 9cc8ace..b7d846e 100644
>> --- a/drivers/hwtracing/intel_th/msu.h
>> +++ b/drivers/hwtracing/intel_th/msu.h
>> @@ -79,10 +79,12 @@ struct msc_block_desc {
>>
>>  static inline unsigned long msc_data_sz(struct msc_block_desc *bdesc)
>>  {
>> -       if (!bdesc->valid_dw)
>> +       u32 valid_dw = bdesc->valid_dw;
>> +
>> +       if (!valid_dw)
>>                 return 0;
>>
>> -       return bdesc->valid_dw * 4 - MSC_BDESC;
>> +       return valid_dw * 4 - MSC_BDESC;

Or, the "malicious device" could just set valid_dw to something within
[1; MSC_BDESC/4), pass the check anyway and yield a more interesting
result, which may lead to an out-of-bounds access in the buffer reading
function. In other words, there's potential for improvement around this
function, but this patch misses it.

Regards,
--
Alex
