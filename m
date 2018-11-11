Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E520871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652E520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeKKUSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:18:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKUSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:18:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15C5431256A5;
        Sun, 11 Nov 2018 10:30:35 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F2C5D736;
        Sun, 11 Nov 2018 10:30:30 +0000 (UTC)
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
Date:   Sun, 11 Nov 2018 11:30:25 +0100
In-Reply-To: <20181111081725.GA30248@1wt.eu> (Willy Tarreau's message of "Sun,
        11 Nov 2018 09:17:25 +0100")
Message-ID: <87y39zx5xa.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 11 Nov 2018 10:30:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau:

> On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
>> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
>>     longstanding example.
>
> This one was a sad read and shows that applications will continue to
> suffer from glibc's prehistorical view on operating systems and will
> continue to have to define their own syscall wrappers to exploit the
> full potential of the modern operating systems they execute on.

What's modern about a 15-bit thread identifier?

I understand that using this interface is required in some cases (which
includes some system calls for which glibc does provide wrappers), but I
assumed that it was at least understood that these reusable IDs for
tasks were an extremely poor interface.  Aren't the resulting bugs
common knowledge?

> This reminds me when one had to write their own spinlocks and atomics
> many years ago. Seeing comments suggesting an application should open
> /proc/$PID makes me really wonder if people actually want to use slow
> and insecure applications designed this way.

I don't understand.  If you want a non-reusable identifier, you have to
go through the /proc interface anyway.  I think the recommendation is to
use the PID/start time combination to get a unique process identifier or
something like that.

I wanted to add gettid to glibc this cycle, but your comments suggest to
me that if we did this, we'd likely never get a proper non-reusable
thread identifier from the kernel.  So I'm not sure what do anymore.

Thanks,
Florian
