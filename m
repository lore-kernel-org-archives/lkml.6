Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDHSC7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 14:02:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:44616 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbeDHSC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 14:02:57 -0400
Date: Sun, 8 Apr 2018 14:02:52 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers@google.com>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Running syzkaller repros using kvm-xfstests
Message-ID: <20180408180252.GC9720@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <001a1148578c10e4700568e814eb@google.com>
 <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org>
 <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org>
 <20180405223226.GA729@dastard>
 <20180406001325.GA133204@google.com>
 <20180406013741.GA7345@thunk.org>
 <20180408063114.GB9720@thunk.org>
 <CACT4Y+Ynbn9qAmk3jVBs6pUjDAz6gJMD5YHM4+EyzEuwBj+4-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ynbn9qAmk3jVBs6pUjDAz6gJMD5YHM4+EyzEuwBj+4-Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 03:18:39PM +0200, Dmitry Vyukov wrote:
> 
> But note that syzkaller is under active development, so pre-canned
> binaries may not always work. Mismatching binary may not understand
> all syscalls, fail to parse program, interpret arguments differently,
> execute program differently, setup a different environment for the
> test, etc. Now a C program captures all of this, because code that
> transforms syzkaller programs into C is versioned along with the rest
> of the system.
> Strictly saying, for syzkaller reproducers one needs to use the exact
> syzkaller revision listed along with the reproducer, see for example:
> https://syzkaller.appspot.com/bug?id=3fb9c4777053e79a6d2a65ac3738664c87629a21
> The "#syz test" styzbot command does this. Using a different syzkaller
> revision may or may not work.

Thanks for the warning.  I assume you try to maintain backwards
compatibility where possible?  It might be nice if you could add some
kind of explicit versioning scheme --- perhaps with a major/minor
version scheme where the syz-executor needs to have the same major
number, and a minor number >= the minor version number of the test?

One of the reasons why the C program is not so useful for me is that
in the Repeat:true case, the C program repeats forever.  So for
example, I translate Repeat:true to -repeat=100.  See:

https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/usr/local/bin/run-syz

I suppose I could just abort the test after N minutes and assume if
the kernel hasn't crashed, that it's probably not going to.  But some
way that the C program can be given an argument or an environment
variable to control how number of loops it will run might be useful.
And some kind of hint as how reliable the repro would be (e.g,. some
indication that you should try to run it at least N times to get a
failure at least 95% of the time).

						- Ted
