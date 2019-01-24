Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA44B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360401;
	bh=SiFF3tBoRE/gVXArRvjeZt80ncSFeTkio+VHeLAf0uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dl4hs61jQkkb4W2Olv2ICAJUfHlU9aYIROJ3EEsLXlDUpOQDh3UmuLknU024AL1gt
	 NUWzWEIvuRjSCZwHsV8YlcURcO5tK1gWwYdF4AxNvJ9GreucV3rruPCO1N8KKFUK0d
	 Bg+iUxpIb2lo17w1oRe3fPuwWMNT7wehRPItlaps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfAXUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbfAXTbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:31:05 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.135.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FB421902;
        Thu, 24 Jan 2019 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358264;
        bh=SiFF3tBoRE/gVXArRvjeZt80ncSFeTkio+VHeLAf0uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knA6azSW9Ys9HLEbn6KW4KCV4Bhszm8hFGOXo//0JW5z3zp8SR3YfrBltRJCYD3YF
         BpJON9y+5Xro880RzzLRKMSJxoHtE4euf7Pu/kIw0ovlnf2qhZbGjHYf+PDNBaY6gd
         MyAkYxUJbT7BGf7FWAvPpMdg5gZeWxyIngaE+H8k=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [for next][PATCH v3 2/2] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Thu, 24 Jan 2019 19:31:01 +0000
Message-Id: <20190124193101.24519-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190124193101.24519-1-okaya@kernel.org>
References: <20190124193101.24519-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.

Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:

WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
  Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
  Selected by [y]:
  - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 11810591840d..b5e9db85e881 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1129,6 +1129,7 @@ config INTEL_OAKTRAIL
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
 	depends on ACPI
+	depends on BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.19.0

