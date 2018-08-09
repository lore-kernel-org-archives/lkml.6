Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2DC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A98E21C2E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A98E21C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeHIFjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:39:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:1388 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeHIFjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:39:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 20:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="252547192"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.128]) ([10.239.13.128])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2018 20:16:54 -0700
Subject: Re: [RFC PATCH 1/1] device-dax: check for vma range while dax_mmap.
To:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com, jack@suse.cz,
        zwisler@kernel.org, yu.c.zhang@intel.com
Cc:     yi.z.zhang@intel.com
References: <e260d513ab831bfe1298374c87c6cca5f7dd3a6f.1533036772.git.yi.z.zhang@linux.intel.com>
 <12a2ebd8-0f15-7d0a-697c-172ed7f77f92@intel.com>
 <5aaca496-af2b-71b1-26af-b2400e0bcb43@linux.intel.com>
 <2d9a11be-732d-23b5-80fe-fc463cef556c@intel.com>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <f05cea2e-77c3-d9ee-c659-af504499d6e3@linux.intel.com>
Date:   Thu, 9 Aug 2018 19:01:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2d9a11be-732d-23b5-80fe-fc463cef556c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月08日 08:05, Dave Jiang wrote:
>
> On 08/02/2018 02:32 AM, Zhang,Yi wrote:
>>
>> On 2018年08月02日 03:40, Dave Jiang wrote:
>>> On 07/31/2018 04:46 AM, Zhang Yi wrote:
>>>> It should be prevent user map an illegal vma range which larger than
>>>> dax device phiscal resourse, as we don't have swap logic while page
>>>> faulting in dax device.
>>> This patch prevents a user mapping an illegal vma range that is larger
>>> than a dax device physical resource.
>>>
>>>> Applications, especailly qemu, map the /dev/dax for virtual nvdimm's
>>>> backend device, we defined the v-nvdimm label area at the end of mapped
>>>> rang. By using an illegal size that exceeds the physical resource of
>>>> /dev/dax, then it will triger qemu a signal fault while accessing these
>>>> label area.
>>> When qemu maps the dax device for virtual nvdimm's backend device, the
>>> v-nvdimm label area is defined at the end of mapped range. By using an
>>> illegal size that exceeds the range of the device dax, it will trigger a
>>> fault with qemu.
>> Thanks Dava, that's could be much better.
>>>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>>>> ---
>>>>  drivers/dax/device.c | 28 ++++++++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>>>> index aff2c15..c9a50cd 100644
>>>> --- a/drivers/dax/device.c
>>>> +++ b/drivers/dax/device.c
>>>> @@ -177,6 +177,32 @@ static const struct attribute_group *dax_attribute_groups[] = {
>>>>  	NULL,
>>>>  };
>>>>  
>>>> +static int check_vma_range(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>>>> +		const char *func)
>>>> +{
>>>> +	struct device *dev = &dev_dax->dev;
>>>> +	struct resource *res;
>>>> +	unsigned long size;
>>>> +	int ret, i;
>>>> +
>>>> +	if (!dax_alive(dev_dax->dax_dev))
>>>> +		return -ENXIO;
>>>> +
>>>> +	size = vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
>>>> +	ret = -EINVAL;
>>>> +	for (i = 0; i < dev_dax->num_resources; i++) {
>>>> +		res = &dev_dax->res[i];
>>>> +		if (size > resource_size(res)) {
>>>> +			dev_info(dev, "%s: %s: fail, vma range is overflow\n",
>>>> +				current->comm, func);
>>>> +			ret = -EINVAL;
>>>> +			continue;
>>>> +		} else
>>>> +			return 0;
>>>> +	}
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>>>>  		const char *func)
>>>>  {
>>>> @@ -465,6 +491,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
>>>>  	 */
>>>>  	id = dax_read_lock();
>>>>  	rc = check_vma(dev_dax, vma, __func__);
>>>> +	if (!rc)
>>>> +		rc |= check_vma_range(dev_dax, vma, __func__);
> I don't see any reason to logical or the return code. It should be 0, so
> you can just assign it to check_vma_range().
Ah.. Yes, Thanks for your kindly review, Dace, I will send the next version.
>
>>> I think you want to augment check_vma() rather than adding another
>>> function? If this is added inside check_vma() then you can also skip the
>>> !dax_alive() check. Do you expect this function to be called anywhere else?
>> since check_vma range also will be called while dax page faulting.  I
>> don't wanna this check_vma_range introduce some additional workload
>> while page fault. just let it checked in the mmap scenario
> Good point. Ok.
>
>>>>  	dax_read_unlock(id);
>>>>  	if (rc)
>>>>  		return rc;
>>>>

