Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A35C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA7208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA7208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934944AbeFRO0k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:26:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbeFRO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:26:38 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNtBT-1fainn1YEt-007VMA; Mon, 18 Jun 2018 16:26:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mic: fix passing the current time
Date:   Mon, 18 Jun 2018 16:25:51 +0200
Message-Id: <20180618142624.3641299-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:LlGz/0+eBWAOVkGPYqwGwdQQZZxxc4MeCg6LsYSlFO5X47mlixo
 hnOMtMUIZO4w5pnRj1GSGFRRedZt4fJRB03PZsAEN8xQlh03ICJ6t9uvEXoERQPjVpX0uSL
 vLcGEyj1xEBBJ6vJ+fnbX6bTq6KY5xtczktUGf1HdqNxuVM8ABU0yvAQsiUdG91TzNV7q8J
 9RKyhj723gbKs2jQy/W5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8h+7ee0I9uQ=:5Y/nqSLEsEydq+azD2iWei
 uf6JU3s4Kg6Kq2v3fSnxYEIJ2rQgdxLoyRncTI5VqeYxAMPN1Vl3z6sH85bjX4hFUk3OV3Fgb
 jg7DK0oTdGT5QHZxuPHfp+8zXgeMqEuCuFkKbAtqTT5ntw6naM5/3jiKK1pnix9pv0AyIvI1f
 5Ph3gU50oR7ADIf57mfumuy1RyjcgiWbYFYhWMjmd8Et7xCC/hGVBw7mHDfAi6Qonyk1m+4nh
 4gYmZw8DCs276Qrz706zrZI6Gudyf11csjF0Q4tEefXZIkEbSPxTyIYBE+xezm2ZkrirQ0FBS
 ndtFPCZsiMoWtxnlp9ql1VdqSSHa3VXw7GblHOr0SJZqd8s4B0GrvlxYvCGSX8eCuL1O3keii
 FxNB3S8gTg6NuBHapdaiexKaRWD1XhySyHZry1S3CAGvCtCFuyWGGXXl+9iLfUdKR6GFoPCgS
 kbsAykhKYII2YhtKTiB+0PAO5h/HEu9/kj2Yds99jP3fwuLiquocAyh+uYCom2ByDB70T5hHr
 rAGR2YPuqbMs612jCkshGmyavXmok/CLNV7x+Un13d2EXOqzXm7GpbxiEG+5FWyDPexSBpmDo
 35IBWgq6cCDTRkIVjc8tx6zsgb/M3B7GFgxxbCzKXhs9P7qg8z0EntE0shG9YcHg5K4abICSu
 Kmf2M/d9pKXJWmZsCyY8EmnNeaBxwa2nQNImL4wNNCysq8+sHchnd76Y5CWx8iNAdJeI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the mic driver passes a 'struct timespec64' as part of
a message into an attached device, where it is used to set the current
system time.

This won't actually work if one of the two sides runs a 32-bit kernel and
the other runs a 64-bit kernel, since the structure layout is different
between the two.

I found this while replacing calls to the deprecated do_settimeofday64()
interface with the modern ktime_get_real_ts() variant, but it seems
appropriate to address both at the same time here.

To make sure we have a sane structure, let's define our own structure
using the layout of the 64-bit kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/mic/cosm/cosm_main.h               | 5 ++++-
 drivers/misc/mic/cosm/cosm_scif_server.c        | 6 +++++-
 drivers/misc/mic/cosm_client/cosm_scif_client.c | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mic/cosm/cosm_main.h b/drivers/misc/mic/cosm/cosm_main.h
index f01156fca881..aa78cdf25e40 100644
--- a/drivers/misc/mic/cosm/cosm_main.h
+++ b/drivers/misc/mic/cosm/cosm_main.h
@@ -45,7 +45,10 @@ struct cosm_msg {
 	u64 id;
 	union {
 		u64 shutdown_status;
-		struct timespec64 timespec;
+		struct {
+			u64 tv_sec;
+			u64 tv_nsec;
+		} timespec;
 	};
 };
 
diff --git a/drivers/misc/mic/cosm/cosm_scif_server.c b/drivers/misc/mic/cosm/cosm_scif_server.c
index 05a63286741c..e94b7eac4a06 100644
--- a/drivers/misc/mic/cosm/cosm_scif_server.c
+++ b/drivers/misc/mic/cosm/cosm_scif_server.c
@@ -179,9 +179,13 @@ static void cosm_set_crashed(struct cosm_device *cdev)
 static void cosm_send_time(struct cosm_device *cdev)
 {
 	struct cosm_msg msg = { .id = COSM_MSG_SYNC_TIME };
+	struct timespec64 ts;
 	int rc;
 
-	getnstimeofday64(&msg.timespec);
+	ktime_get_real_ts64(&ts);
+	msg.timespec.tv_sec = ts.tv_sec;
+	msg.timespec.tv_nsec = ts.tv_nsec;
+
 	rc = scif_send(cdev->epd, &msg, sizeof(msg), SCIF_SEND_BLOCK);
 	if (rc < 0)
 		dev_err(&cdev->dev, "%s %d scif_send failed rc %d\n",
diff --git a/drivers/misc/mic/cosm_client/cosm_scif_client.c b/drivers/misc/mic/cosm_client/cosm_scif_client.c
index beafc0da4027..225078cb51fd 100644
--- a/drivers/misc/mic/cosm_client/cosm_scif_client.c
+++ b/drivers/misc/mic/cosm_client/cosm_scif_client.c
@@ -63,7 +63,11 @@ static struct notifier_block cosm_reboot = {
 /* Set system time from timespec value received from the host */
 static void cosm_set_time(struct cosm_msg *msg)
 {
-	int rc = do_settimeofday64(&msg->timespec);
+	struct timespec64 ts = {
+		.tv_sec = msg->timespec.tv_sec,
+		.tv_nsec = msg->timespec.tv_nsec,
+	};
+	int rc = do_settimeofday64(&ts);
 
 	if (rc)
 		dev_err(&client_spdev->dev, "%s: %d settimeofday rc %d\n",
-- 
2.9.0

