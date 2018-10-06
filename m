Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D9ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696A321473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696A321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeJGEBi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:01:38 -0400
Received: from albireo.enyo.de ([5.158.152.32]:34638 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeJGEBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:01:38 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1g8tce-0006hj-21; Sat, 06 Oct 2018 20:56:24 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1g8tcd-0004TR-Qh; Sat, 06 Oct 2018 22:56:23 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
References: <20180929103453.12025-1-cyphar@cyphar.com>
        <20180929131534.24472-1-cyphar@cyphar.com>
        <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
        <20181001054246.gfinmx3api7kjhmc@ryuk>
        <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
        <20181002073220.7mzndna4tdnxdvdt@ryuk>
Date:   Sat, 06 Oct 2018 22:56:23 +0200
In-Reply-To: <20181002073220.7mzndna4tdnxdvdt@ryuk> (Aleksa Sarai's message of
        "Tue, 2 Oct 2018 17:32:20 +1000")
Message-ID: <875zyeg5fs.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aleksa Sarai:

> On 2018-10-01, Andy Lutomirski <luto@amacapital.net> wrote:
>> >>> Currently most container runtimes try to do this resolution in
>> >>> userspace[1], causing many potential race conditions. In addition, the
>> >>> "obvious" alternative (actually performing a {ch,pivot_}root(2))
>> >>> requires a fork+exec which is *very* costly if necessary for every
>> >>> filesystem operation involving a container.
>> >> 
>> >> Wait. fork() I understand, but why exec? And actually, you don't need
>> >> a full fork() either, clone() lets you do this with some process parts
>> >> shared. And then you also shouldn't need to use SCM_RIGHTS, just keep
>> >> the file descriptor table shared. And why chroot()/pivot_root(),
>> >> wouldn't you want to use setns()?
>> > 
>> > You're right about this -- for C runtimes. In Go we cannot do a raw
>> > clone() or fork() (if you do it manually with RawSyscall you'll end with
>> > broken runtime state). So you're forced to do fork+exec (which then
>> > means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same goes
>> > for CLONE_VFORK.
>> 
>> I must admit that I’m not very sympathetic to the argument that “Go’s
>> runtime model is incompatible with the simpler solution.”
>
> Multi-threaded programs have a similar issue (though with Go it's much
> worse). If you fork a multi-threaded C program then you can only safely
> use AS-Safe glibc functions (those that are safe within a signal
> handler). But if you're just doing three syscalls this shouldn't be as
> big of a problem as Go where you can't even do said syscalls.

The situation is a bit more complicated.  There are many programs out
there which use malloc and free (at least indirectly) after a fork,
and we cannot break them.  In glibc, we have a couple of subsystems
which are put into a known state before calling the fork/clone system
call if the application calls fork.  The price we pay for that is a
fork which is not POSIX-compliant because it is not async-signal-safe.
Admittedly, other libcs chose different trade-offs.

However, what is the same across libcs is this: You cannot call the
clone system call directly and get a fully working new process.  Some
things break.  For example, for recursive mutexes, we need to know the
TID of the current thread, and we cannot perform a system call to get
it for performance reasons.  So everyone has a TID cache for that.
But the TID cache does not get reset when you bypass the fork
implementation in libc, so you end up with subtle corruption bugs on
TID reuse.

So I'd say that in most cases, the C situation is pretty much the same
as the Go situation.  If I recall correctly, the problem for Go is
that it cannot call setns from Go code because it fails in the kernel
for multi-threaded processes, and Go processes are already
multi-threaded when user Go code runs.
