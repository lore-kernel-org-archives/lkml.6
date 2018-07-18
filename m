Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C873DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8259E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8259E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbeGRRBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:01:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731392AbeGRRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:01:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IGJ4Fu037374
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:22:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka8tkgftr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:22:26 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 17:22:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 17:22:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IGMKLW40370420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 16:22:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE96EAE051;
        Wed, 18 Jul 2018 19:22:35 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC89FAE04D;
        Wed, 18 Jul 2018 19:22:33 +0100 (BST)
Received: from [9.85.85.232] (unknown [9.85.85.232])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 19:22:33 +0100 (BST)
Subject: Re: [RFC PATCH v6 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
 <20180716082646.GF17280@dhcp22.suse.cz>
 <cb5fc554-7fa3-1356-c304-ae8c27a0c70c@linux.vnet.ibm.com>
 <20180717115232.GF7193@dhcp22.suse.cz>
From:   Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date:   Wed, 18 Jul 2018 21:52:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717115232.GF7193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071816-0020-0000-0000-000002A81A76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071816-0021-0000-0000-000020F48A0F
Message-Id: <b2c316b9-520e-0a31-3ebd-d3ade50c3783@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 05:22 PM, Michal Hocko wrote:
> On Tue 17-07-18 16:58:10, Mahesh Jagannath Salgaonkar wrote:
>> On 07/16/2018 01:56 PM, Michal Hocko wrote:
>>> On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
>>>> One of the primary issues with Firmware Assisted Dump (fadump) on Power
>>>> is that it needs a large amount of memory to be reserved. This reserved
>>>> memory is used for saving the contents of old crashed kernel's memory before
>>>> fadump capture kernel uses old kernel's memory area to boot. However, This
>>>> reserved memory area stays unused until system crash and isn't available
>>>> for production kernel to use.
>>>
>>> How much memory are we talking about. Regular kernel dump process needs
>>> some reserved memory as well. Why that is not a big problem?
>>
>> We reserve around 5% of total system RAM. On large systems with
>> TeraBytes of memory, this reservation can be quite significant.
>>
>> The regular kernel dump uses the kexec method to boot into capture
>> kernel and it can control the parameters that are being passed to
>> capture kernel. This allows a capability to strip down the parameters
>> that can help lowering down the memory requirement for capture kernel to
>> boot. This allows regular kdump to reserve less memory to start with.
>>
>> Where as fadump depends on power firmware (pHyp) to load the capture
>> kernel after full reset and boots like a regular kernel. It needs same
>> amount of memory to boot as the production kernel. On large systems
>> production kernel needs significant amount of memory to boot. Hence
>> fadump needs to reserve enough memory for capture kernel to boot
>> successfully and execute dump capturing operations. By default fadump
>> reserves 5% of total system RAM and in most cases this has worked
>> flawlessly on variety of system configurations. Optionally,
>> 'crashkernel=X' can also be used to specify more fine-tuned memory size
>> for reservation.
> 
> So why do we even care about fadump when regular kexec provides
> (presumably) same functionality with a smaller memory footprint? Or is
> there any reason why kexec doesn't work well on ppc?

Kexec based kdump is loaded by crashing kernel. When OS crashes, the
system is in an inconsistent state, especially the devices. In some
cases, a rogue DMA or ill-behaving device drivers can cause the kdump
capture to fail.

On power platform, fadump solves these issues by taking help from power
firmware, to fully-reset the system, load the fresh copy of same kernel
to capture the dump with PCI and I/O devices reinitialized, making it
more reliable.

Fadump does full system reset, booting system through the regular boot
options i.e the dump capture kernel is booted in the same fashion and
doesn't have specialized kernel command line option. This implies, we
need to give more memory for the system boot. Since the new kernel boots
from the same memory location as crashed kernel, we reserve 5% of memory
where power firmware moves the crashed kernel's memory content. This
reserved memory is completely removed from the available memory. For
large memory systems like 64TB systems, this account to ~ 3TB, which is
a significant chunk of memory production kernel is deprived of. Hence,
this patch adds an improvement to exiting fadump feature to make the
reserved memory available to system for use, using zone movable.

Thanks,
-Mahesh.

> 
>>>> Instead of setting aside a significant chunk of memory that nobody can use,
>>>> take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
>>>> as ZONE_MOVABLE, so that the kernel is prevented from using, but
>>>> applications are free to use it.
>>>
>>> Why kernel cannot use that memory while userspace can?
>>
>> fadump needs to reserve memory to be able to save crashing kernel's
>> memory, with help from power firmware, before the capture kernel loads
>> into crashing kernel's memory area. Any contents present in this
>> reserved memory will be over-written. If kernel is allowed to use this
>> memory, then we loose that kernel data and won't be part of captured
>> dump, which could be critical to debug root cause of system crash.
> 
> But then you simply screw user memory sitting there. This might be not
> so critical as the kernel memory but still it sounds like you are
> reducing the usefulness of the dump just because of inherent limitations
> of fadump.
> 
>> Kdump and fadump both uses same infrastructure/tool (makedumpfile) to
>> capture the memory dump. While the tool provides flexibility to
>> determine what needs to be part of the dump and what memory to filter
>> out, all supported distributions defaults to "Capture only kernel data
>> and nothing else". Taking advantage of this default we can at least make
>> the reserved memory available for userspace to use.
>>
>> If someone wants to capture userspace data as well then
>> 'fadump=nonmovable' option can be used where reserved pages won't be
>> marked zone movable.
> 
> Ohh, so you have an unclutter thing to support the case above.
> 
>> Advantage of movable method is the reserved memory chunk is also
>> available for use.
>>
>>> [...]
>>>>  Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
>>>>  arch/powerpc/include/asm/fadump.h                |    7 +
>>>>  arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
>>>>  arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
>>>>  include/linux/mmzone.h                           |    2 
>>>>  mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
>>>>  6 files changed, 290 insertions(+), 13 deletions(-)
>>>
>>> This is quite a large change and you didn't seem to explain why we need
>>> it.
>>>
>>
>> In fadump case, the reserved memory stays unused until system is
>> crashed. fadump uses very small portion of this reserved memory, few
>> KBs, for storing fadump metadata. Otherwise, the significant chunk of
>> memory is completely unused. Hence, instead of blocking a memory that is
>> un-utilized through out the lifetime of system, it's better to give it
>> back to production kernel to use. But at the same time we don't want
>> kernel to use that memory. While exploring we found 1) Linux kernel's
>> Contiguous Memory Allocator (CMA) feature and 2) ZONE_MOVABLE, that
>> suites the requirement. Initial 5 revisions of this patchset () was
>> using CMA feature. However, fadump does not do any cma allocations,
>> hence it will be more appropriate to use zone movable to achieve the same.
>>
>> But unlike CMA, there is no interface available to mark a custom
>> reserved memory area as ZONE_MOVABLE. Hence patch 1/4 proposes the same.
> 
> Well, you are adding a significant amount of code so you should be much
> better in explaining why does the generic code care about a ppc specific
> kdump method.
> 

