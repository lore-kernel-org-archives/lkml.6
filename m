Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE8DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911DD20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911DD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLFSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:11:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F1248AE77;
        Thu,  6 Dec 2018 18:11:04 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-106.ams2.redhat.com [10.36.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 005FE5C88D;
        Thu,  6 Dec 2018 18:10:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Paul Burton <paul.burton@mips.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "open list\:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
        <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com>
        <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
        <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
        <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk>
        <alpine.LFD.2.21.1812061659210.4294@eddie.linux-mips.org>
        <alpine.DEB.2.21.1812061719180.12167@digraph.polyomino.org.uk>
        <alpine.LFD.2.21.1812061729340.4294@eddie.linux-mips.org>
Date:   Thu, 06 Dec 2018 19:10:57 +0100
In-Reply-To: <alpine.LFD.2.21.1812061729340.4294@eddie.linux-mips.org> (Maciej
        W. Rozycki's message of "Thu, 6 Dec 2018 17:43:27 +0000 (GMT)")
Message-ID: <87mupiikzy.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 06 Dec 2018 18:11:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej W. Rozycki:

> On Thu, 6 Dec 2018, Joseph Myers wrote:
>
>> >  So how are `SYS_<name>' macros generated that land in <bits/syscall.h>?
>> 
>> By gen-syscall-h.awk, which generates #ifdef conditionals for each 
>> possible __NR_* name (as listed in syscall-names.list in glibc).
>
>  I seem to remember having to take extra care with how the three MIPS ABIs 
> wire the syscalls to get it right in glibc, but I take it then this has 
> been now addressed reliably enough for the glibc not to care how exactly
> <asm/unistd.h> has been arranged.

This is a fairly recent change (commit
2dba5ce7b8115d6a2789bf279892263621088e74, "<bits/syscall.h>: Use an
arch-independent system call list on Linux", first release with it is
glibc 2.27).  This patch is quite backportable; we have put it into our
2.17-derived glibc, and the upstream work was originally driven by
downstream ordering requirements of kernel header and glibc builds.
Glad to see it's useful elsewhere.

The test retains the old <asm/unistd.h>-based macro extraction for
testing purposes, but it needs that only for the actual target
architecture and only the *names*, so it's easy to implement.  Before
that, the generation would have to carefully take into account multiple
sub-targets (i386/x86-64/x32 is one of the more complicated scenarios).
Presumably, you saw problem with that part.

Even if you introduce breakage here, it will only affect older glibc
builds.  It's not something that application developers would see.

Thanks,
Florian
