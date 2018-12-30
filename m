Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2989C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D2621738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546202411;
	bh=wrAYPPOnvAL49A/hLH/LFhI0NHIy36KUnQVQAG6Fyns=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kBY+QcsJJENLExTaiArPw1GhT3PTBTO+GPjpc6RfNIva/HmNrLC2yz/waCsRt3Lsu
	 3diJOLXty/O8gkmJ1MaWXf8jpGpxYKchIU+T5GgFR0dmCNBx3bMW1qSqDX7SXWKFO/
	 AlIPJZ8Euqca/U1jFdigxOfFYmMThZMWLwYVJYNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeL3UkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 15:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeL3UkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 15:40:10 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E66C2075D;
        Sun, 30 Dec 2018 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546202409;
        bh=wrAYPPOnvAL49A/hLH/LFhI0NHIy36KUnQVQAG6Fyns=;
        h=From:To:Cc:Subject:Date:From;
        b=MOuyfDcot4R20w+DZIJjr+TvWb6CptcfH+n5IoIvwc6Tu19RtcGl/uRt+Ii1aSJSW
         4RMJIeqABMHa6NhQRr3Y1H1qXW+W7zwHYbwyL58DHyj6cLlZ4pFAdopn9yB/o/n7ME
         KaQTJSw/g57vs9ghw2gwyYf+zC8rl48s5k/3wJ4I=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: Fix build failure when CONFIG_NLS is set to 'n'
Date:   Sun, 30 Dec 2018 20:40:05 +0000
Message-Id: <20181230204005.6397-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Observing link failure as follows when CONFIG_ACPI is set but
both CONFIG_NLS and CONFIG_PCI are unset.

drivers/acpi/device_sysfs.o: In function `description_show':
device_sysfs.c:(.text+0x48a): undefined reference to `utf16s_to_utf8s'

This issue has been previously fxed by
'commit 8a226e00eeed ("PCI: pci-label: Fix build failure when CONFIG_NLS
is set to 'm' by allmodconfig")' selecting NLS when ACPI is present.

Now that it is possible to have ACPI without PCI, we need an alternative
select statement inside the ACPI kconfig.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7b65a807b3dd..90ff0a47c12e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -10,6 +10,7 @@ menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
 	select PNP
+	select NLS
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
-- 
2.19.0

