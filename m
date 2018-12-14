Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7031214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789249;
	bh=7yaIQw3uyH1UzTHN1wSVlM9O9avNMnWBITnsPD2UbcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7ca6dSQqitaTHN8aXkr9jorJfbUh8HmT/p0mDTaWZ7myXmw2LhGFQA4qunOBgVWN
	 DgcwRi26IQ1pJWWuDmskljQxXts2OCkQAbDtBsoKxQXMBcmc/CmcFC8tQpAYywCLMD
	 DBxi45hXO5hBUwB3H25c4f/KAPcR7dZDfSilNiL8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7031214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeLNMH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbeLNMHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B57214AE;
        Fri, 14 Dec 2018 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789242;
        bh=7yaIQw3uyH1UzTHN1wSVlM9O9avNMnWBITnsPD2UbcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxWE2rSKSQb4cCN59jNfFXHO3F6EVVAKS7HomAMYrtoKY26KT+33dbhS7lsmke/8y
         68G9bubQDDcTlbkIi2YuX7fl8yNCjgWXGIJ2klykXDAnOSAVoxYzxpnC/dRwXnugCh
         2AQ6avUxB7157kd9bLRO68XeZ+5GhYUXOgGfawag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/142] fscache: fix race between enablement and dropping of object
Date:   Fri, 14 Dec 2018 13:00:02 +0100
Message-Id: <20181214115751.717013734@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
-- 
2.19.1



