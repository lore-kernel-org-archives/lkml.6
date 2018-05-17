Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeEQVds (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:33:48 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46362 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:33:47 -0400
X-Google-Smtp-Source: AB8JxZoKk8NOSyFJAv5hs6NbA1Oj6npL+onGZzEGwrEHN2zj2DabBBP0koahWCjsE7alrMDNvERCxw==
Date: Fri, 18 May 2018 00:33:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86: verify_cpu: restore flags later
Message-ID: <20180517213343.GC4047@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	popf
	xor	eax, eax

formally doesn't restore flags because XOR clobber flags.

Do POPF as last instruction and rearrange the other case for symmetry.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/kernel/verify_cpu.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -132,11 +132,11 @@ ENTRY(verify_cpu)
 	jmp	.Lverify_cpu_sse_test	# try again
 
 .Lverify_cpu_no_longmode:
-	popf				# Restore caller passed flags
 	movl $1,%eax
+	popf				# Restore caller passed flags
 	ret
 .Lverify_cpu_sse_ok:
-	popf				# Restore caller passed flags
 	xorl %eax, %eax
+	popf				# Restore caller passed flags
 	ret
 ENDPROC(verify_cpu)
