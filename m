Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F3D20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F3D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeIZDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:21:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:4214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbeIZDVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 14:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="94763021"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.152]) ([10.7.198.152])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2018 14:11:14 -0700
Subject: Re: [PATCH 2/2] nvdimm: Set device node in nd_device_register
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org
References: <20180925204801.6182.73167.stgit@localhost.localdomain>
 <20180925205307.6182.26453.stgit@localhost.localdomain>
 <CAPcyv4jpUNP4mySPr5jYogpf5ZMPgpTu9oOjC89ZYHa=vL1JwQ@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <bcd44872-1961-79ff-f1a5-8ab2c2a99c20@linux.intel.com>
Date:   Tue, 25 Sep 2018 14:11:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jpUNP4mySPr5jYogpf5ZMPgpTu9oOjC89ZYHa=vL1JwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 2:08 PM, Dan Williams wrote:
> On Tue, Sep 25, 2018 at 1:56 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>> This change makes it so that we don't repeatedly overwrite the device node
>> for nvdimm regions. The earliest we can set the node is immediately after
>> calling device init, so I have moved the code there so we can avoid
>> rewriting the node with each uevent.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> ---
>>   drivers/nvdimm/bus.c |   16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
>> index 9148015ed803..96f4d0e1706a 100644
>> --- a/drivers/nvdimm/bus.c
>> +++ b/drivers/nvdimm/bus.c
>> @@ -54,12 +54,6 @@ static int to_nd_device_type(struct device *dev)
>>
>>   static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> -       /*
>> -        * Ensure that region devices always have their numa node set as
>> -        * early as possible.
>> -        */
>> -       if (is_nd_region(dev))
>> -               set_dev_node(dev, to_nd_region(dev)->numa_node);
>>          return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
>>                          to_nd_device_type(dev));
>>   }
>> @@ -519,6 +513,16 @@ void __nd_device_register(struct device *dev)
>>   void nd_device_register(struct device *dev)
>>   {
>>          device_initialize(dev);
>> +
>> +       /*
>> +        * Ensure that region devices always have their NUMA node set as
>> +        * early as possible. This way we are able to make certain that any
>> +        * memory associated with the creation and the creation itself of
>> +        * the region is associated with the correct node.
>> +        */
>> +       if (is_nd_region(dev))
>> +               set_dev_node(dev, to_nd_region(dev)->numa_node);
>> +
>>          __nd_device_register(dev);
> 
> Any reason to not put this inside __nd_device_register()? If you're ok
> with that I can just fix up when applying.

I put it here since regions never call __nd_device_register directly, 
they always call nd_device_register. I figured that by placing it here 
we reduce the impact of this on the other devices that aren't going to 
need it.
