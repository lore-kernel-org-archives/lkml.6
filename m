Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BDDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC376206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lluNnrPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC376206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeLEJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbeLEJjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:40 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79FBF20851;
        Wed,  5 Dec 2018 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002779;
        bh=vj8U5IjoyFbHZB2W+rEWthYhv0xtSqjD6K13Hfj+ph0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lluNnrPIm3YwZWWqANF22j9H6DqVJggcyr5LeTn2x256jW046RmhERfy1Sbw/0Htf
         ZpmqpfcVofsz3pb4QvIiM9o94JkQ+1c4phuX458PaTD2LPOWwqiRd2kjAns/gCU1xu
         Q0y9vtBlGZIwe5JKKQ6Ug0omPyB98AfGk22eZeG4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 066/123] fsi: master-ast-cf: select GENERIC_ALLOCATOR
Date:   Wed,  5 Dec 2018 04:34:58 -0500
Message-Id: <20181205093555.5386-66-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
2.17.1

