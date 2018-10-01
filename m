Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003AC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF77F2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF77F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=innovation.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJAJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:36:03 -0400
Received: from chill.innovation.ch ([216.218.245.220]:60694 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeJAJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:36:03 -0400
Date:   Sun, 30 Sep 2018 19:53:13 -0700
From:   Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/sbshc: Fix rare oops when removing modules.
Message-ID: <20181001025313.GA9144@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a small race when removing the sbshc module where
smbus_alarm() had queued acpi_smbus_callback() for deferred execution
but it hadn't been run yet, so that when it did run hc had been freed
and the module unloaded, resulting in an invalid paging request.

A similar race existed when removing the sbs module with regards to
acpi_sbs_callback() (which is called from acpi_smbus_callback()).

We therefore need to ensure no callbacks are pending or executing before
the cleanups are done and the modules are removed.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/acpi/osl.c   | 1 +
 drivers/acpi/sbshc.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8df9abfa947b..9d139727f164 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1129,6 +1129,7 @@ void acpi_os_wait_events_complete(void)
 	flush_workqueue(kacpid_wq);
 	flush_workqueue(kacpi_notify_wq);
 }
+EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
 struct acpi_hp_work {
 	struct work_struct work;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 7a3431018e0a..5008ead4609a 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -196,6 +196,7 @@ int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc)
 	hc->callback = NULL;
 	hc->context = NULL;
 	mutex_unlock(&hc->lock);
+	acpi_os_wait_events_complete();
 	return 0;
 }
 
@@ -292,6 +293,7 @@ static int acpi_smbus_hc_remove(struct acpi_device *device)
 
 	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
+	acpi_os_wait_events_complete();
 	kfree(hc);
 	device->driver_data = NULL;
 	return 0;
-- 
2.17.1

