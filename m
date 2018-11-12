Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9742822419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9742822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeKMDaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:30:35 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:43790 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:30:35 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMG8K-000077-Hr from joseph_myers@mentor.com ; Mon, 12 Nov 2018 09:36:20 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 12 Nov 2018 17:36:11 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMG8B-0003Gr-4I; Mon, 12 Nov 2018 17:36:11 +0000
Date:   Mon, 12 Nov 2018 17:36:11 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Willy Tarreau <w@1wt.eu>
CC:     Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <20181111120910.GA4425@1wt.eu>
Message-ID: <alpine.DEB.2.21.1811121723210.6607@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <20181111081725.GA30248@1wt.eu> <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com> <20181111111143.GB4189@1wt.eu>
 <87zhufvntw.fsf@oldenburg.str.redhat.com> <20181111120910.GA4425@1wt.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018, Willy Tarreau wrote:

> > The kernel developers care not, and the result is that we
> > copy definitions and declarations from the kernel header files, creating
> > additional problems.
> 
> Probably that these standard compatibility issues should be addressed at
> their root in the kernel header definitions in fact. Working around issues
> always leads to a stall at some point, and it encourages the process not
> to change.

But it's not a bug in the Linux kernel header files.  The set of feature 
test macros supported is libc-specific and libc-version-specific.  The 
internal macros defined as a result of the feature test macros, that 
determine what features to expose, are also libc-specific and 
libc-version-specific.  (The __USE_* macros in glibc are not a stable API.  
For example, we might move to using __GLIBC_USE for more features in place 
of the defined/undefined __USE_* internal macros.)

If a feature is Linux-specific, and the userspace header for it is also 
Linux-specific (as opposed to constants in standard headers such as 
sys/mman.h, where you get all the namespace issues), that userspace header 
*can* include uapi headers in many cases to get constants and structures - 
if those uapi headers actually work in userspace without defining things 
conflicting with libc types.  E.g. <sys/fanotify.h> includes 
<linux/fanotify.h>.

What *is*, in my view, a bug in the uapi headers is that some of them 
don't work when included on their own.  I'd expect #include 
<linux/whatever.h> or #include <asm/whatever.h>, for any such header 
installed by make headers_install, to compile on its own in userspace 
without needing any other headers to be included first, unless some header 
is specifically defined as being an internal part of another header which 
is the one that should be included.

In glibc we have scripts/check-installed-headers.sh which verifies that 
installed headers work when included like that in various language 
standard and feature test macro modes - and with my bots running 
build-many-glibcs.py, this property is effectively verified every few 
hours for (currently) 79 different glibc configurations covering all 
supported glibc ABIs.  If the uapi headers are fixed to work on their own, 
there should be similar continuous integration to make sure that this 
continues to be the case in future.

Simply having uapi headers that reliably work when included on their own 
would help with adding further test automation in glibc to verify 
consistency of constant and structure definitions between glibc and uapi 
headers.  We have a few such checks (e.g. for signal numbers), but now 
that we require Python 3 to build glibc I hope to convert those into more 
general infrastructure for extracting information from headers and running 
checks on the extracted information.

-- 
Joseph S. Myers
joseph@codesourcery.com
