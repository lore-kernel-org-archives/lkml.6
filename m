Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F692145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F692145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeJSAGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbeJSAGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E1B08046C;
        Thu, 18 Oct 2018 16:04:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FADA2B5AB;
        Thu, 18 Oct 2018 16:04:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: statx(2) API and documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4892.1539878663.1@warthog.procyon.org.uk>
Date:   Thu, 18 Oct 2018 17:04:23 +0100
Message-ID: <4893.1539878663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Oct 2018 16:04:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> I'm trying to implement statx for fuse and ran into the following issues:
> 
> - Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
> for stx_attribute; otherwise if querying has non-zero cost, then
> filesystem cannot do it without regressing performance.

Okay, though the way your patch implements it makes it superfluous.  I presume
you have further patches that will actually make use of it from the fuse side?

> - STATX_ALL definition is unclear, can this change, or is it fixed?
> If it's the former, than that's a backward compatibility nightmare.
> If it's the latter, then what's the point?

It's the set of supported attributes known by the headers, and such can
only be added to over time.  But yes, it's probably unnecessary.  Asking
fsinfo() will be a better way of doing things.

> - STATX_ATIME is cleared from stx_mask on SB_RDONLY,

Ummm...  Where?  It's cleared on IS_NOATIME() in generic_fillattr().  I made
the assumption that IS_NOATIME() == false indicates that there isn't an atime
to be had.

> and on NFS it is also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We
> need some sort of guideline in the documentation about what constitutes
> "unsupported": does atime become unsupported because filesystem is remounted
> r/o?  If so, why isn't this case handled consistently in the VFS and
> filesystems?

STATX_ATIME should mean there is an actual atime from the "medium" in
stx_atime, rather than something made up by the filesystem driver; it doesn't
necessarily promise that this will be updated.

There can still be an atime if the medium is read-only.

atime is even more complicated with MNT_NOATIME or MNT_RDONLY because that
doesn't stop the atime from actually being updated through another mountpoint
on the same system.

Note that stx_atime should always contain something that can be used directly
to fill in st_atime if emulating stat() - even if STATX_ATIME is cleared.

> - What about fields that are not cached when statx() is called with
> AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
> but getting it requires a roundtrip to the server.

Not necessarily.  It's not cached in *struct inode*, but that doesn't mean
that the filesystem can't cache it elsewhere.

> Requesting STATX_BTIME in the mask and adding AT_STATX_DONT_SYNC to the
> flags means the filesystem has to decide which it will honor.  My feeling is
> that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in stx_mask.
> Documentation has no word about this case.

From the manpage:

       AT_STATX_DONT_SYNC
              Don't synchronize anything, but rather just  take  whatever  the
              system  has cached if possible. ...
 
Note the "if possible".  If it's not possible, you still need to go get it if
they explicitly asked for it.

David
