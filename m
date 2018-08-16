Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26510214F0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26510214F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeHPE1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:27:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:52156 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeHPE1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:27:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 18:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="224983576"
Received: from jxiao12-mobl.ccr.corp.intel.com (HELO [10.239.200.167]) ([10.239.200.167])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2018 18:32:44 -0700
Subject: Re: dm-bufio: adjust the reserved buffer for dm-verify-target.
To:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
References: <1533710457-6411-1-git-send-email-jin.xiao@intel.com>
 <20180814203245.GA15636@redhat.com>
From:   "Xiao, Jin" <jin.xiao@intel.com>
Message-ID: <3995084e-4250-9c28-2fa1-b61add5fb2e9@intel.com>
Date:   Thu, 16 Aug 2018 09:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180814203245.GA15636@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/2018 4:32 AM, Mike Snitzer wrote:
> On Wed, Aug 08 2018 at  2:40am -0400,
> xiao jin <jin.xiao@intel.com> wrote:
>
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
>> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
>> index dc385b7..3b7ca5e 100644
>> --- a/drivers/md/dm-bufio.c
>> +++ b/drivers/md/dm-bufio.c
>> @@ -841,7 +841,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
>>   			tried_noio_alloc = true;
>>   		}
>>   
>> -		if (!list_empty(&c->reserved_buffers)) {
>> +		if (!c->need_reserved_buffers) {
>>   			b = list_entry(c->reserved_buffers.next,
>>   				       struct dm_buffer, lru_list);
>>   			list_del(&b->lru_list);
>> @@ -1701,7 +1701,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
>>   		goto bad;
>>   	}
>>   
>> -	while (c->need_reserved_buffers) {
>> +	if (list_empty(&c->reserved_buffers)) {
>>   		struct dm_buffer *b = alloc_buffer(c, GFP_KERNEL);
>>   
>>   		if (!b) {
> Point was to allocate N buffers (as accounted in
> c->need_reserved_buffers).  This change just allocates a single one.
> Why?
>
> Your header isn't clear on this at all.

Hi Mike,

Currently alloc_buffer() when creating the client will use the 
__vmalloc() to

get the buffer data for c->reserved_buffers. If the c->reserved_buffers 
is read to

use in the failures case of buffer allocation in the 
__alloc_buffer_wait_no_callback(),

and the CONFIG_DEBUG_SG is enabled, we will hit the BUG() report.

That's the problem I find in reality.


I have some thinking to solve such issue. I think to keep the initial 
buffer with the

data from __vmalloc() in the c->reserved_buffers. But the reserved 
buffer with the data

from __vmalloc() can't be read to use. We can allocate more buffers with the

data mode of DATA_MODE_SLAB or DATA_MODE_GET_FREE_PAGES for 
c->reserved_buffers.

Such reserved buffers can be used in the failures case of buffer allocation

in the __alloc_buffer_wait_no_callback().


I test the code on my device. I never see the BUG() report again. Feel 
free to correct me.


Thanks.


Jin

>> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>> index 12decdbd7..40c66fc 100644
>> --- a/drivers/md/dm-verity-target.c
>> +++ b/drivers/md/dm-verity-target.c
>> @@ -1107,7 +1107,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>>   	v->hash_blocks = hash_position;
>>   
>>   	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
>> -		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
>> +		1 << v->hash_dev_block_bits, 2, sizeof(struct buffer_aux),
>>   		dm_bufio_alloc_callback, NULL);
>>   	if (IS_ERR(v->bufio)) {
>>   		ti->error = "Cannot initialize dm-bufio";
>> -- 
>> 2.7.4
>>
>> --
>> dm-devel mailing list
>> dm-devel@redhat.com
>> https://www.redhat.com/mailman/listinfo/dm-devel
> It isn't at all clear from my initial review that what you're doing
> makes any sense.
>
> Seems like you're just papering over bufio's use of !__virt_addr_valid()
> memory in unintuitive ways.
>
> Mikulas, can you see a better way forward?
>
> Mike
