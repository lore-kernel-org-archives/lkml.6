Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76685214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76685214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeKNWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbeKNWN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:13:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE42488E57;
        Wed, 14 Nov 2018 12:10:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-210.ams2.redhat.com [10.36.117.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA01E103BAAD;
        Wed, 14 Nov 2018 12:10:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Willy Tarreau <w@1wt.eu>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <20181111081725.GA30248@1wt.eu>
        <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
        <20181111111143.GB4189@1wt.eu>
        <87zhufvntw.fsf@oldenburg.str.redhat.com>
        <20181114120348.or5id3hzrmltkyvb@angband.pl>
Date:   Wed, 14 Nov 2018 13:10:16 +0100
In-Reply-To: <20181114120348.or5id3hzrmltkyvb@angband.pl> (Adam Borowski's
        message of "Wed, 14 Nov 2018 13:03:48 +0100")
Message-ID: <87va4zc11z.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 14 Nov 2018 12:10:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Borowski:

> On Sun, Nov 11, 2018 at 12:46:35PM +0100, Florian Weimer wrote:
>> A lot of multi-threaded applications assume that most high-level
>> functionality remains usable even after fork in a multi-threaded
>> process.
>
> How would this be even possible?  Currently fork kills all threads
> (save for the caller).

glibc's fork acquires several locks around fork.  Other mallocs install
fork handlers, too.

> Glibc's manpage also warns:
>
> # After a fork() in a multithreaded program, the child can safely call only
> # async-signal-safe functions (see signal-safety(7)) until such time as it
> # calls execve(2).
>
> Which makes sense as its malloc uses a mutex, and you can't take a breath
> without a library call using malloc somewhere (or in C++, the language
> itself).

Right, but applications require a working malloc after fork,
unfortunately.  opendir is often used to enumerate file descriptors
which need closing, for example.

Thanks,
Florian
