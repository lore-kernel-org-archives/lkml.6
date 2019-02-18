Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173052070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501171;
	bh=1ohTo823P2ljgN71/5zb5WBd3vZ5C4dQ/8Vex5Qri40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDU5LaBprsKhFA6fxkBBlm0ieNXRh7D5UeiEpmDBp07zldhgqg0QX2PehU3zqTqzY
	 zbv1Oh87ssR3B/z1kJO9W2ygpHjpth0M+fkzSgeDAK5pIOEapabrRa+AMQNAs2Kpbm
	 WiHUGqtLUtAshxaNe18Ohtm0n63oA93urw3hp8J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfBRNqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbfBRNqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3B221900;
        Mon, 18 Feb 2019 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497608;
        bh=1ohTo823P2ljgN71/5zb5WBd3vZ5C4dQ/8Vex5Qri40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpI3TaruscMjblWcmIXV5iNrn75JlB9V+cxtw89WFTqepx+Tg+bZMtI7TnlKBzXNd
         97Bex2HSWgQsprvGu2JM3/ML2yp5NQqsvon0ljbfcKWiDSuCo9wlsbolLxHPS9E8gB
         4pJk2KmRLeRwkLRhtSpiAJBwHdTH0OTnmHzyZCYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 45/92] kvm: sev: Fail KVM_SEV_INIT if already initialized
Date:   Mon, 18 Feb 2019 14:42:48 +0100
Message-Id: <20190218133458.924169018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
index 11641d9e7f6f..13baba9d1cc1 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6255,6 +6255,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
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



