Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02E02C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD563208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blgNNpiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD563208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeFLEiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:38:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37397 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeFLEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:38:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so10498467pgv.4;
        Mon, 11 Jun 2018 21:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6Oqc3O0YB3eMiwoMVJT25cP5ckOZNNh67r22qpPAUV8=;
        b=blgNNpiTMV633FJbqXxa4HeSl7d/rsBiUwG9QRX1arYvk7xpYReN7o/Uw7m1h8ZZzI
         v/4ejoVKjiDiw1STlc8/trhqwGTYAhvpKVYa0awlOhAyll/rPVZ4MZYINtyxJ1Lrk+3K
         sOy1NWO4ROUV45VHTiZQ9tebOZqa+iLLT5Fin6Jdahur4ZJ+yUIQAi2lvDU3ag7FZNaY
         uOUb8TtoPTO57JA1ZV5PPTbTMTS6el8VeFvstn4MhiJyb5UkGL20JmlxMcJZS9M3h66O
         zg3y8Emq6f4yK87hDRInEXa8vfPr0el5zumfbyXdlqDeHaNdCGhCkGc8Q+BdLWwh87re
         itdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Oqc3O0YB3eMiwoMVJT25cP5ckOZNNh67r22qpPAUV8=;
        b=dRxviPrQtxdaV8dmANtI7w5VJ+JrNpVH04kS+reywY2dFkE3UrYrrF7VxbGjPeLtOZ
         1A6Y4Z2wgWxnB7uoDLusAe1dINa89vG4JBjqQskJeRpx8VKmBmzkY/EkCeeqpPlOY66m
         j/bdMhyrMKVmkgoO676kXEkDaCgdrkd/BScVhuWqZUjxADlwCOBwmp1qYdzePTgoINQO
         aZLckSK7bzffboGtW/BDWl3PUeDvhYEaKUR/KQgjDkcsBl+O0Q5vbi9c4PelCauTxN6p
         /6gyWl7kczIg9SIj40owQjkZil5jaMBFKurebXv18yAyh0LObwOv0xAtjV517lk+r2nK
         7sOw==
X-Gm-Message-State: APt69E1IZLR7dVUreOLYNi628hLhoGdWCEQZYiO0MY6zn2F+SzfQbBC7
        vMJ+UH7Efxt95SKITIchFkOIm9HxSJQ=
X-Google-Smtp-Source: ADUXVKKZCEgz1Cza3997EGPN5wfbHaQFUiQpIuTUG/Sneel236eSGevwi1yJRVgf28NG0VZ66DpqlQ==
X-Received: by 2002:a63:a84f:: with SMTP id i15-v6mr1837192pgp.422.1528778298320;
        Mon, 11 Jun 2018 21:38:18 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id h12-v6sm14587783pfi.114.2018.06.11.21.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:38:17 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI : dock: add error handling for acpi_bus_get_device
Date:   Tue, 12 Jun 2018 12:38:12 +0800
Message-Id: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acpi_bus_get_device fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling acpi_bus_get_device.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/acpi/dock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index e3fc1f0..02fc134 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -504,7 +504,9 @@ static ssize_t show_docked(struct device *dev,
 	struct dock_station *dock_station = dev->platform_data;
 	struct acpi_device *adev = NULL;
 
-	acpi_bus_get_device(dock_station->handle, &adev);
+	if (acpi_bus_get_device(dock_station->handle, &adev))
+		return -ENODEV;
+
 	return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
-- 
2.7.4

