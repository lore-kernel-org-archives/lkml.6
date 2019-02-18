Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E71217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498358;
	bh=mp2Gv7GiAdsyTbS9Gfag8SEUIbthTuHy0dU/ztQl1Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9Ru0wr1P1Z/ZlTAjj/fN/uIyuPvmpXVyqkmYiL1lYQwnG8GsdHPogeNNa52zt1SG
	 gYFNr9HQAXpI5wnSE9K2Q+YrZw9Sb0e5jVDoiyM8P5THrd+vKJAOOjCIY+V6AgKH0X
	 bQxX//7ohY4S+VJgkSz5KMHiYVh3OAeIBqTR3OcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfBRN7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387427AbfBRN7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74EC72070D;
        Mon, 18 Feb 2019 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498354;
        bh=mp2Gv7GiAdsyTbS9Gfag8SEUIbthTuHy0dU/ztQl1Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3FYaCHmlZbpOo4+ednZCSCOEg5unCMo3TK5ZZsuotpnhMbYrholGN0cm6JCHfMCx
         f9wqtj0JtZHdjk9IZMxYp6XA6mpoPIV/Al/xdN01amHTdmRuXUSwaq7MYOpNLHMBQ3
         L3vTYdDfad9AGWwOQjzTE0D/WeeUN6H62RFbAdLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 41/58] kvm: vmx: Fix entry number check for add_atomic_switch_msr()
Date:   Mon, 18 Feb 2019 14:44:02 +0100
Message-Id: <20190218133511.783677933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

commit 98ae70cc476e833332a2c6bb72f941a25f0de226 upstream.

Commit ca83b4a7f2d068da79a0 ("x86/KVM/VMX: Add find_msr() helper function")
introduces the helper function find_msr(), which returns -ENOENT when
not find the msr in vmx->msr_autoload.guest/host. Correct checking contion
of no more available entry in vmx->msr_autoload.

Fixes: ca83b4a7f2d0 ("x86/KVM/VMX: Add find_msr() helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2178,7 +2178,8 @@ static void add_atomic_switch_msr(struct
 	if (!entry_only)
 		j = find_msr(&m->host, msr);
 
-	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
+	if ((i < 0 && m->guest.nr == NR_AUTOLOAD_MSRS) ||
+		(j < 0 &&  m->host.nr == NR_AUTOLOAD_MSRS)) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;


