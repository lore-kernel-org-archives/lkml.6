Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789C0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359C320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359C320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbeIMTMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbeIMTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA723D2F;
        Thu, 13 Sep 2018 14:02:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 109/197] Input: do not use WARN() in input_alloc_absinfo()
Date:   Thu, 13 Sep 2018 15:30:58 +0200
Message-Id: <20180913131845.908607038@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 100294cee9a98bfd4d6cb2d1c8a8aef0e959b0c4 ]

Some of fuzzers set panic_on_warn=1 so that they can handle WARN()ings
the same way they handle full-blown kernel crashes. We used WARN() in
input_alloc_absinfo() to get a better idea where memory allocation
failed, but since then kmalloc() and friends started dumping call stack on
memory allocation failures anyway, so we are not getting anything extra
from WARN().

Because of the above, let's replace WARN with dev_err(). We use dev_err()
instead of simply removing message and relying on kcalloc() to give us
stack dump so that we'd know the instance of hardware device to which we
were trying to attach input device.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/input.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -480,11 +480,19 @@ EXPORT_SYMBOL(input_inject_event);
  */
 void input_alloc_absinfo(struct input_dev *dev)
 {
-	if (!dev->absinfo)
-		dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo),
-					GFP_KERNEL);
+	if (dev->absinfo)
+		return;
 
-	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
+	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
+	if (!dev->absinfo) {
+		dev_err(dev->dev.parent ?: &dev->dev,
+			"%s: unable to allocate memory\n", __func__);
+		/*
+		 * We will handle this allocation failure in
+		 * input_register_device() when we refuse to register input
+		 * device with ABS bits but without absinfo.
+		 */
+	}
 }
 EXPORT_SYMBOL(input_alloc_absinfo);
 


