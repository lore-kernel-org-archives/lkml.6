Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B75208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="OnMZjFOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B75208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeK1WLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:11:52 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:58685 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeK1WLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543403435; x=1574939435;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Ri20arndQNTFuV6R+3SYIneiawmHlvXWpUTQo19+8+c=;
  b=OnMZjFOp/h+tdqoc+yccMbrCXWMLa5RP2rfQgrfR61HG26g3eOqS81vH
   ITUoUoNeYEPNlK6b7Wv7Tm5uHPaSzqeftAejtHIGMui2DeFxeRgivMH5t
   saJ0eIZOnIn5qSMHJ/PXo09TJ27KpWwdqW98IrPqDSSYtgJMkz5E2dMYA
   k=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="369985763"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Nov 2018 11:10:34 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wASBAReH088435
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 28 Nov 2018 11:10:28 GMT
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 28 Nov 2018 11:10:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 28 Nov 2018 11:10:27 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.95.69.169) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 28 Nov 2018 11:10:23 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        "Nicolai Stange" <nstange@suse.de>,
        Jan Beulich <JBeulich@suse.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] io_apic: initialize irq with -EINVAL
Date:   Wed, 28 Nov 2018 12:09:51 +0100
Message-ID: <1543403393-6004-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To catch the case where the uninitialized variable irq might be
returned. As the path that might lead to this situation can only
occur based on invalid arguments, we initialize this variable with
the value -EINVAL, so that callers are notified accordingly, and no
uninitialized value is returned.

The path that would allow to return an uninitialized value for the
variable irq would require legacy IRQs without the ALLOC flag.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2953bbf..219dbc1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1031,7 +1031,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			     unsigned int flags, struct irq_alloc_info *info)
 {
-	int irq;
+	int irq = -EINVAL;
 	bool legacy = false;
 	struct irq_alloc_info tmp;
 	struct mp_chip_data *data;
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


