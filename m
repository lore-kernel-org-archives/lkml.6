Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E2C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B650B20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFtz2VYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B650B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeLEJkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeLEJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39EF20878;
        Wed,  5 Dec 2018 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002832;
        bh=AUgBNqHZDg3w6WYEgHTnrrbmijnfdz+ZvJnKSHNnarg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFtz2VYkZRuahvEDk1uaSzcsNc+pWwnDucypx6RotOctX6ZKRBFPfiQJX6maybWKq
         rK9qG5IP5Qjf88WDbsGaS6qQOa+p6LnXTFDL2E/f4jNs9B4QMBfbaON1PmAX8jBBk0
         1HCl1zhmBhTBi4cE3nZTBTQsyvEOBnjjt1LCmiy8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 081/123] KVM: x86: fix empty-body warnings
Date:   Wed,  5 Dec 2018 04:35:13 -0500
Message-Id: <20181205093555.5386-81-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>

[ Upstream commit 354cb410d87314e2eda344feea84809e4261570a ]

We get the following warnings about empty statements when building
with 'W=1':

arch/x86/kvm/lapic.c:632:53: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1907:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1936:65: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1975:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Rework the debug helper macro to get rid of these warnings.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fbb0e6df121b..fac4e3d53f17 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -55,7 +55,7 @@
 #define PRIo64 "o"
 
 /* #define apic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg) */
-#define apic_debug(fmt, arg...)
+#define apic_debug(fmt, arg...) do {} while (0)
 
 /* 14 is the version for Xeon and Pentium 8.4.8*/
 #define APIC_VERSION			(0x14UL | ((KVM_APIC_LVT_NUM - 1) << 16))
-- 
2.17.1

