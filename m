Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09706C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14BF2170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14BF2170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHHIHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:07:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:40101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHIHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:07:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 22:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="81597466"
Received: from unknown (HELO [10.239.154.226]) ([10.239.154.226])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2018 22:49:38 -0700
Subject: Re: [PATCH] dm-bufio: adjust the reserved buffer for
 dm-verify-target.
To:     Greg KH <greg@kroah.com>
References: <1533704823-5448-1-git-send-email-jin.xiao@intel.com>
 <20180808052514.GA20034@kroah.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yanmin.zhang@intel.com
From:   xiaojin <jin.xiao@intel.com>
Message-ID: <5B6A84E4.2020805@intel.com>
Date:   Wed, 8 Aug 2018 13:51:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180808052514.GA20034@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月08日 13:25, Greg KH wrote:
> On Wed, Aug 08, 2018 at 01:07:03PM +0800, xiao jin wrote:
>> We hit the BUG() report at include/linux/scatterlist.h:144!
>> The callback is as bellow:
>>    => verity_work
>>    => verity_hash_for_block
>>    => verity_verify_level
>>    => verity_hash
>>    => verity_hash_update
>>    => sg_init_one
>>    => sg_set_buf
>>
>> More debug shows the root cause. When creating dufio client it
>> uses the __vmalloc() to allocate the buffer data for the reserved
>> dm_buffer. The buffer that allocated by the __vmalloc() is invalid
>> according to the __virt_addr_valid().
>>
>> Mostly the reserved dm_buffer is not touched. But occasionally
>> it might fail to allocate the dm_buffer data when we try to
>> allocate in the __alloc_buffer_wait_no_callback(). Then it has
>> to take the reserved dm_buffer for usage. Finally it reports the
>> BUG() as virt_addr_valid() detects the buffer data address is invalid.
>>
>> The patch is to adjust the reserved buffer for dm-verity-target. We
>> allocated two dm_buffers into the reserved buffers list when creating
>> the buffer interface. The first dm_buffer in the reserved buffer list
>> is allocated by the __vmalloc(), it's not used after that. The second
>> dm_buffer in the reserved buffer list is allocated by the
>> __get_free_pages() which can be consumed after that.
>>
>> Signed-off-by: xiao jin <jin.xiao@intel.com>
>> ---
>>   drivers/md/dm-bufio.c         | 4 ++--
>>   drivers/md/dm-verity-target.c | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
Thanks, I will resend to review without the stable mail list.
