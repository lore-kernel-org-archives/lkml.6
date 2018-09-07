Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C47C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865152075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865152075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeIHC16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIHC15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:57 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83F13F36;
        Fri,  7 Sep 2018 21:45:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 03/29] powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.
Date:   Fri,  7 Sep 2018 23:10:24 +0200
Message-Id: <20180907210909.802057166@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit cd813e1cd7122f2c261dce5b54d1e0c97f80e1a5 upstream.

During Machine Check interrupt on pseries platform, register r3 points
RTAS extended event log passed by hypervisor. Since hypervisor uses r3
to pass pointer to rtas log, it stores the original r3 value at the
start of the memory (first 8 bytes) pointed by r3. Since hypervisor
stores this info and rtas log is in BE format, linux should make
sure to restore r3 value in correct endian format.

Without this patch when MCE handler, after recovery, returns to code that
that caused the MCE may end up with Data SLB access interrupt for invalid
address followed by kernel panic or hang.

  Severe Machine check interrupt [Recovered]
    NIP [d00000000ca301b8]: init_module+0x1b8/0x338 [bork_kernel]
    Initiator: CPU
    Error type: SLB [Multihit]
      Effective address: d00000000ca70000
  cpu 0xa: Vector: 380 (Data SLB Access) at [c0000000fc7775b0]
      pc: c0000000009694c0: vsnprintf+0x80/0x480
      lr: c0000000009698e0: vscnprintf+0x20/0x60
      sp: c0000000fc777830
     msr: 8000000002009033
     dar: a803a30c000000d0
    current = 0xc00000000bc9ef00
    paca    = 0xc00000001eca5c00	 softe: 3	 irq_happened: 0x01
      pid   = 8860, comm = insmod
  vscnprintf+0x20/0x60
  vprintk_emit+0xb4/0x4b0
  vprintk_func+0x5c/0xd0
  printk+0x38/0x4c
  init_module+0x1c0/0x338 [bork_kernel]
  do_one_initcall+0x54/0x230
  do_init_module+0x8c/0x248
  load_module+0x12b8/0x15b0
  sys_finit_module+0xa8/0x110
  system_call+0x58/0x6c
  --- Exception: c00 (System Call) at 00007fff8bda0644
  SP (7fffdfbfe980) is in userspace

This patch fixes this issue.

Fixes: a08a53ea4c97 ("powerpc/le: Enable RTAS events support")
Cc: stable@vger.kernel.org # v3.15+
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -298,7 +298,7 @@ static struct rtas_error_log *fwnmi_get_
 	}
 
 	savep = __va(regs->gpr[3]);
-	regs->gpr[3] = savep[0];	/* restore original r3 */
+	regs->gpr[3] = be64_to_cpu(savep[0]);	/* restore original r3 */
 
 	/* If it isn't an extended log we can use the per cpu 64bit buffer */
 	h = (struct rtas_error_log *)&savep[1];


