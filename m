Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1102087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="frFY26S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1102087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeLDK6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeLDK56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E75B2146D;
        Tue,  4 Dec 2018 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921077;
        bh=KLpEduOzAl3nj66wSdpt225swj/rHbcTo6LZwEXecmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frFY26S6kJwQZoYoxFyJKOcfW6mV+X6UCWicgOgZ+GfRAj85fhDI6WcgaTNJ1fM2e
         uhVSNfnlCgOI2Iakz4z9XfNTUzioF8aBZfD899w47Xw4zaAUF1mFgcoEYaA0lpeumJ
         2302z7OFAZ9fojJuSaZlIbL5K86jounuOTlf/AqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.19 070/139] xtensa: enable coprocessors that are being flushed
Date:   Tue,  4 Dec 2018 11:49:11 +0100
Message-Id: <20181204103652.945763798@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 2958b66694e018c552be0b60521fec27e8d12988 upstream.

coprocessor_flush_all may be called from a context of a thread that is
different from the thread being flushed. In that case contents of the
cpenable special register may not match ti->cpenable of the target
thread, resulting in unhandled coprocessor exception in the kernel
context.
Set cpenable special register to the ti->cpenable of the target register
for the duration of the flush and restore it afterwards.
This fixes the following crash caused by coprocessor register inspection
in native gdb:

  (gdb) p/x $w0
  Illegal instruction in kernel: sig: 9 [#1] PREEMPT
  Call Trace:
    ___might_sleep+0x184/0x1a4
    __might_sleep+0x41/0xac
    exit_signals+0x14/0x218
    do_exit+0xc9/0x8b8
    die+0x99/0xa0
    do_illegal_instruction+0x18/0x6c
    common_exception+0x77/0x77
    coprocessor_flush+0x16/0x3c
    arch_ptrace+0x46c/0x674
    sys_ptrace+0x2ce/0x3b4
    system_call+0x54/0x80
    common_exception+0x77/0x77
  note: gdb[100] exited with preempt_count 1
  Killed

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/process.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -94,18 +94,21 @@ void coprocessor_release_all(struct thre
 
 void coprocessor_flush_all(struct thread_info *ti)
 {
-	unsigned long cpenable;
+	unsigned long cpenable, old_cpenable;
 	int i;
 
 	preempt_disable();
 
+	RSR_CPENABLE(old_cpenable);
 	cpenable = ti->cpenable;
+	WSR_CPENABLE(cpenable);
 
 	for (i = 0; i < XCHAL_CP_MAX; i++) {
 		if ((cpenable & 1) != 0 && coprocessor_owner[i] == ti)
 			coprocessor_flush(ti, i);
 		cpenable >>= 1;
 	}
+	WSR_CPENABLE(old_cpenable);
 
 	preempt_enable();
 }


