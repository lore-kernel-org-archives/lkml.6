Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15437206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15437206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeIFNxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728650AbeIFNxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48CDC80401CC;
        Thu,  6 Sep 2018 09:19:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C5CB10F1BE7;
        Thu,  6 Sep 2018 09:19:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/11] UAPI: nilfs2: Fix use of undefined byteswapping
 functions [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:19:17 +0100
Message-ID: <153622555770.14298.17748806314555967351.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:19:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:19:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nilfs2 exports a load of inline functions to userspace that call kernel
byteswapping functions that don't exist in UAPI.  Fix this by making it
#include asm/byteorder.h and use the functions declared there.

A better way is probably to remove these inline functions from the nilfs2
header since they are technically broken.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
cc: linux-nilfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

 include/uapi/linux/nilfs2_ondisk.h |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/nilfs2_ondisk.h b/include/uapi/linux/nilfs2_ondisk.h
index a7e66ab11d1d..47f8f596ff1c 100644
--- a/include/uapi/linux/nilfs2_ondisk.h
+++ b/include/uapi/linux/nilfs2_ondisk.h
@@ -29,6 +29,7 @@
 
 #include <linux/types.h>
 #include <linux/magic.h>
+#include <asm/byteorder.h>
 
 
 #define NILFS_INODE_BMAP_SIZE	7
@@ -533,20 +534,17 @@ enum {
 static inline void							\
 nilfs_checkpoint_set_##name(struct nilfs_checkpoint *cp)		\
 {									\
-	cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |		\
-				   (1UL << NILFS_CHECKPOINT_##flag));	\
+	cp->cp_flags |= __cpu_to_le32(1UL << NILFS_CHECKPOINT_##flag);	\
 }									\
 static inline void							\
 nilfs_checkpoint_clear_##name(struct nilfs_checkpoint *cp)		\
 {									\
-	cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) &		\
-				   ~(1UL << NILFS_CHECKPOINT_##flag));	\
+	cp->cp_flags &= __cpu_to_le32(~(1UL << NILFS_CHECKPOINT_##flag)); \
 }									\
 static inline int							\
 nilfs_checkpoint_##name(const struct nilfs_checkpoint *cp)		\
 {									\
-	return !!(le32_to_cpu(cp->cp_flags) &				\
-		  (1UL << NILFS_CHECKPOINT_##flag));			\
+	return !!(cp->cp_flags & __cpu_to_le32(1UL << NILFS_CHECKPOINT_##flag)); \
 }
 
 NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
@@ -595,21 +593,17 @@ enum {
 static inline void							\
 nilfs_segment_usage_set_##name(struct nilfs_segment_usage *su)		\
 {									\
-	su->su_flags = cpu_to_le32(le32_to_cpu(su->su_flags) |		\
-				   (1UL << NILFS_SEGMENT_USAGE_##flag));\
+	su->su_flags |= __cpu_to_le32(1UL << NILFS_SEGMENT_USAGE_##flag); \
 }									\
 static inline void							\
 nilfs_segment_usage_clear_##name(struct nilfs_segment_usage *su)	\
 {									\
-	su->su_flags =							\
-		cpu_to_le32(le32_to_cpu(su->su_flags) &			\
-			    ~(1UL << NILFS_SEGMENT_USAGE_##flag));      \
+	su->su_flags &= __cpu_to_le32(~(1UL << NILFS_SEGMENT_USAGE_##flag)); \
 }									\
 static inline int							\
 nilfs_segment_usage_##name(const struct nilfs_segment_usage *su)	\
 {									\
-	return !!(le32_to_cpu(su->su_flags) &				\
-		  (1UL << NILFS_SEGMENT_USAGE_##flag));			\
+	return !!(su->su_flags & __cpu_to_le32(1UL << NILFS_SEGMENT_USAGE_##flag)); \
 }
 
 NILFS_SEGMENT_USAGE_FNS(ACTIVE, active)
@@ -619,15 +613,15 @@ NILFS_SEGMENT_USAGE_FNS(ERROR, error)
 static inline void
 nilfs_segment_usage_set_clean(struct nilfs_segment_usage *su)
 {
-	su->su_lastmod = cpu_to_le64(0);
-	su->su_nblocks = cpu_to_le32(0);
-	su->su_flags = cpu_to_le32(0);
+	su->su_lastmod = __cpu_to_le64(0);
+	su->su_nblocks = __cpu_to_le32(0);
+	su->su_flags = __cpu_to_le32(0);
 }
 
 static inline int
 nilfs_segment_usage_clean(const struct nilfs_segment_usage *su)
 {
-	return !le32_to_cpu(su->su_flags);
+	return !su->su_flags;
 }
 
 /**

