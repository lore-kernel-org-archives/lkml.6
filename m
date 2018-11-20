Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446A720870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QqX5L3SX";
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="XrwvqFl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446A720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeKTNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:32:28 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:55791 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbeKTNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:32:27 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2018 08:32:26 EST
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 40CC021849EB;
        Tue, 20 Nov 2018 06:00:32 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id al9msiIKwS-0V5GA5K0;
        Tue, 20 Nov 2018 06:00:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1542682832;
        bh=B2Za9VJ4Qvi/oG5Gy6mKx/fRtEqVqAoZqgSTGcsSXjk=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=QqX5L3SXOchRC+6lLkoNzmroLb3mcBXMfyOQgkjKAB0HCt7tIEA82iPf3YppvACL6
         gumyupD9zj1xzwk4lwaqO70B0PYvcTzhU/foj7Fhq2qPLBeX4CQL9uVWkx866jFrpn
         2d5MerBawXDJQX4lck3gusLQiaCKAyoeTpxYFGIM=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id MRiMKoJiLO-0Q5SxggV;
        Tue, 20 Nov 2018 06:00:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1542682830;
        bh=B2Za9VJ4Qvi/oG5Gy6mKx/fRtEqVqAoZqgSTGcsSXjk=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=XrwvqFl4Q/ySKMDafrtZphUfu100ItX6TakaDJNhBAxpXu2j0pR16ubmzwH5hYbY7
         t4+yFAjb2n1yy3FwbPLJ1lkPQqKwxq2/Qm/rpraF+zxFCsBRS45Nny+glpn6nqlWSJ
         v0By+oDf2ffNHbRYvyZaA4d7KWPkTjrGNwhgYTys=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     bp@alien8.de, sherry.hurwitz@amd.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH v2] x86/cpu/AMD: Fix CPB bit for more processors
Date:   Tue, 20 Nov 2018 11:00:18 +0800
Message-Id: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on some newer F17h
procssors but their revision guide has not been released.

For example,Tesed on AMD "Ryzen 7 2700U with Radeon Vega Mobile Gfx"
and "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx",
their CPUID Fn0000_0001_EAX is 0x00810f10 and should have
CPB feature according AMD product specifications, however
their Fn8000_0007_EDX is 0x00006599, indicating they don't
support CPB feature.

Since whole F17h should support CPB, we set the cap for all of
them.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/x86/kernel/cpu/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index eeea634bee0a..37989fa9e620 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -818,12 +818,13 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
+
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
-	 * all up to and including B1.
+	 * a lot of Family 17h processors and some models are undocumented, since
+	 * whole F17h should support CPB, we set the cap for all of them.
 	 */
-	if (c->x86_model <= 1 && c->x86_stepping <= 1)
-		set_cpu_cap(c, X86_FEATURE_CPB);
+	set_cpu_cap(c, X86_FEATURE_CPB);
 }

 static void init_amd(struct cpuinfo_x86 *c)
--
2.19.1

