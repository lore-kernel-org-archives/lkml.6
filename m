Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FF520664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FF520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJWAu7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJWAu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5A59308FEC4;
        Mon, 22 Oct 2018 16:31:47 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 242BE1057044;
        Mon, 22 Oct 2018 16:31:45 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
To:     Juergen Gross <jgross@suse.com>, Yi Sun <yi.y.sun@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
Date:   Mon, 22 Oct 2018 12:31:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 22 Oct 2018 16:31:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 03:32 AM, Juergen Gross wrote:
> On 22/10/2018 03:53, Yi Sun wrote:
>> On 18-10-19 16:20:52, Juergen Gross wrote:
>>> On 19/10/2018 15:13, Yi Sun wrote:
>> [...]
>>
>>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
>>>> index 0130e48..9e88c7e 100644
>>>> --- a/kernel/locking/qspinlock_paravirt.h
>>>> +++ b/kernel/locking/qspinlock_paravirt.h
>>>> @@ -7,6 +7,8 @@
>>>>  #include <linux/bootmem.h>
>>>>  #include <linux/debug_locks.h>
>>>>  
>>>> +#include <asm/mshyperv.h>
>>>> +
>>>>  /*
>>>>   * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
>>>>   * of spinning them.
>>>> @@ -305,6 +307,10 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>>>>  				wait_early = true;
>>>>  				break;
>>>>  			}
>>>> +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
>>>> +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
>>>> +				break;
>>>> +#endif
>>> I don't like that. Why should a KVM or Xen guest call into a hyperv
>>> specific function?
>>>
>>> Can't you move this to existing hyperv specific paravirt hooks?
>>>
>> hv_notify_long_spin_wait() must be called in this loop but it seems
>> there is no appropriate existing paravirt hook here. So, can I add
>> one more hook in pv_lock_ops to do this notification?
> vcpu_is_preempted() is already part of this loop. And this is a paravirt
> hook. Can't you make use of that? This might require adding another
> parameter to this hook, but I'd prefer that over another pv-spinlock
> hook.
>
> Adding some more locking maintainers and Waiman to the Cc: list.
>
>
> Juergen
>
I agree with Juergen on that. I would suggest rename the
vcpu_is_preempted hook into a more generic vcpu_stop_spinning, perhaps,
so different hypervisors can act on the information accordingly. Adding
an extra parameter is fine.

Cheers,
Longman


