Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698A7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3955B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763009;
	bh=2mApwcoZburJVTc3kX/EkXxfqXHKEo4xacA3fuhDySE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r5X+vb8lFDtp1/1KBkKEce+wiMp6YCXrICMwDzkKNknOjlz6kTxqag380yukwn1s0
	 gBGwRXeNx7VLroaEOiZ1QtNRW+YG7cK+5aqczvcg/uJHeHjOXPbZaaAIkaIBXqYln0
	 OxOYgppdfTUNPeY/9lzJgAto3n4j0UWCITo6wV5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfA2L4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731501AbfA2Ltg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7461F2086C;
        Tue, 29 Jan 2019 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762575;
        bh=2mApwcoZburJVTc3kX/EkXxfqXHKEo4xacA3fuhDySE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZL2b9ywQ3FHI8/iwK++kSFGpuQrrRbtno5sTfM1djZBCpYkF8N02Vb3N5Wb/WvHh
         1gYCjRFL+NpcesyqkfPeyIFOLbKQ6ghrD76GVFvIanTrX4YkBfIKIFY2FtRSOyluUw
         IuXhYGdrkNK+8cGPtxojkX1bk2hFad4luCURn1y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyungtae Kim <kt0755@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 36/68] Input: uinput - fix undefined behavior in uinput_validate_absinfo()
Date:   Tue, 29 Jan 2019 12:35:58 +0100
Message-Id: <20190129113134.578200748@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit d77651a227f8920dd7ec179b84e400cce844eeb3 upstream.

An integer overflow may arise in uinput_validate_absinfo() if "max - min"
can't be represented by an "int". We should check for overflow before
trying to use the result.

Reported-by: Kyungtae Kim <kt0755@gmail.com>
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/uinput.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -39,6 +39,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/uinput.h>
+#include <linux/overflow.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
@@ -356,7 +357,7 @@ static int uinput_open(struct inode *ino
 static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 				   const struct input_absinfo *abs)
 {
-	int min, max;
+	int min, max, range;
 
 	min = abs->minimum;
 	max = abs->maximum;
@@ -368,7 +369,7 @@ static int uinput_validate_absinfo(struc
 		return -EINVAL;
 	}
 
-	if (abs->flat > max - min) {
+	if (!check_sub_overflow(max, min, &range) && abs->flat > range) {
 		printk(KERN_DEBUG
 		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
 		       UINPUT_NAME, code, abs->flat, min, max);


