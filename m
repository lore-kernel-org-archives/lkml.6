Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2851F20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130759;
	bh=nZu2UMzLC/4orPMGqHDqqmWVsFDluLpgFpjWIpDVUf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUbIzt0bIW19/t49FE8JJJ4sNc7htm0LkP4P1vlVkWQhu96zP8l/eneOnwPyOjcYb
	 M/ARMTE9WWBqs0Oky4iKbL5oFIYmtRkchH6mnl3q7A1hhc0z+vJYoBXbgr5tYpEbVZ
	 Kem3IJCRyC30soUWVrc1pzcZXNPZMJZnY6zUuDBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfBYVgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733126AbfBYVgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D61E21841;
        Mon, 25 Feb 2019 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130571;
        bh=nZu2UMzLC/4orPMGqHDqqmWVsFDluLpgFpjWIpDVUf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/HaVA/4U3WZfFfEsFe4kKBPEPDIljKEB4823GbDjSkI0RHzW+66Y3QT9MgWIE5Z1
         +3Qx43agBf2O/I3eQscBXCNXU4jgg5dYbdUk0GzaNAEIqif4nsqN1EQL7RQnfdDclP
         tms8Mm4hOffiz+eYLWMlcQiT76FLTFErliLbhzkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 163/183] KVM: MMU: record maximum physical address width in kvm_mmu_extended_role
Date:   Mon, 25 Feb 2019 22:12:16 +0100
Message-Id: <20190225195122.544638829@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

commit de3ccd26fafc707b09792d9b633c8b5b48865315 upstream.

Previously, commit 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow
MMU reconfiguration is needed") offered some optimization to avoid
the unnecessary reconfiguration. Yet one scenario is broken - when
cpuid changes VM's maximum physical address width, reconfiguration
is needed to reset the reserved bits.  Also, the TDP may need to
reset its shadow_root_level when this value is changed.

To fix this, a new field, maxphyaddr, is introduced in the extended
role structure to keep track of the configured guest physical address
width.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/mmu.c              |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -299,6 +299,7 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_smap:1;
 		unsigned int cr4_smep:1;
 		unsigned int cr4_la57:1;
+		unsigned int maxphyaddr:6;
 	};
 };
 
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4731,6 +4731,7 @@ static union kvm_mmu_extended_role kvm_c
 	ext.cr4_pse = !!is_pse(vcpu);
 	ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
 	ext.cr4_la57 = !!kvm_read_cr4_bits(vcpu, X86_CR4_LA57);
+	ext.maxphyaddr = cpuid_maxphyaddr(vcpu);
 
 	ext.valid = 1;
 


