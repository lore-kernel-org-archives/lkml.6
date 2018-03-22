Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbeCVBkV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeCVBkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:40:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885C92177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELs5/kuoEXgk1CYJoP1C8jMUPO0aQxB76D1J7//B4djmylPDuQZJGJam3ZFoWJkH8h1yfHte9+3x2aab27otEeM=
MIME-Version: 1.0
In-Reply-To: <A78C989F6D9628469189715575E55B23696641B6@IRSMSX103.ger.corp.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com> <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <A78C989F6D9628469189715575E55B23696641B6@IRSMSX103.ger.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 01:39:58 +0000
X-Gmail-Original-Message-ID: <CALCETrXB=jhXQBM8btgSJq-BQY79rL7ekDdv7COgJHSjxj9XoQ@mail.gmail.com>
Message-ID: <CALCETrXB=jhXQBM8btgSJq-BQY79rL7ekDdv7COgJHSjxj9XoQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when FS/GS
 updated by ptracer
To: "Metzger, Markus T" <markus.t.metzger@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 7:01 AM, Metzger, Markus T
<markus.t.metzger@intel.com> wrote:
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto@kernel.org]
>> Sent: 21 March 2018 01:47
>
> Hello Andy,
>
>> I retract this particular comment.  But I still think that all this complexity needs to
>> be more clearly justified.  My objection to the old approach wasn't that I thought
>> it was obviously wrong -- I thought that someone needed to survey existing
>> ptrace() users and see if anyone needed the fancier code that you're adding.  Did
>> you find something that needs this fancy code?
>
> There are 3 cases:
> - only FS changed, e.g. "p $fs = ..."

If a person literally types that, I have no problem if they get
different behavior on different systems.  If it's some existing
program that needs to keep working, then we may be out of luck, since
gdb seems to use SETREGS.

> - only FS_BASE changed, e.g. "p $fs_base = ..."

That's fine no matter what, I think.

> - both change, e.g. "p foo()" when restoring the original register state on return
>   from the inferior call

This is the interesting case.  If everything that matters uses
SETREGS, then I think we're in good shape, and we should probably just
make writing to FS using ptrace on FSGSBASE systems *not* change
FSBASE, since that way is much simpler.
