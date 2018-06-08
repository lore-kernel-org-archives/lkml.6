Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id om33NEqXGlsRHAAAmS7hNA
	; Fri, 08 Jun 2018 14:53:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5F326089E; Fri,  8 Jun 2018 14:53:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 251B8601D2;
	Fri,  8 Jun 2018 14:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 251B8601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFHOxN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:53:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751152AbeFHOxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:53:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE047401EF06;
        Fri,  8 Jun 2018 14:53:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CEBF1C70A;
        Fri,  8 Jun 2018 14:53:04 +0000 (UTC)
Subject: Re: [PATCH 04/10] x86/cet: Handle thread shadow stack
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-5-yu-cheng.yu@intel.com>
 <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
 <3c1bdf85-0c52-39ed-a799-e26ac0e52391@redhat.com>
 <CALCETrWPDXpbVcuFK_1M5DtaCOW_LSf-XHFAD0vpc735oFWLPg@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <6ee29e8b-4a0a-3459-a1ee-03923ba4e15d@redhat.com>
Date: Fri, 8 Jun 2018 16:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWPDXpbVcuFK_1M5DtaCOW_LSf-XHFAD0vpc735oFWLPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 08 Jun 2018 14:53:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 08 Jun 2018 14:53:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 10:53 PM, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 12:47 PM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> On 06/07/2018 08:21 PM, Andy Lutomirski wrote:
>>> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>>
>>>> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
>>>> needs a separate program stack and a separate shadow stack.
>>>> This patch handles allocation and freeing of the thread shadow
>>>> stack.
>>>
>>> Aha -- you're trying to make this automatic.  I'm not convinced this
>>> is a good idea.  The Linux kernel has a long and storied history of
>>> enabling new hardware features in ways that are almost entirely
>>> useless for userspace.
>>>
>>> Florian, do you have any thoughts on how the user/kernel interaction
>>> for the shadow stack should work?
>>
>> I have not looked at this in detail, have not played with the emulator,
>> and have not been privy to any discussions before these patches have
>> been posted, however …
>>
>> I believe that we want as little code in userspace for shadow stack
>> management as possible.  One concern I have is that even with the code
>> we arguably need for various kinds of stack unwinding, we might have
>> unwittingly built a generic trampoline that leads to full CET bypass.
> 
> I was imagining an API like "allocate a shadow stack for the current
> thread, fail if the current thread already has one, and turn on the
> shadow stack".  glibc would call clone and then call this ABI pretty
> much immediately (i.e. before making any calls from which it expects
> to return).

Ahh.  So you propose not to enable shadow stack enforcement on the new 
thread even if it is enabled for the current thread?  For the cases 
where CLONE_VM is involved?

It will still need a new assembler wrapper which sets up the shadow 
stack, and it's probably required to disable signals.

I think it should be reasonable safe and actually implementable.  But 
the benefits are not immediately obvious to me.

> We definitely want strong enough user control that tools like CRIU can
> continue to work.  I haven't looked at the SDM recently enough to
> remember for sure, but I'm reasonably confident that user code can
> learn the address of its own shadow stack.  If nothing else, CRIU
> needs to be able to restore from a context where there's a signal on
> the stack and the signal frame contains a shadow stack pointer.

CRIU also needs the shadow stack *contents*, which shouldn't be directly 
available to the process.  So it needs very special interfaces anyway.

Does CRIU implement MPX support?

Thanks,
Florian
