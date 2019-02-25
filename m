Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DDC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2D221848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130328;
	bh=mt4I40V4RhhcAojjl14RGeniD6Q2Ap4DNRBIsawmMdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GbsYSZRiV2JkjBe6q5lS4Ql9u9rT/Vd/z2Jqv/IV24F6eWrpQpnmlRfsNBbdXibPc
	 f0PxC+1EXZvRV86Md213v7wSZzpEkKkXM3qKtFHw7hk2Wjshant5EiMtgFfYtyiQyC
	 sfXi9Ef58eQqwcz3Lq0a5WQc44YdmwFCf5SwYoyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfBYVcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbfBYVcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2430121841;
        Mon, 25 Feb 2019 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130321;
        bh=mt4I40V4RhhcAojjl14RGeniD6Q2Ap4DNRBIsawmMdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlcP3YkIhUwTqlGbng2ICQBXfIXc0tQO2O3N6ipk5QD5ZTGL6ETB6lskv09hVG/o6
         5HfyrxOJ/NQ3WdcSMwgMgQQ5zbkbpGsfKYnHabOYmf+gETiLJgJFdGjO5s8G+BpPYz
         xgE64uF7ptyHUE2CaL1PdJlDdhpEIKQevopoBJZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talons Lee <xin.li@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 084/183] always clear the X2APIC_ENABLE bit for PV guest
Date:   Mon, 25 Feb 2019 22:10:57 +0100
Message-Id: <20190225195108.631680562@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 2f6787fc71066..c54a493e139a7 100644
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



