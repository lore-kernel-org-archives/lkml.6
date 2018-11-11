Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832BA2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832BA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeKLGDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52834 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:49 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000l6-Bi; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001eg-Ve; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jslaby@suse.cz>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.556386560@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 212/366] tty: vt, get rid of weird source code flow
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

commit 34902b7f2754e6d890feb0cee34187f1bc75c930 upstream.

Some code in vc_allocate is indented by 4 spaces. It is inside a
condition. Invert the condition and move the code to the first
indentation level (using \tab). And insert some empty lines to have
logical code blocks separated.

Then, instead of freeing in an 'if' false branch, use goto-error
label as fail path.

Maybe better to look at this patch with diff -w -b.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/vt/vt.c | 70 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -752,46 +752,54 @@ static void visual_init(struct vc_data *
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
+	struct vt_notifier_param param;
+	struct vc_data *vc;
+
 	WARN_CONSOLE_UNLOCKED();
 
 	if (currcons >= MAX_NR_CONSOLES)
 		return -ENXIO;
-	if (!vc_cons[currcons].d) {
-	    struct vc_data *vc;
-	    struct vt_notifier_param param;
-
-	    /* due to the granularity of kmalloc, we waste some memory here */
-	    /* the alloc is done in two steps, to optimize the common situation
-	       of a 25x80 console (structsize=216, screenbuf_size=4000) */
-	    /* although the numbers above are not valid since long ago, the
-	       point is still up-to-date and the comment still has its value
-	       even if only as a historical artifact.  --mj, July 1998 */
-	    param.vc = vc = kzalloc(sizeof(struct vc_data), GFP_KERNEL);
-	    if (!vc)
+
+	if (vc_cons[currcons].d)
+		return 0;
+
+	/* due to the granularity of kmalloc, we waste some memory here */
+	/* the alloc is done in two steps, to optimize the common situation
+	   of a 25x80 console (structsize=216, screenbuf_size=4000) */
+	/* although the numbers above are not valid since long ago, the
+	   point is still up-to-date and the comment still has its value
+	   even if only as a historical artifact.  --mj, July 1998 */
+	param.vc = vc = kzalloc(sizeof(struct vc_data), GFP_KERNEL);
+	if (!vc)
 		return -ENOMEM;
-	    vc_cons[currcons].d = vc;
-	    tty_port_init(&vc->port);
-	    INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
-	    visual_init(vc, currcons, 1);
-	    if (!*vc->vc_uni_pagedir_loc)
+
+	vc_cons[currcons].d = vc;
+	tty_port_init(&vc->port);
+	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
+
+	visual_init(vc, currcons, 1);
+
+	if (!*vc->vc_uni_pagedir_loc)
 		con_set_default_unimap(vc);
-	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
-	    if (!vc->vc_screenbuf) {
-		kfree(vc);
-		vc_cons[currcons].d = NULL;
-		return -ENOMEM;
-	    }
 
-	    /* If no drivers have overridden us and the user didn't pass a
-	       boot option, default to displaying the cursor */
-	    if (global_cursor_default == -1)
-		    global_cursor_default = 1;
-
-	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
-	    vcs_make_sysfs(currcons);
-	    atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
-	}
+	vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
+	if (!vc->vc_screenbuf)
+		goto err_free;
+
+	/* If no drivers have overridden us and the user didn't pass a
+	   boot option, default to displaying the cursor */
+	if (global_cursor_default == -1)
+		global_cursor_default = 1;
+
+	vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
+	vcs_make_sysfs(currcons);
+	atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
+
 	return 0;
+err_free:
+	kfree(vc);
+	vc_cons[currcons].d = NULL;
+	return -ENOMEM;
 }
 
 static inline int resize_screen(struct vc_data *vc, int width, int height,

