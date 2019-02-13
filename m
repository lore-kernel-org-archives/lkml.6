Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF9C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7335421934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026321;
	bh=QXMFJmtv1NrZ/ZTbdJ7PV4nQNJxMxl39LfvUS1R0j7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MD9/DuG7UdylNbqUnGQhyI0Uszr39Cqfcoi44b5O57+H9jVWDaUldAoRm8r+eAod7
	 ehJV0nytoyeqwjMxPyR5SY4iuyuCpHMeVp/91xx5/Q2SgR8bTvqzVZO2skUthkzHIw
	 ul6ZyTAb1cFPbYZAvL3OAx6ZcHFZojX1/Fn5ZWaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbfBMCim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732961AbfBMCii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54745222C9;
        Wed, 13 Feb 2019 02:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025518;
        bh=QXMFJmtv1NrZ/ZTbdJ7PV4nQNJxMxl39LfvUS1R0j7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bllTgDvW12Hij/L6ywf9KWL85SsZmXFA+VHnC+EAwWSQRuUeMRldUHv7Z4eASJlW/
         5cL3GHCDEPhnYVeXFOZrDGAh0a4JD8lmo6WuOoQlhJCXMG+/jiO/7spqmy5oNQGoKU
         Us9oMT+Kkb+87PP4sbmUs+uAw/XXTIEhZiLy9/qk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Talons Lee <xin.li@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 57/83] always clear the X2APIC_ENABLE bit for PV guest
Date:   Tue, 12 Feb 2019 21:36:35 -0500
Message-Id: <20190213023701.20286-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Talons Lee <xin.li@citrix.com>

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
index 52a7c3faee0c..782f98b332f0 100644
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

