Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCTO6e convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeCTO6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:58:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49eWw9VmrUrXxOQXux2OP99e85alzXPza7PLhd6Zkx6jjMswh+Xr9lpbQFuxBa83G4gBXFVQFsmGPJaDXpowm8=
MIME-Version: 1.0
In-Reply-To: <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com> <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Mar 2018 14:58:08 +0000
X-Gmail-Original-Message-ID: <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
Message-ID: <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on paranoid_entry
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: X86 ML <x86@kernel.org>, Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mar 19, 2018, at 10:49 AM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
> GS base is not the kernel's.
>
> FSGSBASE instructions allow user to write any value on GS base;
> even negative. Sign check on the current GS base is not
> sufficient. Fortunately, reading GS base is fast. Kernel GS
> base is also known from the offset table with the CPU number.

The original version of these patches (mine and Andi’s) didn’t have
this comparison, didn’t need RDMSR, and didn’t allow malicious user
programs to cause the kernel to run decently large chunks of code with
the reverse of the expected GS convention. Why did you change it?

I really really don't like having a corner case like this that can and
will be triggered by malicious user code but that is hard to write a
self-test for because it involves guessing a 64-bit magic number.
Untestable corner cases in the x86 entry code are bad.
