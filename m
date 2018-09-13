Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7FDC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C1920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeIMSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:55:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeIMSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B44A8D19;
        Thu, 13 Sep 2018 13:46:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 075/115] powerpc/64s: Make rfi_flush_fallback a little more robust
Date:   Thu, 13 Sep 2018 15:31:35 +0200
Message-Id: <20180913131828.260656544@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 78ee9946371f5848ddfc88ab1a43867df8f17d83 ]

Because rfi_flush_fallback runs immediately before the return to
userspace it currently runs with the user r1 (stack pointer). This
means if we oops in there we will report a bad kernel stack pointer in
the exception entry path, eg:

  Bad kernel stack pointer 7ffff7150e40 at c0000000000023b4
  Oops: Bad kernel stack pointer, sig: 6 [#1]
  LE SMP NR_CPUS=32 NUMA PowerNV
  Modules linked in:
  CPU: 0 PID: 1246 Comm: klogd Not tainted 4.18.0-rc2-gcc-7.3.1-00175-g0443f8a69ba3 #7
  NIP:  c0000000000023b4 LR: 0000000010053e00 CTR: 0000000000000040
  REGS: c0000000fffe7d40 TRAP: 4100   Not tainted  (4.18.0-rc2-gcc-7.3.1-00175-g0443f8a69ba3)
  MSR:  9000000002803031 <SF,HV,VEC,VSX,FP,ME,IR,DR,LE>  CR: 44000442  XER: 20000000
  CFAR: c00000000000bac8 IRQMASK: c0000000f1e66a80
  GPR00: 0000000002000000 00007ffff7150e40 00007fff93a99900 0000000000000020
  ...
  NIP [c0000000000023b4] rfi_flush_fallback+0x34/0x80
  LR [0000000010053e00] 0x10053e00

Although the NIP tells us where we were, and the TRAP number tells us
what happened, it would still be nicer if we could report the actual
exception rather than barfing about the stack pointer.

We an do that fairly simply by loading the kernel stack pointer on
entry and restoring the user value before returning. That way we see a
regular oops such as:

  Unrecoverable exception 4100 at c00000000000239c
  Oops: Unrecoverable exception, sig: 6 [#1]
  LE SMP NR_CPUS=32 NUMA PowerNV
  Modules linked in:
  CPU: 0 PID: 1251 Comm: klogd Not tainted 4.18.0-rc3-gcc-7.3.1-00097-g4ebfcac65acd-dirty #40
  NIP:  c00000000000239c LR: 0000000010053e00 CTR: 0000000000000040
  REGS: c0000000f1e17bb0 TRAP: 4100   Not tainted  (4.18.0-rc3-gcc-7.3.1-00097-g4ebfcac65acd-dirty)
  MSR:  9000000002803031 <SF,HV,VEC,VSX,FP,ME,IR,DR,LE>  CR: 44000442  XER: 20000000
  CFAR: c00000000000bac8 IRQMASK: 0
  ...
  NIP [c00000000000239c] rfi_flush_fallback+0x3c/0x80
  LR [0000000010053e00] 0x10053e00
  Call Trace:
  [c0000000f1e17e30] [c00000000000b9e4] system_call+0x5c/0x70 (unreliable)

Note this shouldn't make the kernel stack pointer vulnerable to a
meltdown attack, because it should be flushed from the cache before we
return to userspace. The user r1 value will be in the cache, because
we load it in the return path, but that is harmless.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/exceptions-64s.S |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1452,6 +1452,8 @@ TRAMP_REAL_BEGIN(stf_barrier_fallback)
 TRAMP_REAL_BEGIN(rfi_flush_fallback)
 	SET_SCRATCH0(r13);
 	GET_PACA(r13);
+	std	r1,PACA_EXRFI+EX_R12(r13)
+	ld	r1,PACAKSAVE(r13)
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
@@ -1486,12 +1488,15 @@ TRAMP_REAL_BEGIN(rfi_flush_fallback)
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
+	ld	r1,PACA_EXRFI+EX_R12(r13)
 	GET_SCRATCH0(r13);
 	rfid
 
 TRAMP_REAL_BEGIN(hrfi_flush_fallback)
 	SET_SCRATCH0(r13);
 	GET_PACA(r13);
+	std	r1,PACA_EXRFI+EX_R12(r13)
+	ld	r1,PACAKSAVE(r13)
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
@@ -1526,6 +1531,7 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
+	ld	r1,PACA_EXRFI+EX_R12(r13)
 	GET_SCRATCH0(r13);
 	hrfid
 


