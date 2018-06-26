Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D785C26EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785C26EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbeFZSgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:36:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754938AbeFZSgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C958402178A;
        Tue, 26 Jun 2018 18:36:18 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D61D3111763E;
        Tue, 26 Jun 2018 18:36:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Date:   Tue, 26 Jun 2018 20:36:11 +0200
Message-Id: <20180626183612.321-3-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
References: <20180626183612.321-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 18:36:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 18:36:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace comments about places where the console lock should be held with
calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patchset

Changes in v4:
-Keep the comments about which fbcon functions need locks in place
---
 drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74d46ff..cd8d52a967aa 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	struct fb_info *oldinfo = NULL;
  	int found, err = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (oldidx == newidx)
 		return 0;
 
@@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
 {
 	int i, new_idx = -1, ret = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!fbcon_has_console_bind)
 		return 0;
 
@@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] == idx)
@@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 static void fbcon_remap_all(int idx)
 {
 	int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		set_con2fb_map(i, idx, 0);
 
@@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	fbcon_select_primary(info);
 
-- 
2.17.1

