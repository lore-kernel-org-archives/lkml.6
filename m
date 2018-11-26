Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5345C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yh/Ik3b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeKZVwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5048D21104;
        Mon, 26 Nov 2018 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229926;
        bh=wN5S2M3AcFqsf1TBGlyzDxns7vaVQXEHLs3A9ghF3Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yh/Ik3b0QhkEG4BDTn54fWP5JByJ+SvaysU94RxjDJcIW54kNSIV9SvYxwzjVw8LL
         6G8uVtg/CqzNCSIXAvS6wLgeACGl/GLTQyK2ztbBuMxSuUJxENh58nL8QV5wN1BKZ8
         9cv/tV1n+LDlh2t/UKGMlZ7W3RRsja7ydzT83Qnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.9 42/46] drivers/misc/sgi-gru: fix Spectre v1 vulnerability
Date:   Mon, 26 Nov 2018 11:51:31 +0100
Message-Id: <20181126105050.061589529@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit fee05f455ceb5c670cbe48e2f9454ebc4a388554 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/sgi-gru/grukdump.c |    4 ++++
 1 file changed, 4 insertions(+)

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
@@ -196,6 +199,7 @@ int gru_dump_chiplet_request(unsigned lo
 	/* Currently, only dump by gid is implemented */
 	if (req.gid >= gru_max_gids)
 		return -EINVAL;
+	req.gid = array_index_nospec(req.gid, gru_max_gids);
 
 	gru = GID_TO_GRU(req.gid);
 	ubuf = req.buf;


