Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96222529
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2WwYAKk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C96222529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbeKOI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbeKOI3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3432252D;
        Wed, 14 Nov 2018 22:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234259;
        bh=4ZrRMnOj0JysnbwNjZSrFO4Lg1xbECssh/y7R5GDMjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WwYAKk411TZ571nWcNA6SH0XMAyxXYXfqUxN8bEjoY7V1Fml3QtOGNzjvYiB9ZVM
         zBhOnpU3Wg6C2zNbhuoKgsiksYTjKBQXD/lgxpz+rh0oTAN4c49vwDQZzt+GdIl81L
         BA3EPuUwQa20tomhAsMvneG9LGvgrdohRsnbLty8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.18 22/59] hwmon: (ibmpowernv) Remove bogus __init annotations
Date:   Wed, 14 Nov 2018 17:22:54 -0500
Message-Id: <20181114222335.99339-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit e3e61f01d755188cb6c2dcf5a244b9c0937c258e ]

If gcc decides not to inline make_sensor_label():

    WARNING: vmlinux.o(.text+0x4df549c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label()
    The function .create_device_attrs() references
    the function __init .make_sensor_label().
    This is often because .create_device_attrs lacks a __init
    annotation or the annotation of .make_sensor_label is wrong.

As .probe() can be called after freeing of __init memory, all __init
annotiations in the driver are bogus, and should be removed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ibmpowernv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index f829dadfd5a0..2968d527bdf6 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -129,7 +129,7 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", sdata->label);
 }
 
-static int __init get_logical_cpu(int hwcpu)
+static int get_logical_cpu(int hwcpu)
 {
 	int cpu;
 
@@ -140,9 +140,8 @@ static int __init get_logical_cpu(int hwcpu)
 	return -ENOENT;
 }
 
-static void __init make_sensor_label(struct device_node *np,
-				     struct sensor_data *sdata,
-				     const char *label)
+static void make_sensor_label(struct device_node *np,
+			      struct sensor_data *sdata, const char *label)
 {
 	u32 id;
 	size_t n;
-- 
2.17.1

