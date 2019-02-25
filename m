Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E061B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131489;
	bh=lfdi7Bq2KF6en/Y77Jlp9DrZnO0eGKt8/NX4TWw/7zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVM7ClOEkv2HRSpYYLXxfljG5hFfyJnSwVllJ6wAAtJNgizONGjXWMYD++61reDet
	 zSBB4W1lmPQBgf4MfzoD7nRrt0V8h1aY/RRT2ccRsZNrBe37U7+sDfgeZUktTYCFka
	 Lg/a20fSr1DAwIrPmt2D6afn8f/VdCeiPEf2chek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfBYVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbfBYVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18498217F4;
        Mon, 25 Feb 2019 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129799;
        bh=lfdi7Bq2KF6en/Y77Jlp9DrZnO0eGKt8/NX4TWw/7zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S13ANiS4m4sUqLIFbXaYGymk+EoX9J0mZtcsBIoqXHL7W9Hq+yq3X+qHWZbnSelaX
         br5QgGGHcVmHYV5YUa7HmjW3zVUUcyCXQ3rhwoTls8f1LVYRY9hTw22ajsHf88UjuH
         YmndQbUYoPjNawv+RC9jbZq+8aEJbIigThQor3xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talons Lee <xin.li@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/152] always clear the X2APIC_ENABLE bit for PV guest
Date:   Mon, 25 Feb 2019 22:11:04 +0100
Message-Id: <20190225195048.195039534@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 5268c8f39e0efef81af2aaed160272d9eb507beb ]

Commit e657fcc clears cpu capability bit instead of using fake cpuid
value, the EXTD should always be off for PV guest without depending
on cpuid value. So remove the cpuid check in xen_read_msr_safe() to
always clear the X2APIC_ENABLE bit.

Signed-off-by: Talons Lee <xin.li@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/enlighten_pv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 52a7c3faee0cc..782f98b332f05 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -899,10 +899,7 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
 	val = native_read_msr_safe(msr, err);
 	switch (msr) {
 	case MSR_IA32_APICBASE:
-#ifdef CONFIG_X86_X2APIC
-		if (!(cpuid_ecx(1) & (1 << (X86_FEATURE_X2APIC & 31))))
-#endif
-			val &= ~X2APIC_ENABLE;
+		val &= ~X2APIC_ENABLE;
 		break;
 	}
 	return val;
-- 
2.19.1



