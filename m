Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeDIJ3W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:29:22 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:41644 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:29:20 -0400
X-Google-Smtp-Source: AIpwx4/ddZvuKUwDavR7jUzgJcHfNf9/46xj0n8LqdF7wOZ/8dtONFLGnP3fXsk0QoVzJirUYIIHNGHDO+Brpx0MQiA=
MIME-Version: 1.0
In-Reply-To: <20180408180252.GC9720@thunk.org>
References: <001a1148578c10e4700568e814eb@google.com> <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org> <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org> <20180405223226.GA729@dastard>
 <20180406001325.GA133204@google.com> <20180406013741.GA7345@thunk.org>
 <20180408063114.GB9720@thunk.org> <CACT4Y+Ynbn9qAmk3jVBs6pUjDAz6gJMD5YHM4+EyzEuwBj+4-Q@mail.gmail.com>
 <20180408180252.GC9720@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 11:28:59 +0200
Message-ID: <CACT4Y+bXkR3Ecn8xPeeEJwUGYNPGcg-4o5Lshgo5eYf3GxE-9Q@mail.gmail.com>
Subject: Re: Running syzkaller repros using kvm-xfstests
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@google.com>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 8:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Sun, Apr 08, 2018 at 03:18:39PM +0200, Dmitry Vyukov wrote:
>>
>> But note that syzkaller is under active development, so pre-canned
>> binaries may not always work. Mismatching binary may not understand
>> all syscalls, fail to parse program, interpret arguments differently,
>> execute program differently, setup a different environment for the
>> test, etc. Now a C program captures all of this, because code that
>> transforms syzkaller programs into C is versioned along with the rest
>> of the system.
>> Strictly saying, for syzkaller reproducers one needs to use the exact
>> syzkaller revision listed along with the reproducer, see for example:
>> https://syzkaller.appspot.com/bug?id=3fb9c4777053e79a6d2a65ac3738664c87629a21
>> The "#syz test" styzbot command does this. Using a different syzkaller
>> revision may or may not work.
>
> Thanks for the warning.  I assume you try to maintain backwards
> compatibility where possible?  It might be nice if you could add some
> kind of explicit versioning scheme --- perhaps with a major/minor
> version scheme where the syz-executor needs to have the same major
> number, and a minor number >= the minor version number of the test?

We try to not break backwards compatibility without a reason.

Preserving full backwards compatibility within a single binary is
extremely hard. It's like asking kernel to support each and every ever
existed version of every in-memory data structure and all of the
non-functional aspects (like any fluctuations in performance). If one
could give us several additional FTEs for this, then it might be
doable. But even then I don't  think it's the best use of the FTE time
because version control system already gives us exactly this -- exact
behavior on a past revision. On top of this, the backward
compatibility support will sure have bugs too. In the best case we
will spent time debugging why a new version does not precisely model
behavior of an old version. In the worst case you will test something
and think that the bug is fixed, but it's just that the new version
does not behave exactly as the old one. On top of this, this still
does not give us forward compatibility, something that one wants in
majority of cases with an old pre-canned binary. On top of this, the
binaries will be huge because they will need to capture exact versions
of all system call descriptions (and the simplest option for this is
keeping copies all versions), a 87 MiB image definitely won't be
enough to hold this, the binary will be somewhere between gigs and
tens of gigs.


> One of the reasons why the C program is not so useful for me is that
> in the Repeat:true case, the C program repeats forever.  So for
> example, I translate Repeat:true to -repeat=100.  See:
>
> https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/usr/local/bin/run-syz
>
> I suppose I could just abort the test after N minutes and assume if
> the kernel hasn't crashed, that it's probably not going to.  But some
> way that the C program can be given an argument or an environment
> variable to control how number of loops it will run might be useful.
> And some kind of hint as how reliable the repro would be (e.g,. some
> indication that you should try to run it at least N times to get a
> failure at least 95% of the time).

I think:

timeout -s KILL 450 ./a.out

is the solution.
Repro logic runs programs for at most 7.5 minutes, so 450 should be good.

Re env var. There are opposite views too. People complain that
syzkaller C repros are mess (which they are). Currently they complain
minimal amount of code to reproduce the bugs. If we also start
staffing some aux logic in them, it won't be helpful. timeout command
looks just as good.
