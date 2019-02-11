Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA8DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9618217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549919440;
	bh=5SMXV/bVKe5MTWwcyX6l8bcm3QatwqSm1wBSZOMq1hI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=umS1+JawLfia6/wDIoSDC5KlMhh3Jy6aSWfixDO52WoXcr1+9RYoA3c6hQ9ZPq20q
	 A6dQqDNZgRqlJBqlJbHBnVy4ktIUmx4wtxgD14i61xkHTCl3SQCyPSEQ9I0xavRWP2
	 pM+s3mm/aXu+VBiCpu+dxO8lBbhahBRkX/22srxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfBKVKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKVKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:10:38 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1036214DA;
        Mon, 11 Feb 2019 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549919438;
        bh=5SMXV/bVKe5MTWwcyX6l8bcm3QatwqSm1wBSZOMq1hI=;
        h=From:To:Cc:Subject:Date:From;
        b=NecRbMGmndtCGqUXefV+UBrGlUaVwXj8OZvp6d3j8reiwIMDrCOeRSMr+9pqqLNSV
         Kobeqg0tP1/IEwr+OsW2Kno8oS+G+vUCzE0r5dWhBcOEvIKIPoCAPPBkutEdF9uqdS
         +myOGRxQ6GvnGsJiER+WXjJwmHa8W9iW6svR2vFs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: allow reaching the keys quotas exactly
Date:   Mon, 11 Feb 2019 13:10:10 -0800
Message-Id: <20190211211010.220098-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If the sysctl 'kernel.keys.maxkeys' is set to some number n, then
actually users can only add up to 'n - 1' keys.  Likewise for
'kernel.keys.maxbytes' and the root_* versions of these sysctls.  But
these sysctls are apparently supposed to be *maximums*, as per their
names and all documentation I could find -- the keyrings(7) man page,
Documentation/security/keys/core.rst, and all the mentions of EDQUOT
meaning that the key quota was *exceeded* (as opposed to reached).

Thus, fix the code to allow reaching the quotas exactly.

Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
Cc: <stable@vger.kernel.org> # v2.6.26+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 44a80d6741a1..0ec9322af4f9 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -265,8 +265,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 		spin_lock(&user->lock);
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
-			if (user->qnkeys + 1 >= maxkeys ||
-			    user->qnbytes + quotalen >= maxbytes ||
+			if (user->qnkeys + 1 > maxkeys ||
+			    user->qnbytes + quotalen > maxbytes ||
 			    user->qnbytes + quotalen < user->qnbytes)
 				goto no_quota;
 		}
-- 
2.20.1.791.gb4d0f1c61a-goog

