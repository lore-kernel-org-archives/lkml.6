Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbeBGBan (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:30:43 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35309 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeBGBam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:30:42 -0500
X-Google-Smtp-Source: AH8x224K/xmAbptAhux2rJy3iNlq2iKJPdz4mvagrbqogJtSOMoF3sSJVFtL94HHfpBQgTbvZ36EKSmYoI9pQKbgs5k=
MIME-Version: 1.0
In-Reply-To: <20180206235402.GN30338@tassilo.jf.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net> <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
 <20180206235402.GN30338@tassilo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 17:30:40 -0800
X-Google-Sender-Auth: qEr0Mz8jbNm5wGgUDzKeUjhDXIY
Message-ID: <CA+55aFzRMn6+tFFkAbMT_iDcMphDZFU9+OALEn+ecqa7=RqvUA@mail.gmail.com>
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

On Tue, Feb 6, 2018 at 3:54 PM, Andi Kleen <ak@linux.intel.com> wrote:
>
> But for push, on older CPUs (older AMD, most Atoms, really old Intel big core)
> sub+mov is a lot faster than push because push has additional dependencies
> causing pipeline bubbles. So you would make these cases slower if you
> use PUSH.

I refuse to optimize for old CPU's.

Also, even for old CPU's, the push sequence is *much* smaller than the
mov sequence. And really, just a single extra cache miss more than
eats up any advantage you get from decoding.

> PS it was never fully clear to me why we removed the fast path. After all it
> could still be useful on the future CPUs with Spectre hardware fixes.

The fastpath really messes up all these cleanups, and forced that
"mov" sequence and illegible code.

Plus the fastpath couldn't clear those registers anyway, since it
didn't even _save_ them - exactly because the whole point of the
fastpath was that not all registers are clobbered by the calling
conventions.

We can try to see if it's worth re-instating in a few years when
hopefully fixed CPU's will be the norm. Right now the fast path
definitely made no sense.

           Linus
