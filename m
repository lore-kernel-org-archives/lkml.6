Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB68222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbfBNQUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:20:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbfBNQUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:20:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE89F10F8C;
        Thu, 14 Feb 2019 16:20:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A9660BE3;
        Thu, 14 Feb 2019 16:20:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] KEYS: allow reaching the keys quotas exactly
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 16:20:01 +0000
Message-ID: <155016119453.8115.5525641267104914850.stgit@warthog.procyon.org.uk>
In-Reply-To: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
References: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Feb 2019 16:20:06 +0000 (UTC)
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
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/key.c |    4 ++--
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

