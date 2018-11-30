Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9EA20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9EA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeLADuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:50:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeLADuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:50:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A8DEC7913;
        Fri, 30 Nov 2018 16:40:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56A785D9CD;
        Fri, 30 Nov 2018 16:40:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/7] fscache: fix race between enablement and dropping of
 object
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     NeilBrown <neilb@suse.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:40:41 +0000
Message-ID: <154359604153.18703.13408831778890364347.stgit@warthog.procyon.org.uk>
In-Reply-To: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
References: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 30 Nov 2018 16:40:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

It was observed that a process blocked indefintely in
__fscache_read_or_alloc_page(), waiting for FSCACHE_COOKIE_LOOKING_UP
to be cleared via fscache_wait_for_deferred_lookup().

At this time, ->backing_objects was empty, which would normaly prevent
__fscache_read_or_alloc_page() from getting to the point of waiting.
This implies that ->backing_objects was cleared *after*
__fscache_read_or_alloc_page was was entered.

When an object is "killed" and then "dropped",
FSCACHE_COOKIE_LOOKING_UP is cleared in fscache_lookup_failure(), then
KILL_OBJECT and DROP_OBJECT are "called" and only in DROP_OBJECT is
->backing_objects cleared.  This leaves a window where
something else can set FSCACHE_COOKIE_LOOKING_UP and
__fscache_read_or_alloc_page() can start waiting, before
->backing_objects is cleared

There is some uncertainty in this analysis, but it seems to be fit the
observations.  Adding the wake in this patch will be handled correctly
by __fscache_read_or_alloc_page(), as it checks if ->backing_objects
is empty again, after waiting.

Customer which reported the hang, also report that the hang cannot be
reproduced with this fix.

The backtrace for the blocked process looked like:

PID: 29360  TASK: ffff881ff2ac0f80  CPU: 3   COMMAND: "zsh"
 #0 [ffff881ff43efbf8] schedule at ffffffff815e56f1
 #1 [ffff881ff43efc58] bit_wait at ffffffff815e64ed
 #2 [ffff881ff43efc68] __wait_on_bit at ffffffff815e61b8
 #3 [ffff881ff43efca0] out_of_line_wait_on_bit at ffffffff815e625e
 #4 [ffff881ff43efd08] fscache_wait_for_deferred_lookup at ffffffffa04f2e8f [fscache]
 #5 [ffff881ff43efd18] __fscache_read_or_alloc_page at ffffffffa04f2ffe [fscache]
 #6 [ffff881ff43efd58] __nfs_readpage_from_fscache at ffffffffa0679668 [nfs]
 #7 [ffff881ff43efd78] nfs_readpage at ffffffffa067092b [nfs]
 #8 [ffff881ff43efda0] generic_file_read_iter at ffffffff81187a73
 #9 [ffff881ff43efe50] nfs_file_read at ffffffffa066544b [nfs]
#10 [ffff881ff43efe70] __vfs_read at ffffffff811fc756
#11 [ffff881ff43efee8] vfs_read at ffffffff811fccfa
#12 [ffff881ff43eff18] sys_read at ffffffff811fda62
#13 [ffff881ff43eff50] entry_SYSCALL_64_fastpath at ffffffff815e986e

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/object.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 9edc920f651f..6d9cb1719de5 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -730,6 +730,9 @@ static const struct fscache_state *fscache_drop_object(struct fscache_object *ob
 
 	if (awaken)
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+
 
 	/* Prevent a race with our last child, which has to signal EV_CLEARED
 	 * before dropping our spinlock.

