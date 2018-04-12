Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDLOT7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbeDLOT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:19:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9934B2183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+h9wujbVXeXltg9Um/PSfEquDBoIdk+1HI2/8UbIc3L8GqV6oSayAQf3HE0Swjb8p3fgQaTlWywVgWKp2uRtg=
MIME-Version: 1.0
In-Reply-To: <20180412082313.GA6054@kroah.com>
References: <20180411195436.GA7126@kroah.com> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
 <12769.1523477356@warthog.procyon.org.uk> <20180411203308.GA10167@kroah.com>
 <CALCETrWynogzZcaKMLWKce1rMvAC_sViReBDyiEWL-rm21HvAg@mail.gmail.com> <20180412082313.GA6054@kroah.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 12 Apr 2018 07:19:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVm8c0dN=kymg=5-TQEWbL_zk9yCr4Bv4PKJXNC=6j=Fw@mail.gmail.com>
Message-ID: <CALCETrVm8c0dN=kymg=5-TQEWbL_zk9yCr4Bv4PKJXNC=6j=Fw@mail.gmail.com>
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
To: Greg KH <greg@kroah.com>
Cc: Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 1:23 AM, Greg KH <greg@kroah.com> wrote:
> On Wed, Apr 11, 2018 at 07:54:12PM -0700, Andy Lutomirski wrote:
>> On Wed, Apr 11, 2018 at 1:33 PM, Greg KH <greg@kroah.com> wrote:
>> > On Wed, Apr 11, 2018 at 09:09:16PM +0100, David Howells wrote:
>> >> Greg KH <greg@kroah.com> wrote:
>> >>
>> >> > Why not just disable debugfs entirely?  This half-hearted way to sorta
>> >> > lock it down is odd, it is meant to not be there at all, nothing in your
>> >> > normal system should ever depend on it.
>> >> >
>> >> > So again just don't allow it to be mounted at all, much simpler and more
>> >> > obvious as to what is going on.
>> >>
>> >> Yeah, I agree - and then I got complaints because it seems that it's been
>> >> abused to allow drivers and userspace components to communicate.
>> >
>> > With in-kernel code?  Please let me know and I'll go fix it up to not
>> > allow that, as that is not ok.
>> >
>> > I do know of some bad examples of out-of-tree code abusing debugfs to do
>> > crazy things (battery level monitoring?), but that's their own fault...
>> >
>> > debugfs is for DEBUGGING!  For anything you all feel should be "secure",
>> > then just disable it entirely.
>> >
>>
>> Debugfs is very, very useful for, ahem, debugging.  I really think
>> this is an example of why we should split lockdown into the read and
>> write varieties and allow mounting and reading debugfs when only write
>> is locked down.
>
> Ok, but be sure that there are no "secrets" in those debugging files if
> you really buy into the whole "lock down" mess...
>
> Really, it's easier to just disable the whole thing.
>

I mostly agree with your sentiment.  I'm saying that, for most uses, I
*don't* buy into the idea that a normal secure-boot-supporting distro
should block debugfs.  I sometimes like to ask people who report
problems to send me the contents of such-and-such file in debugfs, and
I think it should keep working.  Blocking write access to debugfs is
mostly sensible for a lockdown system, but blocking read only makes
sense if you're worried about straight-up bugs or if you think that
debugfs contains protection-worthy secrets.

What I want to see is:

lockdown=protect_integrity: debugfs is read-only, bpf and perf are
unrestricted, iopl and ioperm are disabled, etc.

lockdown=protect_integrity_and_secrecy: debugfs is gone, bpf and perf
are restricted, plus all the restrictions from
lockdown=protect_integrity

Distros should strongly prefer lockdown=protect_integrity (or
lockdown=off) by default.  lockdown=protect_integrity_and_secrecy is
for custom setups, embedded applications, etc.


--Andy
