Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432CC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA032070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501121;
	bh=SIFg7p5YGgJXg/yDWCUqo0HorGhFYAp8GaFvUWWlxLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zoyKJ6Km5VhPN2TzVzzL7nPyBH+6pI8QN9971FwYrCcMTvlLRFBW4BrOAn7AWY4gf
	 A1Wq0LJ58HjEB3lWrZLxIgUjLJiQabHhxdq2QE64OWzs4TJW30oZMvhovwQAOO88XR
	 aR6kYlsqiHxnxTHvrGXExXFNSdLHQ+3ZWdaJpzJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfBRNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbfBRNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB6A218FC;
        Mon, 18 Feb 2019 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497660;
        bh=SIFg7p5YGgJXg/yDWCUqo0HorGhFYAp8GaFvUWWlxLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWiTEKmd2HogMcLY4cF6k+tXe35RBAIu8LViDuUNosB7DP6QGBqZtxZLBD2Jf06Ox
         mZi6EoGs4KLh4HJfZLVbQQjyn+RsVUQseDBFsjfQls65KT65pk9drOBCcgD/S+RI15
         r6llJsgorOKqDSn+//NMizTGVLCjrkP2FkaNsa2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zdenek Kaspar <zkaspar82@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 62/92] x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is available
Date:   Mon, 18 Feb 2019 14:43:05 +0100
Message-Id: <20190218133500.684093015@linuxfoundation.org>
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 6b1971c694975e49af302229202c0043568b1791 upstream.

SDM says MSR_IA32_VMX_PROCBASED_CTLS2 is only available "If
(CPUID.01H:ECX.[5] && IA32_VMX_PROCBASED_CTLS[63])". It was found that
some old cpus (namely "Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz (family: 0x6,
model: 0xf, stepping: 0x6") don't have it. Add the missing check.

Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Tested-by: Zdenek Kaspar <zkaspar82@gmail.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3620,9 +3620,11 @@ static void nested_vmx_setup_ctls_msrs(s
 	 * secondary cpu-based controls.  Do not include those that
 	 * depend on CPUID bits, they are added later by vmx_cpuid_update.
 	 */
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		msrs->secondary_ctls_low,
-		msrs->secondary_ctls_high);
+	if (msrs->procbased_ctls_high & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      msrs->secondary_ctls_low,
+		      msrs->secondary_ctls_high);
+
 	msrs->secondary_ctls_low = 0;
 	msrs->secondary_ctls_high &=
 		SECONDARY_EXEC_DESC |


