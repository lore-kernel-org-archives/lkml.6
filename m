Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCOIYe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:24:34 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:43888 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeCOIYc (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:11:1>);
        Thu, 15 Mar 2018 04:24:32 -0400
Message-Id: <5AAA3BCB02000078001B1F1B@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 15 Mar 2018 02:24:27 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "David Laight" <David.Laight@aculab.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>, "Arnd Bergmann" <arnd@arndb.de>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>, <x86@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Juergen Gross" <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [v3] xen: remove pre-xen3 fallback handlers
References: <20180313210652.3484599-1-arnd@arndb.de>
 <7c25f7f5-1b54-695e-be5f-6d06d4e89bfa@oracle.com>
In-Reply-To: <7c25f7f5-1b54-695e-be5f-6d06d4e89bfa@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 14.03.18 at 23:47, <boris.ostrovsky@oracle.com> wrote:
> On 03/13/2018 05:06 PM, Arnd Bergmann wrote:
>> The legacy hypercall handlers were originally added with
>> a comment explaining that "copying the argument structures in
>> HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
>> variable is sufficiently safe" and only made sure to not write
>> past the end of the argument structure, the checks in linux/string.h
>> disagree with that, when link-time optimizations are used:
>>
>> In function 'memcpy',
>>     inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
>>     inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
>>     inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
>>     inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
>> include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>>    __read_overflow2();
>>    ^
>>
>> Further research turned out that only Xen 3.0.2 or earlier required the
>> fallback at all, while all versions in use today don't need it.
>> As far as I can tell, it is not even possible to run a mainline kernel
>> on those old Xen releases, at the time when they were in use, only
>> a patched kernel was supported anyway.
>>
>> Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> [v2] use a table lookup instead of a switch/case statement, after
>> multiple suggestions.
>> [v3] remove that file completely
> 
> (+Jan who added this file originally)

Well, if everyone thinks backwards compatibility to those very old
hypervisors is not relevant anymore, then I'm not going to object.
It's really a matter of the consuming distros to know how far back
they want/need to guarantee compatibility.

Jan
