Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499AB20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499AB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeLADuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeLADuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:50:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C8653F3B4;
        Fri, 30 Nov 2018 16:40:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4EDB6012E;
        Fri, 30 Nov 2018 16:40:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/7] cachefiles: Explicitly cast enumerated type in
 put_object
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:40:52 +0000
Message-ID: <154359605275.18703.13154398219288238138.stgit@warthog.procyon.org.uk>
In-Reply-To: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
References: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 30 Nov 2018 16:40:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

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
---

 fs/cachefiles/namei.c |    6 ++++--
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

