Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937298AbeE1KgH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162161AbeE1KgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:36:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Malone <peter.malone@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 186/329] fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
Date: Mon, 28 May 2018 12:01:55 +0200
Message-Id: <20180528100257.798552206@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Malone <peter.malone@gmail.com>

[ Upstream commit 250c6c49e3b68756b14983c076183568636e2bde ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sbuslib.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -121,7 +121,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -160,7 +160,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
