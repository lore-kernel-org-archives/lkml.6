Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D0221901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498705;
	bh=qpvnPINqk/FmxpqDBcnXpRExdi6gNI/J38+G+yhPuuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cd9SLuy6WESfcfCSYdQWsbxSjVkRf0Rf3sTW18ugXQR+u9e0XBQuZn6qDOmd6xxcl
	 K6SOl96veFmWqP2bdo5fjBjubGwE2bhyaudUAcZQzujXwcUjgQugB/bqdLvTFP7rqV
	 d20zAcTdEgbrQ4O5K8exedcTCXl5zfHZsRc7QXS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbfBROFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389152AbfBROFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CDCC21901;
        Mon, 18 Feb 2019 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498700;
        bh=qpvnPINqk/FmxpqDBcnXpRExdi6gNI/J38+G+yhPuuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGl9lgbnr5cv6TlPjzhSCeOtkkbmN3WUrqqERZJcEpvVL5+9BKTDGWSyjhFE+VWJZ
         /Jo1mMQH2uDH7d471TqCrHUKoJZE0Ozgpbg4yNJ6krtTOv4K0YETUUeKtFFZTddVJc
         mJmaafKejQpKr8FFODA2K5qm9ds+x5NdHjxAqoLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Wilhelm <fwilhelm@google.com>,
        stable@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 092/143] KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)
Date:   Mon, 18 Feb 2019 14:43:40 +0100
Message-Id: <20190218133532.418002402@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 353c0956a618a07ba4bbe7ad00ff29fe70e8412a upstream.

Bugzilla: 1671930

Emulation of certain instructions (VMXON, VMCLEAR, VMPTRLD, VMWRITE with
memory operand, INVEPT, INVVPID) can incorrectly inject a page fault
when passed an operand that points to an MMIO address.  The page fault
will use uninitialized kernel stack memory as the CR2 and error code.

The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
exit to userspace; however, it is not an easy fix, so for now just
ensure that the error code and CR2 are zero.

Embargoed until Feb 7th 2019.

Reported-by: Felix Wilhelm <fwilhelm@google.com>
Cc: stable@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4247,6 +4247,13 @@ int kvm_read_guest_virt(struct kvm_vcpu
 {
 	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 
+	/*
+	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
+	 * is returned, but our callers are not ready for that and they blindly
+	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
+	 * uninitialized kernel stack memory into cr2 and error code.
+	 */
+	memset(exception, 0, sizeof(*exception));
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
 					  exception);
 }


