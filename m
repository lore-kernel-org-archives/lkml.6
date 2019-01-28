Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E53C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D762147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690531;
	bh=hEWeGcNmoAXI+GIMZRtqX+cE47RhwELIaJPB4PTWdbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HI9qNelABs+KHxiOJkxgsxExCS/df8ox+kf5rooi3vUPCHM6b110soIFgS11vhtEz
	 k/38b4DVBk1z91c/QhFST4dUDUMMPEhpq+k+Nx9V1euJcZE2KA78G/MEIq0EoOfS3H
	 +eusZ8mfkgrCDLxw5qFTUXYH3OI+E+u8tRK2VYf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfA1Psu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfA1Psp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:48:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D2821741;
        Mon, 28 Jan 2019 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690524;
        bh=hEWeGcNmoAXI+GIMZRtqX+cE47RhwELIaJPB4PTWdbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPYixZwDED29Jj+650I0cm8tAU72b/rgDlgWkEl7hNb62Zn2ltIu/TDBIQlN5Ui9/
         zulPYfeqlNklXnHLHRTqzeoN4eRcYrr2wF/wr6ORxg9rQS8dAOUQ6fm40nVRfLDD0T
         Ze5B93k/1tCZ3webyvSOJZPc3K4sB/Ct/YnOqfjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 112/304] spi: fix spi-at91-usart.c build errors when PINCTRL is not set
Date:   Mon, 28 Jan 2019 10:40:29 -0500
Message-Id: <20190128154341.47195-112-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c2b142cc3939e932d4fa2210c2a5155df5736590 ]

Fix build errors when CONFIG_PINCTRL is not enabled.
The header file <linux/pinctrl/consumer.h> handles both CONFIG_PINCTRL
enabled and disabled cases.

  CC [M]  drivers/spi/spi-at91-usart.o
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_suspend':
../drivers/spi/spi-at91-usart.c:409:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_sleep_state(dev);
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_resume':
../drivers/spi/spi-at91-usart.c:419:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_default_state(dev);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..08bcbd1f9aa2 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
-- 
2.19.1

