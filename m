Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7457320893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457320893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbeG1X1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:27:49 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:48506
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731332AbeG1X1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:27:49 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id jXEgfS03Kq9i0jXEgfFIen; Sat, 28 Jul 2018 14:58:50 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fjXEg-0003bj-CJ; Sat, 28 Jul 2018 14:58:50 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/4] Drivers: hv: vmbus: Get rid of MSR access from vmbus_drv.c
Date:   Sat, 28 Jul 2018 21:58:47 +0000
Message-Id: <20180728215848.13814-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180728215848.13814-1-kys@linuxonhyperv.com>
References: <20180728215630.13712-1-kys@linuxonhyperv.com>
 <20180728215848.13814-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfL7SP7eMaKUZNjKYJS1av4w7hgNlnZjGtZqIGBQA9Q60Fhyn5ipWTRwLFvANSpwri2VMFUydoPg5btRUIo0GvHX5Jkq7h6TQyMIJhsl95LzbnXBeLvgg
 MoF8+NrRDS9ug93l3AtA5rfGi1flmJFezml+XhJn4RaDLGVgIJKrF4n7EsyF5tBkj2b/9vtDkzPsublWR6sUUR456v9RrjBXkUdheV7pbFdwukN0QNQYI6KT
 fJnYd/NsYB5/E02H0BS93yduFviSrL82rmExgk3mBji5z2mzIVXiFu4uQXsRUA4Hvme0dklK+jWwCODhEWuX9Tzt6CTTu4HegpZgcB/4mP5j46d9Wr5R59J5
 rGOJFT0TVQCn78W63tT0NZ2heA3RCgyjM+9EPmTS+U4GgFedAcMV5eWXTpCwco1DXF9qx1HNtOaX2M32LooVoLwd11GW5SCr0fgLL4Y7qt6oY095058+PGSm
 X5iuDgS1g6gyjhyfSz+lLjh/tGrxbZLZO8DJ2naJuAKxj6gXJnQ4T6VEGnXkzS7+nYS8BfXjYTvqOJeIiP7hYTGRoFPchNAHcMgeGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Get rid of ISA specific code from vmus_drv.c which is common code.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 3 +++
 drivers/hv/vmbus_drv.c          | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 156a2e5a97a9..b731c4bf70ed 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -96,6 +96,9 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 #define hv_set_synint_state(int_num, val) \
 	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
 
+#define hv_get_crash_ctl(val) \
+	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
+
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
 #ifdef CONFIG_TRACING
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5e946b1be54c..db145e1a7049 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1146,7 +1146,7 @@ static int vmbus_bus_init(void)
 		 * Register for panic kmsg callback only if the right
 		 * capability is supported by the hypervisor.
 		 */
-		rdmsrl(HV_X64_MSR_CRASH_CTL, hyperv_crash_ctl);
+		hv_get_crash_ctl(hyperv_crash_ctl);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
 			hv_panic_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (hv_panic_page) {
-- 
2.17.1

