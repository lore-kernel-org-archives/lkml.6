Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB765C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1F02086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762340;
	bh=k4LT62um8fDMfwwIYU1HAUpcq/tcyMVMj64I1TSft+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JZCh9B8RxAM6z1SXydEj7Fo3LLEBcqXpL7x0s1g+7QyjzA6hutka+pWPSJwiOVvXz
	 mTzPoLlHT3MEYoOpdqgSeq4wHlUFDu/zYXik2WbsMvmWYHPr0/TCzqxCiZhCwAa+6w
	 A4EEzSw5/cfld/EqKZFJRhS9tSZJZCsc2fLY5tmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfA2Lpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbfA2Lpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D7020882;
        Tue, 29 Jan 2019 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762330;
        bh=k4LT62um8fDMfwwIYU1HAUpcq/tcyMVMj64I1TSft+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyemBRLU4sfBu7Dix2tlB5IYwUB+F5sHT99v2xZdAHcI1NKbo37rGjXd3jQWWFFgL
         IaVUlJnYyzaaNam226O1kKIIavGqp60TqL6KTKF8yjMdVInzCvkQ+xjCtw99AMG29W
         A8daQ4aVFui/aLLlEA8nc/e0Mupz6OEF/0nxNZvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Krish Sadhuhan <krish.sadhukhan@oracle.com>
Subject: [PATCH 4.19 071/103] KVM/nVMX: Do not validate that posted_intr_desc_addr is page aligned
Date:   Tue, 29 Jan 2019 12:35:48 +0100
Message-Id: <20190129113204.915630475@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 22a7cdcae6a4a3c8974899e62851d270956f58ce upstream.

The spec only requires the posted interrupt descriptor address to be
64-bytes aligned (i.e. bits[0:5] == 0). Using page_address_valid also
forces the address to be page aligned.

Only validate that the address does not cross the maximum physical address
without enforcing a page alignment.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 6de84e581c0 ("nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2")
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Krish Sadhuhan <krish.sadhukhan@oracle.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
From: Mark Mielke <mark.mielke@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11733,7 +11733,7 @@ static int nested_vmx_check_apicv_contro
 	    !nested_exit_intr_ack_set(vcpu) ||
 	    (vmcs12->posted_intr_nv & 0xff00) ||
 	    (vmcs12->posted_intr_desc_addr & 0x3f) ||
-	    (!page_address_valid(vcpu, vmcs12->posted_intr_desc_addr))))
+	    (vmcs12->posted_intr_desc_addr >> cpuid_maxphyaddr(vcpu))))
 		return -EINVAL;
 
 	/* tpr shadow is needed by all apicv features. */


