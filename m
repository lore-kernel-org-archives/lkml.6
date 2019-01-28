Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20674C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188121738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691796;
	bh=D79Vhkw1wT6LAm8nJvuZhuAU68C3l222FxBIx3LGRuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g4vfBVbxYgJm74Sr58oB7BlFDRHdlfAaJWVt5kJMqYtLXhnex/UyKnTg2Slaerriv
	 /pRIHBEWRnmMdzLOgeUiE1fC+M7kNH5yQngnIs+6J2Tj31YVdTeAjbMtfS6TUcLExq
	 QazH9SjBtnGcYFaOvi6js/oeuEchQaqLcuDvpeZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfA1QJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbfA1QJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD97E2147A;
        Mon, 28 Jan 2019 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691789;
        bh=D79Vhkw1wT6LAm8nJvuZhuAU68C3l222FxBIx3LGRuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJHNQ7fTgAwLe2ZtbslMy4cRCDAwu98RszoDIKu5ydd+HweXeFqJ/FcKg32JjjYd7
         lEvysPIBZswVZfEUJ8wlhKYxeSRJdEjvCG1EBIiHJWM1/QKxY4b0rUQVNTSMR4YTHX
         rnY0KF7rrKO6ELVH+LjlPVETvP+whhG5FQuaO1Co=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 217/258] kvm: Change offset in kvm_write_guest_offset_cached to unsigned
Date:   Mon, 28 Jan 2019 10:58:43 -0500
Message-Id: <20190128155924.51521-217-sashal@kernel.org>
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

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 7a86dab8cf2f0fdf508f3555dddfc236623bff60 ]

Since the offset is added directly to the hva from the
gfn_to_hva_cache, a negative offset could result in an out of bounds
write. The existing BUG_ON only checks for addresses beyond the end of
the gfn_to_hva_cache, not for addresses before the start of the
gfn_to_hva_cache.

Note that all current call sites have non-negative offsets.

Fixes: 4ec6e8636256 ("kvm: Introduce kvm_write_guest_offset_cached()")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Cfir Cohen <cfir@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kvm_host.h | 3 ++-
 virt/kvm/kvm_main.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698040e0..a03d5e264e5e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -694,7 +694,8 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, int offset, unsigned long len);
+				  void *data, unsigned int offset,
+				  unsigned long len);
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f986e31fa68c..0ddf81dea6fd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1959,7 +1959,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 EXPORT_SYMBOL_GPL(kvm_gfn_to_hva_cache_init);
 
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, int offset, unsigned long len)
+				  void *data, unsigned int offset,
+				  unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	int r;
-- 
2.19.1

