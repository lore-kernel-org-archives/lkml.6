Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2621C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72640206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896317;
	bh=rXVG99cjSxdmgzwbhht31/B8H3F5o8YAPmO1Ky1vh1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tP0apDi6poNwFnCQNt7ewtStfsXvzHLSmkheOBDDibXS9/XKbArs15VWe2Cvk042r
	 12k7pUdGt4MpL/u1jQWTuQYqZY6FHLmcaI9uO4AriqEGLU9QbrgYyiPP1w0kNVj6h9
	 LJxXMw1/DMnqG5Gy+XQ3l2Sk/FC+GM35b0pxa+Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfBKOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732984AbfBKOpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672D82081B;
        Mon, 11 Feb 2019 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896311;
        bh=rXVG99cjSxdmgzwbhht31/B8H3F5o8YAPmO1Ky1vh1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6VzYpFDOSphJIzclnMQJIW71gM48PX5pBjYkCwzraYKpOzD/R3ux/pAiSGxqLEZB
         BMRKnF4E7eMe7GX0Xxq1cAPBSYyKn4XKeaDipEenaOFDL9vajk78g8wo5Lk+zHKn3W
         lhSMXdmLNPNLzuiQ6O2B+ng9XOvEWpjle4eLeJ9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 142/313] KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines
Date:   Mon, 11 Feb 2019 15:17:02 +0100
Message-Id: <20190211141903.121562526@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index eba5756d5b41..79b79408d92e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -543,8 +543,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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



