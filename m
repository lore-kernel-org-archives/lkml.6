Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62926C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2DB20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoR1kxUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2DB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIDHJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36819 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so916526pfo.3;
        Mon, 03 Sep 2018 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frF0BaIgA9XPi5C/PpMcQkh6hQWXokybPdUOPQVwUvU=;
        b=PoR1kxUTkBYKfsf8gjErzPf/Pu9K2R/qFm+Lzt77zWDG+DvqiU2rxda1FCFeqcahbh
         m0jLednzMRN07iUV8PGaIwSV9FAzhfwPKdipmaYJXZrdYQkOdOApGMlUsaMqDQIL7NYX
         jVKdLi2XBl1gTkYRnD6+N8gmvRwlJfcwHav4N8LJVd/qNZI91tQ/nV2xafSDJDbDkD9j
         fidWF4JoyEg6Bq5uCvd/LMqrt55Mdb3b93CEmp2wOIV2z8lcdcfTVqzK+y40tJN77Y74
         wD14J21mjlA112sf+3U5cxwvo+Hko8n1PWSAjRIo8lYiDiNGTITnlhl4IH0OEvihrRwT
         13pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frF0BaIgA9XPi5C/PpMcQkh6hQWXokybPdUOPQVwUvU=;
        b=OzxrMhnpY84zo/9+UtJ+2sjgdqvMRMOPfwxqNGfq7yUSoYtZwCssRSTVg7ASkwhwP7
         /m8fNmMDiAdei4mF+b7JqWIjUYO1IhvxNOj3dxyQWixLA73Dnfqt3Ux7Nut74nu4AEH4
         CrXMs8qBr5l15uqJ36RmV2ls6aRQEbM9Sqz4/ew4huISCHw2uHRocgf/nGJFowZamXNL
         jgVgi+2IZoaQdXS+BDc6IBzrmYxKLA8fUlOJMUpZRRB+FVWNJAX5jvp6ByY4eFPUe6W2
         aEHTqBM1MRGX1Sa8NazrjwUai/YFwI/2MKUf4z3UqdDxPvJCA413Utpgh9wcNKOWNab4
         P7zQ==
X-Gm-Message-State: APzg51Axv6Lusx2unvFFcfY5nabQFpI0amPKKNFN43Ct7Y42VlqixbOK
        pMwUOMkbbrjVS2eIbTWxmtM=
X-Google-Smtp-Source: ANB0VdYwJILszk8CVOneCeT5Z5FD7aPcC3d5ENYis8nsMPxIL+h3VVc2CwriUnl9EXedOjNXcieVrQ==
X-Received: by 2002:a63:e443:: with SMTP id i3-v6mr29624135pgk.381.1536029177486;
        Mon, 03 Sep 2018 19:46:17 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:16 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 17/25] misc: pti: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:43 +0900
Message-Id: <1536029091-4426-18-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/misc/pti.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f..5c885a1 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct pti_tty *pti_tty_data;
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0) {
-		pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
-		if (pti_tty_data == NULL)
-			return -ENOMEM;
+	tty_standard_install(driver, tty);
+	pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
+	if (pti_tty_data == NULL)
+		return -ENOMEM;
 
-		if (idx == PTITTY_MINOR_START)
-			pti_tty_data->mc = pti_request_masterchannel(0, NULL);
-		else
-			pti_tty_data->mc = pti_request_masterchannel(2, NULL);
+	if (idx == PTITTY_MINOR_START)
+		pti_tty_data->mc = pti_request_masterchannel(0, NULL);
+	else
+		pti_tty_data->mc = pti_request_masterchannel(2, NULL);
 
-		if (pti_tty_data->mc == NULL) {
-			kfree(pti_tty_data);
-			return -ENXIO;
-		}
-		tty->driver_data = pti_tty_data;
+	if (pti_tty_data->mc == NULL) {
+		kfree(pti_tty_data);
+		return -ENXIO;
 	}
+	tty->driver_data = pti_tty_data;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.7.4

