Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37289C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42D20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD42D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeG1X1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:27:49 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47024
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731319AbeG1X1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:27:48 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id jXEgfr8e6dH2EjXEgfTCdH; Sat, 28 Jul 2018 14:58:50 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fjXEg-0003bd-7w; Sat, 28 Jul 2018 14:58:50 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/4] Drivers: hv: vmbus: Fix the issue with freeing up hv_ctl_table_hdr
Date:   Sat, 28 Jul 2018 21:58:46 +0000
Message-Id: <20180728215848.13814-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180728215848.13814-1-kys@linuxonhyperv.com>
References: <20180728215630.13712-1-kys@linuxonhyperv.com>
 <20180728215848.13814-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfEwWbiJ7PUSLMscpTnCdWx8zRMXtbPOuJEo4EZHm8O0ic1As6oXkWIsHROl7O8h0wsER+boxOg1BQozrZczDPG3PoUtdtCcGOOpci2Hk1zl50HjM9mEr
 DSkzZeQByYV9xLl1r461Dbw44U1qq4mboMqQX1URnL3OHwBQNMkgP2w46pw8ZQy1wnM0Khq7DMI6Zf+y8NGlmQ8lxQoyme9yzRjrifg3j8bkOmlVU+rHRGb2
 iIr7B48ippkTepqzRxRuqUDCke2cu/VGOFTY390Ut3O1f2fEF720g65N3Z1AIjxBVCeDeHvnVEba6h4xMlgfsmxFGmZF4wMqS0uaK1eTifstSZ1KKqOJCN0+
 OR4THnG4X8FlmAQ7eWWguqGygwU9ibuD41OezI/OUpGK7W0hJFrfifF6kxxmS5oYzfRmXbTtFd4NNDnvJdhoPgsGEw3v9BTNgBqPCNKkuaGVBgi/7aLm8p7S
 PXC6gwwOsVica+SdiKcHXbreydsycdNsC3o5g0Qr1kuycXYzYyqiG6ts89Od/BszJCZoTVrzvL4WcPJPtI+CgR8O2WeVbDXlWDMuqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

The check to free the Hyper-V control table header was reversed. This
fixes it.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a7f33c1f42c5..5e946b1be54c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1176,11 +1176,8 @@ static int vmbus_bus_init(void)
 
 	bus_unregister(&hv_bus);
 	free_page((unsigned long)hv_panic_page);
-	if (!hv_ctl_table_hdr) {
-		unregister_sysctl_table(hv_ctl_table_hdr);
-		hv_ctl_table_hdr = NULL;
-	}
-
+	unregister_sysctl_table(hv_ctl_table_hdr);
+	hv_ctl_table_hdr = NULL;
 	return ret;
 }
 
@@ -1891,11 +1888,8 @@ static void __exit vmbus_exit(void)
 	}
 
 	free_page((unsigned long)hv_panic_page);
-	if (!hv_ctl_table_hdr) {
-		unregister_sysctl_table(hv_ctl_table_hdr);
-		hv_ctl_table_hdr = NULL;
-	}
-
+	unregister_sysctl_table(hv_ctl_table_hdr);
+	hv_ctl_table_hdr = NULL;
 	bus_unregister(&hv_bus);
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
-- 
2.17.1

