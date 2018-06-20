Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC83C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30BD20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30BD20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeFTJVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:21:40 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeFTI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:59 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M1hZS-1gJoru1vOU-00tgex; Wed, 20 Jun 2018 10:29:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: tnc: use monotonic znode timestamp
Date:   Wed, 20 Jun 2018 10:29:11 +0200
Message-Id: <20180620082937.719067-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:vxIMLQRBGMGZ82FXIXw3ZVG74RVbmt6DfFiQ3KR9OdnR8K8rjyx
 pzo8DMnWdiKdjKfV/Y+22HPFE07gRGye4EOG90/MpyWgMH4j2DhKBnFjP5DNLkrnmQ0Yhyi
 bdYTLufQRGFQUio5CzKWbV/kuo87DYulhY/iU8mP7Tj4TWKRDyxU3deiygtfaJE7fJJo8A6
 Up5WAJaVKUk/fjkwaiF2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PSXRrjG/+vo=:M+JjVeQ9cU6iOYjSN8gL+S
 6sZ3Mxkf4GHjxwN1s0z5ZOEvF4b9bXPECWZwzKhHEnt93yulkFHaqUM8eFaC2hKxrK5e6Kq2a
 zkxQqFlC5BUtQAhmO59rZCnf/7BIEeDUZAdqkP5LTb41ehY8pGPYe12A9YAAdjSHEUoLAySW0
 R+nw0wy5WuNwCFuHIVEo7TF+z8ihAAs+s8D8nQ3+h8VGfdro1w+8WbqWfobmgRMdqt4p3HEfW
 G2R/BGZjDAJiGcihbTici27bS2Gq9SX1eQ77C3wRJw9d571UpBgJcAUjXkejPJs6yQcU+KkN4
 v+lG3yjarswIWa1bDaPOyZMoV58HQe6CkuiBug8qlhqO74O6x1LBu8erQ+LjVZDaeZmkwoWnn
 jWpAufZN+Urm4366W7V2JScoz9lxX0IZnNdI0wu97nQmEbCTR6omS8p45iBFMLp/Tdvlwrmuh
 /DHlATDzlha7ODb4oDU1QdO0tnD8JZgCKYsB++s0yUwQ6q5aiBdfpedatXNYb/gKybmy+d7CM
 Qc9ieBOCF8pDDq64TnLRschnMm/OzOU1UX8b3h5MwtdNhFSXh7uRqzTtRfViWU2iPfB0+PVO5
 ffv+XZXB4IOtdr2cHdnz4JyqAxpjgcuhcQDFMQPBWDBCLkf+e85Li22ibrSDb0yeCxdY6ufiv
 EQ/wcH6k+msnDzrRkRNT9uMZuG7Vpi+wJ1LqVLEUNLx9HtIhl8SKyYBFoAyYzJZRB1eI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tnc uses get_seconds() based timestamps to check the age of a znode,
which has two problems: on 32-bit architectures this may overflow in
2038 or 2106, and it gives incorrect information when the system time
is updated using settimeofday().

Using montonic timestamps with ktime_get_seconds() solves both thes
problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/shrinker.c | 2 +-
 fs/ubifs/tnc.c      | 4 ++--
 fs/ubifs/tnc_misc.c | 2 +-
 fs/ubifs/ubifs.h    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/shrinker.c b/fs/ubifs/shrinker.c
index 9a9fb94a41c6..9d10cbdec2cc 100644
--- a/fs/ubifs/shrinker.c
+++ b/fs/ubifs/shrinker.c
@@ -71,7 +71,7 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 {
 	int total_freed = 0;
 	struct ubifs_znode *znode, *zprev;
-	int time = get_seconds();
+	time64_t time = ktime_get_seconds();
 
 	ubifs_assert(mutex_is_locked(&c->umount_mutex));
 	ubifs_assert(mutex_is_locked(&c->tnc_mutex));
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 4a21e7f75e7a..6c497fb48b98 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -1179,7 +1179,7 @@ int ubifs_lookup_level0(struct ubifs_info *c, const union ubifs_key *key,
 {
 	int err, exact;
 	struct ubifs_znode *znode;
-	unsigned long time = get_seconds();
+	time64_t time = ktime_get_seconds();
 
 	dbg_tnck(key, "search key ");
 	ubifs_assert(key_type(c, key) < UBIFS_INVALID_KEY);
@@ -1315,7 +1315,7 @@ static int lookup_level0_dirty(struct ubifs_info *c, const union ubifs_key *key,
 {
 	int err, exact;
 	struct ubifs_znode *znode;
-	unsigned long time = get_seconds();
+	time64_t time = ktime_get_seconds();
 
 	dbg_tnck(key, "search and dirty key ");
 
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 93f5b7859e6f..49f647bc88f0 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -435,7 +435,7 @@ struct ubifs_znode *ubifs_load_znode(struct ubifs_info *c,
 
 	zbr->znode = znode;
 	znode->parent = parent;
-	znode->time = get_seconds();
+	znode->time = ktime_get_seconds();
 	znode->iip = iip;
 
 	return znode;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 04bf84d71e7b..54fb6b1cd042 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -758,7 +758,7 @@ struct ubifs_znode {
 	struct ubifs_znode *parent;
 	struct ubifs_znode *cnext;
 	unsigned long flags;
-	unsigned long time;
+	time64_t time;
 	int level;
 	int child_cnt;
 	int iip;
-- 
2.9.0

