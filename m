Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F822C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064E320891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OELyrn7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934646AbeFLU4z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1586 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934338AbeFLU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528837004; x=1560373004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Wq/2+Vx2/toTC1g6p4xJBEgO2q4jxfN5wL1oSCQ188U=;
  b=OELyrn7a5C444m/zkra/SzgYH+aJgS/L2LbGoVUcBNHckQq6p65m1GgW
   sfNT2APLAI1cL57ivt9LdVP1UDD6EUZaRbbUEMqpMoo8XM3AQUe0OhItj
   5TPQqRN3SLyv+t5lBJTGXAYvxW/iuInEc+Ptb4p0zR2dTXJ+G9NcHWds5
   Q=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="617032514"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:43 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuewb125665
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:41 GMT
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:38 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:38 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.60.129)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:37 +0000
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
Subject: [RFC PATCH 10/12] xen/events: add xen_shutdown_pirqs helper function
Date:   Tue, 12 Jun 2018 20:56:17 +0000
Message-ID: <20180612205619.28156-11-anchalag@amazon.com>
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

Add a simple helper function to "shutdown" active PIRQs, which actually
closes event channels but keeps related IRQ structures intact. PM
suspend/hibernation code will rely on this.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/xen/events/events_base.c | 12 ++++++++++++
 include/xen/events.h             |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 762378f..88137c8 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1581,6 +1581,18 @@ void xen_irq_resume(void)
 	restore_pirqs();
 }
 
+void xen_shutdown_pirqs(void)
+{
+	struct irq_info *info;
+
+	list_for_each_entry(info, &xen_irq_list_head, list) {
+		if (info->type != IRQT_PIRQ || !VALID_EVTCHN(info->evtchn))
+			continue;
+
+		shutdown_pirq(irq_get_irq_data(info->irq));
+	}
+}
+
 static struct irq_chip xen_dynamic_chip __read_mostly = {
 	.name			= "xen-dyn",
 
diff --git a/include/xen/events.h b/include/xen/events.h
index c3e6bc6..e4d5ccb 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -70,6 +70,7 @@ static inline void notify_remote_via_evtchn(int port)
 void notify_remote_via_irq(int irq);
 
 void xen_irq_resume(void);
+void xen_shutdown_pirqs(void);
 
 /* Clear an irq's pending state, in preparation for polling on it */
 void xen_clear_irq_pending(int irq);
-- 
2.7.4

