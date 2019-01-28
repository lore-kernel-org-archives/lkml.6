Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C924AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0002171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691788;
	bh=sJdydmKzAp2rJ6z6ss40IveaxoUYMGUfskY4/xHNGhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNGHM3xRegjEg4AnaYzwefmIsAcGG/UJLrJ16+1Vg21qKebyE+rSHFLPXW1Q1IWkH
	 lxRHMvATd2f1kG+LULR2niIgHcgg0xlzRrRDH1P65J3yF8pAOJFvZBT55VNoakN990
	 +GT1hPs6k3cwqmBM62GAghQP6RY+c7Nwrc0bd1k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfA1QJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731968AbfA1QJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3832084A;
        Mon, 28 Jan 2019 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691780;
        bh=sJdydmKzAp2rJ6z6ss40IveaxoUYMGUfskY4/xHNGhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWGQ75AUpZQtnXpkMn0EMIqER5C7LU8zm6erXxZwQM7jA9ejsPWjaEEUABiO5qn3G
         SS6VX4Ztb+/20t7siy2eM3eBNIPbmDNajY5IzhRyI+U89Dvh9q7/6hlEEozQGGBMr8
         7Rarx8pevZZLu8LINEiN/ExGk0C5b2ZobNEq6odQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 215/258] KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported
Date:   Mon, 28 Jan 2019 10:58:41 -0500
Message-Id: <20190128155924.51521-215-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

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
index f1d3fe5a0c65..02ac8fa0cd6d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5837,6 +5837,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
 
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

