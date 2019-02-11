Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E4021B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900619;
	bh=KpFAjQoWUx4b55EwkKa8aj76oFHaXpuar5iA0KEs/NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HcUqTuT5HtN8GXkwnEprYW7m2DuvGP1m4g6THYfiIV6ZBjxo2U5FSmt+4FTgPrm2u
	 HcYHeFZCSvJjY/yPfKZzEQQh7nWuRHaCBGNUcCQHFq0Bu78kwPDqvAMu+Rq0mefdv9
	 6Ciubu+Llgfuntd/pMtBOKqUUQJefaL5HXnbyOYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfBKP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbfBKOd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D060218A3;
        Mon, 11 Feb 2019 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895638;
        bh=KpFAjQoWUx4b55EwkKa8aj76oFHaXpuar5iA0KEs/NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hJ0IsZB/4Owtrzm+/BwGEMQGjYR/UwL8fMvc3yTRBBHwGh2R9pJw7tDh2ESc6tYJ
         K9vLeVJ0Pzr1HPPlc5WKpJjA2bjDE6fYePbHp4tpMDb3SGIjz3z+VcUBJs8mC7WvHC
         V0n+n8ensTYUNJfdZjfGvAp0UnEkhoBUktDHSHoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 245/352] KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported
Date:   Mon, 11 Feb 2019 15:17:52 +0100
Message-Id: <20190211141902.711191937@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit e87555e550cef4941579cd879759a7c0dee24e68 ]

AMD doesn't seem to implement MSR_IA32_MCG_EXT_CTL and svm code in kvm
knows nothing about it, however, this MSR is among emulated_msrs and
thus returned with KVM_GET_MSR_INDEX_LIST. The consequent KVM_GET_MSRS,
of course, fails.

Report the MSR as unsupported to not confuse userspace.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 101f53ccf571..11641d9e7f6f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5836,6 +5836,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
 
 static bool svm_has_emulated_msr(int index)
 {
+	switch (index) {
+	case MSR_IA32_MCG_EXT_CTL:
+		return false;
+	default:
+		break;
+	}
+
 	return true;
 }
 
-- 
2.19.1



