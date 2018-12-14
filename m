Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62ECC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791287;
	bh=Ri5Uwokb3+UkhLQHIsDBE3eXj2mtEDYgJ8YIGWlTyQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Al6osyd7I81HPW1XdmAnahLsXeECu33lrdD3Vb3ge6ABWz5hadI75jJ3VN/iH6poq
	 H2xZY0HN9nJveY0pnqqejncVzPOI1EVFvQYvmaeqmrLRl8bIY4c5xeTlZdt4Hq6NcZ
	 bo6Tg6/xJZbnZUKeLw0pskIEionUFBJfN9iVjiho=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED6D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeLNMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbeLNMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE162146E;
        Fri, 14 Dec 2018 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789004;
        bh=Ri5Uwokb3+UkhLQHIsDBE3eXj2mtEDYgJ8YIGWlTyQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEPm9ZunkuOeZVAe+DPBkJh37NOKD5WW8uhVpLOU9qaZ2Quje1Kid8ZyL4t+m9v8K
         wbLpDROz3FmT3jPw20yB4ULgTCsHUUSU3w/x0lgMA4hBJTYJdXJmWINJWLlGFI/0lG
         fwRERwphYCGUML4oY+FpMbhM93xAcf1izE1s9WSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/142] hwmon: (mlxreg-fan) Fix macros for tacho fault reading
Date:   Fri, 14 Dec 2018 12:59:02 +0100
Message-Id: <20181214115749.344624477@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



