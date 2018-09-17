Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C0ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ADE2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ADE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbeIREhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:32 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EC23C49;
        Mon, 17 Sep 2018 23:08:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.18 028/158] KVM: x86: Merge EMULTYPE_RETRY and EMULTYPE_ALLOW_REEXECUTE
Date:   Tue, 18 Sep 2018 00:40:58 +0200
Message-Id: <20180917211712.287204382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 384bf2218e96f57118270945b1841e4dbbe9e352 upstream.

retry_instruction() and reexecute_instruction() are a package deal,
i.e. there is no scenario where one is allowed and the other is not.
Merge their controlling emulation type flags to enforce this in code.
Name the combined flag EMULTYPE_ALLOW_RETRY to make it abundantly
clear that we are allowing re{try,execute} to occur, as opposed to
explicitly requesting retry of a previously failed instruction.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    7 +++----
 arch/x86/kvm/mmu.c              |    2 +-
 arch/x86/kvm/x86.c              |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1198,10 +1198,9 @@ enum emulation_result {
 #define EMULTYPE_NO_DECODE	    (1 << 0)
 #define EMULTYPE_TRAP_UD	    (1 << 1)
 #define EMULTYPE_SKIP		    (1 << 2)
-#define EMULTYPE_RETRY		    (1 << 3)
-#define EMULTYPE_ALLOW_REEXECUTE    (1 << 4)
-#define EMULTYPE_NO_UD_ON_FAIL	    (1 << 5)
-#define EMULTYPE_VMWARE		    (1 << 6)
+#define EMULTYPE_ALLOW_RETRY	    (1 << 3)
+#define EMULTYPE_NO_UD_ON_FAIL	    (1 << 4)
+#define EMULTYPE_VMWARE		    (1 << 5)
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
 			    int emulation_type, void *insn, int insn_len);
 
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4960,7 +4960,7 @@ static int make_mmu_pages_available(stru
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 		       void *insn, int insn_len)
 {
-	int r, emulation_type = EMULTYPE_RETRY | EMULTYPE_ALLOW_REEXECUTE;
+	int r, emulation_type = EMULTYPE_ALLOW_RETRY;
 	enum emulation_result er;
 	bool direct = vcpu->arch.mmu.direct_map;
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5810,7 +5810,7 @@ static bool reexecute_instruction(struct
 	gpa_t gpa = cr2;
 	kvm_pfn_t pfn;
 
-	if (!(emulation_type & EMULTYPE_ALLOW_REEXECUTE))
+	if (!(emulation_type & EMULTYPE_ALLOW_RETRY))
 		return false;
 
 	if (!vcpu->arch.mmu.direct_map) {
@@ -5898,7 +5898,7 @@ static bool retry_instruction(struct x86
 	 */
 	vcpu->arch.last_retry_eip = vcpu->arch.last_retry_addr = 0;
 
-	if (!(emulation_type & EMULTYPE_RETRY))
+	if (!(emulation_type & EMULTYPE_ALLOW_RETRY))
 		return false;
 
 	if (x86_page_table_writing_insn(ctxt))


