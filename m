Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeE3UbC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:31:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeE3UbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:31:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, deepa.kernel@gmail.com
Cc: Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Geliang Tang <geliangtang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Remove bogus format string definition
Date: Wed, 30 May 2018 22:30:09 +0200
Message-Id: <20180530203024.2792802-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:xc1xDQdDhoY90WXKWkZtsWgytnVsGNCu7hLgFJ8/KpNl5xScp7Z
 Jc+2jDDiXhO1YtdZ6PzwTMno9uhJfpJFZddoOj1SxVjkYBcUUNEq2elWRU5v7FSe04vkHed
 DMpbh7lyyH0+S+E6h9IGXeMyttC9Jjqfis5FE8BM3yQHnb0Q4MQBCwQ3OwmoHm13J/QeS9a
 WS3nvJ0rbTclSPgjPAM1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TeZp+1Nz9nk=:h4n2WZvn0f/pg14ns0Nbts
 m3mcr2/HTyZNGGoEFlNehtuaMTDB1aUWhbWiqVmWQyb7qFrMxFHB9bS8Rg52gfm7isIFyWLmp
 i9+B+gLrXg31+d6TCc2bhfw/sth+VUbxOwmUQTyRMaGW4Bg9MR+7hbsheAHxaPlppXyo33Hk3
 mezHLjU0YtO0IBPnDHNsUDP5XPu35JZfh6BI76Vm+K3ds7svFrXTaAVQwcvlkev4MX3O1YocV
 5SkUDu/PwOr963f4jquw0OnwzkPb316vg1oq3gQJQHXIse8ImaLTAr5UrAsVHYXo3Kl/Swsza
 Y2uDDm2bRxRz4U5DFW3GRhIaaL8QmCnMb9Jg2hYPtP7GL/0SO3C4F5c3uRfsPXPezUYOINC3V
 Izimfa5bChPA6mEsuazqkoELGRI4qdMvFCPj2bknSCr6PtjWoW3D30r7Z5ZO4gBnqm1bggs1z
 AUWweX1l9DXSLJc5rVWIiLgPBrMyXNZ9JOmq/GQyVQ6fHDHnf76fkO5ifX9xCyX3MiijBCu95
 JxuILYfq3t3H/M/zOgnDxFJvosKGpzoY4VRxZABOe7CbG+Lo4q72n2y2bTG8ETVlMibR0WmM8
 rR+jwQEO0JbeFJVye0eRESu7zJGnDmnsbCRRCGdiN2lNLstGdMnw3fe4HIfghBNjh6q8RCAcp
 CkIoGYfFuhOdC4JdaAketLOAgYszMXis8jM30nafPW5CLz6ycDf6lun0SEXuXpDVfZS0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore conversion to timespec64 introduces its own method of passing
seconds into sscanf() and sprintf() type functions to work around the
timespec64 definition on 64-bit systems that redefine it to 'timespec'.

That hack is now finally getting removed, but that means we get a (harmless)
warning once both patches are merged:

fs/pstore/ram.c: In function 'ramoops_read_kmsg_hdr':
fs/pstore/ram.c:39:29: error: format '%ld' expects argument of type 'long int *', but argument 3 has type 'time64_t *' {aka 'long long int *'} [-Werror=format=]
 #define RAMOOPS_KERNMSG_HDR "===="
                             ^~~~~~
fs/pstore/ram.c:167:21: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'

This removes the pstore specific workaround and uses the same method that
we have in place for all other functions that print a timespec64.

Related to this, I found that the kasprintf() output contains an incorrect
nanosecond values for any number starting with zeroes, and I adapt the
format string accordingly.

Link: https://lkml.org/lkml/2018/5/19/115
Link: https://lkml.org/lkml/2018/5/16/1080
Fixes: 0f0d83b99ef7 ("pstore: Convert internal records to timespec64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/pstore/ram.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 69e893076ab7..bbd1e357c23d 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -38,11 +38,6 @@
 
 #define RAMOOPS_KERNMSG_HDR "===="
 #define MIN_MEM_SIZE 4096UL
-#if __BITS_PER_LONG == 64
-# define TVSEC_FMT "%ld"
-#else
-# define TVSEC_FMT "%lld"
-#endif
 
 static ulong record_size = MIN_MEM_SIZE;
 module_param(record_size, ulong, 0400);
@@ -164,15 +159,15 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 	char data_type;
 	int header_length = 0;
 
-	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n%n",
-		   &time->tv_sec, &time->tv_nsec, &data_type,
+	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
+		   (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
 		   &header_length) == 3) {
 		if (data_type == 'C')
 			*compressed = true;
 		else
 			*compressed = false;
-	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu\n%n",
-			  &time->tv_sec, &time->tv_nsec,
+	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
+			  (time64_t *)&time->tv_sec, &time->tv_nsec,
 			  &header_length) == 2) {
 		*compressed = false;
 	} else {
@@ -367,8 +362,8 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
 	char *hdr;
 	size_t len;
 
-	hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n",
-		record->time.tv_sec,
+	hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
+		(time64_t)record->time.tv_sec,
 		record->time.tv_nsec / 1000,
 		record->compressed ? 'C' : 'D');
 	WARN_ON_ONCE(!hdr);
-- 
2.9.0
