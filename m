Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627FA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhJH1YMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627FA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeKTE2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbeKTC5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AF32089F;
        Mon, 19 Nov 2018 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645211;
        bh=Q4GJuccLR46gV3MQTPZT1NXGpYXszajUtI4qJA6HlGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhJH1YMXEqyiSd0AzSFFb+UG6QZ6WJnNg+DBsoR0qnw2eHlF+SCAzA50P4ySUCpM+
         iXL2LwInlEpBotScIEep1nYgjW5chApFePaal5o3XdeoSBXBlhn5BN6AoJj3shEWrR
         CzUWy21miQgHVqVSGvH/YzAoab1XErOAFWpUt13k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ritesh Raj Sarraf <rrs@researchut.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.19 079/205] um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
Date:   Mon, 19 Nov 2018 17:26:26 +0100
Message-Id: <20181119162630.668726790@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 0676b957c24bfb6e495449ba7b7e72c5b5d79233 upstream.

32bit UML used to define PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
own its own because many years ago not all libcs had these request codes
in their UAPI.
These days PTRACE_SYSEMU/_SINGLESTEP is well known and part of glibc
and our own define becomes problematic.

With change c48831d0eebf ("linux/x86: sync sys/ptrace.h with Linux 4.14
[BZ #22433]") glibc turned PTRACE_SYSEMU/_SINGLESTEP into a enum and
UML failed to build.

Let's drop our define and rely on the fact that every libc has
PTRACE_SYSEMU/_SINGLESTEP.

Cc: <stable@vger.kernel.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Reported-and-tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/um/shared/sysdep/ptrace_32.h |   10 ----------
 1 file changed, 10 deletions(-)

--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -10,20 +10,10 @@
 
 static inline void update_debugregs(int seq) {}
 
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#ifndef PTRACE_SYSEMU_SINGLESTEP
-#define PTRACE_SYSEMU_SINGLESTEP 32
-#endif
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)


