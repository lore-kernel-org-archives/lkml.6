Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCNUi6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:38:58 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42155 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:38:57 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Thread-Topic: arc_usr_cmpxchg and preemption
Thread-Index: AQHTu7KSgtMaj81NvU2WaxKl+xOkrqPP4yWAgAAPhQCAAC4ZgA==
Date: Wed, 14 Mar 2018 20:38:53 +0000
Message-ID: <1521059931.11552.51.camel@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
         <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
         <20180314175352.GP4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180314175352.GP4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18847B7F7A53446ACF7F7C86D6A353F@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EKd5Ik031329

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
> 
> Something like:
> 
> int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
> {
> 	u32 val;
> 	int ret;
> 
> again:
> 	ret = 0;
> 
> 	preempt_disable();
> 	val = get_user(user_ptr);
> 	if (val == old)
> 		ret = put_user(new, user_ptr);
> 	preempt_enable();
> 
> 	if (ret == -EFAULT) {
> 		struct page *page;
> 		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
> 		if (ret < 0)
> 			return ret;
> 		put_page(page);
> 		goto again;

I guess this jump we need to do only once, right?
If for whatever reason get_user_pages_fast() fails we return immediately
and if it succeeds there's no reason for put_user() to not succeed as
required page is supposed to be prepared for write.

Otherwise if something goes way too bad we may end-up in an infinite loop
which we'd better prevent.

> 	}
> 
> 	return ret;
> }

@Vineet, are you OK with proposed implementation?

-Alexey
