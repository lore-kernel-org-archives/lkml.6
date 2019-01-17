Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5123A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAQP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:27:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B94DA432CA;
        Thu, 17 Jan 2019 15:27:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43DD16533E;
        Thu, 17 Jan 2019 15:27:30 +0000 (UTC)
Subject: [PATCH 0/6] AFS fixes
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:27:29 +0000
Message-ID: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 17 Jan 2019 15:27:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Here's a set of fixes for AFS:

 (1) Use struct_size() for kzalloc() size calculation.

 (2) When calling YFS.CreateFile rather than AFS.CreateFile, it is possible
     to create a file with a file lock already held.  The default value
     indicating no lock required is actually -1, not 0.

 (3) Fix an oops in inode/vnode validation if the target inode doesn't have
     a server interest assigned (ie. a server that will notify us of
     changes by third parties).

 (4) Fix refcounting of keys in file locking.

 (5) Fix a race in refcounting asynchronous operations in the event of an
     error during request transmission.  The provision of a dedicated
     function to get an extra ref on a call is split into a separate
     commit.

The patches can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
	tag afs-fixes-20190117

David
---
David Howells (3):
      afs: Fix key refcounting in file locking code
      afs: Provide a function to get a ref on a call
      afs: Fix race in async call refcounting

Gustavo A. R. Silva (1):
      afs: Use struct_size() in kzalloc()

Marc Dionne (2):
      afs: Set correct lock type for the yfs CreateFile
      afs: Don't set vnode->cb_s_break in afs_validate()


 fs/afs/flock.c             |    4 ++-
 fs/afs/inode.c             |    3 ++
 fs/afs/protocol_yfs.h      |   11 +++++++++
 fs/afs/rxrpc.c             |   53 +++++++++++++++++++++++++++++++++++---------
 fs/afs/server_list.c       |    4 +--
 fs/afs/yfsclient.c         |    2 +-
 include/trace/events/afs.h |    2 ++
 7 files changed, 61 insertions(+), 18 deletions(-)

