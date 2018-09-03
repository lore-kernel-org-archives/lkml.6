Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbeICVs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:48:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeICVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2402BD09;
        Mon,  3 Sep 2018 17:27:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-fsdevel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 4.14 149/165] MIPS: Correct the 64-bit DSP accumulator register size
Date:   Mon,  3 Sep 2018 18:57:15 +0200
Message-Id: <20180903165704.558076450@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit f5958b4cf4fc38ed4583ab83fb7c4cd1ab05f47b upstream.

Use the `unsigned long' rather than `__u32' type for DSP accumulator
registers, like with the regular MIPS multiply/divide accumulator and
general-purpose registers, as all are 64-bit in 64-bit implementations
and using a 32-bit data type leads to contents truncation on context
saving.

Update `arch_ptrace' and `compat_arch_ptrace' accordingly, removing
casts that are similarly not used with multiply/divide accumulator or
general-purpose register accesses.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
Patchwork: https://patchwork.linux-mips.org/patch/19329/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 2.6.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/processor.h |    2 +-
 arch/mips/kernel/ptrace.c         |    2 +-
 arch/mips/kernel/ptrace32.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -141,7 +141,7 @@ struct mips_fpu_struct {
 
 #define NUM_DSP_REGS   6
 
-typedef __u32 dspreg_t;
+typedef unsigned long dspreg_t;
 
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -847,7 +847,7 @@ long arch_ptrace(struct task_struct *chi
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -141,7 +141,7 @@ long compat_arch_ptrace(struct task_stru
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:


