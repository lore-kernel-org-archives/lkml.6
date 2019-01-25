Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA01C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E9F217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYStW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:49:22 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.171]:14208 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfAYStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:49:22 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 7C68A14C9C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:49:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n6XZgPYFB2PzOn6XZgzRx5; Fri, 25 Jan 2019 12:49:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42356 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn6XW-001bXi-E4; Fri, 25 Jan 2019 12:49:20 -0600
Date:   Fri, 25 Jan 2019 12:49:17 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/events: Mark expected switch fall-throughs
Message-ID: <20190125184917.GA7289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn6XW-001bXi-E4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:42356
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from arch/x86/events/intel/core.c:22:
arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
arch/x86/events/intel/../perf_event.h:668:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
  x86_pmu.quirks = &__quirk;     \
  ~~~~~~~~~~~~~~~^~~~~~~~~~
arch/x86/events/intel/core.c:4170:3: note: in expansion of macro ‘x86_add_quirk’
   x86_add_quirk(intel_clovertown_quirk);
   ^~~~~~~~~~~~~
arch/x86/events/intel/core.c:4171:2: note: here
  case INTEL_FAM6_CORE2_MEROM_L:
  ^~~~
arch/x86/events/intel/lbr.c:929:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/events/intel/core.c | 2 ++
 arch/x86/events/intel/lbr.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..ece43e7e4569 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4168,6 +4168,8 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_CORE2_MEROM:
 		x86_add_quirk(intel_clovertown_quirk);
+		/* fall through */
+
 	case INTEL_FAM6_CORE2_MEROM_L:
 	case INTEL_FAM6_CORE2_PENRYN:
 	case INTEL_FAM6_CORE2_DUNNINGTON:
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c88ed39582a1..580c1b91c454 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -931,6 +931,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 			ret = X86_BR_ZERO_CALL;
 			break;
 		}
+		/* fall through */
 	case 0x9a: /* call far absolute */
 		ret = X86_BR_CALL;
 		break;
-- 
2.20.1

