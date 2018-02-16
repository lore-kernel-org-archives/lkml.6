Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031503AbeBPQZz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:25:55 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44889 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031270AbeBPQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:25:54 -0500
X-Google-Smtp-Source: AH8x227EtJhRRq/bzIRDmJUkKDoxo2mb2AtZAJv++K1xen33GtYnYCufDX7bLw2STo6mRtriSuU1+LIYgPpLZyBzNJU=
MIME-Version: 1.0
In-Reply-To: <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 16 Feb 2018 16:25:33 +0000
Message-ID: <CAJwJo6Z-1yMszSJnx1=+z0igjHSrfz=dLKxmsxrFhcCyYgYpHg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-15 20:02 GMT+00:00 Andy Lutomirski <luto@kernel.org>:
> On Thu, Feb 15, 2018 at 4:36 PM, Nadav Amit <namit@vmware.com> wrote:
>> Based on the understanding that there should be no way for userspace to
>> address the kernel-space from compatibility mode, disable it while
>> running in compatibility mode as long as the 64-bit code segment of the
>> user is not used.
>>
>> Reenabling PTI is performed by restoring NX-bits to the userspace
>> mappings, flushing the TLBs, and notifying all the CPUs that use the
>> affected mm to disable PTI. Each core responds by removing the present
>> bit for the 64-bit code-segment, and marking that PTI is disabled on
>> that core.
>>
>
> I dislike this patch because it's conflating two things.  The patch
> claims to merely disable PTI for compat tasks, whatever those are.
> But it's also introducing a much stronger concept of what a compat
> task is.  The kernel currently mostly doesn't care whether a task is
> "compat" or not, and I think that most remaining code paths that do
> care are buggy and should be removed.

Yes, please, don't do a stronger concept..
Speaking from CRIU side, it C/R ia32 tasks with x86_64 binaries.

-- 
             Dmitry
