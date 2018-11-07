Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC232086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeKGPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:48:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:35422 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeKGPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:48:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 22:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="278986354"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2018 22:19:33 -0800
Subject: Re: [PATCH] lib/genaloc: Fix allocation of aligned buffer from
 non-aligned chunk
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        labbott@redhat.com
References: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
 <20181106141131.76e94f6b1ff2859d96792aca@linux-foundation.org>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <d76d64cf-70a9-9c1f-6f11-2d812aacaaef@intel.com>
Date:   Wed, 7 Nov 2018 08:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106141131.76e94f6b1ff2859d96792aca@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/18 12:11 AM, Andrew Morton wrote:
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
> 
> Why does this need "fixing"?  Are there current callers which can
> misalign chunk_start_addr?  Or is there a requirement that future
> callers can misalign chunk_start_addr?
> 
I work on adding aligned allocation support for ION heaps
(https://www.spinics.net/lists/linux-driver-devel/msg118754.html). Two
of these heaps use genpool internally.

If you want to have an ability to allocate buffers aligned on different
boundaries (for example, 4K, 1MB, ...), this fix actually removes the
requirement for chunk_start_addr to be aligned on the max possible
alignment.

Thanks,
Alexey
