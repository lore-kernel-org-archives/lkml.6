Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C650420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfAQLza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:55:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfAQLza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:55:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25EC980D;
        Thu, 17 Jan 2019 03:55:29 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198753F557;
        Thu, 17 Jan 2019 03:55:25 -0800 (PST)
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To:     mathieu.poirier@linaro.org
Cc:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
 <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a9f6be39-6914-4f32-0212-da016757dd72@arm.com>
Date:   Thu, 17 Jan 2019 11:55:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 16/01/2019 23:43, Mathieu Poirier wrote:
> Good evening Suzuki,
> 
> On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 15/01/2019 23:07, Mathieu Poirier wrote:
>>> Add a "sinks" directory entry so that users can see all the sinks
>>> available in the system in a single place.  Individual sink are added
>>> as they are registered with the coresight bus.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

...

>>> +static ssize_t etm_perf_sink_name_show(struct device *dev,
>>> +                                    struct device_attribute *dattr,
>>> +                                    char *buf)
>>> +{
>>> +     /* See function coresight_sink_by_id() to know where this is used */
>>> +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
>>> +
>>> +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
>>> +}
>>> +
>>> +int etm_perf_symlink_sink(struct coresight_device *csdev)
>>> +{
>>> +     struct device *pmu_dev = etm_pmu.dev;
>>> +     struct device *pdev = csdev->dev.parent;
>>> +     struct device_attribute *dev_attr;
>>> +
>>> +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
>>> +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
>>> +             return -EINVAL;
>>> +
>>> +     if (!etm_perf_up)
>>> +             return -EPROBE_DEFER;
>>> +
>>> +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
>>> +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
>>> +     dev_attr->attr.mode = 0444;
>>> +     dev_attr->show = etm_perf_sink_name_show;
>>
>> I would have  added the attribute to the csdev (say, sink_attr),
>> and add that to the group, so that it is easier to remove the
>> attribute when the sink device is removed from the system (when
>> we get there). It would be good to have something in place to remove the
>> attribute.
> 
> My hope was to avoid introducing a new field in the already bloated
> coresight_device structure, and on top of things a component specific
> field.  I think it would be worth it if we'd envision making the

I agree. May be we could add a union for the fields specific to the "Type" of
the device.

> coresight drivers removable in a not so distant future.  But doing
> something like that is quite tricky (as Kim quickly found out) and
> skirts the bottom of the list of priorities, if on it at all.

> 
> I'll change it if you're really keen on it but it would be code that
> is never used.

Yes, I understand. But we would want to get there sometime in the future,
in order to allow using the Coresight out of the box on Enterprise systems.
So it would be good to prepare towards that as we go.


Also, it makes the failure handling easier.

Cheers
Suzuki
