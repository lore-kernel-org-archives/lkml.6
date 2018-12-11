Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE1DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9D20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542950;
	bh=L5F6tSQ6qDPunY/pcqoyPD0FZJPtkQcHtDgvjeHg2WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DqNbHecKGOawkHoK9Tnduok8IW+NW3Q99jTk9wZdEXFy+qsoieX2rI8JVOKv/F6dN
	 /ZC+3wKGycchX3DoIRLLCDXq0kbhm3JlZXQLW7ciYWu3tkM5cnn+8CrwL7mDiWNqbR
	 zt5wf9VA8W2Wz6KkpLYlefHAwUzdyDvjiAK3yZT0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeLKPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbeLKPm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D530020672;
        Tue, 11 Dec 2018 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542948;
        bh=L5F6tSQ6qDPunY/pcqoyPD0FZJPtkQcHtDgvjeHg2WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrpAVkuyI/Kouoxkzd8iOShlpQ+j0uEpHTiuKhZnmtRSAJOvhryJStswGWdP5cv72
         lWQsk7npgO/pPiGVxDf9vZM+/6bFtwt5y5a4SyvfLj+AIGPjaApWTwA5vAFUqgxFCA
         5GVhIQWI4SlnrRCm7T/nF+4AgzWYNmIbDQRkpnr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 01/54] Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"
Date:   Tue, 11 Dec 2018 16:40:49 +0100
Message-Id: <20181211151546.074391484@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit cbc56a12da05d5333a9020c4d7854ad7d0b5a31d which was
upstream commit 4ec7cece87b3ed21ffcd407c62fb2f151a366bc1.

>From Dietmar May's report on the stable mailing list
(https://www.spinics.net/lists/stable/msg272201.html):

> I've run into some problems which appear due to (a) recent patch(es) on
> the wlcore wifi driver.
>
> 4.4.160 - commit 3fdd34643ffc378b5924941fad40352c04610294
> 4.9.131 - commit afeeecc764436f31d4447575bb9007732333818c
>
> Earlier versions (4.9.130 and 4.4.159 - tested back to 4.4.49) do not
> exhibit this problem. It is still present in 4.9.141.
>
> master as of 4.20.0-rc4 does not exhibit this problem.
>
> Basically, during client association when in AP mode (running hostapd),
> handshake may or may not complete following a noticeable delay. If
> successful, then the driver fails consistently in warn_slowpath_null
> during disassociation. If unsuccessful, the wifi client attempts multiple
> times, sometimes failing repeatedly. I've had clients unable to connect
> for 3-5 minutes during testing, with the syslog filled with dozens of
> backtraces. syslog details are below.
>
> I'm working on an embedded device with a TI 3352 ARM processor and a
> murata wl1271 module in sdio mode. We're running a fully patched ubuntu
> 18.04 ARM build, with a kernel built from kernel.org's stable/linux repo <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.9.y&id=afeeecc764436f31d4447575bb9007732333818c>.
> Relevant parts of the kernel config are included below.
>
> The commit message states:
>
> > /I've only seen this few times with the runtime PM patches enabled so
> > this one is probably not needed before that. This seems to work
> > currently based on the current PM implementation timer. Let's apply
> > this separately though in case others are hitting this issue./
> We're not doing anything explicit with power management. The device is an
> IoT edge gateway with battery backup, normally running on wall power. The
> battery is currently used solely to shut down the system cleanly to avoid
> filesystem corruption.
>
> The device tree is configured to keep power in suspend; but the device
> should never suspend, so in our case, there is no need to call
> wl1271_ps_elp_wakeup() or wl1271_ps_elp_sleep(), as occurs in the patch.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wlcore/cmd.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -35,7 +35,6 @@
 #include "wl12xx_80211.h"
 #include "cmd.h"
 #include "event.h"
-#include "ps.h"
 #include "tx.h"
 #include "hw_ops.h"
 
@@ -188,10 +187,6 @@ int wlcore_cmd_wait_for_event_or_timeout
 
 	timeout_time = jiffies + msecs_to_jiffies(WL1271_EVENT_TIMEOUT);
 
-	ret = wl1271_ps_elp_wakeup(wl);
-	if (ret < 0)
-		return ret;
-
 	do {
 		if (time_after(jiffies, timeout_time)) {
 			wl1271_debug(DEBUG_CMD, "timeout waiting for event %d",
@@ -223,7 +218,6 @@ int wlcore_cmd_wait_for_event_or_timeout
 	} while (!event);
 
 out:
-	wl1271_ps_elp_sleep(wl);
 	kfree(events_vector);
 	return ret;
 }


