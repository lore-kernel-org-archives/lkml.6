Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeDSPk3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:40:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeDSPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:40:26 -0400
Date: Thu, 19 Apr 2018 17:40:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Message-ID: <20180419154006.GE3600@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com>
 <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:57:07AM -0500, Alex G. wrote:
> ghes_severity() is a one-to-one mapping from a set of unsorted
> severities to monotonically increasing numbers. The "one-to-one" mapping
> part of the sentence is obvious from the function name. To change it to
> parse the entire GHES would completely destroy this, and I think it
> would apply policy in the wrong place.

So do a wrapper or whatever. Do a ghes_compute_severity() or however you
would wanna call it and do the iteration there.

> Should I do that, I might have to call it something like
> ghes_parse_and_apply_policy_to_severity(). But that misses the whole
> point if these changes.

What policy? You simply compute the severity like we do in the mce code.

> I would like to get to the handlers first, and then decide if things are
> okay or not,

Why? Give me an example why you'd handle an error first and then decide
whether we're ok or not?

Usually, the error handler decides that in one place. So what exactly
are you trying to do differently that doesn't fit that flow?

> I don't want to leave people scratching their heads, but I also don't
> want to make AER a special case without having a generic way to handle
> these cases. People are just as susceptible to scratch their heads
> wondering why AER is a special case and everything else crashes.

Not if it is properly done *and* documented why we applying the
respective policy for the error type.

> Maybe it's better move the AER handling to NMI/IRQ context, since
> ghes_handle_aer() is only scheduling the real AER andler, and is irq
> safe. I'm scratching my head about why we're messing with IRQ work from
> NMI context, instead of just scheduling a regular handler to take care
> of things.

No, first pls explain what exactly you're trying to do and then we can
talk about how to do it. Btw, a real-life example to accompany that
intention goes a long way.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
