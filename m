Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C420878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2C420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeGMOsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:48:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGMOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:48:02 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MQwFa-1fUfU635Qc-00UKJT; Fri, 13 Jul 2018 16:32:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [RESEND] ubifs: tnc: use monotonic znode timestamp
Date:   Fri, 13 Jul 2018 16:31:56 +0200
Message-Id: <20180713143212.3142541-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180713143212.3142541-1-arnd@arndb.de>
References: <20180713143212.3142541-1-arnd@arndb.de>
X-Provags-ID: V03:K1:H5cyEy/4n2rffZ+f05a5Y2q0wYJq76/yPOG+EB2VwJpzALrJQOO
 fe1eJUMvJ7JCZdm0s6k6D5F4ju9iIg5RLrdXoW0weEONv7orS1L/EGAZXipqgxXSsbpnvjm
 Eglp0k1Txq1FeASQY3TUd0ikRzpupGubxHi1/2P1jlQk7eIyZQMJwVgGaJfNV1ZiuTzHJ8K
 e09HAmib2eV7mZuBPtZbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vpcAhTQV7XM=:DydeVvz7ZJrjTeFSGKvhPG
 1HLO6FU+uHYe5MN+VFbsPTDvYJA0N8Dht3rk7ELlai3yT/O3WxEzGQacL0RC8rbS+EOF8D2fk
 Xb4aWWFc9OQjQZHG4pCSvYoNTGYW85ahmAuXDm1SiPYZZcdboq9buaPRafd/AExAt6P2muFlc
 LqEPT0hkyv1oYXL+ivBhoqyfpWiG299PpjVbGVrCS+mU1vKKh3MlIQLnHhAOeyCoeA7Pw4MeP
 NMFHNHUmM9FrkVZM0y+p/XIy0pRAS86aLUZ12JVZME/GCuD5lDmEngf6JF40seNm3CuXxVqy2
 BXz3sLopmmOfkGC9E5RctIZUG3GKT208Wem867T3xeTaJmnp6mFQs0jjYHcclhyAqXnu9JrET
 FqesXWWen8GZwU1XJLLEORY9OwNP46LY76POHMznzy94B4maNMOaKwEbz4G+jASLPMATE76pI
 UzFZ0ZmK1qHPeTiDhWSLl5MxXLIXx7JAcYx/z+7iSK7MHTY+ewPbAVBn4PhsqA7VaRez/gaAz
 y1psi7ZL1lMq09iuypdaBdYCqQiwxUY6Y2Fml7jzcFZrvL5ZXplJWQAeWKzj8JXify1jq5Q3E
 lzrHiuwDyZXo6dKTp1/TqEsE8h6ji43A0iy6rFbD8e7yXraDMF4pqkAVBGYhg9js/59CyrI9v
 V95OoNa2YNndGfs5337KwFXAt8xMW6R9Pr5IxPY28zoXeYLAmZcu6ZQjZ53s0EE7lnVQ=
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

