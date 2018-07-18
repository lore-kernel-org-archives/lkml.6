Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FC520854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FC520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeGRPka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:40:30 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3EE43CAF;
        Wed, 18 Jul 2018 15:02:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brad Spengler <spender@grsecurity.net>
Subject: [PATCH 4.4 2/3] x86/cpu: Probe CPUID leaf 6 even when cpuid_level == 6
Date:   Wed, 18 Jul 2018 17:01:59 +0200
Message-Id: <20180718145156.243426620@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718145156.152413234@linuxfoundation.org>
References: <20180718145156.152413234@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 3df8d9208569ef0b2313e516566222d745f3b94b upstream.

A typo (or mis-merge?) resulted in leaf 6 only being probed if
cpuid_level >= 7.

Fixes: 2ccd71f1b278 ("x86/cpufeature: Move some of the scattered feature bits to x86_capability")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Link: http://lkml.kernel.org/r/6ea30c0e9daec21e488b54761881a6dfcf3e04d0.1481825597.git.luto@kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/common.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -686,13 +686,14 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_1_EDX] = edx;
 	}
 
+	/* Thermal and Power Management Leaf: level 0x00000006 (eax) */
+	if (c->cpuid_level >= 0x00000006)
+		c->x86_capability[CPUID_6_EAX] = cpuid_eax(0x00000006);
+
 	/* Additional Intel-defined flags: level 0x00000007 */
 	if (c->cpuid_level >= 0x00000007) {
 		cpuid_count(0x00000007, 0, &eax, &ebx, &ecx, &edx);
-
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
-
-		c->x86_capability[CPUID_6_EAX] = cpuid_eax(0x00000006);
 		c->x86_capability[CPUID_7_ECX] = ecx;
 	}
 


