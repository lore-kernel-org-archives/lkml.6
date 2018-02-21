Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935493AbeBUQVA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:21:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932767AbeBUQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:20:58 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz>
References: <20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz> <20180116193936.oiycvwlk5xy3gm77@dwarf.suse.cz> <20180111120157.23qceywzi6omvvkb@dwarf.suse.cz> <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk> <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk> <20180111115915.dejachty3l7fwpmf@dwarf.suse.cz> <4582.1516120311@warthog.procyon.org.uk> <24618.1516206864@warthog.procyon.org.uk>
To: Jiri Bohac <jbohac@suse.cz>
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org,
        gnomes@lxorguk.ukuu.org.uk, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jforbes@redhat.com,
        Chun-Yi Lee <joeyli.kernel@gmail.com>
Subject: Re: [PATCH 08a/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23575.1519230051.1@warthog.procyon.org.uk>
Date: Wed, 21 Feb 2018 16:20:51 +0000
Message-ID: <23576.1519230051@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Bohac <jbohac@suse.cz> wrote:

> Key verification may and will fail for lots of reasons which is
> just going to make a user's life harder. E.g. you want to kexec
> an old kernel with an expired key. Or your date is just wrong and
> you get -EKEYEXPIRED.

Note that we can't check for expired keys as we can't trust the system clock
to be correct at this point.

> Also, only now I found that some of the error codes the crypto
> code returns yield really confusing messages (e.g.
> kexec_file_load of an unsigned kernel returns -ELIBBAD which
> makes kexec exit with "kexec_file_load failed: Accessing a
> corrupted shared library").

Yeah, that should be fixed.

> Maybe the error code could be unified to -EKEYREJECTED for all
> sorts of key verification failures?

Things like ENOMEM and EINTR definitely need to stay separate (not that I
allow interruption at the moment).

ENOKEY (couldn't find matching key), EINVAL (didn't recognise identifier),
ENOPKG (couldn't find a crypto algo) and EBADMSG (couldn't parse signature)
are arguable.  I think there's a valid case for treating ENOKEY, EINVAL and
ENOPKG differently to EKEYREJECTED - more so for ENOKEY.  In my opinion,
ENOKEY, EINVAL and ENOPKG are not fatal errors if we're not enforcing
signature checking, but EKEYREJECTED and EBADMSG are.

David
