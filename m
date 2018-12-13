Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB8920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB8920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeLMQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeLMQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:05:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23C1081DFA;
        Thu, 13 Dec 2018 16:05:08 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 211536012B;
        Thu, 13 Dec 2018 16:05:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>, tg@mirbsd.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
References: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
        <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
        <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
        <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
        <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
        <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
        <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
        <20181212165237.GT23599@brightrain.aerifal.cx>
        <CALCETrV6+YAazq7vY_aR=4kXc4ykXb1Se7hgvHeEVJtbZ91=Qg@mail.gmail.com>
        <20181213124025.bczxzj6ez34joo6v@localhost>
        <20181213155744.GU23599@brightrain.aerifal.cx>
Date:   Thu, 13 Dec 2018 17:04:59 +0100
In-Reply-To: <20181213155744.GU23599@brightrain.aerifal.cx> (Rich Felker's
        message of "Thu, 13 Dec 2018 10:57:44 -0500")
Message-ID: <87o99pl8es.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Dec 2018 16:05:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rich Felker:

>> If the compiler can handle the zeroing, that would be great, though not
>> sure how (some __attribute__((zero)) which generates a type constructor
>> for such structure; it kind of departs from what the C language offers).
>
> The compiler fundamentally can't. At the very least it would require
> effective type tracking, which requires shadow memory and is even more
> controversial than -fstrict-aliasing (because in a sense it's a
> stronger version thereof).

It's possible to do it with the right types.  See _Bool on 32-bit Darwin
PowerPC for an example, which is four bytes instead of the usual one.

Similarly, we could have integer types with trap representations.
Whether it is a good idea is a different matter, but the amount of
compiler magic required is actually limited.

Thanks,
Florian
