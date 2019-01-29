Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2460BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF24320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761967;
	bh=4GioorKk7EUnjVuM1v6EvE6VBkxkD1Le/LCEWDYLwwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U+A7PWg1nQj5aNPMn08Vs/UG/05XMDBSAoxSB5nN93ECwgHjqVirewWXjzifpbXox
	 0cmmU4y1mKSwanD0bV6c5e4b7/RzFmIj7m5t7FzPmULm6Z3lxBbVbSn9EhLTgxPWJQ
	 JyZU34yTkV0agR68gKaJdb1Ysh3AlvB6IeSJ2HfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfA2LjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfA2LjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D95320857;
        Tue, 29 Jan 2019 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761961;
        bh=4GioorKk7EUnjVuM1v6EvE6VBkxkD1Le/LCEWDYLwwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPjPZq7+Milr7U75Q5orXlQV3x8PUaSa5LxOAMggiiCnAQSLdT/f/MSLFhnVJFwj2
         MUDtGtxUZSOznLmttIGThLtnd4UbS1CEMcvttIC/tosdL12b8YapgDiBrTHjMhAhy5
         eL+/4MBc1DRnct8iJVYRmbURttXuFCgCCK631dXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.20 060/117] vgacon: unconfuse vc_origin when using soft scrollback
Date:   Tue, 29 Jan 2019 12:35:11 +0100
Message-Id: <20190129113210.661815079@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit bfd8d8fe98b8792f362cd210a7873969f8d2fc04 upstream.

When CONFIG_VGACON_SOFT_SCROLLBACK is selected, the VGA display memory
index and vc_visible_origin don't change when scrollback is activated.
The actual screen content is saved away and the scrollbackdata is copied
over it. However the vt code, and /dev/vcs devices in particular, still
expect vc_origin to always point at the actual screen content not the
displayed scrollback content.

So adjust vc_origin to point at the saved screen content when scrollback
is active and set it back to vc_visible_origin when restoring the screen.

This fixes /dev/vcsa<n> that return scrollback content when they
shouldn't (onli /dev/vcsa without a number should), and also fixes
/dev/vcsu that should return scrollback content when scrollback is
active but currently doesn't.

An unnecessary call to vga_set_mem_top() is also removed.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/vgacon.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -271,6 +271,7 @@ static void vgacon_scrollback_update(str
 
 static void vgacon_restore_screen(struct vc_data *c)
 {
+	c->vc_origin = c->vc_visible_origin;
 	vgacon_scrollback_cur->save = 0;
 
 	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
@@ -287,8 +288,7 @@ static void vgacon_scrolldelta(struct vc
 	int start, end, count, soff;
 
 	if (!lines) {
-		c->vc_visible_origin = c->vc_origin;
-		vga_set_mem_top(c);
+		vgacon_restore_screen(c);
 		return;
 	}
 
@@ -298,6 +298,7 @@ static void vgacon_scrolldelta(struct vc
 	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
+		c->vc_origin = (unsigned long)c->vc_screenbuf;
 		vgacon_scrollback_cur->save = 1;
 	}
 
@@ -335,7 +336,7 @@ static void vgacon_scrolldelta(struct vc
 		int copysize;
 
 		int diff = c->vc_rows - count;
-		void *d = (void *) c->vc_origin;
+		void *d = (void *) c->vc_visible_origin;
 		void *s = (void *) c->vc_screenbuf;
 
 		count *= c->vc_size_row;


