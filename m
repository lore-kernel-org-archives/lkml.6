Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE5CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D720831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LQJsPRvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040D720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeKATCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:02:25 -0400
Received: from mail.efficios.com ([167.114.142.138]:41804 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeKATCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:02:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 73B6F22771A;
        Thu,  1 Nov 2018 06:00:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id U7cbJwXUbdjq; Thu,  1 Nov 2018 06:00:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 14C3F227716;
        Thu,  1 Nov 2018 06:00:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 14C3F227716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541066405;
        bh=gM7Kec0aqOSc74Mk9mz7nq5+r7lpkxUKvOiAtaED5o0=;
        h=From:To:Date:Message-Id;
        b=LQJsPRvkx4KNc3y8OvP02BzWos1dzII9+Tkm2bvJX98dTyJtkxN2B1kpUVTGlb4qr
         Wg0JMrv5XMLSvvK0UN7gDFS3qNRZmNChXSQ6JAfII1FoFGa3r+NyNFcaOO2byNsTii
         8Kbxcy5diwscLEAMGtg3Cc7W7zNJh4SaKyGM50rghVJEYL8mXikyWynUx4YPtv8HIL
         sQzATFuvZ1VMf83anB87YZaMHBjNxTHcDCiBI5dY36yF1kJxXqD5gBAftGmG8Q7aJc
         Bh4sOIEsf8maFZtD3YJS+w/pfm3wavjkufO32mJic+k3R+HFs1COpXcjV61hP+diSi
         ekjSAGr3X0RxQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xJbU_vLP5yGr; Thu,  1 Nov 2018 06:00:04 -0400 (EDT)
Received: from thinkos.etherlink (sessfw99-sesbfw99-92.ericsson.net [192.176.1.92])
        by mail.efficios.com (Postfix) with ESMTPSA id DF8B92276B4;
        Thu,  1 Nov 2018 05:59:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH for 4.21 09/16] powerpc: Wire up cpu_opv system call
Date:   Thu,  1 Nov 2018 10:58:37 +0100
Message-Id: <20181101095844.24462-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171ea189..8f58710f5e8b 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -394,3 +394,4 @@ SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
 COMPAT_SYS(io_pgetevents)
+SYSCALL(cpu_opv)
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d0b448..112e2c54750a 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -400,5 +400,6 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
+#define __NR_cpu_opv		389
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.11.0

