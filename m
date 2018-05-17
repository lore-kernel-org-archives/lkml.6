Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEQNqE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752191AbeEQNqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:46:01 -0400
Subject: Re: [PATCH 0/2] support kdump for AMD secure memory encryption(sme)
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com
References: <20180515015133.4363-1-lijiang@redhat.com>
 <55bda494-bee4-5696-03e5-fc21c9d6b631@amd.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <18309611-c8c4-92cb-161e-f35ef3d243ea@redhat.com>
Date: Thu, 17 May 2018 21:45:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <55bda494-bee4-5696-03e5-fc21c9d6b631@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年05月15日 21:31, Tom Lendacky 写道:
> On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
>> It is convenient to remap the old memory encrypted to the second kernel by
>> calling ioremap_encrypted().
>>
>> When sme enabled on AMD server, we also need to support kdump. Because
>> the memory is encrypted in the first kernel, we will remap the old memory
>> encrypted to the second kernel(crash kernel), and sme is also enabled in
>> the second kernel, otherwise the old memory encrypted can not be decrypted.
>> Because simply changing the value of a C-bit on a page will not
>> automatically encrypt the existing contents of a page, and any data in the
>> page prior to the C-bit modification will become unintelligible. A page of
>> memory that is marked encrypted will be automatically decrypted when read
>> from DRAM and will be automatically encrypted when written to DRAM.
>>
>> For the kdump, it is necessary to distinguish whether the memory is
>> encrypted. Furthermore, we should also know which part of the memory is
>> encrypted or decrypted. We will appropriately remap the memory according
>> to the specific situation in order to tell cpu how to deal with the
>> data(encrypted or decrypted). For example, when sme enabled, if the old
>> memory is encrypted, we will remap the old memory in encrypted way, which
>> will automatically decrypt the old memory encrypted when we read those data
>> from the remapping address.
>>
>>  ----------------------------------------------
>> | first-kernel | second-kernel | kdump support |
>> |      (mem_encrypt=on|off)    |   (yes|no)    | 
>> |--------------+---------------+---------------|
>> |     on       |     on        |     yes       |
>> |     off      |     off       |     yes       |
>> |     on       |     off       |     no        |
>> |     off      |     on        |     no        |
>> |______________|_______________|_______________|
>>
>> Test tools:
>> makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
>> commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
>> Author: Lianbo Jiang <lijiang@redhat.com>
>> Date:   Mon May 14 17:02:40 2018 +0800
>> Note: This patch can only dump vmcore in the case of SME enabled.
>>
>> crash-7.2.1: https://github.com/crash-utility/crash.git
>> commit 1e1bd9c4c1be (Fix for the "bpf" command display on Linux 4.17-rc1)
>> Author: Dave Anderson <anderson@redhat.com>
>> Date:   Fri May 11 15:54:32 2018 -0400
>>
>> Test environment:
>> HP ProLiant DL385Gen10 AMD EPYC 7251
>> 8-Core Processor
>> 32768 MB memory
>> 600 GB disk space
>>
>> Linux 4.17-rc4:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> commit 75bc37fefc44 ("Linux 4.17-rc4")
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Sun May 6 16:57:38 2018 -1000
>>
>> Reference:
>> AMD64 Architecture Programmer's Manual
>> https://support.amd.com/TechDocs/24593.pdf
>>
> 
> Have you also tested this with SEV?  It would be nice if the kdump
> changes you make work with both SME and SEV.
> 
Thank you, Tom.
This is a great question, we originally plan to implement SEV in subsequent patches, and
we are also working on SEV at present.
Furthermore, we have another known issue that the system can't jump into the second kernel
when SME is enabled and kaslr is disabled in kdump mode. It seems that is a complex problems,
maybe it is related to kaslr and SME, currently, i'm not sure the root cause, but we will
also plan to fix it. Can you give me any advice about this issue?

Thanks.
Lianbo
> Thanks,
> Tom
> 
>> Lianbo Jiang (2):
>>   add a function(ioremap_encrypted) for kdump when AMD sme enabled.
>>   support kdump when AMD secure memory encryption is active
>>
>>  arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
>>  arch/x86/include/asm/io.h       |  2 ++
>>  arch/x86/kernel/acpi/boot.c     |  8 ++++++++
>>  arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
>>  arch/x86/mm/ioremap.c           | 25 +++++++++++++++++--------
>>  drivers/acpi/tables.c           | 14 +++++++++++++-
>>  drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
>>  fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
>>  include/linux/crash_dump.h      |  4 ++++
>>  kernel/kexec_core.c             | 12 ++++++++++++
>>  10 files changed, 135 insertions(+), 16 deletions(-)
>>
