Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B09C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709C722419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709C722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeKMCyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:54:06 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:42544 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeKMCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:54:06 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMFZ8-0004m9-Nb from joseph_myers@mentor.com ; Mon, 12 Nov 2018 08:59:58 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 12 Nov 2018 16:59:55 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMFZ4-0002jk-QD; Mon, 12 Nov 2018 16:59:54 +0000
Date:   Mon, 12 Nov 2018 16:59:54 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Florian Weimer <fweimer@redhat.com>
CC:     Willy Tarreau <w@1wt.eu>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <87zhufvntw.fsf@oldenburg.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1811121647310.6607@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <20181111081725.GA30248@1wt.eu> <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com> <20181111111143.GB4189@1wt.eu>
 <87zhufvntw.fsf@oldenburg.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018, Florian Weimer wrote:

> The kernel does not know about TCB layout, so a lot of low-level
> threading aspects are defined by userspace.
> 
> The kernel does not know about POSIX cancellation.  Directly calling
> system calls breaks support for that.

Indeed.  Where cancellation is involved, glibc needs to know exactly what 
instructions might be calling a cancellable syscall and what instructions 
are before or after the syscall (see Adhemerval's patches for bug 12683).

This involves an ABI that is not just specific to a particular libc, but 
specific to a particular libc version.  So it's inherently unsuitable to 
put cancellable syscalls in libc_nonshared.a, as well as unsuitable to put 
them in any kernel-provided library.

The interface for setting errno may also be libc-specific, for any 
syscalls involving setting errno.

Syscalls often involve types in their interfaces such as off_t and struct 
timespec.  libcs may have multiple different variants of those types; the 
variants available, and the ways of selecting them, are libc-specific and 
libc-version-specific.  So for any syscall for which the proper userspace 
interface involves one of those types, wrappers for it are inherently 
specific to a particular libc and libc version.  (See e.g. how preadv2 and 
pwritev2 syscalls also have preadv64v2 and pwritev64v2 APIs in glibc, with 
appropriate redirections hased on __USE_FILE_OFFSET64, which is in turn 
based on _FILE_OFFSET_BITS.)

There are many ABI variants that are relevant to glibc but not to the 
kernel.  Some of these involve ABI tagging of object files to indicate 
which ABI variant an object is built for (and those that don't have such 
tagging ought to have it), to prevent accidental linking of objects for 
different ABIs.  How to build objects for different userspace ABIs is not 
something the kernel should need to know anything about; it's most 
naturally dealt with at the level of building compiler multilibs and libc.

glibc deliberately avoids depending at compile time on the existence of 
libgcc_s.so to facilitate bootstrap builds (a stripped glibc binary built 
with a C-only static-only inhibit_libc GCC that was built without glibc 
should be identical to the result of a longer alternating sequence of GCC 
and glibc builds).  I don't think any kernel-provided library would be any 
better to depend on.

What one might suggest is that when new syscalls are added, kernel 
developers should at least obtain agreement on linux-api from libc people 
about what the userspace interface to the syscall should be.  That means 
the userspace-level types (such as off_t and struct timespec), and the 
choice of error handling (returning error number or setting errno), and 
the name of the header declaring the function, and the name of the 
function, and how the syscall relates to thread cancellation, for example 
- and whatever other issues may be raised.

-- 
Joseph S. Myers
joseph@codesourcery.com
