Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CFFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704F20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790319;
	bh=CqLMntQSb5i5rxe8x//iZt/SRmMl+XaROKACpPzesPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9mEjik7FgmF7qlsTaQyn/5z6CD6tI0KDkgr0z7hPi8y7joEl2nFvXXGsprD2DI3O
	 RcizGDRAFLR7kh/VCkGEP/0r5MYvFfuPjepBxq6uNaXZHEBDkaFBUVrKEkaQcG2G/G
	 uhzkL7DrumLpzTr4NZmOTmUt4x1ZtdEv0CA5NFTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeLNMMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbeLNMM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73B3214E0;
        Fri, 14 Dec 2018 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789546;
        bh=CqLMntQSb5i5rxe8x//iZt/SRmMl+XaROKACpPzesPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIAYSCO28nl687R4hRrjEajvp/urok9Lgi0HA8yPD1qFRzh1m1mI0g6rG5+6JogUI
         7MxBKNAcldxoFtHyl45yhNrSfg0M1vG9McJUkBISnvNDE8Up21mWMQ7CFEF4i9nXSb
         N66hjGPFTD6Hy7sSMnoqIsrNthvZltQfJ8HsplFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 34/51] KVM: x86: fix empty-body warnings
Date:   Fri, 14 Dec 2018 13:00:36 +0100
Message-Id: <20181214115716.288118539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 69a81a7daa24..c8630569e392 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -57,7 +57,7 @@
 #define APIC_BUS_CYCLE_NS 1
 
 /* #define apic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg) */
-#define apic_debug(fmt, arg...)
+#define apic_debug(fmt, arg...) do {} while (0)
 
 /* 14 is the version for Xeon and Pentium 8.4.8*/
 #define APIC_VERSION			(0x14UL | ((KVM_APIC_LVT_NUM - 1) << 16))
-- 
2.19.1



