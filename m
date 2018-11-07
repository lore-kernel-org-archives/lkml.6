Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3F12086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3F12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeKGPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:54:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:44023 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeKGPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:54:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 22:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="278987454"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2018 22:25:58 -0800
Subject: Re: [PATCH] lib/genaloc: Fix allocation of aligned buffer from
 non-aligned chunk
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        labbott@redhat.com
References: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
 <20181106141542.08a9d7de30a439ec9fe50486@linux-foundation.org>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <fa2b502b-13a1-2f93-02aa-de1121b6e602@intel.com>
Date:   Wed, 7 Nov 2018 08:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106141542.08a9d7de30a439ec9fe50486@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/18 12:15 AM, Andrew Morton wrote:
> On Tue,  6 Nov 2018 14:20:53 +0200 Alexey Skidanov <alexey.skidanov@intel.com> wrote:
> 
>> On success, gen_pool_first_fit_align() returns the bit number such that
>> chunk_start_addr + (bit << order) is properly aligned. On failure,
>> the bitmap size parameter is returned.
>>
>> When the chunk_start_addr isn't aligned properly, the
>> chunk_start_addr + (bit << order) isn't aligned too.
>>
>> To fix this, gen_pool_first_fit_align() takes into account
>> the chunk_start_addr alignment and returns the bit value such that
>> chunk_start_addr + (bit << order) is properly aligned
>> (exactly as it done in CMA).
>>
>> ...
>>
>> --- a/include/linux/genalloc.h
>> +++ b/include/linux/genalloc.h
>>
>> ...
>>
>> +		struct gen_pool *pool, unsigned long start_add)
>>
>> ...
>>
>> +		struct gen_pool *pool, unsigned long start_add)
>>
>> ...
>>
>> +		struct gen_pool *pool, unsigned long start_add)
>>
>> ...
>>
> 
> We have three typos here.  Which makes me wonder why we're passing the
> new argument and then not using it?
> 
genpool uses allocation callbacks function that implement some
allocation strategy - bes fit, first fit, ... All of them has the same
type. The added chunk start_addr is used only in one of them -
gen_pool_first_fit_align()

Thanks,
Alexey
