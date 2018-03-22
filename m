Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeCVB0l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:26:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39541 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeCVB0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:26:39 -0400
X-Google-Smtp-Source: AG47ELtXYe0P3g0VY/9isFwk6dIYDPqdcq4GTvBjct+BIkzZuOhodJT4yY2UfzBtlG6exXDOUicZU1bdUVwVsLs8DlQ=
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com> <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2018 18:26:38 -0700
X-Google-Sender-Auth: GgzyCmcNGrukB1tl8UGlMsdAu_8
Message-ID: <CA+55aFydu4+MZ=-5L7wDr2LvNH6Dbmi4qLnfHAAOrHKZCb5wdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 7:42 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> Instead of framing this as an enhanced version of the read/write ops
> why not look at replacing or extending something like the
> memcpy_fromio or memcpy_toio operations?

Yes, doing something like "memcpy_fromio_avx()" is much more
palatable, in that it works like the crypto functions do - if you do
big chunks, the "kernel_fpu_begin/end()" isn't nearly the issue it can
be otherwise.

Note that we definitely have seen hardware that *depends* on the
regular memcpy_fromio()" not doing big reads. I don't know how
hardware people screw it up, but it's clearly possible.

So it really needs to be an explicitly named function that basically a
driver can use to say "my hardware really likes big aligned accesses"
and explicitly ask for some AVX version if possible.

                    Linus
