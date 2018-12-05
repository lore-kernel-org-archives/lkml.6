Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF58CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F31206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zgFGkVDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F31206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeLEKFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeLEJlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:47 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6EE820879;
        Wed,  5 Dec 2018 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002906;
        bh=aypELQQHZhyPOlo20z6q9sAKCTEGpKVt6f5JfOxQB4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgFGkVDbFL15bmWvC7VwVbsN11djFQJFwtvg6nGh4nJH3nV6LlK9n1F/vMSSk9x1x
         HNxcYICvKupaGCRcs9zSl8kAVpG26n8gPuij6MsqcVMXmDQPc+iHnWClrkvtdq709u
         15nZOVUNfhEipPyVXiXXB7JGeih+ZT3Zr2t1Il0s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 107/123] cachefiles: Explicitly cast enumerated type in put_object
Date:   Wed,  5 Dec 2018 04:35:39 -0500
Message-Id: <20181205093555.5386-107-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

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
2.17.1

