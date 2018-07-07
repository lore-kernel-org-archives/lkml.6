Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D2FC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792BC21A2E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792BC21A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeGGJLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:11:31 -0400
Received: from www.osadl.org ([62.245.132.105]:60914 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeGGJL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:11:29 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w67983ii032529;
        Sat, 7 Jul 2018 11:08:03 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     "Author: Paul Mackerras" <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] KVM: PPC: Book3S HV: fix constant size warning
Date:   Sat,  7 Jul 2018 11:07:25 +0200
Message-Id: <1530954445-6780-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The constants are 64bit but not explicitly declared UL resulting
in sparse warnings. Fixed by declaring the constants UL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

sparse fallout from compile checking book3s_hv.c:
arch/powerpc/kvm/book3s_hv.c:141:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:142:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:143:9: warning: constant 0x7FFF2908450D8DA9 is so big it is long
arch/powerpc/kvm/book3s_hv.c:144:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:145:9: warning: constant 0x199A421245058DA9 is so big it is long
arch/powerpc/kvm/book3s_hv.c:146:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:147:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:148:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:149:9: warning: constant 0x164520C62609AECA is so big it is long
arch/powerpc/kvm/book3s_hv.c:1667:60: warning: constant 0xf0000000000003ff is so big it is unsigned long
arch/powerpc/kvm/book3s_hv.c:2896:42: warning: constant 0x164520C62609AECA is so big it is long

most of the warnings are local constants in book3s_hv.c, PSSCR_GUEST_VIS
from reg.h is not. Although PSSCR_GUEST_VIS is not #ifdef CONFIG_PPC_BOOK3S
it seems only to be used in that particular platform (check with cscope).

The constants fit in the target variables so the size declaration 
discrepancy does not actually cause a problem here.

Patch was compiletested with: ppc64_defconfig (implies
CONFIG_KVM=y, CONFIG_KVM_BOOK3S_64_HV=m)

Patch is against 4.18-rc3 (localversion-next is next-20180705)

 arch/powerpc/include/asm/reg.h |  2 +-
 arch/powerpc/kvm/book3s_hv.c   | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5625684..858aa79 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -161,7 +161,7 @@
 #define PSSCR_ESL		0x00200000 /* Enable State Loss */
 #define PSSCR_SD		0x00400000 /* Status Disable */
 #define PSSCR_PLS	0xf000000000000000 /* Power-saving Level Status */
-#define PSSCR_GUEST_VIS	0xf0000000000003ff /* Guest-visible PSSCR fields */
+#define PSSCR_GUEST_VIS	0xf0000000000003ffUL /* Guest-visible PSSCR fields */
 #define PSSCR_FAKE_SUSPEND	0x00000400 /* Fake-suspend bit (P9 DD2.2) */
 #define PSSCR_FAKE_SUSPEND_LG	10	   /* Fake-suspend bit position */
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ee4a885..c517859 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -128,14 +128,14 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
  * and SPURR count and should be set according to the number of
  * online threads in the vcore being run.
  */
-#define RWMR_RPA_P8_1THREAD	0x164520C62609AECA
-#define RWMR_RPA_P8_2THREAD	0x7FFF2908450D8DA9
-#define RWMR_RPA_P8_3THREAD	0x164520C62609AECA
-#define RWMR_RPA_P8_4THREAD	0x199A421245058DA9
-#define RWMR_RPA_P8_5THREAD	0x164520C62609AECA
-#define RWMR_RPA_P8_6THREAD	0x164520C62609AECA
-#define RWMR_RPA_P8_7THREAD	0x164520C62609AECA
-#define RWMR_RPA_P8_8THREAD	0x164520C62609AECA
+#define RWMR_RPA_P8_1THREAD	0x164520C62609AECAUL
+#define RWMR_RPA_P8_2THREAD	0x7FFF2908450D8DA9UL
+#define RWMR_RPA_P8_3THREAD	0x164520C62609AECAUL
+#define RWMR_RPA_P8_4THREAD	0x199A421245058DA9UL
+#define RWMR_RPA_P8_5THREAD	0x164520C62609AECAUL
+#define RWMR_RPA_P8_6THREAD	0x164520C62609AECAUL
+#define RWMR_RPA_P8_7THREAD	0x164520C62609AECAUL
+#define RWMR_RPA_P8_8THREAD	0x164520C62609AECAUL
 
 static unsigned long p8_rwmr_values[MAX_SMT_THREADS + 1] = {
 	RWMR_RPA_P8_1THREAD,
-- 
2.1.4

