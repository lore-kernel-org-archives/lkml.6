Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D8DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF2208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Tv1XHtkv";
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="tWSGK3Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABF2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeKPPwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:52:06 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:39321 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727271AbeKPPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:52:06 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 10:52:04 EST
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id B77781346CDF;
        Fri, 16 Nov 2018 08:33:32 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id aMA4hsfQQH-XOmG8LCZ;
        Fri, 16 Nov 2018 08:33:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1542346405;
        bh=cFGAtMBwXZg1WRLvk7A3sjAU5clFUhpmf/sf+VY2TdE=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=Tv1XHtkvt68I+4GKJ00eSO/ckfIr5HBTtwtDIp8s1pxPGtH/ivPDR3yjGgmIpSA8j
         bQeZxqWjPR+hFRWg3tDApcrfGPAWzpx62DljqMTiijNfHl1OcE2uD2mCJkld8jgnJj
         1fNC9WlNoi3zGFoo7I+RVaCZcF8yte5SywyoBNqE=
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Na0LOu5HlX-XJFeUS94;
        Fri, 16 Nov 2018 08:33:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1542346404;
        bh=cFGAtMBwXZg1WRLvk7A3sjAU5clFUhpmf/sf+VY2TdE=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=tWSGK3RsQoKKrwTHoxLQIfVWGx87glojy6DlSzpa4iX0XrYbzUXsTc2MmZBh2GSWm
         PJVrfx8YzJ4Ypxdrz5Mqh6eYT41/yurAGUjacWQVZH32UnlE8q6ieGXcotE9su7U4g
         hSv6fBKO4O26YxM/u46KXuNnMJC+jBdRb5yMTxw8=
Authentication-Results: smtp4p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     sherry.hurwitz@amd.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] x86/cpu/AMD: Fix CPB bit for more processors
Date:   Fri, 16 Nov 2018 13:31:06 +0800
Message-Id: <20181116053106.11571-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on Model 17,
Stepping 0, but revision guide has not been released for
newer Family 17h models.

Tesed on AMD "Ryzen 7 2700U with Radeon Vega Mobile Gfx"
and "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx",
their CPUID Fn0000_0001_EAX is 0x00810f10 and should have
CPB feature according AMD product specifications, however
their Fn8000_0007_EDX is 0x00006599, indicating they don't
support CPB feature.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/x86/kernel/cpu/amd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index eeea634bee0a..7db43ef8e97e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -821,8 +821,12 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
 	 * all up to and including B1.
+	 *
+	 * Revision guide for Family 17h, Model 17 has not been released, but
+	 * Model 17, Stepping 0 have the same issue.
 	 */
-	if (c->x86_model <= 1 && c->x86_stepping <= 1)
+	if ((c->x86_model <= 1 && c->x86_stepping <= 1) ||	\
+		(c->x86_model == 17 && c->x86_stepping == 0))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 
-- 
2.19.1

