Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAB5C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2242820821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738395;
	bh=8Oi6rqaNItEew6sbOdHq397YN3wmCdI7aHVimx5D3nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrApg+BU7lIegQBBiUIEw51rhAwIjY42UJZlqq20mFJPfuPJtqDxdABjziTrjpe20
	 26Gug8FOaM70+l51uGVclrLCVfNCnh/Ri74UU1/e44R3PMNrq89DE/esVC9tcxgiUv
	 hTYwGVpP/QwoXwVKogiOpZL0oR6EyVEgFr0AGuWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfBISxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfBISt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C92E2195D;
        Sat,  9 Feb 2019 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738167;
        bh=8Oi6rqaNItEew6sbOdHq397YN3wmCdI7aHVimx5D3nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vf3khAKos0Bd1YpOXO20M8QIzInUcqW3r02iEBj5cl+AdJxSFQpHsi/a3DrweZeRV
         9S9xtC6KlBQC38d+yIhPs0vB1bS2LKdc7FuXjDlIod2R4E0yi3pvU4HYkicruQh0OZ
         K4iyTOnfcBizNTfPJaDTERLq3RJjgP4U0imb1YHI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/28] kvm: sev: Fail KVM_SEV_INIT if already initialized
Date:   Sat,  9 Feb 2019 13:48:36 -0500
Message-Id: <20190209184840.126418-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

[ Upstream commit 3f14a89d1132dcae3c8ce6721c6ef51f6e6d9b5f ]

By code inspection, it was found that multiple calls to KVM_SEV_INIT
could deplete asid bits and overwrite kvm_sev_info's regions_list.

Multiple calls to KVM_SVM_INIT is not likely to occur with QEMU, but this
should likely be fixed anyway.

This code is serialized by kvm->lock.

Fixes: 1654efcbc431 ("KVM: SVM: Add KVM_SEV_INIT command")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f1d3fe5a0c65..0976853ed723 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6249,6 +6249,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	int asid, ret;
 
 	ret = -EBUSY;
+	if (unlikely(sev->active))
+		return ret;
+
 	asid = sev_asid_new();
 	if (asid < 0)
 		return ret;
-- 
2.19.1

