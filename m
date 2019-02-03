Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF3C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC772073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfBCOcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:32:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728568AbfBCOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:50 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIce-00062g-Nk; Sun, 03 Feb 2019 14:19:48 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007Ip-Fg; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Dexuan Cui" <decui@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.158525199@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 235/305] Drivers: hv: vmbus: check the
 creation_status in vmbus_establish_gpadl()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit eceb05965489784f24bbf4d61ba60e475a983016 upstream.

This is a longstanding issue: if the vmbus upper-layer drivers try to
consume too many GPADLs, the host may return with an error
0xC0000044 (STATUS_QUOTA_EXCEEDED), but currently we forget to check
the creation_status, and hence we can pass an invalid GPADL handle
into the OPEN_CHANNEL message, and get an error code 0xc0000225 in
open_info->response.open_result.status, and finally we hang in
vmbus_open() -> "goto error_free_info" -> vmbus_teardown_gpadl().

With this patch, we can exit gracefully on STATUS_QUOTA_EXCEEDED.

Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hv/channel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -416,6 +416,14 @@ int vmbus_establish_gpadl(struct vmbus_c
 	}
 	wait_for_completion(&msginfo->waitevent);
 
+	if (msginfo->response.gpadl_created.creation_status != 0) {
+		pr_err("Failed to establish GPADL: err = 0x%x\n",
+		       msginfo->response.gpadl_created.creation_status);
+
+		ret = -EDQUOT;
+		goto cleanup;
+	}
+
 	/* At this point, we received the gpadl created msg */
 	*gpadl_handle = gpadlmsg->gpadl;
 

