Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB28C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F72E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsytgRot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbeLQPDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46599 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbeLQPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so10979275edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDtH6zGmEM2l3DfcIg+caiDfheYBOXtlnL/AyD04Lv0=;
        b=OsytgRotCYSj8GIir/YK3vDecpGeM7KqXOX7VKsXjYTbBWvLb4Q1ZstqTvEFABlprj
         f5kf9r8vWiUMPw9p7fUP9er1UR+KU310GYdOH02cu3X/eIS1F3vs3YXOxbblEw0cZDDa
         FTwl2vfEIEIa7Xm5tNyaXs7ZEM2q2nJWIcirDA6Yml7TYatqpm9SX69GnNZgKpNMYTLs
         09KwyXilFtuaCZfJhvvGOgMIWgNrE+8WJkgc8Ik9glBaLSO0eXia3HQooeU4HSab4AF1
         AniFv2iSZ1o/qoq684Rn88lkyCKfUd4FlCplKPU28L40s5a8ThkBYrJkeN4jaPIRuUU9
         OLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDtH6zGmEM2l3DfcIg+caiDfheYBOXtlnL/AyD04Lv0=;
        b=kBB1hmZZM3EnXhzRNvQi0F9wcIF95U0lK419GHNz86uI+Fv7jddPiPtrmOFVodE3a1
         wl4+IC0PD+81KOvLGppCNUrIPbr2ib90X/UD9/3Lnn+vdWncZa9+T7A96nMNKZcItGzA
         u3C5ejQNvGgFE+G6t0qLiRFDvJafVdQFkOuL5lv10TvNNasg2kk/hRv23E4gUHRJG1bq
         mM/8qk9is60qqTHQYWTAKvRFSkYTxI88gkQnQQRjATG0nGLXA7lGYFulohtiMO6ZCkoY
         X5ks5q2kXJcHU9U8f4H9/cD8WY3wb+UFJGhM6Oj/fpfTwlr23BRKMX5Kebx1o8+dQrxy
         /y0g==
X-Gm-Message-State: AA+aEWbwqoK1ilBgEb/ydEaKhWe69+02S8XvCDsfmvCA3F+ZKW4mD+qA
        QIKqlCK+v4IRMICoKSFpxAY=
X-Google-Smtp-Source: AFSGD/UCwMvecKnam9uQcbAL0Fjm6IUex5glVGKmhroD/n4bZnRjM1TW8TrxTssJeWEOeL1KGMctSQ==
X-Received: by 2002:a17:906:30d5:: with SMTP id b21-v6mr10702168ejb.42.1545058982498;
        Mon, 17 Dec 2018 07:03:02 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g21sm3879709edc.63.2018.12.17.07.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:01 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 14/19] mailbox: omap: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:12 +0100
Message-Id: <20181217150217.32435-15-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217150217.32435-1-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/omap-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index db66e952a871..7e54ebb7defe 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -486,7 +486,7 @@ static int omap_mbox_register(struct omap_mbox_device *mdev)
 	list_add(&mdev->elem, &omap_mbox_devices);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	ret = mbox_controller_register(&mdev->controller);
+	ret = devm_mbox_controller_register(&mdev->controller);
 
 err_out:
 	if (ret) {
@@ -508,8 +508,6 @@ static int omap_mbox_unregister(struct omap_mbox_device *mdev)
 	list_del(&mdev->elem);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	mbox_controller_unregister(&mdev->controller);
-
 	mboxes = mdev->mboxes;
 	for (i = 0; mboxes[i]; i++)
 		device_unregister(mboxes[i]->dev);
-- 
2.19.1

