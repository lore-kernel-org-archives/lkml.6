Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8AF03C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4206420891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mEQuXVDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934822AbeFLVAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:00:22 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3344 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934091AbeFLU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836997; x=1560372997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wAt5tCtl8i934+pWMAzHn7TQ1fBj1MjwfTCjDanT1zU=;
  b=mEQuXVDav/ZQoovD3cJMr9HPly0mYofxJT0iN6hdFgNon0a9QVRfSr8i
   JTc0Do8NsbkpaWWjgTKJ44jHqwY5m1uXJWyiBwZLUd1UILFm9fgLcDtmL
   jhxeGU8RcYP4aPhFCnmn80uwPsvI6y3U/mEyCgpoAchFrba+aCVj7mxEk
   w=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="347699295"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:33 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuVEL129961
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:31 GMT
Received: from EX13D02UWC003.ant.amazon.com (10.43.162.199) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:31 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D02UWC003.ant.amazon.com (10.43.162.199) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:31 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.60.129)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:30 +0000
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
Subject: [RFC PATCH 04/12] x86/xen: Introduce new function to map HYPERVISOR_shared_info on Resume
Date:   Tue, 12 Jun 2018 20:56:11 +0000
Message-ID: <20180612205619.28156-5-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a small function which re-uses shared page's PA allocated
during guest initialization time in reserve_shared_info() and not
allocate new page during resume flow.
It also  does the mapping of shared_info_page by calling
xen_hvm_init_shared_info() to use the function.

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Sebastian Biemueller <sbiemue@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
CR: https://cr.amazon.com/r/8273203/
---
 arch/x86/xen/enlighten_hvm.c | 7 +++++++
 arch/x86/xen/xen-ops.h       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 754d5391d9fa..2c4bcf92a90a 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -24,6 +24,13 @@
 
 static unsigned long shared_info_pfn;
 
+void xen_hvm_map_shared_info(void)
+{
+	xen_hvm_init_shared_info();
+	if (shared_info_pfn)
+		HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
+}
+
 void xen_hvm_init_shared_info(void)
 {
 	struct xen_add_to_physmap xatp;
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index f377e1820c6c..94c8a009ab35 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -58,6 +58,7 @@ void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
 
 void xen_callback_vector(void);
+void xen_hvm_map_shared_info(void);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
 
-- 
2.14.3

