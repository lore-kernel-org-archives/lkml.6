Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE68C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E662620879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692180;
	bh=pGAjK0RcMWjl1z04je7yA45W5ky3e6+MUNBieQFlWQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGmA90FQ0J2nqAAuO4UbGllgJxfSb1cEZid5yequqtN+6mXuphJLBZQkB/LqeGhwK
	 jsNWfD+dvlBy368rRpJaiYNmZhAbUtR5xceMIAJX37Lz8VPPbeKLsytKZ1Ty9KQueM
	 ifP75ZlxZY9Hzo+R7skJDKLVqDAyu07Dcms44ETU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfA1QQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbfA1QQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE55920879;
        Mon, 28 Jan 2019 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692174;
        bh=pGAjK0RcMWjl1z04je7yA45W5ky3e6+MUNBieQFlWQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV5Sf8cHFr0lTDqlzoacZPKuyMw3F1RlLFOlZFflDyUY/6INEO2sfOwX5k5+P7WSK
         UU3VZBOI5NPjV1DBYZ5/jNoDFa+GUIZII+zImnp3JOsPAvHp5HifONY9O6+qcir5Pk
         RyYt5AtLOb1tNMM2EtjzL+Ox20g7l2l5Z9GJlc38=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 098/170] KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines
Date:   Mon, 28 Jan 2019 11:10:48 -0500
Message-Id: <20190128161200.55107-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

[ Upstream commit 693ac10a88a2219bde553b2e8460dbec97e594e6 ]

The kvm capability KVM_CAP_SPAPR_TCE_VFIO is used to indicate the
availability of in kernel tce acceleration for vfio. However it is
currently the case that this is only available on a powernv machine,
not for a pseries machine.

Thus make this capability dependent on having the cpu feature
CPU_FTR_HVMODE.

[paulus@ozlabs.org - fixed compilation for Book E.]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/powerpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ecb45361095b..a35995a6b34a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -540,8 +540,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
-		/* fallthrough */
+		r = 1;
+		break;
 	case KVM_CAP_SPAPR_TCE_VFIO:
+		r = !!cpu_has_feature(CPU_FTR_HVMODE);
+		break;
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
 	case KVM_CAP_PPC_ENABLE_HCALL:
-- 
2.19.1

