Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 437DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDED2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p0+Os1tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDED2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbeFLU4j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6029 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeFLU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836995; x=1560372995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0F1GfjZPIl4k7H/vkwsKAphOOqwq532rc/1rL93kMSg=;
  b=p0+Os1tnFnJSGqqvMjoccerrRGBaBNQdiuvTiXFKfe3Fek42U6N0adRI
   Ine32Q4uELpXO5qTJA3nrw8My1v3RJConGWWEMB+DSIyEX/a/hNY6b5q7
   04mncv1byNXY4LaiNd7BcUqy81TEPELvK30csxb1YuNuAshQGbygu+ZFx
   k=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="736713942"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuT1J117272
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:32 GMT
Received: from EX13D16UWB003.ant.amazon.com (10.43.161.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:28 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D16UWB003.ant.amazon.com (10.43.161.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:27 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.62.226)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:27 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 02/12] xen/manage: introduce helper function to know the on-going suspend mode
Date:   Tue, 12 Jun 2018 20:56:09 +0000
Message-ID: <20180612205619.28156-3-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Introduce simple functions which help to know the on-going suspend mode
so that other Xen-related code can behave differently according to the
current suspend mode.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Alakesh Haloi <alakeshh@amazon.com>
Reviewed-by: Sebastian Biemueller <sbiemue@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/xen/manage.c  | 15 +++++++++++++++
 include/xen/xen-ops.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 8f9ea87..326631d 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -50,6 +50,21 @@ enum suspend_modes {
 /* Protected by pm_mutex */
 static enum suspend_modes suspend_mode = NO_SUSPEND;
 
+bool xen_suspend_mode_is_xen_suspend(void)
+{
+	return suspend_mode == XEN_SUSPEND;
+}
+
+bool xen_suspend_mode_is_pm_suspend(void)
+{
+	return suspend_mode == PM_SUSPEND;
+}
+
+bool xen_suspend_mode_is_pm_hibernation(void)
+{
+	return suspend_mode == PM_HIBERNATION;
+}
+
 struct suspend_info {
 	int cancelled;
 };
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index fd23e42..be78f6f 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -39,6 +39,10 @@ u64 xen_steal_clock(int cpu);
 
 int xen_setup_shutdown_event(void);
 
+bool xen_suspend_mode_is_xen_suspend(void);
+bool xen_suspend_mode_is_pm_suspend(void);
+bool xen_suspend_mode_is_pm_hibernation(void);
+
 extern unsigned long *xen_contiguous_bitmap;
 
 #ifdef CONFIG_XEN_PV
-- 
2.7.4

