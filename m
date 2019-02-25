Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03392084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130140;
	bh=RMyL8iQ0MkUykazmYHPjJScq5vPO8M77C8/pB+tmff4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yVVksBt850hrs+Tm8Y8oeYrrLZ3giYAq/AEnl+c02x6z3KhipbNQqFqKTr6H6BBTd
	 dK2piMncix+Gv4quDVD/5my+8rh3ENKFaemJqEmpiYps2f5dHxjHbxHrtO23cSQuL9
	 LqIYCKVPlN86lM1X6Yl3XLykrnYf4zCkaBxYZL0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfBYV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731933AbfBYV25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085A820C01;
        Mon, 25 Feb 2019 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130136;
        bh=RMyL8iQ0MkUykazmYHPjJScq5vPO8M77C8/pB+tmff4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blYTaoks2KBuoLkqHX7iJTBBRHb1mHfc1iPMhAE4FdSsOsNF3n1GpX4HPaGWqF2Pc
         vJjrQ5z4vSU+jIdKoHcVFQ0dO5xPeTs4/UF1+ISf6mQ7/kKT4Mc7rTFkYIYK+v5fQF
         uU8kukmNP2q7KblrfSyZJV0bImYn+NBIuuFRvlkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.20 018/183] KEYS: allow reaching the keys quotas exactly
Date:   Mon, 25 Feb 2019 22:09:51 +0100
Message-Id: <20190225195057.803846332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a08bf91ce28ed3ae7b6fef35d843fef8dc8c2cd9 upstream.

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
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/keys/key.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -265,8 +265,8 @@ struct key *key_alloc(struct key_type *t
 
 		spin_lock(&user->lock);
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
-			if (user->qnkeys + 1 >= maxkeys ||
-			    user->qnbytes + quotalen >= maxbytes ||
+			if (user->qnkeys + 1 > maxkeys ||
+			    user->qnbytes + quotalen > maxbytes ||
 			    user->qnbytes + quotalen < user->qnbytes)
 				goto no_quota;
 		}


