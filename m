Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeDABmK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47386 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeDABlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:08 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <b865dfcc967b076d91d6ab6e56a7bfddfa7f3c5e.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 09/12] block/swim: Rename macros to avoid inconsistent
 inverted logic
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sony drive status bits use active-low logic. The swim_readbit()
function converts that to 'C' logic for readability. Hence, the
sense of the names of the status bit macros should not be inverted.

Mostly they are correct. However, the TWOMEG_DRIVE, MFM_MODE and
TWOMEG_MEDIA macros have inverted sense (like MkLinux). Fix this
inconsistency and make the following patches less confusing.

The same problem affects swim3.c so fix that too.

No functional change.

The FDHD drive status bits are documented in sonydriv.cpp from MAME
and in swimiii.h from MkLinux.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c  | 8 ++++----
 drivers/block/swim3.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 8be0d92bc431..d69cc5dadbfc 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -111,7 +111,7 @@ struct iwm {
 /* Select values for swim_select and swim_readbit */
 
 #define READ_DATA_0	0x074
-#define TWOMEG_DRIVE	0x075
+#define ONEMEG_DRIVE	0x075
 #define SINGLE_SIDED	0x076
 #define DRIVE_PRESENT	0x077
 #define DISK_IN		0x170
@@ -119,9 +119,9 @@ struct iwm {
 #define TRACK_ZERO	0x172
 #define TACHO		0x173
 #define READ_DATA_1	0x174
-#define MFM_MODE	0x175
+#define GCR_MODE	0x175
 #define SEEK_COMPLETE	0x176
-#define ONEMEG_MEDIA	0x177
+#define TWOMEG_MEDIA	0x177
 
 /* Bits in handshake register */
 
@@ -619,7 +619,7 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, ONEMEG_MEDIA);
+		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index af51015d056e..469541c1e51e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -148,7 +148,7 @@ struct swim3 {
 #define MOTOR_ON	2
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
-#define TWOMEG_DRIVE	5
+#define ONEMEG_DRIVE	5
 #define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
@@ -156,9 +156,9 @@ struct swim3 {
 #define TRACK_ZERO	10
 #define TACHO		11
 #define READ_DATA_1	12
-#define MFM_MODE	13
+#define GCR_MODE	13
 #define SEEK_COMPLETE	14
-#define ONEMEG_MEDIA	15
+#define TWOMEG_MEDIA	15
 
 /* Definitions of values used in writing and formatting */
 #define DATA_ESCAPE	0x99
-- 
2.16.1
