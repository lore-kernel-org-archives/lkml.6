Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeCULyq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:54:46 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:48765 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeCULyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:54:41 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "wbx@uclibc-ng.org" <wbx@uclibc-ng.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Thread-Topic: [PATCH] ARC: Improve cmpxchng syscall implementation
Thread-Index: AQHTv3F6C4JZhTz2+k+N1OG5jGcfeKPX0MIAgAK2WQA=
Date: Wed, 21 Mar 2018 11:54:35 +0000
Message-ID: <1521633274.9805.30.camel@synopsys.com>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
         <5bc39838-b1c5-ef65-f97d-8777ed33bda0@synopsys.com>
In-Reply-To: <5bc39838-b1c5-ef65-f97d-8777ed33bda0@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F144678AFD9E2E4EB151407D91816C26@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LBspjn004520

Hi Vineet,

On Mon, 2018-03-19 at 11:29 -0700, Vineet Gupta wrote:
> On 03/19/2018 04:00 AM, Alexey Brodkin wrote:
> > arc_usr_cmpxchg syscall is supposed to be used on platforms
> > that lack support of Load-Locked/Store-Conditional instructions
> > in hardware. And in that case we mimic missing hardware features
> > with help of kernel's sycall that "atomically" checks current
> > value in memory and then if it matches caller expectation new
> > value is written to that same location.
> > 
> 
> ...
> ...
> 
> > 
> > 2. What's worse if we're dealing with data from not yet allocated
> >     page (think of pre-copy-on-write state) we'll successfully
> >     read data but on write we'll silently return to user-space
> >     with correct result 
> 
> This is technically incorrect, even for reading, you need a page, which could be 
> common zero page in certain cases.

Ok I'll reword it like.

> 
> (which we really read just before). That leads
> >     to very strange problems in user-space app further down the line
> >     because new value was never written to the destination.
> > 
> > 3. Regardless of what went wrong we'll return from syscall
> >     and user-space application will continue to execute.
> >     Even if user's pointer was completely bogus.
> 
> Again we are exaggerating (from technical correctness POV) - if user pointer was 
> bogs, the read would not have worked in first place etc. So lets tone down the 
> rhetoric.

Ok here I may rephrase it like that:
------------------------------->8-----------------------------
3. Regardless of what went wrong we'll return from syscall
   and user-space application will continue to execute.
------------------------------->8-----------------------------

> 
> >     In case of hardware LL/SC that app would have been killed
> >     by the kernel.
> > 
> > With that change we attempt to imrove on all 3 items above:
> > 
> > 1. We still disable preemption around read-and-write of
> >     user's data but if we happen to fail with either of them
> >     we're enabling preemption and try to force page fault so
> >     that we have a correct mapping in the TLB. Then re-try
> >     again in "atomic" context.
> > 
> > 2. If real page fault fails or even access_ok() returns false
> >     we send SIGSEGV to the user-space process so if something goes
> >     seriously wrong we'll know about it much earlier.
> > 
> 
> 
> >   
> >   	/*
> >   	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
> > @@ -60,23 +62,48 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
> >   	/* Z indicates to userspace if operation succeded */
> >   	regs->status32 &= ~STATUS_Z_MASK;
> >   
> > -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
> > -		return -EFAULT;
> > +	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
> > +	if (!ret)
> > +		goto fail;
> >   
> > +again:
> >   	preempt_disable();
> >   
> > -	if (__get_user(uval, uaddr))
> > -		goto done;
> > -
> > -	if (uval == expected) {
> > -		if (!__put_user(new, uaddr))
> > +	ret = __get_user(val, uaddr);
> > +	if (ret == -EFAULT) {
> 
> 
> Lets see if this warrants adding complexity ! This implies that TLB entry with 
> Read permissions didn't exist for reading the var and page fault handler could not 
> wire up even a zero page due to preempt_disable, meaning it was something not 
> touched by userspace already - sort of uninitialized variable in user code.

Ok I completely missed the fact that fast path TLB miss handler is being
executed even if we have preemption disabled. So given the mapping exist
we do not need to retry with enabled preemption.

Still maybe I'm a bit paranoid here but IMHO it's good to be ready for a corner-case
when the pointer is completely bogus and there's no mapping for him.
I understand that today we only expect this syscall to be used from libc's
internals but as long as syscall exists nobody stops anybody from using it
directly without libc. So maybe instead of doing get_user_pages_fast() just
send a SIGSEGV to the process? At least user will realize there's some problem
at earlier stage.

> Otherwise it is extremely unlikely to start with a TLB entry with Read 
> permissions, followed by syscall Trap only to find the entry missing, unless a 
> global TLB flush came from other cores, right in the middle. But this syscall is 
> not guaranteed to work with SMP anyways, so lets ignore any SMP misdoings here.

Well but that's exactly the situation I was debugging: we start from data from read-only
page and on attempt to write back modified value COW machinery gets involved.

That was on UP platform.

> Now in case it was *an* uninitialized var, do we have to guarantee any well 
> defined semantics for the kernel emulation of cmpxchg ? IMO it should be fine to 
> return 0 or -EFAULT etc. Infact -EFAULT is better as it will force a retry loop on 
> user side, given the typical cmpxchg usage pattern.

The problem is libc only expects to get a value read from memory.
And in theory expected value might be -14 which is basically -EFAULT.
I'm not talking about 0 at all because in some cases that's exactly what
user-space expects.

So if we read unexpected value then we'll just return it without even attempting
to write.

If we read expected data but fail to write then we'll send a SIGSEGV and
return whatever... let it be -EFAULT - anyways the app will be killed on exit from
this syscall.

-Alexey
