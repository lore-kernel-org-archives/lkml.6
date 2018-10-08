Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680AC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814F92089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfeAwpeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814F92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeJIBrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeJIBrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EABD2089D;
        Mon,  8 Oct 2018 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023642;
        bh=3W8/WV/y9xmG6JxMVr3ferq4BdwMLue3Ry49G2tHw6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfeAwpeKen71EYCdEENVNijZbK4z79cQ8w0ztB0weOtGWsizkNzRIVebb3ukjtOze
         rpKXCs/sCPBnJeLpi2um8PFW7SvOHlc8QRtECvG5EvbeHPL6RMAqspv59ULQJ5Gb9g
         tKJIDyuLPtvfLUHwroHH8XA07lpxEUvLqlqNtu+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 034/113] wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
Date:   Mon,  8 Oct 2018 20:30:35 +0200
Message-Id: <20181008175532.496930196@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4ec7cece87b3ed21ffcd407c62fb2f151a366bc1 ]

Otherwise we can get:

WARNING: CPU: 0 PID: 55 at drivers/net/wireless/ti/wlcore/io.h:84

I've only seen this few times with the runtime PM patches enabled
so this one is probably not needed before that. This seems to
work currently based on the current PM implementation timer. Let's
apply this separately though in case others are hitting this issue.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wlcore/cmd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -35,6 +35,7 @@
 #include "wl12xx_80211.h"
 #include "cmd.h"
 #include "event.h"
+#include "ps.h"
 #include "tx.h"
 #include "hw_ops.h"
 
@@ -191,6 +192,10 @@ int wlcore_cmd_wait_for_event_or_timeout
 
 	timeout_time = jiffies + msecs_to_jiffies(WL1271_EVENT_TIMEOUT);
 
+	ret = wl1271_ps_elp_wakeup(wl);
+	if (ret < 0)
+		return ret;
+
 	do {
 		if (time_after(jiffies, timeout_time)) {
 			wl1271_debug(DEBUG_CMD, "timeout waiting for event %d",
@@ -222,6 +227,7 @@ int wlcore_cmd_wait_for_event_or_timeout
 	} while (!event);
 
 out:
+	wl1271_ps_elp_sleep(wl);
 	kfree(events_vector);
 	return ret;
 }


