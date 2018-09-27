Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6DBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF9216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFF9216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeI1CYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:24:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:3626 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeI1CYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:24:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 13:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="87276646"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.153]) ([10.7.198.153])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2018 13:03:12 -0700
Subject: Re: [RFC workqueue/driver-core PATCH 2/5] async: Add support for
 queueing on specific NUMA node
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215143.13512.56522.stgit@localhost.localdomain>
 <CAPcyv4iJOYiM+rHsM4GPifKNJ=X+AtV2MgWTn+f7u0VBzXb2og@mail.gmail.com>
 <d16cabf9-28f7-31e2-c43d-027738185518@linux.intel.com>
 <CAPcyv4iJeb-tJZVWRziwHQ-ug2P8Hgov2FSGvaXDOjw337kfMg@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <e9e09e7d-fee1-8736-82b3-13ba65879863@linux.intel.com>
Date:   Thu, 27 Sep 2018 13:03:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iJeb-tJZVWRziwHQ-ug2P8Hgov2FSGvaXDOjw337kfMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 12:48 PM, Dan Williams wrote:
> On Thu, Sep 27, 2018 at 8:24 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> [..]
>>>> - * Returns an async_cookie_t that may be used for checkpointing later.
>>>> - * @domain may be used in the async_synchronize_*_domain() functions to
>>>> - * wait within a certain synchronization domain rather than globally.  A
>>>> - * synchronization domain is specified via @domain.  Note: This function
>>>> - * may be called from atomic or non-atomic contexts.
>>>> + * Device specific version of async_schedule_near_domain that provides some
>>>> + * NUMA awareness based on the device node.
>>>> + */
>>>> +async_cookie_t async_schedule_dev_domain(async_func_t func, struct device *dev,
>>>> +                                        struct async_domain *domain)
>>>> +{
>>>> +       return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(async_schedule_dev_domain);
>>>
>>> This seems unnecessary and restrictive. Callers may want to pass
>>> something other than dev as the parameter to the async function, and
>>> dev_to_node() is not on onerous burden to place on callers.
>>
>>
>> That is what async_schedule_near_domain is for, they can call that. The
>> "dev" versions of the calls as just supposed to be helpers since one of
>> the most common parameters to the async_schedule calls is a device, so I
>> thought I would just put together a function that takes care of all this
>> for us so I could drop an argument and avoid having to use dev_to_node
>> everywhere.
> 
> Yeah, makes sense, I guess I was reacting to the fact that this
> expands the number of exports unnecessarily. The other async routines
> are exported because they hide internal implementation details of the
> async implementation. The async_schedule_dev* helpers can just be
> static inline wrappers.

I can do them as inline wrappers for the next patch set. Shouldn't be 
too much of an issue.

Thanks.

- Alex

