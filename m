Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeELInb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 04:43:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39124 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 04:43:29 -0400
X-Google-Smtp-Source: AB8JxZrkHHFPEZr4JNa8tu4WnAg8aYtkOaY39lUHby23O14YWl7XrCSRkE722uCkossUYygXOsy6apldfakCkcqxbSc=
MIME-Version: 1.0
In-Reply-To: <20180202221829.tdiji2332t7orcxj@gmail.com>
References: <001a11449aa2faf11805643af581@google.com> <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
 <20180202221829.tdiji2332t7orcxj@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 12 May 2018 10:43:08 +0200
Message-ID: <CACT4Y+afpDQ7A3caRmskML06h8Q6+NkVAn6HtV93ExPec-g2pA@mail.gmail.com>
Subject: Re: WARNING: kernel stack regs has bad 'bp' value (3)
To: Eric Biggers <ebiggers3@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: syzbot <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 11:18 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Fri, Feb 02, 2018 at 02:57:32PM +0100, Dmitry Vyukov wrote:
>> On Fri, Feb 2, 2018 at 2:48 PM, syzbot
>> <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com> wrote:
>> > Hello,
>> >
>> > syzbot hit the following crash on upstream commit
>> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
>> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
>> >
>> > So far this crash happened 4 times on net-next, upstream.
>> > C reproducer is attached.
>> > syzkaller reproducer is attached.
>> > Raw console output is attached.
>> > compiler: gcc (GCC) 7.1.1 20170620
>> > .config is attached.
>>
>>
>> From suspicious frames I see salsa20_asm_crypt there, so +crypto maintainers.
>>
>
> Looks like the x86 implementations of Salsa20 (both i586 and x86_64) need to be
> updated to not use %ebp/%rbp.

Ard,

This was bisected as introduced by:

commit 83dee2ce1ae791c3dc0c9d4d3a8d42cb109613f6
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri Jan 19 12:04:34 2018 +0000

    crypto: sha3-generic - rewrite KECCAK transform to help the
compiler optimize

https://gist.githubusercontent.com/dvyukov/47f93f5a0679170dddf93bc019b42f6d/raw/65beac8ddd30003bbd4e9729236dc8572094abf7/gistfile1.txt
