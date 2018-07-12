Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2EAECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B950B20839
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GPkdZki3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B950B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbeGLW21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:28:27 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:47210 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbeGLW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:28:26 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 593B510C0ED7;
        Thu, 12 Jul 2018 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531433812; bh=Yca7s6kD60X289PP1e7w0j3AFetzIOVmOpQwIZStfjc=;
        h=From:To:CC:Subject:Date:From;
        b=GPkdZki3HmVWGuySb2wdl/QNuceX0Rj4eIIF4xK8wP+YuBhiLULG2RgphO3yuhJRP
         BW9xBGyrw+tWkwRAkoO+qVWdjd7S9sMLP2cUi/HUn7LhGMrUG4p70jciA0dhP8pm9e
         VOSdi3c0Rsv8VxP7QEzJ9mLTebj5AiZRnYzp0zPYwrHlW1TRad5ueeZkD2sf1ddYVd
         WNKwBrJaZMdBxxMJIZZEoKzSuEV8yz6pVF52y3O1KiwWZ00RuyaiLV4gO1siYCuFQl
         S/K3ctXJzDtQbcCLIZggB0tyg+01nVTR8HLwIoec+Iy/j5ApDGGpUsWfL9EOtKlnAl
         k5xpivJgf71pQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 45E5934AF;
        Thu, 12 Jul 2018 15:16:52 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 12 Jul 2018 15:16:52 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 03:46:49 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 03:46:48 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ARC: mm: allow mprotect to make stack mappings executable
Date:   Thu, 12 Jul 2018 15:16:34 -0700
Message-ID: <1531433794-7518-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mprotect(EXEC) was failing for stack mappings as default vm flags was
missing MAYEXEC.

This was triggered by glibc test suite nptl/tst-execstack testcase

What is surprising is that despite running LTP for years on, we didn't
catch this issue as it lacks a directed test case.

gcc dejagnu tests with nested functions also requiring exec stack work
fine though because they rely on the GNU_STACK segment spit out by
compiler and handled in kernel elf loader.

This glibc case is different as the stack is non exec to begin with and
a dlopen of shared lib with GNU_STACK segment triggers the exec stack
proceedings using a mprotect(PROT_EXEC) which was broken.

CC: stable@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 109baa06831c..09ddddf71cc5 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -105,7 +105,7 @@ typedef pte_t * pgtable_t;
 #define virt_addr_valid(kaddr)  pfn_valid(virt_to_pfn(kaddr))
 
 /* Default Permissions for stack/heaps pages (Non Executable) */
-#define VM_DATA_DEFAULT_FLAGS   (VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE)
+#define VM_DATA_DEFAULT_FLAGS   (VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #define WANT_PAGE_VIRTUAL   1
 
-- 
2.7.4

