Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeEBDUy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:20:54 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:39868 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeEBDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:20:50 -0400
X-Google-Smtp-Source: AB8JxZrJc7Ry/VIhLugw4/01T3ifMu1XOP7OymaGzXchIaCsH+wuDvZh41Z1CBDYo13a+LOLcFdXCn1Tg/wWk+1Q8cY=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzDt1uvDBqgkB0T2o2-d5Fi0tBiGcy5iAZ-wRNdAL4uQw@mail.gmail.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
 <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
 <CA+55aFwZ3hrrOJ5W-C8gdam3aGNxz8FEAq9gPnRBkVmwu4BvYA@mail.gmail.com>
 <CAPcyv4i=cjQr9xvxt+Mjp-fhzyNJdTTp7uaAtpJN9R4gPg_j-Q@mail.gmail.com>
 <CA+55aFyZXWoiWnEU8S1PNNyUTWsi7UCnBuDKOobfMLaE8uFKJg@mail.gmail.com>
 <CAPcyv4jTUn2gSPSB1r7p9A7VNxBf54Aa5dnGbGsomDqmbvsHLQ@mail.gmail.com> <CA+55aFzDt1uvDBqgkB0T2o2-d5Fi0tBiGcy5iAZ-wRNdAL4uQw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 1 May 2018 20:20:49 -0700
Message-ID: <CAPcyv4hQVKL=OtoYbWDGfOMdWen3MkF5qBPrek98+w2gODHvtg@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 8:13 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 1, 2018 at 8:03 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
>
>> Because dax. There's no page cache indirection games we can play here
>> to poison a page and map in another page. The mapped page is 1:1
>> associated with the filesystem block and physical memory address.
>
> I'm not talking page cache indirection.
>
> I'm talking literally mapping a different page into the kernel virtual
> address space that the failing read was done for.
>
> But you seem to be right that we don't actually support that. I'm guessing
> the hwpoison code has never had to run in that kind of situation and will
> just give up.
>
> That would seem to be sad. It really feels like the obvious solution to any
> MCE's - just map a dummy page at the address that causes problems.
>
> That can have bad effects for real memory (because who knows what internal
> kernel data structure might be in there), but would seem to be the
> _optimal_ solution for some  random pmem access. And makes it absolutely
> trivial to just return to the execution that got  the error exception.

The other property of pmem that we need to contend with that makes it
a snowflake relative to typical memory is that errors can be repaired
by sending a slow-path command to the DIMM device. We trap block-layer
writes in the pmem driver that target known 'badblocks' and send the
sideband command to clear the error along with the new data.
