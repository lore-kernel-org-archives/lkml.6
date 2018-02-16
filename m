Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756761AbeBPAff (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:35:35 -0500
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:53364 "EHLO
        ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeBPAfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:35:34 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com>
 <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
 <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <d1095ed0-1a4e-823e-d65a-558ea53dfce5@citrix.com>
Date: Fri, 16 Feb 2018 00:35:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 00:08, Linus Torvalds wrote:
> On Thu, Feb 15, 2018 at 3:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> Linus, how would you feel about, by default, preventing 64-bit
>> programs from long-jumping to __USER32_CS and vice versa?
> How? It's a standard GDT entry. Are you going to start switching the
> GDT around every context switch?
>
> I *thought* that user space can just do a far jump on its own. But
> it's so long since I had to care that I may have forgotten all the
> requirements for going between "compatibility mode" and real long
> mode.

Yes - it is just a straight far jump to switch between compat and long mode.

A evil^W cunning programmer can use the 286 world view and disable
segments by clearing the present bit to yield #NP[sel] on use, which is
liable to be rather faster than LGDT on a context switch.

Alternatively, set both the L and D (code segments only), or playing
with DPL/type can all yield #GP[sel] on use, but these probably aren't
as good options.

~Andrew
