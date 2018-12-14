Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1952147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789187;
	bh=fk+lnqcIjjAdFYK0y5jSgakE/KifD22Jhz/p9YbNFNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6KFY7gQg32YTHVkxsc3EDbekU1nCRKyW2pGAmOhgKkamdRAK9JUcv4Kp9/PnTWpO
	 PM0g26f0KQgyXebMjtDuUz2fgz25C/SvuDKv1uNyjxHWpUFnmcwzw6Iy9YgL3u1G0e
	 nJCgqCmH7SsKQ6xeTE6sMRO1KBNfCn+TfIXns8yY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1952147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbeLNMG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbeLNMGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72EF621479;
        Fri, 14 Dec 2018 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789182;
        bh=fk+lnqcIjjAdFYK0y5jSgakE/KifD22Jhz/p9YbNFNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzBX+rk2wwKTCQIImxtbSEB2TMPfUMlklTOBXpebsgGW/WVx2Lp6fQgCy++UQhFep
         st183VkqjaK9OccyxU74VsaOvHOTUJ5h73UikvQqkN7L7Nrqc9j/Kz0TCgkR63oJnj
         60j7TRgYhVz3ySxr24/QZRia3PBhUAAW4TscArTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/142] cachefiles: Explicitly cast enumerated type in put_object
Date:   Fri, 14 Dec 2018 13:00:03 +0100
Message-Id: <20181214115751.754526103@linuxfoundation.org>
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

[ Upstream commit b7e768b7e3522695ed36dcb48ecdcd344bd30a9b ]

Clang warns when one enumerated type is implicitly converted to another.

fs/cachefiles/namei.c:247:50: warning: implicit conversion from
enumeration type 'enum cachefiles_obj_ref_trace' to different
enumeration type 'enum fscache_obj_ref_trace' [-Wenum-conversion]
        cache->cache.ops->put_object(&xobject->fscache,
cachefiles_obj_put_wait_retry);

Silence this warning by explicitly casting to fscache_obj_ref_trace,
which is also done in put_object.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 95983c744164..5ab411d4bc59 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -244,11 +244,13 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 
 	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
 
-	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_retry);
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
 	goto try_again;
 
 requeue:
-	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_timeo);
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
 	_leave(" = -ETIMEDOUT");
 	return -ETIMEDOUT;
 }
-- 
2.19.1



