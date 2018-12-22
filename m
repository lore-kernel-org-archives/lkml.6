Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE021927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437734;
	bh=siwv04tjtdXgeL0jqAUW7KsgdPS12qH9eR/hz9p9Do8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVu9lQYKHiS2/IHwU6iJa0l7AhjUNzdWpX5dgnWTezk/3atLlQUArTaWUbuWZhClY
	 Hc+d9a+lqMf7hZ8vtO6SZxxHz6G9zsTtgGdCFsxsvf0nqriIyhvxctyLiz5F3NaTgs
	 Szu9Zv0P77h1w/zdToznNRWDQRMKEoJbDtKM9mSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404756AbeLVAPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404708AbeLVAPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:05 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986E22192C;
        Sat, 22 Dec 2018 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437705;
        bh=siwv04tjtdXgeL0jqAUW7KsgdPS12qH9eR/hz9p9Do8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/i+qiwg5K6yJXyURTdIqeptHypAxui//XGO8N6rE8/epZOsZdP3wz2IrbdowttXD
         dKLrGcTVCCTkdg8HsQG1xjRHbM70y/lzFTNG3I4bMvwz5U7LJprICZOYQEd1jjD/Pt
         re3p5av7X8whOviPO+Ur3bKqvxpOE4X7OD7Dpb58=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Date:   Sat, 22 Dec 2018 00:14:47 +0000
Message-Id: <20181222001452.7474-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is scanning PCI bus to find out if it is switchable or not. If
CONFIG_PCI is not set, assume unswitchable.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/apple-gmux.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index fd2ffebc868f..b552b54bf58b 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	 * If Thunderbolt is present, the external DP port is not fully
 	 * switchable. Force its AUX channel to the discrete GPU.
 	 */
+#ifdef CONFIG_PCI
 	gmux_data->external_switchable =
 		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
+#else
+	gmux_data->external_switchable = false;
+#endif
 	if (!gmux_data->external_switchable)
 		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
 
-- 
2.19.0

