Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A72C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502F72089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr354HH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502F72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeKZVx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbeKZVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EA220817;
        Mon, 26 Nov 2018 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229983;
        bh=Yi0TBohtnkDtVN7zU9V101YcpIbHz/s7Q864U2KoYLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nr354HH+rN+aG+1gCb0VAlSdAkbrBvAvaoJ3vMRjyejkp7B9JvVwqGU4kdPOO86nP
         XaIjkzCtmmbtYTbUJuAM0iPCbNqHPpwhG8eynrVbMLYMsRgo5IYAkUAqgKQuCoKhg2
         Nm4p8Vr5mi0wSX0omyT/KdbHccpAaRyedKg0LA0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/62] hwmon: (ibmpowernv) Remove bogus __init annotations
Date:   Mon, 26 Nov 2018 11:51:08 +0100
Message-Id: <20181126105052.996452896@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
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
index 5ccdd0b52650..b38f4951c94e 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -126,7 +126,7 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", sdata->label);
 }
 
-static int __init get_logical_cpu(int hwcpu)
+static int get_logical_cpu(int hwcpu)
 {
 	int cpu;
 
@@ -137,9 +137,8 @@ static int __init get_logical_cpu(int hwcpu)
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



