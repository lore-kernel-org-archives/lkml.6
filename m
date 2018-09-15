Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D7ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20584214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qz8QoENf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20584214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeIOFyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:54:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeIOFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:54:19 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8F0bR1t046767;
        Fri, 14 Sep 2018 19:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536971847;
        bh=IB39Nnh1RI4spJd8J9S80MU30mSuXvMxoKfq0ImOMGw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qz8QoENf1mqypDLikPBWqqbDexI8Q5dHoKzjbfgD/02p9UTSxp0RoyL5cX6wMBHgs
         hzDp6oSsPxQ7OEivXNKW+fVuMu5M2dm2uaC3zbojDwP8JxDSPAor39ebLOGmxPGtGy
         VeE80mhLywh5pEtvb5Nyx1sGCtONgxtApu3DaRhE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bRZH032375;
        Fri, 14 Sep 2018 19:37:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 19:37:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 19:37:27 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bRDh002123;
        Fri, 14 Sep 2018 19:37:27 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8F0bRx13339;
        Fri, 14 Sep 2018 19:37:27 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/5] remoteproc: Fix unbalanced boot with sysfs for no auto-boot rprocs
Date:   Fri, 14 Sep 2018 19:37:21 -0500
Message-ID: <20180915003725.17549-2-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180915003725.17549-1-s-anna@ti.com>
References: <20180915003725.17549-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remoteproc core performs automatic boot and shutdown of a remote
processor during rproc_add() and rproc_del() for remote processors
supporting 'auto-boot'. The remoteproc devices not using 'auto-boot'
require either a remoteproc client driver or a userspace client to
use the sysfs 'state' variable to perform the boot and shutdown. The
in-kernel client drivers hold the corresponding remoteproc driver
module's reference count when they acquire a rproc handle through
the rproc_get_by_phandle() API, but there is no such support for
userspace applications performing the boot through sysfs interface.

The shutdown of a remoteproc upon removing a remoteproc platform
driver is automatic only with 'auto-boot' and this can cause a
remoteproc with no auto-boot to stay powered on and never freed
up if booted using the sysfs interface without a matching stop,
and when the remoteproc driver module is removed or unbound from
the device. This will result in a memory leak as well as the
corresponding remoteproc ida being never deallocated. Fix this
by holding a module reference count for the remoteproc's driver
during a sysfs 'start' and releasing it during the sysfs 'stop'
operation.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 47be411400e5..2142b3ea726e 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/module.h>
 #include <linux/remoteproc.h>
 
 #include "remoteproc_internal.h"
@@ -100,14 +101,27 @@ static ssize_t state_store(struct device *dev,
 		if (rproc->state == RPROC_RUNNING)
 			return -EBUSY;
 
+		/*
+		 * prevent underlying implementation from being removed
+		 * when remoteproc does not support auto-boot
+		 */
+		if (!rproc->auto_boot &&
+		    !try_module_get(dev->parent->driver->owner))
+			return -EINVAL;
+
 		ret = rproc_boot(rproc);
-		if (ret)
+		if (ret) {
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
+			if (!rproc->auto_boot)
+				module_put(dev->parent->driver->owner);
+		}
 	} else if (sysfs_streq(buf, "stop")) {
 		if (rproc->state != RPROC_RUNNING)
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
+		if (!rproc->auto_boot)
+			module_put(dev->parent->driver->owner);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.18.0

