Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D469B222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897945;
	bh=DrEnnnD9ZLAXfmtcIDh46HAQdpdJRYUCdCA6BK/FHx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D51XE1yCPARXC8ITMp7GW4tML2W+z0CbP9pgLjl3v+IkhDrd0W3WaHbcj2TihfQjp
	 OS382MZxSfGN0VcuHHHnMMVsyyFXigCtZ4GZa18wb7x8TuEwGLjJqyhqDCHJutPrHq
	 KK4xsiFNdyQS9fmemE6PttaYlw40AA3Sg6hq8t98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403803AbfBKPKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391783AbfBKPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:10:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EEF222A7;
        Mon, 11 Feb 2019 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897819;
        bh=DrEnnnD9ZLAXfmtcIDh46HAQdpdJRYUCdCA6BK/FHx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvZAHNB3XQItyCOvLKJJouml2r6gUd6sdnNocXqKhuGDwQ8OQCV5jAVusxAkTS+3S
         RWlzn4t8/L3ofuh6idmrM/EPlvrBOAxsRLlpKwaNPRJ9rWg6SUb0/gutJ9cBX7ackP
         idJRwnR+wmCNgSTAoPUV1gzoHRjhFH2igPhmlpcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Wilhelm <fwilhelm@google.com>,
        stable@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 126/137] KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)
Date:   Mon, 11 Feb 2019 15:20:07 +0100
Message-Id: <20190211141823.853663861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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
@@ -4513,6 +4513,13 @@ int kvm_read_guest_virt(struct kvm_vcpu
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


