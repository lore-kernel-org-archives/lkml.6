Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeDXUE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:04:27 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:40185 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeDXUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:04:24 -0400
X-Google-Smtp-Source: AIpwx48SJ6yjA0TdmaWXG8W5jpqbm0s3UH3Hkuvb8kE9/8oxxcXpZlrsHD3XDvPzBJJzPmQ4f1WBh32+fI6AtJrSN1A=
MIME-Version: 1.0
In-Reply-To: <20180424215429.1de8b1b3@redhat.com>
References: <20180424215429.1de8b1b3@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Apr 2018 13:04:23 -0700
X-Google-Sender-Auth: IBsiD_F_gSzQ0GiKAhfhNbGjPU0
Message-ID: <CA+55aFx-V8L602X-EHgrJPNA49v_ZiBZW=+v=tcSQK5QZOXYJw@mail.gmail.com>
Subject: Re: Boot failures with net-next after rebase to v4.17.0-rc1
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Ahern <dsa@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:54 PM, Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
> Hi all,
>
> I'm experiencing boot failures with net-next git-tree after it got
> rebased/merged with Linus'es tree at v4.17.0-rc1.

I suspect it's the global bit stuff that came in very late in the
merge window, and had been developed and tested for a while before,
but showed some problems under some configs.

The fix is currently in the x86/pti tree in -tip, see:

   x86/pti: Fix boot problems from Global-bit setting

and I expect it will percolate upstream soon.

In the meantime, it would be good to verify that merging that x86/pti
branch fixes it for you?

There is another candidate for boot problems - do you happen to have
CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled? That can under certain
circumstances get a percpu setup page fault because memory hadn't been
initialized sufficiently.

The fix there is to move the mm_init() call one step earlier in
init_main(): start_kernel() (to before trap_init()).

And if it's neither of the above, I think you'll need to help bisect it.

               Linus
