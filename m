Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KUTMLsiLGVvLXwAAmS7hNA
	; Thu, 07 Jun 2018 19:47:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2686A6074D; Thu,  7 Jun 2018 19:47:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A2D8D605A2;
	Thu,  7 Jun 2018 19:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2D8D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeFGTra (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:47:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753017AbeFGTr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2B2C8884C;
        Thu,  7 Jun 2018 19:47:27 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-135.ams2.redhat.com [10.36.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75D192166BB2;
        Thu,  7 Jun 2018 19:47:23 +0000 (UTC)
Subject: Re: [PATCH 04/10] x86/cet: Handle thread shadow stack
To: Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
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
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <3c1bdf85-0c52-39ed-a799-e26ac0e52391@redhat.com>
Date: Thu, 7 Jun 2018 21:47:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 19:47:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 19:47:27 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 08:21 PM, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
>> needs a separate program stack and a separate shadow stack.
>> This patch handles allocation and freeing of the thread shadow
>> stack.
> 
> Aha -- you're trying to make this automatic.  I'm not convinced this
> is a good idea.  The Linux kernel has a long and storied history of
> enabling new hardware features in ways that are almost entirely
> useless for userspace.
> 
> Florian, do you have any thoughts on how the user/kernel interaction
> for the shadow stack should work?

I have not looked at this in detail, have not played with the emulator, 
and have not been privy to any discussions before these patches have 
been posted, however …

I believe that we want as little code in userspace for shadow stack 
management as possible.  One concern I have is that even with the code 
we arguably need for various kinds of stack unwinding, we might have 
unwittingly built a generic trampoline that leads to full CET bypass.

I also expect that we'd only have donor mappings in userspace anyway, 
and that the memory is not actually accessible from userspace if it is 
used for a shadow stack.

> My intuition would be that all
> shadow stack management should be entirely controlled by userspace --
> newly cloned threads (with CLONE_VM) should have no shadow stack
> initially, and newly started processes should have no shadow stack
> until they ask for one.

If the new thread doesn't have a shadow stack, we need to disable 
signals around clone, and we are very likely forced to rewrite the early 
thread setup in assembler, to avoid spurious calls (including calls to 
thunks to get EIP on i386).  I wouldn't want to do this If we can avoid 
it.  Just using C and hoping to get away with it doesn't sound greater, 
either.  And obviously there is the matter that the initial thread setup 
code ends up being that universal trampoline.

Thanks,
Florian
