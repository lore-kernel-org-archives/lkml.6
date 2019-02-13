Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559C6222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025326;
	bh=IBuSxHGGz76Wu4/mNMoAVn5LKItJcaUsRmWRdX7ZJAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TrMKFXiVXoWLcxHguadbVbExchc2/nim0Keanrdd/gsTTWq+zSzvq/9p8F/8AWG+w
	 3+UrbXwqFq8Kb1ZyWhNRGP85duR6ZPY1FUju+n6kSS+2l+x16+rXGvDrjbxfPy9U6Q
	 jFzDXVmIk8iIcGaDpfIGqqw1WaKwYozKh518mwTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfBMCfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbfBMCfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1A2222C7;
        Wed, 13 Feb 2019 02:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025319;
        bh=IBuSxHGGz76Wu4/mNMoAVn5LKItJcaUsRmWRdX7ZJAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlgVwIlszf6SsnMYur3HfpD6Sd4InwQ/3LZVT0qv3pcGZzJP2RM5YZMR35JT/d3Vz
         ByRzNVxTTELqILG3DWONOH05rcZ1qTJTI7vcRApyrRC+7e4qphwTRSEHRQvx3bUnG4
         tk/7ml8+1ypJ0ZEnSjnc/CERGLx1dEyPPLpQeJwk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Talons Lee <xin.li@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 066/105] always clear the X2APIC_ENABLE bit for PV guest
Date:   Tue, 12 Feb 2019 21:32:57 -0500
Message-Id: <20190213023336.19019-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index 2f6787fc7106..c54a493e139a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -898,10 +898,7 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
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

