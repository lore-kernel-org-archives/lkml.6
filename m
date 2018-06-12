Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF7F3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C20E20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BxclWojv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C20E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeFLU4u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:31588 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeFLU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528837003; x=1560373003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bYmNmCUIJbwg50VlZ0yhSQ9hf2/oIpgURH04cgg2wsA=;
  b=BxclWojvSlkmK0HuFZjTO58LF1cDecQsioipcijylgAXHfGL+qnBzIgF
   u9+uNhvYVMcjhXlMQOPzPg6BR8SnuNzdPz9cPYD1aOLhExFmA2Lyasyy6
   8JJt/MxOKMh0ypuMNdJJId6KarXA71nrwfxZkhJM/iItlLsb3r2oq9yFe
   c=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="682679289"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKucc6020809
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:38 GMT
Received: from EX13D07UWB004.ant.amazon.com (10.43.161.196) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D07UWB004.ant.amazon.com (10.43.161.196) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:35 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:34 +0000
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
Subject: [RFC PATCH 08/12] xen-time-introduce-xen_-save-restore-_steal_clock
Date:   Tue, 12 Jun 2018 20:56:15 +0000
Message-ID: <20180612205619.28156-9-anchalag@amazon.com>
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

Currently, steal time accounting code in scheduler expects steal clock
callback to provide monotonically increasing value. If the accounting
code receives a smaller value than previous one, it uses a negative
value to calculate steal time and results in incorrectly updated idle
and steal time accounting. This breaks userspace tools which read
/proc/stat.

top - 08:05:35 up  2:12,  3 users,  load average: 0.00, 0.07, 0.23
Tasks:  80 total,   1 running,  79 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.0%sy,  0.0%ni,30100.0%id,  0.0%wa,  0.0%hi, 0.0%si,-1253874204672.0%st

This can actually happen when a Xen PVHVM guest gets restored from
hibernation, because such a restored guest is just a fresh domain from
Xen perspective and the time information in runstate info starts over
from scratch.

This patch introduces xen_save_steal_clock() which saves current values
in runstate info into per-cpu variables. Its couterpart,
xen_restore_steal_clock(), sets offset if it found the current values in
runstate info are smaller than previous ones. xen_steal_clock() is also
modified to use the offset to ensure that scheduler only sees
monotonically increasing number.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/xen/time.c    | 28 +++++++++++++++++++++++++++-
 include/xen/xen-ops.h |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 3e741cd..4756042 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -20,6 +20,8 @@
 
 /* runstate info updated by Xen */
 static DEFINE_PER_CPU(struct vcpu_runstate_info, xen_runstate);
+static DEFINE_PER_CPU(u64, xen_prev_steal_clock);
+static DEFINE_PER_CPU(u64, xen_steal_clock_offset);
 
 static DEFINE_PER_CPU(u64[4], old_runstate_time);
 
@@ -149,7 +151,7 @@ bool xen_vcpu_stolen(int vcpu)
 	return per_cpu(xen_runstate, vcpu).state == RUNSTATE_runnable;
 }
 
-u64 xen_steal_clock(int cpu)
+static u64 __xen_steal_clock(int cpu)
 {
 	struct vcpu_runstate_info state;
 
@@ -157,6 +159,30 @@ u64 xen_steal_clock(int cpu)
 	return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
 }
 
+u64 xen_steal_clock(int cpu)
+{
+	return __xen_steal_clock(cpu) + per_cpu(xen_steal_clock_offset, cpu);
+}
+
+void xen_save_steal_clock(int cpu)
+{
+	per_cpu(xen_prev_steal_clock, cpu) = xen_steal_clock(cpu);
+}
+
+void xen_restore_steal_clock(int cpu)
+{
+	u64 steal_clock = __xen_steal_clock(cpu);
+
+	if (per_cpu(xen_prev_steal_clock, cpu) > steal_clock) {
+		/* Need to update the offset */
+		per_cpu(xen_steal_clock_offset, cpu) =
+			per_cpu(xen_prev_steal_clock, cpu) - steal_clock;
+	} else {
+		/* Avoid unnecessary steal clock warp */
+		per_cpu(xen_steal_clock_offset, cpu) = 0;
+	}
+}
+
 void xen_setup_runstate_info(int cpu)
 {
 	struct vcpu_register_runstate_memory_area area;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 65f25bd..10330f8 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -36,6 +36,8 @@ void xen_time_setup_guest(void);
 void xen_manage_runstate_time(int action);
 void xen_get_runstate_snapshot(struct vcpu_runstate_info *res);
 u64 xen_steal_clock(int cpu);
+void xen_save_steal_clock(int cpu);
+void xen_restore_steal_clock(int cpu);
 
 int xen_setup_shutdown_event(void);
 
-- 
2.7.4

