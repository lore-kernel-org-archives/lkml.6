Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11765C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E0A20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfAGDTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:19:35 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:35930 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfAGDTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:19:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,449,1539673200"; 
   d="scan'208";a="25169875"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Jan 2019 20:19:35 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Sun, 6 Jan 2019
 20:20:10 -0700
From:   Joey Zhang <joey.zhang@microchip.com>
To:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Joey Zhang <joey.zhang@microchip.com>
Subject: [PATCH] NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()
Date:   Mon, 7 Jan 2019 11:12:56 +0800
Message-ID: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NTB peer host crashes or reboots, the NTB transport link will be
down and the MWs of NTB transport will be invalid. But the
ntb_transport_link_cleanup() does not free these invalid MWs. When
the NTB peer host is recovered later, NTB transport link will be
up and the ntb_set_mw() will not reset up MWs. Because the MWs of
NTB transport are invalid, the NTB transport will not work.

We can fix it by freeing MWs when NTB transport link is down, then
the ntb_set_mw() will reset up MWs when NTB transport link is up.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3bfdb45..6e8902d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	if (!nt->link_is_up)
 		cancel_delayed_work_sync(&nt->link_work);
 
+	for (i = 0; i < nt->mw_count; i++)
+		ntb_free_mw(nt, i);
+
 	/* The scratchpad registers keep the values if the remote side
 	 * goes down, blast them now to give them a sane value the next
 	 * time they are accessed
-- 
2.7.4

