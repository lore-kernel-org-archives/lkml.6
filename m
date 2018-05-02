Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEBKlH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:41:07 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:38185 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:41:04 -0400
X-Google-Smtp-Source: AB8JxZohsW+BNNdGC8MCjkxLcjI0hzDbM9ZrY5/YzVYrsrql8ucgZaYUJlo68kIz2sqTYwZEI0bpWRDQDQ6NRc4//eQ=
MIME-Version: 1.0
In-Reply-To: <20180501195501.GB11698@bhelgaas-glaptop.roam.corp.google.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
 <CAJZ5v0j8GAatWoAra37y3c-ti2Ft5am75KONgEkjB6AaypkCqg@mail.gmail.com>
 <ae84e595-dede-1409-4aff-3a29a310f2ba@canonical.com> <CAJZ5v0gapMMf=KqBAoDTv0SUBeusrUFPyEz6Z4k8Y3Szizdm5Q@mail.gmail.com>
 <1f67f00a-8141-f9af-2120-c78f7cfecb1d@canonical.com> <CAJZ5v0iPsoxCLxsq156RvyZ1cWtM9jNMLUPMnE3cqi5r1jk8jg@mail.gmail.com>
 <20180501195501.GB11698@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 May 2018 12:41:03 +0200
X-Google-Sender-Auth: yj7Btk2bLWv9vXUm6mFPSmt_468
Message-ID: <CAJZ5v0geYMuzcEhCKcaCHNP-j_ceeyZM0CqEaOTeE3jqVd6zaA@mail.gmail.com>
Subject: Re: [Regression] PCI / PM: Simplify device wakeup settings code
To: Bjorn Helgaas <helgaas@kernel.org>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:55 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, May 01, 2018 at 10:34:29AM +0200, Rafael J. Wysocki wrote:
>> On Mon, Apr 30, 2018 at 4:22 PM, Joseph Salisbury
>> <joseph.salisbury@canonical.com> wrote:
>> > On 04/16/2018 11:58 AM, Rafael J. Wysocki wrote:
>> >> On Mon, Apr 16, 2018 at 5:31 PM, Joseph Salisbury
>> >> <joseph.salisbury@canonical.com> wrote:
>> >>> On 04/13/2018 05:34 PM, Rafael J. Wysocki wrote:
>> >>>> On Fri, Apr 13, 2018 at 7:56 PM, Joseph Salisbury
>> >>>> <joseph.salisbury@canonical.com> wrote:
>> >>>>> Hi Rafael,
>> >>>>>
>> >>>>> A kernel bug report was opened against Ubuntu [0].  After a kernel
>> >>>>> bisect, it was found that reverting the following two commits resolved
>> >>>>> this bug:
>> >>>>>
>> >>>>> 0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
>> >>>>> 0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
>> >>>>>
>> >>>>> This is a regression introduced in v4.13-rc1 and still exists in
>> >>>>> mainline.  The bug causes the battery to drain when the system is
>> >>>>> powered down and unplugged, which does not happed prior to these two
>> >>>>> commits.
>> >>>> What system and what do you mean by "powered down"?  How much time
>> >>>> does it take for the battery to drain now?
>> >>> By powered down, the bug reporter is saying physically powered off and
>> >>> unplugged.  The system is a HP laptop:
>> >>>
>> >>> dmi.chassis.vendor: HP
>> >>> dmi.product.family: 103C_5335KV HP Notebook
>> >>> dmi.product.name: HP Notebook
>> >>> vendor_id    : GenuineIntel
>> >>> cpu family    : 6
>> >>>
>> >>>
>> >>>>> The bisect actually pointed to commit de3ef1e, but reverting
>> >>>>> these two commits fixes the issue.
>> >>>>>
>> >>>>> I was hoping to get your feedback, since you are the patch author.  Do
>> >>>>> you think gathering any additional data will help diagnose this issue,
>> >>>>> or would it be best to submit a revert request?
>> >>>> First, reverting these is not an option or you will break systems
>> >>>> relying on them now.  4.13 is three releases back at this point.
>> >>>>
>> >>>> Second, your issue appears to be related to the suspend/shutdown path
>> >>>> whereas commit 0ce3fcaff929 is mostly about resume, so presumably the
>> >>>> change in pci_enable_wake() causes the problem to happen.  Can you try
>> >>>> to revert this one alone and see if that helps?
>> >>> A test kernel with commits 0ce3fcaff929 and de3ef1eb1cd0 reverted was
>> >>> tested.  However, the test kernel still exhibited the bug.
>> >> So essentially the bisection result cannot be trusted.
>> >
>> > We performed some more testing and confirmed just a revert of the
>> > following commit resolves the bug:
>> >
>> > 0847684cfc5f0 ("PCI / PM: Simplify device wakeup settings code")
>>
>> Thanks for confirming this!
>>
>> > Can you think of any suggestions to help debug further?
>>
>> The root cause of the regression is likely the change in
>> pci_enable_wake() removing the device_may_wakeup() check from it.
>>
>> Probably, one of the drivers in the platform calls pci_enable_wake()
>> directly from its ->shutdown() callback and that causes the device to
>> be set up for system wakeup which in turn causes the power draw while
>> the system is off to increase.
>>
>> I would look at the PCI drivers used on that platform to find which of
>> them call pci_enable_wake() directly from ->shutdown() and I would
>> make these calls conditional on device_may_wakeup().
>
> I took a quick look with
>
>   git grep -E "pci_enable_wake\(.*[^0]\);|device_may_wakeup"
>
> and didn't notice any pci_enable_wake() callers that called
> device_may_wakeup() first.

I've just look at a bunch of network drivers doing that.

It looks like I may need to restore __pci_enable_wake() with an extra
"runtime" argument for internal use.

Joseph, can you ask the reporter to test the Bjorn's patch, please?
