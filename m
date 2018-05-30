Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeE3LrH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:47:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60647 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751737AbeE3LG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Peter Malone" <peter.malone@gmail.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Mathieu Malaterre" <malat@debian.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.814339507@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 012/153] fbdev: Fixing arbitrary kernel leak in case
 FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Malone <peter.malone@gmail.com>

commit 250c6c49e3b68756b14983c076183568636e2bde upstream.

Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
sbusfb_ioctl_helper().

'index' is defined as an int in sbusfb_ioctl_helper().
We retrieve this from the user:
if (get_user(index, &c->index) ||
    __get_user(count, &c->count) ||
    __get_user(ured, &c->red) ||
    __get_user(ugreen, &c->green) ||
    __get_user(ublue, &c->blue))
       return -EFAULT;

and then we use 'index' in the following way:
red = cmap->red[index + i] >> 8;
green = cmap->green[index + i] >> 8;
blue = cmap->blue[index + i] >> 8;

This is a classic information leak vulnerability. 'index' should be
an unsigned int, given its usage above.

This patch is straight-forward; it changes 'index' to unsigned int
in two switch-cases: FBIOGETCMAP_SPARC && FBIOPUTCMAP_SPARC.

This patch fixes CVE-2018-6412.

Signed-off-by: Peter Malone <peter.malone@gmail.com>
Acked-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/sbuslib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
