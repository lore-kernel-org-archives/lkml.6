Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCXAqp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:46:45 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:54676 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:46:43 -0400
X-Google-Smtp-Source: AG47ELu9Fm1kX8PjPaA6E4QKHkrRY+C5yDQAbwl4/3TWQwdRIBYO0BHi/7dlYi4WLzs0meajWlwG/ynAyhPRPm7WK9Y=
MIME-Version: 1.0
In-Reply-To: <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
References: <20180323174447.55F35636@viggo.jf.intel.com> <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2018 17:46:42 -0700
X-Google-Sender-Auth: HIBzCSzq1S-fIdVDXF1BcMoNpWc
Message-ID: <CA+55aFxn=NiAhtz77nrx1_10em8bume-M0UzYZU2eVm5n71juA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 5:40 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> Well, rats.  This somehow makes things slower with PCIDs on.

.. what happens when you enable global pages with PCID? You disabled
them explicitly because you thought they wouldn't matter..

Even with PCID, a global TLB entry for the shared pages would make
sense, because it's now just *one* entry in the TLB rather that "one
per PCID and one for the kernel mapping".

So even if in theory the lifetime of the TLB entry is the same, when
you have capacity misses it most definitely isn't.

And for process tear-down and build-up the per-PCID TLB entry does
nothing at all. While for a true global entry, it gets shared even
across process creation/deletion. So even ignoring TLB capacity
issues, with lots of shortlived processes global TLB entries are much
better.

It is, of course, possible that I misunderstood what you actually
benchmarked. But I assume the above benchmark numbers are with the
whole "don't even do global entries if you have PCID".

               Linus
