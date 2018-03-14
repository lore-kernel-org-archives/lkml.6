Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbeCNJf7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:35:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeCNJf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:35:57 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Cc: "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-2-vkuznets@redhat.com>
        <DM5PR2101MB103059A90CD91DE8FA69920BDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
Date: Wed, 14 Mar 2018 10:35:52 +0100
In-Reply-To: <DM5PR2101MB103059A90CD91DE8FA69920BDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Tue, 13 Mar 2018 22:46:10 +0000")
Message-ID: <874lljc83r.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> writes:

>> -----Original Message-----
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Friday, March 9, 2018 6:03 AM
>> To: kvm@vger.kernel.org
>> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krčmář
>> <rkrcmar@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Michael
>> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
>> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; Bandan Das <bsd@redhat.com>;
>> linux-kernel@vger.kernel.org
>> Subject: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
>> 
>> hyperv.h is not part of uapi, there are no (known) users outside of kernel.
>> We are making changes to this file to match current Hyper-V TLFS and we
>> don't want to maintain backwards compatibility.
>> 
>> Move the file renaming to hyperv-tlfs.h to avoid confusing it with
>> mshyperv.h. In future, all definitions from TLFS should go to it and
>> all kernel objects should go to mshyperv.h or include/linux/hyperv.h.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> [snip]
>
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index 447371f4de56..72855182b191 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -31,7 +31,6 @@
>>  #include <linux/vmalloc.h>
>>  #include <linux/hyperv.h>
>>  #include <linux/export.h>
>> -#include <asm/hyperv.h>
>
> This #include should remain and be changed to asm/hyperv-tlfs.h.  This
> file uses the hypercall status values HV_STATUS_*.
>
>>  #include <asm/mshyperv.h>

My idea was that <asm/mshyperv.h> already includes <asm/hyperv-tlfs.h> so
there's no need to include them both.

>> 
>>  #include "hyperv_vmbus.h"
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index fe96aab9e794..45f3694bbb76 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -29,7 +29,6 @@
>>  #include <linux/version.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/clockchips.h>
>> -#include <asm/hyperv.h>
>
> This #include should remain and be changed to asm/hyperv-tlfs.h.  This
> file uses HV_MESSAGE_* values.
>

Ditto.

>>  #include <asm/mshyperv.h>
>>  #include "hyperv_vmbus.h"
>> 
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 22300ec7b556..500f805a6ef2 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -27,6 +27,7 @@
>> 
>>  #include <linux/list.h>
>>  #include <asm/sync_bitops.h>
>> +#include <asm/hyperv-tlfs.h>
>>  #include <linux/atomic.h>
>>  #include <linux/hyperv.h>
>>  #include <linux/interrupt.h>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index bc65c4d79c1f..b10fe26c4891 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -36,7 +36,6 @@
>>  #include <linux/cpu.h>
>>  #include <linux/sched/task_stack.h>
>> 
>> -#include <asm/hyperv.h>
>
> This #include should remain and be changed to asm/hyperv-tlfs.h.  This
> file uses HVMSG_* values.
>

Ditto.

>>  #include <asm/mshyperv.h>
>>  #include <linux/notifier.h>
>>  #include <linux/ptrace.h>

Thanks for the review!

-- 
  Vitaly
