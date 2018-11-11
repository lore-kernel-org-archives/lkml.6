Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0C12148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0C12148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeKLGRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:17:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50678 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730523AbeKLFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000oU-Mz; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qk-VK; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jacek Anaszewski" <j.anaszewski@samsung.com>,
        "Zach Brown" <zach.brown@ni.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Nathan Sullivan" <nathan.sullivan@ni.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.55345034@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 331/366] leds: do not overflow sysfs buffer in
 led_trigger_show
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Sullivan <nathan.sullivan@ni.com>

commit 3b9b95363c45365d606ad4bbba16acca75fdf6d3 upstream.

Per the documentation, use scnprintf instead of sprintf to ensure there
is never more than PAGE_SIZE bytes of trigger names put into the
buffer.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/leds/led-triggers.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -78,21 +78,23 @@ ssize_t led_trigger_show(struct device *
 	down_read(&led_cdev->trigger_lock);
 
 	if (!led_cdev->trigger)
-		len += sprintf(buf+len, "[none] ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "[none] ");
 	else
-		len += sprintf(buf+len, "none ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "none ");
 
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (led_cdev->trigger && !strcmp(led_cdev->trigger->name,
 							trig->name))
-			len += sprintf(buf+len, "[%s] ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "[%s] ",
+					 trig->name);
 		else
-			len += sprintf(buf+len, "%s ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "%s ",
+					 trig->name);
 	}
 	up_read(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
 
-	len += sprintf(len+buf, "\n");
+	len += scnprintf(len+buf, PAGE_SIZE - len, "\n");
 	return len;
 }
 EXPORT_SYMBOL_GPL(led_trigger_show);

