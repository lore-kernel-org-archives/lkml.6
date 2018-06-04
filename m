Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbeFDPY1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:24:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752143AbeFDPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:24:26 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAK8P3a1QMrvMqLdg6OxKDSXz2wEceVMJ2-S9tJZETzk5oFcTCw@mail.gmail.com>
References: <CAK8P3a1QMrvMqLdg6OxKDSXz2wEceVMJ2-S9tJZETzk5oFcTCw@mail.gmail.com> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk> <152720686035.9073.17015443936296474540.stgit@warthog.procyon.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/32] VFS: Implement fsmount() to effect a pre-configured mount [ver #8]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26747.1528125864.1@warthog.procyon.org.uk>
Date: Mon, 04 Jun 2018 16:24:24 +0100
Message-ID: <26748.1528125864@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> The prototype in the header doesn't match the one in the implementation,
> which should cause a compile-time error, at least if syscalls.h is included
> in namespace.c

I've fixed that sort of thing up from kbuild warnings.

> Do you have a particular use case in mind for the spare_4/spare_5 arguments?
> If not, we can probably skip them. If we end up needing them after all, we
> can always add a new syscall entry point, or use one of the flag bits to
> decide whether the additional arguments are valid or not.

Whilst that is true, these aren't really (or probably shouldn't be) hot path
syscalls, so I would contend that just clearing the extra arguments shouldn't
be much of a performance loss.  On the other hand, syscall numbers are to some
extent precious.  If we hit ~512 syscalls we start to have an issue as we
start to get overlaps.

And, yes, I do have ideas for them involving ID mapping on mounts (ie. killing
off shiftfs).

> >  COND_SYSCALL(sys_fsopen);
> > +COND_SYSCALL(sys_fsmount);
> 
> This should only be needed if the syscall is optional, which it doesn't
> seem to be (same for the other ones here).

Al removed them.

David
