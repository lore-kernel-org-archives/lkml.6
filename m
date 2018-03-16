Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeCPRdm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:33:42 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39690 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeCPRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:33:39 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "peterz@infradead.org" <peterz@infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Thread-Topic: arc_usr_cmpxchg and preemption
Thread-Index: AQHTu7KSgtMaj81NvU2WaxKl+xOkrqPP4yWAgAAPhQCAAx70AA==
Date: Fri, 16 Mar 2018 17:33:27 +0000
Message-ID: <1521221606.4805.16.camel@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
         <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
         <20180314175352.GP4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180314175352.GP4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9D0AE192006194686F339D488803AF7@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GIFL0e031508

Hi Peter, Vineet,

On Wed, 2018-03-14 at 18:53 +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 09:58:19AM -0700, Vineet Gupta wrote:
> 
> > Well it is broken wrt the semantics the syscall is supposed to provide.
> > Preemption disabling is what prevents a concurrent thread from coming in and
> > modifying the same location (Imagine a variable which is being cmpxchg
> > concurrently by 2 threads).
> > 
> > One approach is to do it the MIPS way, emulate the llsc flag - set it under
> > preemption disabled section and clear it in switch_to
> 
> *shudder*... just catch the -EFAULT, force the write fault and retry.

More I look at this initially quite simple thing more it looks like
a can of worms...

> Something like:
> 
> int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
> {

That functions is supposed to return old value stored in memory.
At least that's how it is used in case of ARC and M68K.

Remember there's already libc that relies on that established API
and we cannot just change it... even though it might be a good idea.
For example return "errno" and pass old value via pointer in an argument.
But now I guess it's better to use what we have now.

> 	u32 val;
> 	int ret;
> 
> again:
> 	ret = 0;
> 
> 	preempt_disable();
> 	val = get_user(user_ptr);

What if get_user() fails?
In Peter's implementation we will return 0, in Vineet's
we will return -EFAULT... and who knows what kind of unexpected behavior happens
further down the line in user-space... so I think it would be safer to kill
the process then.

And that's my take:
-------------------------->8------------------------
int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
{
	u32 val;
	int ret;

again:
	ret = 0;

	preempt_disable();

	ret = get_user(val, user_ptr);
	if(ret == -EFAULT) {
		struct page *page;

		preempt_enable();
		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
		if (ret < 0) {
			force_sig(SIGSEGV, current);
			return ret;
		}

		put_page(page);
		goto again;
	}

	if (val == old)
		ret = put_user(new, user_ptr);

	preempt_enable();

	if (ret == -EFAULT) {
		struct page *page;

		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
		if (ret < 0) {
			force_sig(SIGSEGV, current);
			return ret;
		}

		put_page(page);
		goto again;
	}

	return ret;
}
-------------------------->8------------------------

-Alexey
