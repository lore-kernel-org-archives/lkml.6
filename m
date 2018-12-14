Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966D820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791202;
	bh=fsL5r1c7+05fCk1Wbdfmzt1PnC526txupe5XiyhnKCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=owt8J/BlciHEC8RX4USoOUaI3RelznMVVkpGNHcmmljwy1UU4MijpEDjP32I5I34F
	 PdRcwOCBFu/9dHwu+pyGaG+LKy3otXpMyZo/bxo57+S1D/mfGD/6gT3fdq7jhS+ohU
	 7UhAG1XJio6VEflaTLx6/iSAxhuCfCisFwjQ16go=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966D820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeLNMEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbeLNMEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D017D21479;
        Fri, 14 Dec 2018 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789070;
        bh=fsL5r1c7+05fCk1Wbdfmzt1PnC526txupe5XiyhnKCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0MHGJ2twbMj2fw5KGjQojCQx+9w5FgcX3/81zpBoKl3iNd7Br9ppvHfcYYnYAPR3
         mrk2ygqkQiYyTfrRxZYjJH7ZeTXSLdL305ksn+cHa9lrHCSShUuwx85RCygNzgXqNp
         jyQdE0SiYyjby20qBUenX130lt1vE2L99Kjmpkw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/142] fsi: master-ast-cf: select GENERIC_ALLOCATOR
Date:   Fri, 14 Dec 2018 12:59:28 +0100
Message-Id: <20181214115750.382850192@linuxfoundation.org>
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

[ Upstream commit 64999fa7aa2c076ec6d05aee481f11f5296ceb8c ]

In randconfig builds without CONFIG_GENERIC_ALLOCATOR, this driver
fails to link:

ERROR: "gen_pool_alloc_algo" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "gen_pool_fixed_alloc" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "of_gen_pool_get" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "gen_pool_free" [drivers/fsi/fsi-master-ast-cf.ko] undefined!

Select the dependency as all other users do.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index af3a20dd5aa4..99c99a5d57fe 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -46,6 +46,7 @@ config FSI_MASTER_AST_CF
 	tristate "FSI master based on Aspeed ColdFire coprocessor"
 	depends on GPIOLIB
 	depends on GPIO_ASPEED
+	select GENERIC_ALLOCATOR
 	---help---
 	This option enables a FSI master using the AST2400 and AST2500 GPIO
 	lines driven by the internal ColdFire coprocessor. This requires
-- 
2.19.1



