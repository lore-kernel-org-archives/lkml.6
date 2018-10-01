Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8066C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FC32083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FC32083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJAPzA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:55:00 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:59453 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeJAPzA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Mon, 1 Oct 2018 11:55:00 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 01 Oct 2018 03:18:11 -0600
Message-Id: <5BB1E65002000078001ED196@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Mon, 01 Oct 2018 03:18:08 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        <longman@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH 2/2] xen: make xen_qlock_wait()
 nestable
References: <20181001071641.19282*1*jgross@suse.com>
 <20181001071641.19282-3-jgross@suse.com>
 <5BB1E18802000078001ED127@suse.com>
 <b09903d2-b6f5-299e-5880-f048fd4e1a8b@suse.com>
In-Reply-To: <b09903d2-b6f5-299e-5880-f048fd4e1a8b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 01.10.18 at 11:03, <jgross@suse.com> wrote:
> On 01/10/2018 10:57, Jan Beulich wrote:
>>>>> On 01.10.18 at 09:16, <jgross@suse.com> wrote:
>>> xen_qlock_wait() isn't safe for nested calls due to interrupts. A call
>>> of xen_qlock_kick() might be ignored in case a deeper nesting level
>>> was active right before the call of xen_poll_irq():
>>>
>>> CPU 1:                                   CPU 2:
>>> spin_lock(lock1)
>>>                                          spin_lock(lock1)
>>>                                          -> xen_qlock_wait()
>>>                                             -> xen_clear_irq_pending()
>>>                                             Interrupt happens
>>> spin_unlock(lock1)
>>> -> xen_qlock_kick(CPU 2)
>>> spin_lock_irqsave(lock2)
>>>                                          spin_lock_irqsave(lock2)
>>>                                          -> xen_qlock_wait()
>>>                                             -> xen_clear_irq_pending()
>>>                                                clears kick for lock1
>>>                                             -> xen_poll_irq()
>>> spin_unlock_irq_restore(lock2)
>>> -> xen_qlock_kick(CPU 2)
>>>                                             wakes up
>>>                                          spin_unlock_irq_restore(lock2)
>>>                                          IRET
>>>                                            resumes in xen_qlock_wait()
>>>                                            -> xen_poll_irq()
>>>                                            never wakes up
>>>
>>> The solution is to disable interrupts in xen_qlock_wait() and not to
>>> poll for the irq in case xen_qlock_wait() is called in nmi context.
>> 
>> Are precautions against NMI really worthwhile? Locks acquired both
>> in NMI context as well as outside of it are liable to deadlock anyway,
>> aren't they?
> 
> The locks don't need to be the same. A NMI-only lock tried to be
> acquired with xen_qlock_wait() for another lock having been interrupted
> by the NMI will be enough to risk the issue.

Ah, right. In which case
Reviewed-by: Jan Beulich <jbeulich@suse.com>

Jan


