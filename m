Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3AC43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84C21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSbI3/dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E84C21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHOXa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:30:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34337 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHOXa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so963540plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzKCtfmk6mLmM9sua49g+B7N832rpugedePAGNhMaiE=;
        b=CSbI3/dy/D1HAEec9tTQAdYR6/YFj71mKzwazRjN6EJOP7FofxMPn48Q46YZqYyoPG
         wkgMOCBaOkflPv/xRka6DHOyQbt6GqjDxHMfwxS2TzvKLCGjH+2OSa3HX1AbVFH3nIEm
         SOWSZWWbLdXDobgmplPFODtFSSQatLgZ6z6zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzKCtfmk6mLmM9sua49g+B7N832rpugedePAGNhMaiE=;
        b=qe63r//j5Zhx28nQRyK59FOdOHh1YInQfkMcBOfUCx4T3rHhJgtseTm8XvpZEbqr6V
         RFiPM9EaNwCysMc5h+qA8BT668EqTT/JApngNHPnm0ixlfrraMnAR72oaHEkcIRJ8yW8
         XgafG3fBaW+zw8OfkZtUnXSTwzvJXH1MhO1u9sRk2BQ1uEannZlihEEtJTTSZLMyOjiu
         2YesaGraG8KID2XuIRspmUuRBdcRbdlX16ymoh7x7amni+IjkPzHg/K+tGnxKOZpB97x
         22fLeOScfjEbUM23ENi/uuEEM9AyVyVHqv6EUFf6F7Olc0HxESCksTH7IMKstao13mXC
         4liQ==
X-Gm-Message-State: AOUpUlFl3HCA9ltrGj/crRw/LXhu94hcQCEJ2MX7PY7WNRmAi3Dmc1TJ
        6q4gSL7FlFKKjNR+s6ls729Qrg==
X-Google-Smtp-Source: AA+uWPyTx8rrO/soqbuEWRd+iTLBVuDfjjEz/RG2kT1PmH+gYPq0EMFdFFvapCA4t9uMXbIuc3vfxg==
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8-v6mr25605193plr.343.1534365433458;
        Wed, 15 Aug 2018 13:37:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 3/6] firmware: coreboot: Make bus registration symmetric
Date:   Wed, 15 Aug 2018 13:37:05 -0700
Message-Id: <20180815203708.67090-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
References: <20180815203708.67090-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus is registered in module_init() but is unregistered when the
platform driver remove() function calls coreboot_table_exit(). That
isn't symmetric and it causes the bus to appear on systems that compile
this code in, even when there isn't any coreboot firmware on the device.
Let's move the registration to the coreboot_table_init() function so
that it matches the exit path.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 898bb9abc41f..f417170f83ea 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -70,12 +70,6 @@ static struct bus_type coreboot_bus_type = {
 	.remove		= coreboot_bus_remove,
 };
 
-static int __init coreboot_bus_init(void)
-{
-	return bus_register(&coreboot_bus_type);
-}
-module_init(coreboot_bus_init);
-
 static void coreboot_device_release(struct device *dev)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -114,6 +108,10 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		goto out;
 	}
 
+	ret = bus_register(&coreboot_bus_type);
+	if (ret)
+		goto out;
+
 	ptr_entry = (void *)ptr_header + header.header_bytes;
 	for (i = 0; i < header.table_entries; i++) {
 		memcpy_fromio(&entry, ptr_entry, sizeof(entry));
@@ -138,6 +136,10 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 		ptr_entry += entry.size;
 	}
+
+	if (ret)
+		bus_unregister(&coreboot_bus_type);
+
 out:
 	iounmap(ptr);
 	return ret;
-- 
Sent by a computer through tubes

