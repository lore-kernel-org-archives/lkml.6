Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC956C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A998B20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vurMG4Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeLEJyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbeLEJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:54:00 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A102082B;
        Wed,  5 Dec 2018 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003639;
        bh=Skxv7YuJdKqJygYp1GKeFyUzkEKoQN9QrwF0O9iaBaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vurMG4Ki5kF3bJdBt2x8kkIT49yFVGIDoac4oNb1Rnmy2nR9fjezm07qtUpb/aV8L
         0NTuDOHx7lSVBdrJqCcWzjqGX9udm0v5FrZt42Gm8aj4bGrLHQRRAMELzgYsXvWgb+
         uO0f2gKnL4a+iwrL0dhBuF/dxFXg5uND3YnnJsWc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     NeilBrown <neilb@suse.com>, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 26/33] fscache: fix race between enablement and dropping of object
Date:   Wed,  5 Dec 2018 04:51:24 -0500
Message-Id: <20181205095131.7685-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

[ Upstream commit c5a94f434c82529afda290df3235e4d85873c5b4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fscache/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 7a182c87f378..ab1d7f35f6c2 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -715,6 +715,9 @@ static const struct fscache_state *fscache_drop_object(struct fscache_object *ob
 
 	if (awaken)
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+
 
 	/* Prevent a race with our last child, which has to signal EV_CLEARED
 	 * before dropping our spinlock.
-- 
2.17.1

