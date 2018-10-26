Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F26ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9342420869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9342420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeJ0H0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:26:12 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:39102 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeJ0H0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:26:12 -0400
Received: from localhost.localdomain (85-76-71-107-nat.elisa-mobile.fi [85.76.71.107])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 5BDD6300BC;
        Sat, 27 Oct 2018 01:47:18 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: fix out of bounds array access on CN68XX
Date:   Sat, 27 Oct 2018 01:46:34 +0300
Message-Id: <20181026224634.30560-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of interfaces is returned by
cvmx_helper_get_number_of_interfaces(), and the value is used to access
interface_port_count[]. When CN68XX support was added, we forgot
to increase the array size. Fix that.

Fixes: 2c8c3f0201333 ("MIPS: Octeon: Support additional interfaces on CN68XX")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec669eb..6c79e8a16a26 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority) (int pko_port,
 void (*cvmx_override_ipd_port_setup) (int ipd_port);
 
 /* Port count per interface */
-static int interface_port_count[5];
+static int interface_port_count[9];
 
 /**
  * Return the number of interfaces the chip has. Each interface
-- 
2.17.0

