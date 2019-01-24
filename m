Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F3EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B88A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359117;
	bh=TkR5yjku+sFkj3oGNLpHalcAr0xbJg+hJF4dEJfHjEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yisIhVNB+jNPT1eMW+OP7G3P8cCRcIT1+cyvYJwRT5IaEqrpBCGGgGllEMVfzvcy0
	 aL7awXevoBguT20QPQ1bItYMVprX+nsjKXcyue17ZQEH4EES7HSUnzXdhAkHpECDfy
	 AluXKqFJjOttPfyP52wN754vHK8d4RKLTsWkH2iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfAXTpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388158AbfAXTo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE74320663;
        Thu, 24 Jan 2019 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359098;
        bh=TkR5yjku+sFkj3oGNLpHalcAr0xbJg+hJF4dEJfHjEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzFUvFj6Tvp6YC4mhGsGIPJfHXiDbn3VgVHK+jmSoKEw8Kexi2kKrqIXaOd3KFqaJ
         HmA2bZ+i5Idadi0KhMvFixzXGLI3Mqi/Zpbz+ZVkIWXCrlmTIJWGU8lDXvpqniz4u8
         1ZMZXlbzwyoFKpdLUI+G4am2ixVUIGTk0Jx0XBBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 111/127] KVM: PPC: Book3S HV: Align gfn to L1 page size when inserting nest-rmap entry
Date:   Thu, 24 Jan 2019 20:20:57 +0100
Message-Id: <20190124190216.702944174@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

[ Upstream commit 8400f8740651c1a3081c30b46004451c448f4d5f ]

Nested rmap entries are used to store the translation from L1 gpa to L2
gpa when entries are inserted into the shadow (nested) page tables. This
rmap list is located by indexing the rmap array in the memslot by L1
gfn. When we come to search for these entries we only know the L1 page size
(which could be PAGE_SIZE, 2M or a 1G page) and so can only select a gfn
aligned to that size. This means that when we insert the entry, so we can
find it later, we need to align the gfn we use to select the rmap list
in which to insert the entry to L1 page size as well.

By not doing this we were missing nested rmap entries when modifying L1
ptes which were for a page also passed through to an L2 guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..fc64535e4c00 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1220,6 +1220,8 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 			return ret;
 		shift = kvmppc_radix_level_to_shift(level);
 	}
+	/* Align gfn to the start of the page */
+	gfn = (gpa & ~((1UL << shift) - 1)) >> PAGE_SHIFT;
 
 	/* 3. Compute the pte we need to insert for nest_gpa -> host r_addr */
 
-- 
2.19.1



