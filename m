Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeEBDeI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:34:08 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:53861 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeEBDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:34:07 -0400
X-Google-Smtp-Source: AB8JxZp4OhbLRvBhv9rz9r3Pu8hKEDTqLyl8YXqGc2vofKg5xVAXgByzGB1LmrioiveVu6jUHX8DKXHnBgFP4zqNHGY=
MIME-Version: 1.0
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
 <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
 <CA+55aFwZ3hrrOJ5W-C8gdam3aGNxz8FEAq9gPnRBkVmwu4BvYA@mail.gmail.com>
 <CAPcyv4i=cjQr9xvxt+Mjp-fhzyNJdTTp7uaAtpJN9R4gPg_j-Q@mail.gmail.com>
 <CA+55aFyZXWoiWnEU8S1PNNyUTWsi7UCnBuDKOobfMLaE8uFKJg@mail.gmail.com>
 <CAPcyv4jTUn2gSPSB1r7p9A7VNxBf54Aa5dnGbGsomDqmbvsHLQ@mail.gmail.com>
 <CA+55aFzDt1uvDBqgkB0T2o2-d5Fi0tBiGcy5iAZ-wRNdAL4uQw@mail.gmail.com>
 <CAPcyv4hQVKL=OtoYbWDGfOMdWen3MkF5qBPrek98+w2gODHvtg@mail.gmail.com> <CAPcyv4ixtVC3w9BE3Z2ME-qMPCh9evBKP51SDrNPXAsg7xH1RQ@mail.gmail.com>
In-Reply-To: <CAPcyv4ixtVC3w9BE3Z2ME-qMPCh9evBKP51SDrNPXAsg7xH1RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 02 May 2018 03:33:55 +0000
Message-ID: <CA+55aFy2LAzRbjCEghN_7SAZgAOr0RoUFDwYkkB+V91jdTg-YA@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Dan Williams <dan.j.williams@intel.com>
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

On Tue, May 1, 2018 at 8:22 PM Dan Williams <dan.j.williams@intel.com>
wrote:

> All that to say that having a typical RAM page covering poisoned pmem
> would complicate the 'clear badblocks' implementation.

Ugh, ok.

I guess the good news is that your patches aren't so big, and don't really
affect anything else.

But can we at least take this to be the impetus for just getting rid of
that disgusting unrolled memcpy? Ablout half of the lines in the patch set
comes from that thing.

Is anybody seriously going to use pmem with some in-order chip that can't
even get something as simple as a memory copy loop right? "git blame"
fingers Tony Luck, I think he may have been influenced by the fumes from
Itanium.

I  have some dim memory of "rep movs doesn't work well for pmem", but does
it *seriously* need unrolling to cacheline boundaries? And if it does, who
designed it, and why is anybody using it?

              Linus
