Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA2BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDCF20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDCF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeKLGSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:18:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50570 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730486AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsh-0000oN-ID; Sun, 11 Nov 2018 19:58:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001rS-8d; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jonathan Cameron" <jic23@kernel.org>,
        "Alison Schofield" <amsfield22@gmail.com>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.462769652@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 340/366] iio: iio-trig-periodic-rtc: Free trigger
 resource  correctly
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This is based on upstream commit 10e840dfb0b7, which did not touch the
iio-trig-periodic-rtc driver because it has been removed upstream.

The following explanation comes from that commit:

    These stand-alone trigger drivers were using iio_trigger_put()
    where they should have been using iio_trigger_free().  The
    iio_trigger_put() adds a module_put which is bad since they
    never did a module_get.

    In the sysfs driver, module_get/put's are used as triggers are
    added & removed. This extra module_put() occurs on an error path
    in the probe routine (probably rare).

    In the bfin-timer & interrupt trigger drivers, the module resources
    are not explicitly managed, so it's doing a put on something that
    was never get'd.  It occurs on the probe error path and on the
    remove path (not so rare).

    Tested with the sysfs trigger driver.
    The bfin & interrupt drivers were build tested & inspected only.

This was build tested only.

Cc: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -123,7 +123,7 @@ static int iio_trig_periodic_rtc_probe(s
 		trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
 		if (!trig_info) {
 			ret = -ENOMEM;
-			goto error_put_trigger_and_remove_from_list;
+			goto error_free_trigger_and_remove_from_list;
 		}
 		iio_trigger_set_drvdata(trig, trig_info);
 		trig->ops = &iio_prtc_trigger_ops;
@@ -151,9 +151,9 @@ error_close_rtc:
 	rtc_class_close(trig_info->rtc);
 error_free_trig_info:
 	kfree(trig_info);
-error_put_trigger_and_remove_from_list:
+error_free_trigger_and_remove_from_list:
 	list_del(&trig->alloc_list);
-	iio_trigger_put(trig);
+	iio_trigger_free(trig);
 error_free_completed_registrations:
 	list_for_each_entry_safe(trig,
 				 trig2,

