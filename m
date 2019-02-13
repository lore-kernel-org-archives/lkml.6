Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C7C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C45207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027049;
	bh=u29ijz/e6aML/AdxV0H78F+xu+ykR4NiH/5Edk4QpI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7x15f/iWigSSRsFay0x4tLSuKKD2pPNpwsM34VMJ5TUGbZXc//Ns43ZOKLYmPv2b
	 aDIjZ8sSbfvAnviQLwQqi7caCZWpsQQMsjSbeiL8/yPy5QTqtHZJBCYDPvBU89OQe2
	 S98fr5HwazOMpXFMMJNYuRgePwqRhcNrLOTWUQKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbfBMDEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbfBMCeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70E6222C2;
        Wed, 13 Feb 2019 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025248;
        bh=u29ijz/e6aML/AdxV0H78F+xu+ykR4NiH/5Edk4QpI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/rDy5m+8RIgMvqSg042o4BZw6xnbTejggUFLU1csnMqYWNjLxYgjBWjwC1EizCVf
         uHTl0OzXRMDKUBBWx8B1BJrX5XyuaBAQW2mrvsKsvP9Lhn9qgTA+yvyBpdw7Oqs3ra
         88PqinztQMBLI/nRfxjbcn7TKDrO5NAlVFyps/ag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Cook <mcook@mackal.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 030/105] hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D
Date:   Tue, 12 Feb 2019 21:32:21 -0500
Message-Id: <20190213023336.19019-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 9de15c95a63f527c8f7a968cd95e6ec71fc6891d ]

Similar to other recent chips from Nuvoton, IO mapping may be disabled
by default. Enable it when instantiating the driver and after resume.

Fixes: 0599682b826f ("hwmon: (nct6775) Add support for NCT6798D")
Fixes: e41da286a2fd ("hwmon: (nct6775) Add support for NCT6797D")
Reported-by: Michael Cook <mcook@mackal.net>
Cc: Michael Cook <mcook@mackal.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 8f91e366866f..4adec4ab7d06 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4508,7 +4508,8 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 
 	if (data->kind == nct6791 || data->kind == nct6792 ||
 	    data->kind == nct6793 || data->kind == nct6795 ||
-	    data->kind == nct6796)
+	    data->kind == nct6796 || data->kind == nct6797 ||
+	    data->kind == nct6798)
 		nct6791_enable_io_mapping(sioreg);
 
 	superio_exit(sioreg);
@@ -4644,7 +4645,8 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 
 	if (sio_data->kind == nct6791 || sio_data->kind == nct6792 ||
 	    sio_data->kind == nct6793 || sio_data->kind == nct6795 ||
-	    sio_data->kind == nct6796)
+	    sio_data->kind == nct6796 || sio_data->kind == nct6797 ||
+	    sio_data->kind == nct6798)
 		nct6791_enable_io_mapping(sioaddr);
 
 	superio_exit(sioaddr);
-- 
2.19.1

