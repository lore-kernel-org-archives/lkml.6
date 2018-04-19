Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeDSQ1C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:27:02 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:41589 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeDSQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:26:59 -0400
X-Google-Smtp-Source: AIpwx49lgWW9/qzMw96sARDXlOVACpJT9mxkktENpClnoCqAWDs+5AP0u/hDC8FBj7cEcrOjTy0/Nw==
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com> <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
Date: Thu, 19 Apr 2018 11:26:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419154006.GE3600@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/19/2018 10:40 AM, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 09:57:07AM -0500, Alex G. wrote:
>> ghes_severity() is a one-to-one mapping from a set of unsorted
>> severities to monotonically increasing numbers. The "one-to-one" mapping
>> part of the sentence is obvious from the function name. To change it to
>> parse the entire GHES would completely destroy this, and I think it
>> would apply policy in the wrong place.
> 
> So do a wrapper or whatever. Do a ghes_compute_severity() or however you
> would wanna call it and do the iteration there.

That doesn't sound right. There isn't a formula to compute. What we're
doing is we're looking at individual error sources, and deciding what
errors we can handle based both on the error, and our ability to handle
the error.

>> Should I do that, I might have to call it something like
>> ghes_parse_and_apply_policy_to_severity(). But that misses the whole
>> point if these changes.
> 
> What policy? You simply compute the severity like we do in the mce code.

As explained above, our ability to resolve an error depends on the
interaction between the error and error handler. This is very closely
tied to the capabilities of each individual handler. I'll do it your
way, but I don't think ignoring this tight coupling is the right thing
to do.

> 
>> I would like to get to the handlers first, and then decide if things are
>> okay or not,
> 
> Why? Give me an example why you'd handle an error first and then decide
> whether we're ok or not?
> 
> Usually, the error handler decides that in one place. So what exactly
> are you trying to do differently that doesn't fit that flow?

In the NMI case you don't make it to the error handler. James and I beat
this subject to the afterlife in v1.

>> I don't want to leave people scratching their heads, but I also don't
>> want to make AER a special case without having a generic way to handle
>> these cases. People are just as susceptible to scratch their heads
>> wondering why AER is a special case and everything else crashes.
> 
> Not if it is properly done *and* documented why we applying the
> respective policy for the error type.
> 
>> Maybe it's better move the AER handling to NMI/IRQ context, since
>> ghes_handle_aer() is only scheduling the real AER andler, and is irq
>> safe. I'm scratching my head about why we're messing with IRQ work from
>> NMI context, instead of just scheduling a regular handler to take care
>> of things.
> 
> No, first pls explain what exactly you're trying to do

I realize v1 was quite a while back, so I'll take this opportunity to
restate:

At a very high level, I'm working with Dell on improving server
reliability, with a focus on NVME hotplug and surprise removal. One of
the features we don't support is surprise removal of NVME drives;
hotplug is supported with 'prepare to remove'. This is one of the
reasons NVME is not on feature parity with SAS and SATA.

My role is to solve this issue on linux, and to not worry about other
OSes. This puts me in a position to have a linux-centric view of the
problem, as opposed to the more common firmware-centric view.

Part of solving the surprise removal issue involves improving FFS error
handling. This is required because the servers which are shipping use
FFS instead of native error notifications. As part of extensive testing,
I have found the NMI handler to be the most common cause of crashes, and
hence this series.

> and then we can talk about how to do it.

Your move.

> Btw, a real-life example to accompany that intention goes a long way.

I'm not sure if this is the example you're looking for, but
take an r740xd server, and slowly unplug an Intel NVME drives at an
angle. You're likely to crash the machine.

Alex
