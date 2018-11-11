Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A3A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A3A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeKKVfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:35:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKVfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:35:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 127FF83F3C;
        Sun, 11 Nov 2018 11:46:45 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B3D5C1B4;
        Sun, 11 Nov 2018 11:46:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <20181111081725.GA30248@1wt.eu>
        <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
        <20181111111143.GB4189@1wt.eu>
Date:   Sun, 11 Nov 2018 12:46:35 +0100
In-Reply-To: <20181111111143.GB4189@1wt.eu> (Willy Tarreau's message of "Sun,
        11 Nov 2018 12:11:43 +0100")
Message-ID: <87zhufvntw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 11 Nov 2018 11:46:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau:

> I think the issue is a bit more complex :
>   - linux doesn't support a single libc
>   - glibc doesn't support a single OS
>
> In practice we all know (believe?) that both statements above are
> true but in practice 99% of the time there's a 1:1 relation between
> these two components.

Eh.  Most Linux systems do not run glibc at all (and use cryptography
and other tricks to prevent users from installing it).

> What we'd really need would be to have the libc
> interface as part of the operating system itself. I'm perfectly fine
> with glibc providing all the "high-level" stuff like strcpy(), FILE*
> operations etc, and all this probably is mostly system-independent.

That's a bit messy, unfortunately.

The kernel does not know about TCB layout, so a lot of low-level
threading aspects are defined by userspace.

The kernel does not know about POSIX cancellation.  Directly calling
system calls breaks support for that.

A lot of multi-threaded applications assume that most high-level
functionality remains usable even after fork in a multi-threaded
process.  (This is increasingly a problem today with all those direct
calls to clone.)  Unfortunately, this introduces rather tricky
low-level/high-level cross-subsystem issues, too.

> But the system interface could possibly be handled easier in the
> system itself, which would also provide a smoother adoption of new
> syscalls and API updates. It would also limit the hassle required to
> provide new syscalls, as if you start to have to contribute to two
> projects at once for a single syscall, it becomes really painful.

Sure, the duplication is unfortunate.

Several glibc contributors deeply care about standards compliance for
header files.  The kernel developers care not, and the result is that we
copy definitions and declarations from the kernel header files, creating
additional problems.

We also want to use old kernel headers to compile glibc and still
implement features which are only defined by newer (upstream) kernels,
so that leads to more duplication.

Thanks,
Florian
