Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A9E1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F16C20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F16C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935387AbeFML4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:56:14 -0400
Received: from mail05-md.ns.itscom.net ([175.177.155.115]:57101 "EHLO
        mail05-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935261AbeFML4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:56:12 -0400
Received: from scan12-mds.s.noc.itscom.net (scan12-md.ns.itscom.net [175.177.155.6])
        by mail05-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 74639658515;
        Wed, 13 Jun 2018 20:56:10 +0900 (JST)
Received: from unknown (HELO mail04-md-outgoing.ns.itscom.net) ([175.177.155.114])
  by scan12-mds.s.noc.itscom.net with ESMTP; 13 Jun 2018 20:56:10 +0900
Received: from jromail.nowhere (h116-0-242-084.catv02.itscom.jp [116.0.242.84])
        by mail04-md-outgoing.ns.itscom.net (Postfix) with ESMTP;
        Wed, 13 Jun 2018 20:56:10 +0900 (JST)
Received: from jro by jrobl id 1fT4Nm-0001NU-1n ; Wed, 13 Jun 2018 20:56:10 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH 14/39] ovl: stack file ops
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20180612182423.GA30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-15-mszeredi@redhat.com> <20180610041243.GJ30522@ZenIV.linux.org.uk> <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com> <20180612022926.GY30522@ZenIV.linux.org.uk> <20180612024029.GZ30522@ZenIV.linux.org.uk> <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com> <20180612182423.GA30522@ZenIV.linux.org.uk>
Date:   Wed, 13 Jun 2018 20:56:10 +0900
Message-ID: <5299.1528890970@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro:
> I'd managed to push that particular nest of horrors out of mind ;-/
> Having dug out my notes from back then and grepped around...  The real
> mess is not even /proc/*/maps - it's /proc/*/map_files/* and yes, the
> reasons for that kludge are still valid ;-/
	:::
> Uses of ->vm_file (and rules for those) are too convoluted to untangle
> at the moment.  I still would love to get that straightened out, but
> it's not this cycle fodder, more's the pity...

I don't fully read this thread, but the discussion is related to the
file path printed in /proc/$$/maps?  If so, as just for your
information, here is an approach that aufs took.

In linux-v2.6 era, aufs tried implementing mmap by customzing
address_space ops, but it was not good and failed completing the
implementation.
As wel as overlayfs, aufs has two struct file objects for a single
a regular file.  One is for a virtual aufs' entry, and the other is for
a real layer's entry.  When a user issues mmap(2) for the virtual file,
aufs redirects the request to the real file on the layer internally.  So
the vm_file points to the real file.  It means /proc/$$/maps prints the
unexpected file path.

Aufs added another struct file* vm_prfile in struct vma.  It points to
the virtual aufs file, and /proc/$$/maps prints vm_prfile instead of
vm_file. Of cource, maintaining vm_prfile is important since vma may be
merged or splitted.
Still I don't like this approach, but I don't have another better idea,
also it works for many years.  You can get the patch in
aufs4-standalone.git on sourceforge if you want.


J. R. Okajima
