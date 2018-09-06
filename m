Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB420857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDB420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeIFRuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:50:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbeIFRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:49:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E6B84021700;
        Thu,  6 Sep 2018 13:14:30 +0000 (UTC)
Received: from [10.36.116.235] (ovpn-116-235.ams2.redhat.com [10.36.116.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC792166B41;
        Thu,  6 Sep 2018 13:14:26 +0000 (UTC)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jean Delvare <khali@linux-fr.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <2094d667-5dbf-b4b8-8e19-c76d67b82362@redhat.com>
 <e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9013df5a-02f9-55b8-eb5e-fad4be0a2c92@redhat.com>
Date:   Thu, 6 Sep 2018 15:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 13:14:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 13:14:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
> On 06/09/2018 10:25, Auger Eric wrote:
>>> +		mutex_lock(&fparam->lock);
>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>> void the queue and deallocate this memory.

By the way I saw there is a kind of garbage collectors for faults which
wouldn't have received any responses. However I am not sure this removes
the concern of having the fault list on kernel side growing beyond
acceptable limits.
>>
>> SMMUv3 holds a queue of events whose size is implementation dependent.
>> I think such a queue should be available at SW level and its size should
>> be negotiated.
> 
> Note that this fault API can also be used by host device drivers that
> want to be notified on fault, in which case a direct callback seems
> easier to use, and perhaps more efficient than an intermediate queue.

> 
> When injecting faults into userspace it makes sense to batch events, to
> avoid context switches. Even though that queue management should
> probably be done by VFIO, the IOMMU API has to help in some way, at
> least to tell VFIO when the IOMMU driver is done processing a batch of
> event.
Yes I am currently investigating the usage of a kfifo in
vfio_iommu_type1, filled by the direct callback.
> 
>> Note SMMU has separate queues for PRI and fault events. Here you use the
>> same queue for all events. I don't know if it would make sense to have
>> separate APIs?
> 
> Host device drivers that use this API to be notified on fault can't deal
> with arch-specific event formats (SMMU event, Vt-d fault event, etc), so
> the APIs should be arch-agnostic. Given that requirement, using a single
> iommu_fault_event structure for both PRI and event queues made sense,
> especially since the even queue can have stall events that look a lot
> like PRI page requests.
I understand the data structure needs to be generic. Now I guess PRI
events and other standard translator error events (that can happen
without PRI) may have different characteristics in event fields, queue
size, that may deserve to create different APIs and internal data
structs. Also this may help separating the concerns. My remark also
stems from the fact the SMMU uses 2 different queues, whose size can
also be different.

Thanks

Eric
> 
> Or do you mean separate APIs for recoverable and non-recoverable faults?
> Using the same queue for PRI and stall event, and a separate one for
> non-recoverable events?
> 
> Separate queues may be useful for the device driver scenario
> (non-virtualization), where recoverable faults are handled by
> io-pgfaults while non-recoverable ones could be reported directly to the
> device driver. For this case I was thinking of adding a
> multiple-consumer thing: both io-pgfaults and the device driver register
> a fault handler. io-pgfault handles recoverable ones and what's left
> goes to the device driver. This could also allow the device driver to be
> notified when io-pgfault doesn't successfully handle a fault
> (handle_mm_fault returns an error).
> 
> Thanks,
> Jean
> 
