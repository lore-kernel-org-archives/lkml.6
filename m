Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99721486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789179;
	bh=qa2OK8WHl5JBj5ekm5Q+tZWnMc0rxet70iQ5c3n37f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxO4NEEZoBCAevF0xOtL0myq2dc+rkRxjKLstvi9YwMzeMRGbRqwU4htdhc+FwjTU
	 n4gNUjL336KsuT3oCL6xRzMKXjSVyOr3Xru4Wg0pHJlRgjI9y5YMpVA3BnTTvHTey9
	 1vA1VbfsmWlbXGR3j5G41HMPOr6eVvdR51l7paq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeLNMGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbeLNMGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF94A21479;
        Fri, 14 Dec 2018 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789169;
        bh=qa2OK8WHl5JBj5ekm5Q+tZWnMc0rxet70iQ5c3n37f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4KMlBIvkldDjg9946LGA2TuNDraTGVHqGdpYsCF6Eyst8GJzM/b6CtUQtIBvPLta
         ejUEA/RpCX2nJOwoaXKHEXd+a/BA6yUPjnlCwgdU0v3qIkZ6J5gnJlljxWUKzjAIeG
         tRVE26qU8JhLP5qyN9YakfuV1Zfl/UHFEN1gNdW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/142] KVM: x86: fix empty-body warnings
Date:   Fri, 14 Dec 2018 12:59:43 +0100
Message-Id: <20181214115750.974208477@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 2216d21e955d..3692de84c420 100644
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
2.19.1



