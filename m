Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA5EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B164204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895660;
	bh=kFi2/JZpQSaYq/fAbyFCu0cZqUCHqBMqtoY0V0ukxpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CVuxETwVdiEmNivYZyWVKUcOtAmjG1LO3J0G/j854/tvmeOWDYLbR1CjHMJTuGee+
	 gFTYrPl6rL7w1lE6mz9LK/lr4DfPnyMjaDN0UUuq4WYTAJ91/meg1UBVOq+vnFaG27
	 ljELZFPsCyYRU0KzNLlkpPlDGOVc9Fj0GFLsKfrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfBKOeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfBKOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48EF204EC;
        Mon, 11 Feb 2019 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895656;
        bh=kFi2/JZpQSaYq/fAbyFCu0cZqUCHqBMqtoY0V0ukxpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJ06OSFQtKGzZ2bW9qNjOwrv865xeFqjzAC7RgqNmajnx8V+c4GdhddPUSuqdtXVC
         7mGpetbfwFonSvOLOy5RF4HqYOtwzOvbogIxYqmTGnqy+GFfods31ekCt3ouyZMva0
         zn5EmjoCrP9h2GiPSA22K+70Gc+C7sR88JdTz+g0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 248/352] kvm: Change offset in kvm_write_guest_offset_cached to unsigned
Date:   Mon, 11 Feb 2019 15:17:55 +0100
Message-Id: <20190211141902.901779005@linuxfoundation.org>
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
index 2679e476b6c3..065ee2fb4034 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1965,7 +1965,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
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



