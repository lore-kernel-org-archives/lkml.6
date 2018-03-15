Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCOJMS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:12:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33104 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeCOJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:12:13 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Thread-Topic: arc_usr_cmpxchg and preemption
Thread-Index: AQHTu7KSgtMaj81NvU2WaxKl+xOkrqPP4yWAgAAPhQCAAC4ZgIAAw4yAgAAO6wA=
Date: Thu, 15 Mar 2018 09:12:09 +0000
Message-ID: <1521105128.11552.64.camel@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
         <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
         <20180314175352.GP4064@hirez.programming.kicks-ass.net>
         <1521059931.11552.51.camel@synopsys.com>
         <20180315081845.GS4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180315081845.GS4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5373E3962868F54486F8E6ED3D0ADF5F@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2F9CPUp008874

Hi Peter,

On Thu, 2018-03-15 at 09:18 +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 08:38:53PM +0000, Alexey Brodkin wrote:
> > > int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
> > > {
> > > 	u32 val;
> > > 	int ret;
> > > 
> > > again:
> > > 	ret = 0;
> > > 
> > > 	preempt_disable();
> > > 	val = get_user(user_ptr);
> > > 	if (val == old)
> > > 		ret = put_user(new, user_ptr);
> > > 	preempt_enable();
> > > 
> > > 	if (ret == -EFAULT) {
> > > 		struct page *page;
> > > 		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
> > > 		if (ret < 0)
> > > 			return ret;
> > > 		put_page(page);
> > > 		goto again;
> > 
> > I guess this jump we need to do only once, right?
> 
> Typically, yes. It is theoretically possible for the page to get
> paged-out right after we do put_page() and before we do get/put_user(),
> But if that happens the machine likely has bigger problems than having
> to do this loop again.
> 
> FWIW, look at kernel/futex.c for working examples of this pattern, the
> above was written purely from memory and could contain a fail or two ;-)

Thanks for the pointer!

> Also, it might make sense to stuff this implementation in some lib/ file
> somewhere and make all platforms that need it use the same code, afaict
> there really isn't anything platform specific to it.

Not clear which part do you mean here.
Are you talking about entire cmpxchg syscall implementation?

Do you think there're many users of that quite an inefficient
[compared to proper HW version] atomic exchange?

-Alexey
