Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BD9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45D82173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45D82173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeHHOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:06:46 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:50032 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:06:46 -0400
X-IronPort-AV: E=Sophos;i="5.51,457,1526342400"; 
   d="scan'208";a="62277365"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Gabriel Ercarug <bercarug@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] xen/balloon: fix balloon initialization for PVH Dom0
Date:   Wed, 8 Aug 2018 13:46:41 +0200
Message-ID: <20180808114641.20854-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current balloon code tries to calculate a delta factor for the
balloon target when running in HVM mode in order to account for memory
used by the firmware.

This workaround for memory accounting doesn't work properly on a PVH
Dom0, that has a static-max value different from the target value even
at startup. Note that this is not a problem for DomUs because guests are
started with a static-max value that matches the amount of RAM in the
memory map.

Fix this by forcefully setting target_diff for Dom0, regardless of
it's mode.

Reported-by: Gabriel Bercarug <bercarug@amazon.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Gabriel Ercarug <bercarug@amazon.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/xen-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index b437fccd4e62..294f35ce9e46 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -81,7 +81,7 @@ static void watch_target(struct xenbus_watch *watch,
 			static_max = new_target;
 		else
 			static_max >>= PAGE_SHIFT - 10;
-		target_diff = xen_pv_domain() ? 0
+		target_diff = (xen_pv_domain() || xen_initial_domain()) ? 0
 				: static_max - balloon_stats.target_pages;
 	}
 
-- 
2.18.0

