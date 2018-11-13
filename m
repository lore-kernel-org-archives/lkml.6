Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1772C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1772C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeKNJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeKNJUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:20:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6B7990C65;
        Tue, 13 Nov 2018 23:20:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C47BA608F3;
        Tue, 13 Nov 2018 23:20:14 +0000 (UTC)
Subject: [PATCH 0/3] AFS fixes
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 23:20:13 +0000
Message-ID: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 13 Nov 2018 23:20:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of fixes for AFS if you could pass them on to Linus:

 (1) Fix the interaction between vnode (inode) state validation and
     callback-break.  There are some unhandled cases that lead to kafs
     transmitting a FetchStatus request on every validate call after the
     server's record of the client expires due to lack of use and is
     discarded.

 (2) Fix some missing network error handling, and improve what happens when
     multiple errors are produced because an operation is duplicated across
     multiple servers.

 (3) Use d_instantiate() rather than d_add() and don't call d_drop() when
     instantiating a new inode.

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David
---
David Howells (3):
      afs: Fix validation/callback interaction
      afs: Fix missing net error handling
      afs: Use d_instantiate() rather than d_add() and don't d_drop()


 fs/afs/dir.c       |    4 +---
 fs/afs/fs_probe.c  |   39 ++++++++++++++++++++++++--------------
 fs/afs/inode.c     |   18 ++++++++++++------
 fs/afs/internal.h  |    9 +++++++++
 fs/afs/misc.c      |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/rotate.c    |   53 +++++++++++++---------------------------------------
 fs/afs/vl_probe.c  |   45 ++++++++++++++++++++++++++------------------
 fs/afs/vl_rotate.c |   50 ++++++++++---------------------------------------
 8 files changed, 148 insertions(+), 122 deletions(-)

