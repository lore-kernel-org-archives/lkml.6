Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC994C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5942081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5942081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLDV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:26:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:51967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeLDV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:26:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96127311"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:26:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 2/4] x86/vdso: Remove a stale/misleading comment from the linker script
Date:   Tue,  4 Dec 2018 13:25:58 -0800
Message-Id: <20181204212600.28090-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212600.28090-1-sean.j.christopherson@intel.com>
References: <20181204212600.28090-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, vdso2c aggressively stripped data from the vDSO
image when generating the final userspace image.  This included
stripping the .altinstructions and .altinstr_replacement sections.
Eventually, the stripping process reverted to "objdump -S" and no
longer removed the aforementioned sections, but the comment remained.

Keeping the .alt* sections at the end of the PT_LOAD segment is no
longer necessary, but there's no harm in doing so and it's a helpful
reminder that they don't need to be included in the final vDSO image,
i.e. someone may want to take another stab at zapping/stripping the
unneeded sections.

Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 0cedc905c8d6..93c6dc7812d0 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -65,11 +65,6 @@ SECTIONS
 
 	.text		: { *(.text*) }			:text	=0x90909090,
 
-	/*
-	 * At the end so that eu-elflint stays happy when vdso2c strips
-	 * these.  A better implementation would avoid allocating space
-	 * for these.
-	 */
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
 
-- 
2.19.2

