Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF00EC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD98A207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278579;
	bh=BJ9cF3W6Vouz7oEaBEaYWTWRu/w0w9yKiIUxI2e5g/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQbG+C01dfkuud9mL8ZoZw6s4dpFgh+mayApP4HAtO8h1ApRUqZvS6egVu7F5s4/X
	 uSr/rmgIG/aq8bEcsVrY9NklPO2EI1u75xVHgRFF7cWj9i/jP8xFkYeIf2qvQ+PcL5
	 t/IkgpeGhw2KgQ7K2NB/TaiF3VsJHNOMxCeoiu8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfBDLJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfBDKkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C9B2087C;
        Mon,  4 Feb 2019 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276838;
        bh=BJ9cF3W6Vouz7oEaBEaYWTWRu/w0w9yKiIUxI2e5g/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBQn42h226swtAm1qNn8/GCq+SSsmpRfaRp5DRzPy6wqEVM0ytQFQwUIX0+aoxOdz
         XvjcuJOI3KTcNEWqu+QlUt3ZQ3j//IXA9oQQpY1YyaIvqm5K02yTP0OCj5JCOWdAA8
         l345rmFEWCrJLr7gj7Bl7mqjVWaAMwZcvBUU5vXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 32/65] s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU
Date:   Mon,  4 Feb 2019 11:36:25 +0100
Message-Id: <20190204103616.283214181@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 60f1bf29c0b2519989927cae640cd1f50f59dc7f upstream.

When calling smp_call_ipl_cpu() from the IPL CPU, we will try to read
from pcpu_devices->lowcore. However, due to prefixing, that will result
in reading from absolute address 0 on that CPU. We have to go via the
actual lowcore instead.

This means that right now, we will read lc->nodat_stack == 0 and
therfore work on a very wrong stack.

This BUG essentially broke rebooting under QEMU TCG (which will report
a low address protection exception). And checking under KVM, it is
also broken under KVM. With 1 VCPU it can be easily triggered.

:/# echo 1 > /proc/sys/kernel/sysrq
:/# echo b > /proc/sysrq-trigger
[   28.476745] sysrq: SysRq : Resetting
[   28.476793] Kernel stack overflow.
[   28.476817] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
[   28.476820] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
[   28.476826] Krnl PSW : 0400c00180000000 0000000000115c0c (pcpu_delegate+0x12c/0x140)
[   28.476861]            R:0 T:1 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[   28.476863] Krnl GPRS: ffffffffffffffff 0000000000000000 000000000010dff8 0000000000000000
[   28.476864]            0000000000000000 0000000000000000 0000000000ab7090 000003e0006efbf0
[   28.476864]            000000000010dff8 0000000000000000 0000000000000000 0000000000000000
[   28.476865]            000000007fffc000 0000000000730408 000003e0006efc58 0000000000000000
[   28.476887] Krnl Code: 0000000000115bfe: 4170f000            la      %r7,0(%r15)
[   28.476887]            0000000000115c02: 41f0a000            la      %r15,0(%r10)
[   28.476887]           #0000000000115c06: e370f0980024        stg     %r7,152(%r15)
[   28.476887]           >0000000000115c0c: c0e5fffff86e        brasl   %r14,114ce8
[   28.476887]            0000000000115c12: 41f07000            la      %r15,0(%r7)
[   28.476887]            0000000000115c16: a7f4ffa8            brc     15,115b66
[   28.476887]            0000000000115c1a: 0707                bcr     0,%r7
[   28.476887]            0000000000115c1c: 0707                bcr     0,%r7
[   28.476901] Call Trace:
[   28.476902] Last Breaking-Event-Address:
[   28.476920]  [<0000000000a01c4a>] arch_call_rest_init+0x22/0x80
[   28.476927] Kernel panic - not syncing: Corrupt kernel stack, can't continue.
[   28.476930] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
[   28.476932] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
[   28.476932] Call Trace:

Fixes: 2f859d0dad81 ("s390/smp: reduce size of struct pcpu")
Cc: stable@vger.kernel.org # 4.0+
Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/smp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -360,9 +360,13 @@ void smp_call_online_cpu(void (*func)(vo
  */
 void smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
+	struct _lowcore *lc = pcpu_devices->lowcore;
+
+	if (pcpu_devices[0].address == stap())
+		lc = &S390_lowcore;
+
 	pcpu_delegate(&pcpu_devices[0], func, data,
-		      pcpu_devices->lowcore->panic_stack -
-		      PANIC_FRAME_OFFSET + PAGE_SIZE);
+		      lc->panic_stack - PANIC_FRAME_OFFSET + PAGE_SIZE);
 }
 
 int smp_find_processor_id(u16 address)


