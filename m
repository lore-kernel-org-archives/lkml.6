Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956CCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4482133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukH/ZPQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4482133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbeK3Bbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbeK3Bbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C34E213A2;
        Thu, 29 Nov 2018 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501567;
        bh=IL0jWB3ZAO1mAw3PVLElun1iU9Z9wgTk/5nPbNt5ky8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukH/ZPQ+Zeru/WyNiRRfSu/VL8YNyBx+1Wa0iDCx6aVezewMZGzuUy8izxAWlm6pv
         F2Qo/gFVoKtn2bUT25r0c3mSH28KIMrcg68oboeM8xmO9rOJgQu0tZX8+hlRdrDApN
         bAZErEGzieYnqDcNqkggYOd2a7i6n+kdTecUPMkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 015/100] gpio: dont free unallocated ida on gpiochip_add_data_with_key() error path
Date:   Thu, 29 Nov 2018 15:11:45 +0100
Message-Id: <20181129140100.199782296@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vz@mleia.com>

commit a05a14049999598a3bb6fab12db6b768a0215522 upstream.

The change corrects the error path in gpiochip_add_data_with_key()
by avoiding to call ida_simple_remove(), if ida_simple_get() returns
an error.

Note that ida_simple_remove()/ida_free() throws a BUG(), if id argument
is negative, it allows to easily check the correctness of the fix by
fuzzing the return value from ida_simple_get().

Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1166,7 +1166,7 @@ int gpiochip_add_data(struct gpio_chip *
 	gdev->descs = kcalloc(chip->ngpio, sizeof(gdev->descs[0]), GFP_KERNEL);
 	if (!gdev->descs) {
 		status = -ENOMEM;
-		goto err_free_gdev;
+		goto err_free_ida;
 	}
 
 	if (chip->ngpio == 0) {
@@ -1298,8 +1298,9 @@ err_free_label:
 	kfree(gdev->label);
 err_free_descs:
 	kfree(gdev->descs);
-err_free_gdev:
+err_free_ida:
 	ida_simple_remove(&gpio_ida, gdev->id);
+err_free_gdev:
 	/* failures here can mean systems won't boot... */
 	pr_err("%s: GPIOs %d..%d (%s) failed to register\n", __func__,
 	       gdev->base, gdev->base + gdev->ngpio - 1,


