Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E629EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0D42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0D42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeGRCq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:46:27 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:34242 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbeGRCq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:46:26 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffbvV-0007MA-0y; Wed, 18 Jul 2018 04:10:51 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffbvU-0008Up-7N; Wed, 18 Jul 2018 04:10:48 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 04:10:42 +0200
Message-Id: <20180718021044.32611-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
References: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 1/3] vt: don't reinvent min()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the helper function saved us was a cast.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/selection.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 90ea1cc52b7a..34e7110f310d 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -116,12 +116,6 @@ static inline int atedge(const int p, int size_row)
 	return (!(p % size_row)	|| !((p + 2) % size_row));
 }
 
-/* constrain v such that v <= u */
-static inline unsigned short limit(const unsigned short v, const unsigned short u)
-{
-	return (v > u) ? u : v;
-}
-
 /* stores the char in UTF8 and returns the number of bytes used (1-3) */
 static int store_utf8(u16 c, char *p)
 {
@@ -167,10 +161,10 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	if (copy_from_user(&v, sel, sizeof(*sel)))
 		return -EFAULT;
 
-	v.xs = limit(v.xs - 1, vc->vc_cols - 1);
-	v.ys = limit(v.ys - 1, vc->vc_rows - 1);
-	v.xe = limit(v.xe - 1, vc->vc_cols - 1);
-	v.ye = limit(v.ye - 1, vc->vc_rows - 1);
+	v.xs = min_t(u16, v.xs - 1, vc->vc_cols - 1);
+	v.ys = min_t(u16, v.ys - 1, vc->vc_rows - 1);
+	v.xe = min_t(u16, v.xe - 1, vc->vc_cols - 1);
+	v.ye = min_t(u16, v.ye - 1, vc->vc_rows - 1);
 	ps = v.ys * vc->vc_size_row + (v.xs << 1);
 	pe = v.ye * vc->vc_size_row + (v.xe << 1);
 
-- 
2.18.0

