Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D3C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A765621852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762386;
	bh=wFGWZTSJ7nLDUK6UBAn7f+yjTCJctEKk7Vm4HKbNKPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FYUyjPflTU5AlzxiubKgbCYnoJgRY327VcLrhU1sPjoCDmK7Uo+QTsz66v4cQXFnH
	 fJ3jWTUQmm/rlioPCIPocJRrSvv7S+5aRRK/0h04/5jG4DPZ4BSZDJbJ8y3/Uw++MO
	 Oxm2BTIrtGk3+/qAqJBJVEsqF0csvlUUxdZQHpI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfA2LqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbfA2LqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5C321874;
        Tue, 29 Jan 2019 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762377;
        bh=wFGWZTSJ7nLDUK6UBAn7f+yjTCJctEKk7Vm4HKbNKPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mh8P9NW7pf1Ah2USoxvUrTbwRubEKip7VIWc+dTOj5QvX6h6mbTrcL4oSZna+cn/M
         2vHaqZqO8OTexe3IyqCDIuyF57D4hQwJmnTuOBvSeGdoIBbIU78pf6CHLVwbtkEYE0
         bH/RaCwlddjBnCcsM/7gjxRYDpOmZzN8tsUHWNGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyungtae Kim <kt0755@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 060/103] Input: uinput - fix undefined behavior in uinput_validate_absinfo()
Date:   Tue, 29 Jan 2019 12:35:37 +0100
Message-Id: <20190129113204.281783124@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


