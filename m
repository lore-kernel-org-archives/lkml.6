Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D5DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6547F214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkF9/dI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6547F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeKIHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbeKIHps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:48 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB920208A3;
        Thu,  8 Nov 2018 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714897;
        bh=97LSY278TYMgkPBzhg2RNG9JhwXldBq0cCeL9e0w7HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkF9/dI69GQfqqIY8ke5Ph1MIvThQnpjAuKn5AgwVoBOAD2nA4r0uBmT+rTEL3JgL
         oEWyHg4TTRuQRXpCzVEoDkkEV94RU5at+7IAm07VJgczt2HmQ9RAG0XAXqn6bgwnyP
         t2pgtBTOukB32ml6pMjeHeJGHTc1MtYR69yD/FyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.14 11/31] cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)
Date:   Thu,  8 Nov 2018 13:52:35 -0800
Message-Id: <20181108215130.636636359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 169b803397499be85bdd1e3d07d6f5e3d4bd669e upstream.

the victim might've been rmdir'ed just before the lock_rename();
unlike the normal callers, we do not look the source up after the
parents are locked - we know it beforehand and just recheck that it's
still the child of what used to be its parent.  Unfortunately,
the check is too weak - we don't spot a dead directory since its
->d_parent is unchanged, dentry is positive, etc.  So we sail all
the way to ->rename(), with hosting filesystems _not_ expecting
to be asked renaming an rmdir'ed subdirectory.

The fix is easy, fortunately - the lock on parent is sufficient for
making IS_DEADDIR() on child safe.

Cc: stable@vger.kernel.org
Fixes: 9ae326a69004 (CacheFiles: A cache that backs onto a mounted filesystem)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cachefiles/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -340,7 +340,7 @@ try_again:
 	trap = lock_rename(cache->graveyard, dir);
 
 	/* do some checks before getting the grave dentry */
-	if (rep->d_parent != dir) {
+	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
 		/* the entry was probably culled when we dropped the parent dir
 		 * lock */
 		unlock_rename(cache->graveyard, dir);


