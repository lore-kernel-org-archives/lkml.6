Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820286;
	bh=OpkSoja5OoTfoUrO7AMhjTJIQbUNeloJ8kj8dQ5tuEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rWZXDNVeVdq8dKTQcXghbNaK19bu/sYwppQ+p07lREphDfw7NZp73kwyTjR6RM0Ba
	 QbTaCOtcjXJcvvhV9TVmZOw2Ne+reUuxolDKRDbuEe+TA8Pqb9CHYiSOIAB/afSuK/
	 a46DSFBJcCtYZrOfthJ2gu7mP9rix2/uPPmrQFIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfAROEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36172 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfAROEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so10568123lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVF/+rdzQVmDvcOxbIn7hLVP8/m/t64C/jXS8/amg08=;
        b=kib+mKN2iMt+SC3cr4MkhQp/2PL+OZRh39UXrQvIiU5NriO44p25wSb4Jp2xma70b1
         GS/JeAAgxYEN0KF0NPixoaiV7yEqjwQGfjIMOtJ1edu7pUZPKW3MSXnxgBXgAy/qxxjh
         XDWlGrNNHepSGfaSJyApR+zN8VnobJbBs+Xz50c+xwdArQX1xsVYfcV/1HZBJcfE/i2P
         gQl7kKMftDC2070S+CQDsNb68bAnwAWty4NnilvB7wDwwvU/9H+AzWjVFey6nD3De8KY
         RxY+3dDX2mYO0B4BNMubqJW2PeFSa36C2iRBVALL3YfRmxz8AjXRJLt6Y/DsWX0FKj+R
         iwmw==
X-Gm-Message-State: AJcUukeQd8Re/G3S9K46huPcT/4kIDICr7Th8qsAT7WcUayXNPDiXTAU
        wces+YeRyKpQUQlzka7gFqc=
X-Google-Smtp-Source: ALg8bN5VHtjHufGJDP70XS1DLwgcclDu4iucZkN6BBJ2OgpQrlnqRayI53u2/+HkbgEl4GhkgbfLrw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr12312768lfe.154.1547820281063;
        Fri, 18 Jan 2019 06:04:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d10sm816549lfa.71.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002WA-Gq; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
Date:   Fri, 18 Jan 2019 15:03:08 +0100
Message-Id: <20190118140308.9599-6-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
instead of open coding. Note that this will allow matching also on the
node name instead of the (for FDT) deprecated device_type property.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 5 +++--
 arch/riscv/kernel/smpboot.c    | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 4891fd62b95e..e7a4701f0256 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,7 +28,7 @@ bool has_fpu __read_mostly;
 
 void riscv_fill_hwcap(void)
 {
-	struct device_node *node = NULL;
+	struct device_node *node;
 	const char *isa;
 	size_t i;
 	static unsigned long isa2hwcap[256] = {0};
@@ -46,9 +46,10 @@ void riscv_fill_hwcap(void)
 	 * We don't support running Linux on hertergenous ISA systems.  For
 	 * now, we just check the ISA of the first "okay" processor.
 	 */
-	while ((node = of_find_node_by_type(node, "cpu")))
+	for_each_of_cpu_node(node) {
 		if (riscv_of_processor_hartid(node) >= 0)
 			break;
+	}
 	if (!node) {
 		pr_warn("Unable to find \"cpu\" devicetree entry\n");
 		return;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 18cda0e8cf94..6e2813257e03 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -50,12 +50,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 void __init setup_smp(void)
 {
-	struct device_node *dn = NULL;
+	struct device_node *dn;
 	int hart;
 	bool found_boot_cpu = false;
 	int cpuid = 1;
 
-	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+	for_each_of_cpu_node(dn) {
 		hart = riscv_of_processor_hartid(dn);
 		if (hart < 0)
 			continue;
-- 
2.20.1

