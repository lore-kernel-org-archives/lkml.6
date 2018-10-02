Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39822C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E432064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E432064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeJBXvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:51:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:26642 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeJBXvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:51:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 10:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="88565746"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.165]) ([10.7.198.165])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2018 10:07:28 -0700
Subject: Re: [PATCH v2] libnvdimm, dimm: Maximize label transfer size
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <153842839852.2679462.16816747305002065908.stgit@dwillia2-desk3.amr.corp.intel.com>
 <71e2a4b6-68d9-d90d-b927-90840d8c6ee1@linux.intel.com>
 <CAPcyv4jQ7eAbEaUUP0R_JFKRADGU1kXhMd_Q=Gw5+1Xki5WYjA@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <051ce2c1-41ed-a42d-7f55-1303f8f33c32@linux.intel.com>
Date:   Tue, 2 Oct 2018 10:07:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jQ7eAbEaUUP0R_JFKRADGU1kXhMd_Q=Gw5+1Xki5WYjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2018 3:02 PM, Dan Williams wrote:
> On Mon, Oct 1, 2018 at 2:54 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>>
>>
>> On 10/1/2018 2:14 PM, Dan Williams wrote:
>>> Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
>>> operations. Given the expense of calling into firmware, maximize the
>>> amount of label data we transfer per call to be up to the total label
>>> space if allowed by the firmware, or 256K whichever is smaller.
>>>
>>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>> Changes in v2:
>>> * clamp the max allocation size at 256K in case large label areas with
>>>     unlimited transfer sizes appear in the future.
>>>
>>>    drivers/nvdimm/dimm_devs.c       |   14 ++++++++------
>>>    tools/testing/nvdimm/test/nfit.c |    2 +-
>>>    2 files changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
>>> index 863cabc35215..3616e2e47788 100644
>>> --- a/drivers/nvdimm/dimm_devs.c
>>> +++ b/drivers/nvdimm/dimm_devs.c
>>> @@ -111,8 +111,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>>>        if (!ndd->data)
>>>                return -ENOMEM;
>>>
>>> -     max_cmd_size = min_t(u32, PAGE_SIZE, ndd->nsarea.max_xfer);
>>> -     cmd = kzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
>>> +     max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
>>> +     max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
>>> +     cmd = kvzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
>>>        if (!cmd)
>>>                return -ENOMEM;
>>>
>>
>> So I wouldn't use 256K as the limit, maybe 256K minus the sizeof(*cmd).
>> Otherwise you are still allocating additional memory to take care of
>> that little trailing bit that is being added.
> 
> Does it matter? This is a slow / infrequently used path and I do don't
> see the practical difference of 256K vs slightly less than 256K.

It depends on the approach used. From past experience 256K could easily 
become 512K with just that extra bit of overhead. That is why I was 
thinking if we are going to make 256K the limit, we should make that the 
hard limit and not add a little bit extra onto it.

>>> @@ -134,7 +135,7 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>>>                memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
>>>        }
>>>        dev_dbg(ndd->dev, "len: %zu rc: %d\n", offset, rc);
>>> -     kfree(cmd);
>>> +     kvfree(cmd);
>>>
>>>        return rc;
>>>    }
>>> @@ -157,9 +158,10 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
>>>        if (offset + len > ndd->nsarea.config_size)
>>>                return -ENXIO;
>>>
>>> -     max_cmd_size = min_t(u32, PAGE_SIZE, len);
>>> +     max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
>>>        max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
>>> -     cmd = kzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
>>> +     max_cmd_size = min_t(u32, max_cmd_size, len);
>>> +     cmd = kvzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
>>>        if (!cmd)
>>>                return -ENOMEM;
>>>
>>
>> For the set operation I am not sure you have any code that is going to
>> be updating things multiple labels at a time. From what I can tell the
>> largest set call you ever make is probably for a namespace index and
>> odds are that will only ever be 256 or 512 bytes.
> 
> Inside the kernel, true, but we do perform large sets from userspace.
> That said I don't see why this low level routine should encode
> layering violation knowledge of how it might be used.

Can userspace call this directly? I only see 3 callers of this and all 
of them limit themselves to writing either a single namespace index or 
label.

Also we know that the behavior is supposed to be that we only update 
what we have to as it introduces issues if we try to overwrite all of 
the config space. That is why I think it would be better to keep the 
upper limit for writes small anyway. That way we make it painful for 
somebody to do the wrong thing.

>> Also the limitations here could probably use some additional clean-up.
>> For example you have a check for offset + len > config_size above this
>> min_t calls. As such it should be impossible for length to ever be
>> greater than config_size so you shouldn't need to test for the min of
>> both and could just use the min of len versus the max_xfer.
> 
> Again that's a case of this leaf routine encoding assumptions about
> how it might be used. I'd rather be pedantic since this is not a hot
> path.

No. This is me reading the code. Just to be clear, before we start 
trying to determine the max_cmd_size we have the following bit of code:
	if (offset + len > ndd->nsarea.config_size)
		return -ENXIO;

So if that logic is already there how can we have len be greater than 
ndd->nsarea.config_size? As far as I can tell we can't so we could save 
ourselves one of the min_t checks since we know len should always be 
less than or equal to ndd->nsarea.config_size.

