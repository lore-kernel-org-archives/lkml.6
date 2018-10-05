Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC082087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC082087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJETZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:25:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727666AbeJETZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:25:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7AEE8D0342DC8;
        Fri,  5 Oct 2018 20:27:19 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 5 Oct 2018
 20:27:16 +0800
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
To:     Will Deacon <will.deacon@arm.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
 <20181004122207.GE4065@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        <Jan.Glauber@cavium.com>, Peter Zijlstra <peterz@infradead.org>,
        <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, <Vadim.Lomovtsev@cavium.com>,
        Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b04c43bd-5c90-cc06-e2cc-ce542981853a@huawei.com>
Date:   Fri, 5 Oct 2018 13:27:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181004122207.GE4065@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 13:22, Will Deacon wrote:
> Hi Ganapat,
>
> On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
>> can you please pull this patch?
>
> I still don't like the idea of just removing events like this, especially
> when other architectures (including some x86 and Power CPUs afaict) playa
> similar games for generic events, and these events do actually appear in
> user code.
>
> I also don't understand why you remove the TLB events. I think that logic
> would imply we should remove all of the events, because we can't distinguish
> prefetches from reads either. If we want to be consistent, then I think
> we should just remove the OP_WRITE events for L1D and BPU -- would you be
> ok with that instead?
>
> Also, looking at the code, I think our PMCEID parsing is broken for 8.1
> parts, where the upper 32 bits of the register are offset by 0x4000 in the
> event numbering space.
>

Here's something I noticed:
static ssize_t
armv8pmu_events_sysfs_show(struct device *dev,
			   struct device_attribute *attr, char *page)
{
	struct perf_pmu_events_attr *pmu_attr;

	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);

	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);

Should this be min width now be 4, since event width is now 16 bits 
(even though I don't know why we need to specify this width at all)?

Cheers,
John

> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>


