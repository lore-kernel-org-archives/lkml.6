Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031258AbeEZHWH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 03:22:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46047 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031170AbeEZHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 03:22:06 -0400
X-Google-Smtp-Source: AB8JxZo83txhgFmjuJJ77vACG7ZQgvaTrLmYbrC0VhuUrTY2NphQdd1Evwy0RS/1c6L61BBF3y5Ucw==
Date: Sat, 26 May 2018 00:22:03 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        syzbot <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: kernel stack regs has bad 'bp' value (3)
Message-ID: <20180526072203.GA724@sol.localdomain>
References: <001a11449aa2faf11805643af581@google.com>
 <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
 <20180202221829.tdiji2332t7orcxj@gmail.com>
 <CACT4Y+afpDQ7A3caRmskML06h8Q6+NkVAn6HtV93ExPec-g2pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+afpDQ7A3caRmskML06h8Q6+NkVAn6HtV93ExPec-g2pA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 10:43:08AM +0200, Dmitry Vyukov wrote:
> On Fri, Feb 2, 2018 at 11:18 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Fri, Feb 02, 2018 at 02:57:32PM +0100, Dmitry Vyukov wrote:
> >> On Fri, Feb 2, 2018 at 2:48 PM, syzbot
> >> <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com> wrote:
> >> > Hello,
> >> >
> >> > syzbot hit the following crash on upstream commit
> >> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
> >> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
> >> >
> >> > So far this crash happened 4 times on net-next, upstream.
> >> > C reproducer is attached.
> >> > syzkaller reproducer is attached.
> >> > Raw console output is attached.
> >> > compiler: gcc (GCC) 7.1.1 20170620
> >> > .config is attached.
> >>
> >>
> >> From suspicious frames I see salsa20_asm_crypt there, so +crypto maintainers.
> >>
> >
> > Looks like the x86 implementations of Salsa20 (both i586 and x86_64) need to be
> > updated to not use %ebp/%rbp.
> 
> Ard,
> 
> This was bisected as introduced by:
> 
> commit 83dee2ce1ae791c3dc0c9d4d3a8d42cb109613f6
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Fri Jan 19 12:04:34 2018 +0000
> 
>     crypto: sha3-generic - rewrite KECCAK transform to help the
> compiler optimize
> 
> https://gist.githubusercontent.com/dvyukov/47f93f5a0679170dddf93bc019b42f6d/raw/65beac8ddd30003bbd4e9729236dc8572094abf7/gistfile1.txt

Note that syzbot's original C reproducer (from Feb 1) for this actually
triggered the warning through salsa20-asm, which I've just proposed to "fix" by
https://patchwork.kernel.org/patch/10428863/.  sha3-generic is apparently
another instance of the same bug, where the %rbp register is used for data.

Eric
