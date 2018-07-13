Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B1208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854B1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeGMHnt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbeGMHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:43:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD1EF402382F;
        Fri, 13 Jul 2018 07:30:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5274C1C67A;
        Fri, 13 Jul 2018 07:30:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5A7CC3BF-5F4E-4624-A129-4BD0434D0747@amacapital.net>
References: <5A7CC3BF-5F4E-4624-A129-4BD0434D0747@amacapital.net> <3236C75A-5D74-4BB4-A1EC-06F6E22D810C@amacapital.net> <611054C7-D6E8-4C89-958E-3128C9305E1E@amacapital.net> <20180712223223.GA28610@thunk.org> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk> <22105.1531436081@warthog.procyon.org.uk> <23894.1531438559@warthog.procyon.org.uk> <26064.1531440190@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3428.1531467024.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 Jul 2018 08:30:24 +0100
Message-ID: <3429.1531467024@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 13 Jul 2018 07:30:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 13 Jul 2018 07:30:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> > Also you can't currently directly create a bind mount from userspace as you
> > can only bind from another path point - which you may not be able to access
> > (either by permission failure or because it's not in your mount namespace).
> > 
> 
> Are you trying to preserve the magic bind semantics with the new API?

No, I'm pointing out that you can't emulate this by doing a bind mount from
userspace if you can't access the thing you're binding from.

Now, we could create a syscall that just picks up an extant superblock using a
device and attaches it to a mount for you, but that would have to be at least
partially parameterised - which would be very fs-dependent - so that it can
know whether or not you're allowed to create another mount to that sb.

What you're talking about is emulating sget() in userspace - when we have to
do it in the kernel anyway if we still offer mount(2).

David
