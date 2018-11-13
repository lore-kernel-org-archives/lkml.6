Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D26C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4E21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D4E21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeKNEsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:48:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39676 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeKNEsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:48:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so14480681wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axpG6rzE7l/3qR0YkiVIhOuz2ldr2WJwHJpqxgxardQ=;
        b=E8YI01exCW7KhAPauOjaLbdT47P0mo/viI6BDQb7YThc35kuYBM43n+pEdIoErCPTy
         iEFlan6REeljWnfiDFhRBvOFEHIz3UhE8H9efIhnT7NYk1HcFki2s00sKRgeOuPYla4H
         Dp55AtptHDYYwvxR/9M93Tefn7u9UzTGOc0JmViNwxfpLBVbQflAXxCEwORlwZnaQkrN
         o45sxfQ1BvyAuZrzawk4OZ+TcPhP22qG1nsSI7fIvBesK3bAz33buNhbu7XjsZiv9D3T
         bJV18KEq64Cku+DbO3ncNv9I0mrKa23vYJuUT+OfaTcKbWBMLUd9gTVgEUNAKjduTSZQ
         /07w==
X-Gm-Message-State: AGRZ1gImYAELx2ZuH11ldlBKoyVZaD68N0l0Dk2boVzqYYRZlT/QCKOM
        coJVFyu8Dkbv2Ykg5b8EMSM=
X-Google-Smtp-Source: AJdET5ePO/C8G4VSiB7eoZf+D29DIDFhYy6NYq1ehm+ziUerBQag6Hmjw6CgM+EVFNewFvAGjJawdA==
X-Received: by 2002:adf:fe05:: with SMTP id n5-v6mr6028406wrr.116.1542134958874;
        Tue, 13 Nov 2018 10:49:18 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-247-207.eurotel.cz. [37.188.247.207])
        by smtp.gmail.com with ESMTPSA id y138sm7228308wmc.16.2018.11.13.10.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:49:17 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] l1tf: drop the swap storage limit restriction when l1tf=off
Date:   Tue, 13 Nov 2018 19:49:10 +0100
Message-Id: <20181113184910.26697-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Swap storage is restricted to max_swapfile_size (~16TB on x86_64)
whenever the system is deemed affected by L1TF vulnerability. Even
though the limit is quite high for most deployments it seems to be
too restrictive for deployments which are willing to live with the
mitigation disabled.

We have a customer to deploy 8x 6,4TB PCIe/NVMe SSD swap devices
which is clearly out of the limit.

Drop the swap restriction when l1tf=off is specified. It also doesn't
make much sense to warn about too much memory for the l1tf mitigation
when it is forcefully disabled by the administrator.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 Documentation/admin-guide/l1tf.rst              | 5 ++++-
 arch/x86/kernel/cpu/bugs.c                      | 3 ++-
 arch/x86/mm/init.c                              | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..a54f2bd39e77 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2095,6 +2095,8 @@
 			off
 				Disables hypervisor mitigations and doesn't
 				emit any warnings.
+				It also drops the swap size and available
+				RAM limit restriction.
 
 			Default is 'flush'.
 
diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide/l1tf.rst
index b85dd80510b0..b00464a9c09c 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -405,6 +405,8 @@ The kernel command line allows to control the L1TF mitigations at boot
 
   off		Disables hypervisor mitigations and doesn't emit any
 		warnings.
+		It also drops the swap size and available RAM limit restrictions.
+
   ============  =============================================================
 
 The default is 'flush'. For details about L1D flushing see :ref:`l1d_flush`.
@@ -576,7 +578,8 @@ Default mitigations
   The kernel default mitigations for vulnerable processors are:
 
   - PTE inversion to protect against malicious user space. This is done
-    unconditionally and cannot be controlled.
+    unconditionally and cannot be controlled. The swap storage is limited
+    to ~16TB.
 
   - L1D conditional flushing on VMENTER when EPT is enabled for
     a guest.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c37e66e493bf..761100cd3eab 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -779,7 +779,8 @@ static void __init l1tf_select_mitigation(void)
 #endif
 
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
-	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
+	if (l1tf_mitigation != L1TF_MITIGATION_OFF &&
+			e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
 		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
 				half_pa);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ef99f3892e1f..427a955a2cf2 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -931,7 +931,7 @@ unsigned long max_swapfile_size(void)
 
 	pages = generic_max_swapfile_size();
 
-	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
+	if (boot_cpu_has_bug(X86_BUG_L1TF) && l1tf_mitigation != L1TF_MITIGATION_OFF) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
 		unsigned long long l1tf_limit = l1tf_pfn_limit();
 		/*
-- 
2.19.1

