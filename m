Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFEEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105D20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6105D20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeGQMAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:00:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730591AbeGQMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:00:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HBNfVR141232
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:28:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9eqpj7j9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:28:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 12:28:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 12:28:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HBSEgZ40108114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 11:28:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05D224C059;
        Tue, 17 Jul 2018 14:28:33 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7AB4C050;
        Tue, 17 Jul 2018 14:28:30 +0100 (BST)
Received: from [9.193.101.166] (unknown [9.193.101.166])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 14:28:30 +0100 (BST)
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
From:   Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date:   Tue, 17 Jul 2018 16:58:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716082646.GF17280@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071711-0012-0000-0000-0000028B1F28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071711-0013-0000-0000-000020BCDDC0
Message-Id: <cb5fc554-7fa3-1356-c304-ae8c27a0c70c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 01:56 PM, Michal Hocko wrote:
> On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
>> One of the primary issues with Firmware Assisted Dump (fadump) on Power
>> is that it needs a large amount of memory to be reserved. This reserved
>> memory is used for saving the contents of old crashed kernel's memory before
>> fadump capture kernel uses old kernel's memory area to boot. However, This
>> reserved memory area stays unused until system crash and isn't available
>> for production kernel to use.
> 
> How much memory are we talking about. Regular kernel dump process needs
> some reserved memory as well. Why that is not a big problem?

We reserve around 5% of total system RAM. On large systems with
TeraBytes of memory, this reservation can be quite significant.

The regular kernel dump uses the kexec method to boot into capture
kernel and it can control the parameters that are being passed to
capture kernel. This allows a capability to strip down the parameters
that can help lowering down the memory requirement for capture kernel to
boot. This allows regular kdump to reserve less memory to start with.

Where as fadump depends on power firmware (pHyp) to load the capture
kernel after full reset and boots like a regular kernel. It needs same
amount of memory to boot as the production kernel. On large systems
production kernel needs significant amount of memory to boot. Hence
fadump needs to reserve enough memory for capture kernel to boot
successfully and execute dump capturing operations. By default fadump
reserves 5% of total system RAM and in most cases this has worked
flawlessly on variety of system configurations. Optionally,
'crashkernel=X' can also be used to specify more fine-tuned memory size
for reservation.


> 
>> Instead of setting aside a significant chunk of memory that nobody can use,
>> take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
>> as ZONE_MOVABLE, so that the kernel is prevented from using, but
>> applications are free to use it.
> 
> Why kernel cannot use that memory while userspace can?

fadump needs to reserve memory to be able to save crashing kernel's
memory, with help from power firmware, before the capture kernel loads
into crashing kernel's memory area. Any contents present in this
reserved memory will be over-written. If kernel is allowed to use this
memory, then we loose that kernel data and won't be part of captured
dump, which could be critical to debug root cause of system crash.

Kdump and fadump both uses same infrastructure/tool (makedumpfile) to
capture the memory dump. While the tool provides flexibility to
determine what needs to be part of the dump and what memory to filter
out, all supported distributions defaults to "Capture only kernel data
and nothing else". Taking advantage of this default we can at least make
the reserved memory available for userspace to use.

If someone wants to capture userspace data as well then
'fadump=nonmovable' option can be used where reserved pages won't be
marked zone movable.

Advantage of movable method is the reserved memory chunk is also
available for use.

> [...]
>>  Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
>>  arch/powerpc/include/asm/fadump.h                |    7 +
>>  arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
>>  arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
>>  include/linux/mmzone.h                           |    2 
>>  mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
>>  6 files changed, 290 insertions(+), 13 deletions(-)
> 
> This is quite a large change and you didn't seem to explain why we need
> it.
> 

In fadump case, the reserved memory stays unused until system is
crashed. fadump uses very small portion of this reserved memory, few
KBs, for storing fadump metadata. Otherwise, the significant chunk of
memory is completely unused. Hence, instead of blocking a memory that is
un-utilized through out the lifetime of system, it's better to give it
back to production kernel to use. But at the same time we don't want
kernel to use that memory. While exploring we found 1) Linux kernel's
Contiguous Memory Allocator (CMA) feature and 2) ZONE_MOVABLE, that
suites the requirement. Initial 5 revisions of this patchset () was
using CMA feature. However, fadump does not do any cma allocations,
hence it will be more appropriate to use zone movable to achieve the same.

But unlike CMA, there is no interface available to mark a custom
reserved memory area as ZONE_MOVABLE. Hence patch 1/4 proposes the same.

Thanks,
-Mahesh.


