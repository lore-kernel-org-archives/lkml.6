Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3C72080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3C72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeKLF4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52006 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbeKLF4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:11 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000l9-CG; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001eb-Ur; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jiri Slaby" <jslaby@suse.cz>,
        "Fugang Duan" <fugang.duan@nxp.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.209678984@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 211/366] tty: vt, remove reduntant check
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

commit 182846a00f489849c55d113954f0c4a8a286ca39 upstream.

MAX_NR_CONSOLES and MAX_NR_USER_CONSOLES are both 63 since they were
introduced in 1.1.54. And since vc_allocate does:

if (currcons >= MAX_NR_CONSOLES)
	return -ENXIO;

if (!vc_cons[currcons].d) {
	if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
		return -EPERM;
}

the second check is pointless. Remove both the check and the macro
MAX_NR_USER_CONSOLES.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/vt/vt.c     | 4 ----
 include/uapi/linux/vt.h | 1 -
 2 files changed, 5 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -760,10 +760,6 @@ int vc_allocate(unsigned int currcons)	/
 	    struct vc_data *vc;
 	    struct vt_notifier_param param;
 
-	    /* prevent users from taking too much memory */
-	    if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
-	      return -EPERM;
-
 	    /* due to the granularity of kmalloc, we waste some memory here */
 	    /* the alloc is done in two steps, to optimize the common situation
 	       of a 25x80 console (structsize=216, screenbuf_size=4000) */
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -8,7 +8,6 @@
  */
 #define MIN_NR_CONSOLES 1       /* must be at least 1 */
 #define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
-#define MAX_NR_USER_CONSOLES 63	/* must be root to allocate above this */
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */
 

