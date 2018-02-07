Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754355AbeBGRh4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:37:56 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:51299 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbeBGRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:37:54 -0500
X-Google-Smtp-Source: AH8x224K2m9Im8l7pQ5pdX4dMc2Rx1eRTh7SNHzmmSldOqE6XPv2Sas1iY19lsBvcHpBxrSt0mEgwJtYo7bBkGBBGf4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzM8ynf4m-X6EPS10gxNqsKPN_8mGucGHvBp8H+OkgW3g@mail.gmail.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net> <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
 <20180206235402.GN30338@tassilo.jf.intel.com> <CA+55aFzRMn6+tFFkAbMT_iDcMphDZFU9+OALEn+ecqa7=RqvUA@mail.gmail.com>
 <20180207151854.GB10945@tassilo.jf.intel.com> <CA+55aFzM8ynf4m-X6EPS10gxNqsKPN_8mGucGHvBp8H+OkgW3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 09:37:53 -0800
X-Google-Sender-Auth: uwvW7R6ePBBgHrw-bOcY-pjISUY
Message-ID: <CA+55aFxJri=_txLWBkVqs6peL5BLC0XpJSZUQr4YYGHC1s09mg@mail.gmail.com>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
To: Andi Kleen <ak@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 9:05 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The other thing we need to do is to just pass down the system call
> number as an argument instead of reloading it.

.. we may also want to disable some debug things.

For example, if you enable KASAN, it does insane things for
do_syscall(). I realize that nobody is supposed to care about
performance for KASAN, but still...

So one of the issues with do_syscall() is simply that _because_ it was
the rare case only, the code simply was never even looked at. But if y
ou look at the straight-line case, do_syscall_64() really doesn't look
too bad apart from the argument reloading that I do think is largely
fixable.

              Linus
