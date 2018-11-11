Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71AE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChMpbe6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71AE214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbeKLKJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbeKLIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17921223C8;
        Sun, 11 Nov 2018 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975222;
        bh=lLM+8/WPsmv731/UyQLV7yafwkIU9C7dTkew4JH3KzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChMpbe6KVqcd4SNM7IXgotxvnqJ7ybrCzsAV7o82LwewqiAkoOxbOHIl3C/eQ0PG1
         /BvUz4qT+y/cps2CWF2/NRDCkhx9X5HPck9THzxjsmv8bASL3UzVpyslrP+OePgdTJ
         4oOi+0JMn1jjenH3J7LHVSE8ii9MceVz7VvCiXZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 005/361] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Sun, 11 Nov 2018 14:15:52 -0800
Message-Id: <20181111221620.818436341@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

commit 6c925b333368cda4e1b0513b07f72316c0e7edd7 upstream.

We should only iomap the area of the chip that is memory mapped.
Otherwise we could be mapping devices beyond the memory space or that
belong to other devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Fixes: ebd71e3a4861 ("mtd: maps: gpio-addr-flash: fix warnings and make more portable")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/maps/gpio-addr-flash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -238,7 +238,7 @@ static int gpio_flash_probe(struct platf
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
+	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
 	if (!state->map.virt)
 		return -ENOMEM;
 


