Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452221905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497976;
	bh=HmjuXY+xhZ1Q/kk1ErLmJaVzR8Pjjskr0w3XhA/M8yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ikDfsnZzj4nKeFi/Mq7OW3FeF8x9WJxDju78worAFjDT6Y1j7k1obIo1WTzc32VHU
	 6mMV0WWpA39Qi7mlrZao18Fvoyo9WPsrHGMBcyxLvs1pMlmCRXpClgaLI1yqup3OSK
	 ov5+2u13SBF6XhoCVv0tNvGMePnUQ+Dg3VOWGi1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfBRNwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfBRNwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:52:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A472F20842;
        Mon, 18 Feb 2019 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497970;
        bh=HmjuXY+xhZ1Q/kk1ErLmJaVzR8Pjjskr0w3XhA/M8yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmivtXvTf488eBI4uuPlmq4gZpCT0aG4JM8mEMkVHgKXokuhC4KP7O1TZuCbuCUtX
         W+6KRzkWVAacn2Hu+lDQKEM2+L0iuhMTtXB2EAhrdlJBmXeA7v8JSoJhDyN2xBa4An
         acbkcuumK6Nog9WYgDaPqsO4pp1e+CjBcDoOImZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>, Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 68/85] Revert "mm: dont reclaim inodes with many attached pages"
Date:   Mon, 18 Feb 2019 14:43:34 +0100
Message-Id: <20190218133506.495855150@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

From: Dave Chinner <dchinner@redhat.com>

commit 69056ee6a8a3d576ed31e38b3b14c70d6c74edcc upstream.

This reverts commit a76cf1a474d7d ("mm: don't reclaim inodes with many
attached pages").

This change causes serious changes to page cache and inode cache
behaviour and balance, resulting in major performance regressions when
combining worklaods such as large file copies and kernel compiles.

  https://bugzilla.kernel.org/show_bug.cgi?id=202441

This change is a hack to work around the problems introduced by changing
how agressive shrinkers are on small caches in commit 172b06c32b94 ("mm:
slowly shrink slabs with a relatively small number of objects").  It
creates more problems than it solves, wasn't adequately reviewed or
tested, so it needs to be reverted.

Link: http://lkml.kernel.org/r/20190130041707.27750-2-david@fromorbit.com
Fixes: a76cf1a474d7d ("mm: don't reclaim inodes with many attached pages")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Cc: Wolfgang Walter <linux@stwm.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Spock <dairinin@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/inode.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -730,11 +730,8 @@ static enum lru_status inode_lru_isolate
 		return LRU_REMOVED;
 	}
 
-	/*
-	 * Recently referenced inodes and inodes with many attached pages
-	 * get one more pass.
-	 */
-	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
+	/* recently referenced inodes get one more pass */
+	if (inode->i_state & I_REFERENCED) {
 		inode->i_state &= ~I_REFERENCED;
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;


