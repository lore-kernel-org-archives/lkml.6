Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914222173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129481;
	bh=8fB485zScYWmeSdSrpyYt/oiQq9aCHyEsmrvEW35Jgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d/bjimdNk5ywngqlJ2INt9pllrNVRHD+9exRHk3ffeXOe8cJITpCr8UYHx/XeZivB
	 /yga/fm+DN6xyMcB43wf55taO0bR+X3XXlnTI8GlKw9nt4PGKb/ccB+FV0YDSjXOuI
	 rwD0epQkZcBAeMxPue1MFGtpKywToqKa8qFpwja0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfBYVSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbfBYVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F0C21734;
        Mon, 25 Feb 2019 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129477;
        bh=8fB485zScYWmeSdSrpyYt/oiQq9aCHyEsmrvEW35Jgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdukkWTzCqcKi8wHHAa/r1/Yjeqn2nKCcLoPogcQoye0ZKtcFr8OkfW2loSIO3u2j
         S7dk7xWg4lJjBzJTfQrjJ8iIRVIx1oJRyptZeLm0vp+sRBDi0fyoSvrsDkFbbpBucG
         1gH40uWOpXFKSau1vM0D7WEfHYKG2z4GoS0Sr8j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talons Lee <xin.li@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/71] always clear the X2APIC_ENABLE bit for PV guest
Date:   Mon, 25 Feb 2019 22:11:38 +0100
Message-Id: <20190225195037.236441058@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index fd173e6425ccf..481d7920ea244 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -900,10 +900,7 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
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



