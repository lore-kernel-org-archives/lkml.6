Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758185AbeD0MJ4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:09:56 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:47698 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758103AbeD0MJo (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Fri, 27 Apr 2018 08:09:44 -0400
Message-Id: <5AE3130702000078001BF180@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Fri, 27 Apr 2018 06:09:43 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <douly.fnst@cn.fujitsu.com>
Cc: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from
 being accounted"
References: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
 <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
In-Reply-To: <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 27.04.18 at 10:32, <douly.fnst@cn.fujitsu.com> wrote:
> At 04/27/2018 03:21 PM, Jan Beulich wrote:
>> I've just stumbled across this commit, and I'm wondering if that's actually
>> correct (I too have at least one system where such IDs are reported in
>> MADT): For offline/absent CPUs, the firmware may not know the APIC IDs
> 
> The MADT table is not reasonable, the Local APIC entries(xAPIC/x2APIC)
> in MADT is not always correct as OS want. So, we should do this sanity
> check.

Of course, sanity checking is necessary.

>> at the point MADT is built, so I think it is quite reasonable to put ~0 in
>> there. The ACPID spec specifically calls out that the IDs must not change
>> across sleep states, which implies to me that they may change across an
>> offline period of a CPU. IOW I think such entries still need to contribute to
>> the count of disabled CPUs.
> 
> Aha, there are no CPU devices which will map it's physical ID to the
> illegal number 0xffffffff, So it will never be used.

The ID will never be used, yes, but the CPU may be (after firmware has
assigned it a valid ID).

> BTW, Limiting the number of the disabled CPUs is also a goal.

I'm afraid I don't understand: Limiting the number of disabled CPUs is
certainly desirable when those can never be used, but why would you
want to do this when they might later get hotplugged? I'm not aware
of a way to tell, by just looking at the MADT, which of the two cases
apply.

Jan
