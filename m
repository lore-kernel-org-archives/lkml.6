Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23451C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B082086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B082086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJPSuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:50:02 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.21]:35500 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbeJPSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:50:02 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C12131712D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:00:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id CN4mgFM06tz4jCN4wgN84s; Tue, 16 Oct 2018 06:00:08 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:36208 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCN4l-000q4w-T0; Tue, 16 Oct 2018 05:59:48 -0500
Date:   Tue, 16 Oct 2018 12:59:44 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dimitri Sivanich <sivanich@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drivers/misc/sgi-gru: fix Spectre v1 vulnerability
Message-ID: <20181016105944.GA27135@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gCN4l-000q4w-T0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:36208
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

req.gid can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

vers/misc/sgi-gru/grukdump.c:200 gru_dump_chiplet_request() warn:
potential spectre issue 'gru_base' [w]

Fix this by sanitizing req.gid before calling macro GID_TO_GRU, which
uses it to index gru_base.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/misc/sgi-gru/grukdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/sgi-gru/grukdump.c b/drivers/misc/sgi-gru/grukdump.c
index 313da31..1540a77 100644
--- a/drivers/misc/sgi-gru/grukdump.c
+++ b/drivers/misc/sgi-gru/grukdump.c
@@ -27,6 +27,9 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <asm/uv/uv_hub.h>
+
+#include <linux/nospec.h>
+
 #include "gru.h"
 #include "grutables.h"
 #include "gruhandles.h"
@@ -196,6 +199,7 @@ int gru_dump_chiplet_request(unsigned long arg)
 	/* Currently, only dump by gid is implemented */
 	if (req.gid >= gru_max_gids)
 		return -EINVAL;
+	req.gid = array_index_nospec(req.gid, gru_max_gids);
 
 	gru = GID_TO_GRU(req.gid);
 	ubuf = req.buf;
-- 
2.7.4

