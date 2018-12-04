Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8428CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACE82087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ObxvGFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACE82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeLDLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbeLDLD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0782C2151B;
        Tue,  4 Dec 2018 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921408;
        bh=IxbbE8dcJrIOtzZW8j9C0cg0oDGiNE+i9R6YANUc6aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ObxvGFO5uWb1xUD4lUeaJW+0ss9GGhpRyJMKpRCl2wqs49ZAEut8cVxLptdS+nZg
         J8hCOp3FWHR5lg+xfxioDttUIjXlnNjVl/mCwshQeLqjrmYdeffAsESqkWlSx//PNM
         5GOGCTiM9MeLnoy9mp/duce85PEmii988Hi0PAH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 058/146] Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"
Date:   Tue,  4 Dec 2018 11:49:04 +0100
Message-Id: <20181204103729.177459344@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit e87efc44dd36ba3db59847c418354711ebad779b which was
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
---
 drivers/net/wireless/ti/wlcore/cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index f48c3f62966d..761cf8573a80 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -35,7 +35,6 @@
 #include "wl12xx_80211.h"
 #include "cmd.h"
 #include "event.h"
-#include "ps.h"
 #include "tx.h"
 #include "hw_ops.h"
 
@@ -192,10 +191,6 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
 
 	timeout_time = jiffies + msecs_to_jiffies(WL1271_EVENT_TIMEOUT);
 
-	ret = wl1271_ps_elp_wakeup(wl);
-	if (ret < 0)
-		return ret;
-
 	do {
 		if (time_after(jiffies, timeout_time)) {
 			wl1271_debug(DEBUG_CMD, "timeout waiting for event %d",
@@ -227,7 +222,6 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
 	} while (!event);
 
 out:
-	wl1271_ps_elp_sleep(wl);
 	kfree(events_vector);
 	return ret;
 }
-- 
2.17.1



