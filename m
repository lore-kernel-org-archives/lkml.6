Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeDPP6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:58:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39420 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeDPP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:58:11 -0400
X-Google-Smtp-Source: AIpwx485a79GLXwFI78gfVS8lr8YM6bKoaoXWKsvwgUnleR7PJmY4OUjQxXAtSYU7U/mvoLD3hYlmR+gagnnF98zjNg=
MIME-Version: 1.0
In-Reply-To: <ae84e595-dede-1409-4aff-3a29a310f2ba@canonical.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
 <CAJZ5v0j8GAatWoAra37y3c-ti2Ft5am75KONgEkjB6AaypkCqg@mail.gmail.com> <ae84e595-dede-1409-4aff-3a29a310f2ba@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Apr 2018 17:58:10 +0200
X-Google-Sender-Auth: -cGEJ0f0_B5sDUTXDQr-U22rh9s
Message-ID: <CAJZ5v0gapMMf=KqBAoDTv0SUBeusrUFPyEz6Z4k8Y3Szizdm5Q@mail.gmail.com>
Subject: Re: [Regression] PCI / PM: Simplify device wakeup settings code
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 5:31 PM, Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
> On 04/13/2018 05:34 PM, Rafael J. Wysocki wrote:
>> On Fri, Apr 13, 2018 at 7:56 PM, Joseph Salisbury
>> <joseph.salisbury@canonical.com> wrote:
>>> Hi Rafael,
>>>
>>> A kernel bug report was opened against Ubuntu [0].  After a kernel
>>> bisect, it was found that reverting the following two commits resolved
>>> this bug:
>>>
>>> 0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
>>> 0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
>>>
>>> This is a regression introduced in v4.13-rc1 and still exists in
>>> mainline.  The bug causes the battery to drain when the system is
>>> powered down and unplugged, which does not happed prior to these two
>>> commits.
>> What system and what do you mean by "powered down"?  How much time
>> does it take for the battery to drain now?
> By powered down, the bug reporter is saying physically powered off and
> unplugged.  The system is a HP laptop:
>
> dmi.chassis.vendor: HP
> dmi.product.family: 103C_5335KV HP Notebook
> dmi.product.name: HP Notebook
> vendor_id    : GenuineIntel
> cpu family    : 6
>
>
>>
>>> The bisect actually pointed to commit de3ef1e, but reverting
>>> these two commits fixes the issue.
>>>
>>> I was hoping to get your feedback, since you are the patch author.  Do
>>> you think gathering any additional data will help diagnose this issue,
>>> or would it be best to submit a revert request?
>> First, reverting these is not an option or you will break systems
>> relying on them now.  4.13 is three releases back at this point.
>>
>> Second, your issue appears to be related to the suspend/shutdown path
>> whereas commit 0ce3fcaff929 is mostly about resume, so presumably the
>> change in pci_enable_wake() causes the problem to happen.  Can you try
>> to revert this one alone and see if that helps?
> A test kernel with commits 0ce3fcaff929 and de3ef1eb1cd0 reverted was
> tested.  However, the test kernel still exhibited the bug.

So essentially the bisection result cannot be trusted.
