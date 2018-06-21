Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED5C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D52219EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D52219EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932973AbeFUSSL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:18:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:31203 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932519AbeFUSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:18:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 11:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="49541006"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2018 11:18:09 -0700
Date:   Thu, 21 Jun 2018 11:18:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()
Message-ID: <20180621181808.GA20097@agluck-desk>
References: <20180621124020.6244-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621124020.6244-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counter proposal.  We don't need the temp mci_status because we exit the
loop early.  Nor the "ret" variable.


How does this look?

-Tony

---


diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index e4cf6ff1c2e1..0e30abccfe54 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -772,23 +772,23 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
-	int i, ret = 0;
+	int i;
 	char *tmp;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
 		m->status = mce_rdmsrl(msr_ops.status(i));
-		if (m->status & MCI_STATUS_VAL) {
-			__set_bit(i, validp);
-			if (quirk_no_way_out)
-				quirk_no_way_out(i, m, regs);
-		}
+		if (!(m->status & MCI_STATUS_VAL))
+			continue;
+		__set_bit(i, validp);
+		if (quirk_no_way_out)
+			quirk_no_way_out(i, m, regs);
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			*msg = tmp;
-			ret = 1;
+			return 1;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 /*
