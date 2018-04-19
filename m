Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDSO5P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:57:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36021 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeDSO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:57:10 -0400
X-Google-Smtp-Source: AIpwx4/P9+x4qgnrMPzzurLq6jv/wVt2CuLHRwliWBrXgPHrSaboJV0lY3ceTcH5DW/svaaBFqaX+A==
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
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
Date: Thu, 19 Apr 2018 09:57:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418175415.GJ4795@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2018 12:54 PM, Borislav Petkov wrote:
> On Mon, Apr 16, 2018 at 04:59:02PM -0500, Alexandru Gagniuc wrote:
>> Firmware is evil:
>>  - ACPI was created to "try and make the 'ACPI' extensions somehow
>>  Windows specific" in order to "work well with NT and not the others
>>  even if they are open"
>>  - EFI was created to hide "secret" registers from the OS.
>>  - UEFI was created to allow compromising an otherwise secure OS.
>>
>> Never has firmware been created to solve a problem or simplify an
>> otherwise cumbersome process. It is of no surprise then, that
>> firmware nowadays intentionally crashes an OS.
> 
> I don't believe I'm saying this but, get rid of that rant. Even though I
> agree, it doesn't belong in a commit message.

Of course.

(snip)> Well, Tyler touched that AER error severity handling recently
and we had
> it all nicely documented in the comment above ghes_handle_aer().
> 
> Your ghes_handle_aer_irqsafe() graft basically bypasses
> ghes_handle_aer() instead of incorporating in it.
> 
> If all you wanna say is, the severity computation should go through all
> the sections and look at each error's severity before making a decision,
> then add that to ghes_severity() instead of doing that "deferrable"
> severity dance.

ghes_severity() is a one-to-one mapping from a set of unsorted
severities to monotonically increasing numbers. The "one-to-one" mapping
part of the sentence is obvious from the function name. To change it to
parse the entire GHES would completely destroy this, and I think it
would apply policy in the wrong place.

Should I do that, I might have to call it something like
ghes_parse_and_apply_policy_to_severity(). But that misses the whole
point if these changes.

I would like to get to the handlers first, and then decide if things are
okay or not, but the ARM guys didn't exactly like this approach. It
seems there are quite some per-error-type considerations.
The logical step is to associate these considerations with the specific
error type they apply to, rather than hide them as a decision under an
innocent ghes_severity().

> And add the changes to the policy to the comment above
> ghes_handle_aer(). I don't want any changes from people coming and going
> and leaving us scratching heads why we did it this way.
>
> And no need for those handlers and so on - make it simple first - then we
> can talk more complex handling.

I don't want to leave people scratching their heads, but I also don't
want to make AER a special case without having a generic way to handle
these cases. People are just as susceptible to scratch their heads
wondering why AER is a special case and everything else crashes.

Maybe it's better move the AER handling to NMI/IRQ context, since
ghes_handle_aer() is only scheduling the real AER andler, and is irq
safe. I'm scratching my head about why we're messing with IRQ work from
NMI context, instead of just scheduling a regular handler to take care
of things.

Alex
