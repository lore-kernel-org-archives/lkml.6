Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D9DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6F2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeGMOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:41:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:41:21 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LdVQI-1gMMBA2nGE-00ijxF; Fri, 13 Jul 2018 16:26:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2, RESEND] afs: stop using time_t for internal times
Date:   Fri, 13 Jul 2018 16:25:57 +0200
Message-Id: <20180713142605.3138377-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:muopVIXrRh9HYHtoyB17ckhpoiMC8DMWhsBi2+n1JE1P2vcnyPA
 MlOdmidS31/+ZJLiGchbextdQbSw5Dxc68DVaYKMIzHRepTwdvJbZT06GmShRPpg6/jcYT+
 CM0o0y8gs5usSejNwDCG4H9kKbhEX7q6Zh2UzkJ3QPUcnQQrSvNPxqf1kMkwbP+Kv3OldJi
 Sy1AQqCxvc/jnsMPQlH9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2O/QxCMcfLA=:jvQ3nnVxW6dzs79fIjCVn3
 dZcXm3yXjVz8Sp2NKkYCE2gsBh6p8Hhpde8NQTIJxsPydunY3iyyCN5BN2RASQJYKcA+FrFXn
 bwcxOi6ZfV0AolLnWHtyon2CMDrjaO1vpgd3tlez9KuBXafOv0RUgXCAmu0tYy1VNMaJaU1je
 hLoIuhRhKtyXEJ58dHklmYL7Ytp1Kw0Y0B/IWDC9NDPRXXeYttYMljmnDISWo6rhv8LL0p8hI
 etng+ZbUtPp/31CbRJ14uluSYkWabi2DCl/WWPPu6QDise/6TOvCkGejpy1TYWwhe/k3Dii2C
 MQUIY1zfe8Y6QFYPeykglPy0r11D69qkPlY3MHcyjM3C0W6BEC0Lyd0XSYsWQO9+nQpbO2MJ0
 iUq8VsoWGkD+XVQV7ghmHeNmLOhKToDtMgBbdl3yySVseZhg4U33kAge/Xe0DxuIJHUCxsyNH
 OvuhHxEkB1N/4O8oDxLsp52Svrif9x4tcT28l6DrkEyco0ZzTpURLcw0nyRP3vMQ+7O8PP9t6
 q31xLyBmO3+MJVL9hvzt8Eiwnm32nv8rpGTcfx42X8R69vSIVZgx350NuiyphH7foL5OXRUWB
 +fzzTwumStX2g2LbQsOh2vQgOUAKIlnk5dlj05Q+uqk1dR4gn5TGfNiIHr7hief2EpKVHA4WT
 0Ah8aYdl0G1guohXKY352hL/YfpODffuAPVoGex2KQuK4/6+O5ExMEIEQb1nJ4axGryY=
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
Originally submitted this on June 20, but got no reply.
Resending this in case it got lost somewhere on the way.
David, can you pick up both patches?
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

