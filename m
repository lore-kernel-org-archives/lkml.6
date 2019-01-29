Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC190C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762081;
	bh=smwXdD9wso+KYmeTABeRP4XY/VUixQvW9JNwMHcnoZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhKfH6Pi/EuhuoMYnPvHtuQcbEd7gZSOHVe21K5S4JuoO3G8qdmmZgQU1BUciKyCj
	 KTyFnkGL73Pve+nE0mKi8ATMHIGQWzZPx4YYcJVoI0DIHT4uqAxeNOIpEoUqmIy6Bq
	 AXJjUIrkUGB6Tw90uEVKN04QrF7IJ1wbMoyRRl3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfA2LlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfA2LlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6611021873;
        Tue, 29 Jan 2019 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762074;
        bh=smwXdD9wso+KYmeTABeRP4XY/VUixQvW9JNwMHcnoZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pu6igajVbt2lIP0i5K9AVFdXte2K84Kgf2uqDFtN+9c8xbkrzFEXqr8f0Xvo2nqt0
         QamO4zUoZztJb4tQdHHvH2wAXkTIIYkiORhc2lM3WdqOHpwM6EA0RbUdPrt2sUiMRS
         F/nYSwU0rn/Vn5icwOLtApFjdDS9GqH+d3g2BHbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyungtae Kim <kt0755@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.20 068/117] Input: uinput - fix undefined behavior in uinput_validate_absinfo()
Date:   Tue, 29 Jan 2019 12:35:19 +0100
Message-Id: <20190129113210.978723533@linuxfoundation.org>
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
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/overflow.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
@@ -405,7 +406,7 @@ static int uinput_open(struct inode *ino
 static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 				   const struct input_absinfo *abs)
 {
-	int min, max;
+	int min, max, range;
 
 	min = abs->minimum;
 	max = abs->maximum;
@@ -417,7 +418,7 @@ static int uinput_validate_absinfo(struc
 		return -EINVAL;
 	}
 
-	if (abs->flat > max - min) {
+	if (!check_sub_overflow(max, min, &range) && abs->flat > range) {
 		printk(KERN_DEBUG
 		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
 		       UINPUT_NAME, code, abs->flat, min, max);


