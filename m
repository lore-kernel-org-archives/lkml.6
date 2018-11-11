Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879AC2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879AC2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeKLGEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53000 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:54 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000l4-4Y; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Q8-Vp; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andrew F. Davis" <afd@ti.com>, "Suman Anna" <s-anna@ti.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.537605856@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 051/366] rpmsg: Correct support for MODULE_DEVICE_TABLE()
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

From: "Andrew F. Davis" <afd@ti.com>

commit 5b7d127726de6eed4b900bc3bbb167837690818f upstream.

Due to missing a missing entry in file2alias.c MODULE_DEVICE_TABLE() are
not generating the proper module aliases. Add the needed entry here.

Fixes: bcabbccabffe ("rpmsg: add virtio-based remote processor messaging bus")
Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 14 insertions(+)

--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -136,6 +136,9 @@ int main(void)
 	DEVID(hv_vmbus_device_id);
 	DEVID_FIELD(hv_vmbus_device_id, guid);
 
+	DEVID(rpmsg_device_id);
+	DEVID_FIELD(rpmsg_device_id, name);
+
 	DEVID(i2c_device_id);
 	DEVID_FIELD(i2c_device_id, name);
 
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -884,6 +884,17 @@ static int do_vmbus_entry(const char *fi
 }
 ADD_TO_DEVTABLE("vmbus", hv_vmbus_device_id, do_vmbus_entry);
 
+/* Looks like: rpmsg:S */
+static int do_rpmsg_entry(const char *filename, void *symval,
+			  char *alias)
+{
+	DEF_FIELD_ADDR(symval, rpmsg_device_id, name);
+	sprintf(alias, RPMSG_DEVICE_MODALIAS_FMT, *name);
+
+	return 1;
+}
+ADD_TO_DEVTABLE("rpmsg", rpmsg_device_id, do_rpmsg_entry);
+
 /* Looks like: i2c:S */
 static int do_i2c_entry(const char *filename, void *symval,
 			char *alias)

