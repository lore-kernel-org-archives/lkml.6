Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F4E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F4E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeKBJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeKBJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:04:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A938285546;
        Thu,  1 Nov 2018 23:59:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E9C61001F53;
        Thu,  1 Nov 2018 23:59:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
References: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com> <20181031053355.GQ32577@ZenIV.linux.org.uk> <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com> <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com> <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com> <28156.1541092687@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, swhiteho@redhat.com,
        john.johansen@canonical.com, alan.christopher.jenkins@gmail.com,
        ebiederm@redhat.com, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] mount API series
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3548.1541116763.1@warthog.procyon.org.uk>
Date:   Thu, 01 Nov 2018 23:59:23 +0000
Message-ID: <3549.1541116763@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 01 Nov 2018 23:59:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So if the patch series can be split up into a prep-phase that doesn't
> change any user-visible semantics (including the security side), but
> that uses the fs_context internally and allows the filesystems to be
> converted to the new world order, than that would make merging the
> early work much easier (and then my worry about the later phases would
> probably be much less too).

As a first go, I've rebased the patches to v4.19 (which required no other
changes), folded in some small bugfixes (fix error handling in remount, fix
incorrect user_ns in proc and mqueue) and split the set up.

There are now three branches in my git tree:

 (*) mount-api-core.  These are the internal-only patches that add the
     fs_context, the legacy wrapper and the security hooks and make certain
     filesystems make use of it.

 (*) mount-api-uapi.  This is mount-api-core with the UAPI-visible patches
     stacked thereon.

 (*) mount-api.  This is the original patchset.

"git diff mount-api mount-api-uapi" shows no differences.

Note that the commit "vfs: Implement logging through fs_context" appears in
both sets.  I was just going to leave it as macros that just wrap pr_notice(),
but I think it might be wiser to pull it out of line (as will be required
later) and make it produce messages at different levels.

The git tree in question is at:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

David
