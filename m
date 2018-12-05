Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F9BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C02084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG/Dc461"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1C02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeLEJiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbeLEJiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:08 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E5920851;
        Wed,  5 Dec 2018 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002688;
        bh=0ZefGoi3mAi713UDVgSZQV/lZD0dS2DOhEe0eXzxV9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pG/Dc461PjKMTJBugbEESUyi7kOBHsuDC7ef2vTfz4+XyiN9uu0V5Wa9nBGA1qypl
         MfK0Xxy9gka/4ZNuz0hedK1P6SwzWu0e838jphNhyoqENY1hOnG0NeUotv5p0ow4PH
         7lWGYVQLI8P6R3STTFSdznk6m2n9EcVBOA+w3EIY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 039/123] hwmon: (mlxreg-fan) Fix macros for tacho fault reading
Date:   Wed,  5 Dec 2018 04:34:31 -0500
Message-Id: <20181205093555.5386-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit 243cfe3fb8978c7eec24511aba7dac98819ed896 ]

Fix macros for tacometer fault reading.
This fix is relevant for three Mellanox systems MQMB7, MSN37, MSN34,
which are about to be released to the customers.
At the moment, none of them is at customers sites.

Fixes: 65afb4c8e7e4 ("hwmon: (mlxreg-fan) Add support for Mellanox FAN driver")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/mlxreg-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index de46577c7d5a..d8fa4bea4bc8 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -51,7 +51,7 @@
  */
 #define MLXREG_FAN_GET_RPM(rval, d, s)	(DIV_ROUND_CLOSEST(15000000 * 100, \
 					 ((rval) + (s)) * (d)))
-#define MLXREG_FAN_GET_FAULT(val, mask) (!!((val) ^ (mask)))
+#define MLXREG_FAN_GET_FAULT(val, mask) (!((val) ^ (mask)))
 #define MLXREG_FAN_PWM_DUTY2STATE(duty)	(DIV_ROUND_CLOSEST((duty) *	\
 					 MLXREG_FAN_MAX_STATE,		\
 					 MLXREG_FAN_MAX_DUTY))
-- 
2.17.1

