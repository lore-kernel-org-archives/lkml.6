Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51B3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6412120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6412120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:03:21 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbeFTODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:03:20 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lx4sD-1gGBoW1ZpR-016f6u; Wed, 20 Jun 2018 16:02:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] afs: stop using time_t for internal times
Date:   Wed, 20 Jun 2018 16:02:47 +0200
Message-Id: <20180620140256.19648-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Lxn+1U/8re2lIeaD19RxYEV7PzzWtOPBXz2AQ2Z/PF7fzVqFNVd
 9m7UwZ7m83cf/yfzpNGyzrvKwqgE/yOU8w+tppuEXXmeaud/OikltIiX6bWNltLBC4/V7fC
 4w8NG9LzoDxmYKhxI1tA18Azbf79Slbe9fajH3WVBp+tEXJIoTAulO3+fNAVQOQADZFTxKx
 laiSioEzF2oXI22D7HoKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7IeezqHgk8I=:aOupF9trc1pmuJwNO7wW6K
 2RYXLC34HA/Y4FyZcY21FCsuyYbJxAN61Ee+vfoftS337tGRT0kEsdGaDsqLPMHr92LqgB0T1
 1bSB8aZDoBp6hivxvMsBlv+P8vO+ex/l3ba7U8HLIiPZpf6NMM76mbK6kGKWTTY1AHO7ZU1y2
 31YQUgXa4QpQRT9fRAfp7eSI5pgB82YI7E29PUvCBa35I+Qq1sUqNAB8B3bsiAkcMpmhgmHyP
 10e2V0npJxyx86eD0jDxj7PfYbsw9uFxmH15UiGuc0M9przGqRjEdy2ISy5IOocMdB4XYvFnS
 Fa+BGMruR0POs9V75YyaGcCjOLF/GoEyB6dA5CJPhVjNYisj2lAB8ZZ//kMn+ePrh2n3WR8oA
 1vnZNLfiVxwROhtOTxAAPTxVigO32P8Ni44Eek1ABzu+JuYk2XtfqM9faUFLjoTEhKB1Hz+ki
 PqYPewrEo6HaNuZEX77TLoWd7+T6b/sC8zNfuF/iNHw4aPq50+IA/V2yGkTQVMiYMrkVT3YWh
 zKGR1z/MM+yH1VjhXfyqvMI8r2cImQV1UiI60Kc67HX+8LtkFjFGnM/1l27VuFsZZOm2Gsxac
 F3F95iuabLjAqtzzZC520ox0v6D0X1PIr2kc6Vm/7jqKZ3xTBaFoXm07TbfQ1PBCn1gihvNkJ
 lpvYUUTn1ilMc0QhVG1t7RHUUryzYianENS84rmU3uPviMBtM/5MJ+wcH/0N4W2YXJwc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs uses 32-bit timestamps everywhere, but mixes signed and unsigned
usage, which is a bit inconsistent. In particular on 32-bit machines,
it currently uses unsigned timestamps (ranging from 1970 to 2106) for
locally modified files, but signed timestamps (rand 1902 to 2038) when
reading from a remote end. On 64-bit machines, we always interpret
timestamps as unsigned here.

This replaces the deprecated time_t with a new explicitly unsigned
afs_time32_t to get a consistent interpretation of inode times
according the the wire protocol definition.

This avoids the y2038 overflow on 32-bit machines, extending the range
to the end of the afs_time32_t in year 2106. On 64-bit machines, using
the shorter type saves a few bytes for each afs_file_status and
afs_volsync saves a few bytes over time_t or time64_t.

Note that mtime_server and struct afs_volsync are not currently
used in any meaningful way and could be removed completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/afs/afs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index b4ff1f7ae4ab..a17f4ce06323 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -26,6 +26,7 @@
 typedef unsigned			afs_volid_t;
 typedef unsigned			afs_vnodeid_t;
 typedef unsigned long long		afs_dataversion_t;
+typedef unsigned			afs_time32_t;
 
 typedef enum {
 	AFSVL_RWVOL,			/* read/write volume */
@@ -129,8 +130,8 @@ typedef u32 afs_access_t;
 struct afs_file_status {
 	u64			size;		/* file size */
 	afs_dataversion_t	data_version;	/* current data version */
-	time_t			mtime_client;	/* last time client changed data */
-	time_t			mtime_server;	/* last time server changed data */
+	afs_time32_t		mtime_client;	/* last time client changed data */
+	afs_time32_t		mtime_server;	/* last time server changed data */
 	unsigned		abort_code;	/* Abort if bulk-fetching this failed */
 
 	afs_file_type_t		type;		/* file type */
@@ -158,7 +159,7 @@ struct afs_file_status {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
-	time_t			creation;	/* volume creation time */
+	afs_time32_t		creation;	/* volume creation time */
 };
 
 /*
-- 
2.9.0

