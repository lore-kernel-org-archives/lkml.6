Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8348C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7537B20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7537B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbeIHCGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:06:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeIHCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:06:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B24C6EF6;
        Fri,  7 Sep 2018 21:23:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bandan Das <bsd@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.18 093/145] KVM: VMX: fixes for vmentry_l1d_flush module parameter
Date:   Fri,  7 Sep 2018 23:09:19 +0200
Message-Id: <20180907210911.644705014@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 0027ff2a75f9dcf0537ac0a65c5840b0e21a4950 upstream.

Two bug fixes:

1) missing entries in the l1d_param array; this can cause a host crash
if an access attempts to reach the missing entry. Future-proof the get
function against any overflows as well.  However, the two entries
VMENTER_L1D_FLUSH_EPT_DISABLED and VMENTER_L1D_FLUSH_NOT_REQUIRED must
not be accepted by the parse function, so disable them there.

2) invalid values must be rejected even if the CPU does not have the
bug, so test for them before checking boot_cpu_has(X86_BUG_L1TF)

... and a small refactoring, since the .cmd field is redundant with
the index in the array.

Reported-by: Bandan Das <bsd@redhat.com>
Cc: stable@vger.kernel.org
Fixes: a7b9020b06ec6d7c3f3b0d4ef1a9eba12654f4f7
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -197,12 +197,14 @@ static enum vmx_l1d_flush_state __read_m
 
 static const struct {
 	const char *option;
-	enum vmx_l1d_flush_state cmd;
+	bool for_parse;
 } vmentry_l1d_param[] = {
-	{"auto",	VMENTER_L1D_FLUSH_AUTO},
-	{"never",	VMENTER_L1D_FLUSH_NEVER},
-	{"cond",	VMENTER_L1D_FLUSH_COND},
-	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
+	[VMENTER_L1D_FLUSH_AUTO]	 = {"auto", true},
+	[VMENTER_L1D_FLUSH_NEVER]	 = {"never", true},
+	[VMENTER_L1D_FLUSH_COND]	 = {"cond", true},
+	[VMENTER_L1D_FLUSH_ALWAYS]	 = {"always", true},
+	[VMENTER_L1D_FLUSH_EPT_DISABLED] = {"EPT disabled", false},
+	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
 };
 
 #define L1D_CACHE_ORDER 4
@@ -286,8 +288,9 @@ static int vmentry_l1d_flush_parse(const
 
 	if (s) {
 		for (i = 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
-			if (sysfs_streq(s, vmentry_l1d_param[i].option))
-				return vmentry_l1d_param[i].cmd;
+			if (vmentry_l1d_param[i].for_parse &&
+			    sysfs_streq(s, vmentry_l1d_param[i].option))
+				return i;
 		}
 	}
 	return -EINVAL;
@@ -297,13 +300,13 @@ static int vmentry_l1d_flush_set(const c
 {
 	int l1tf, ret;
 
-	if (!boot_cpu_has(X86_BUG_L1TF))
-		return 0;
-
 	l1tf = vmentry_l1d_flush_parse(s);
 	if (l1tf < 0)
 		return l1tf;
 
+	if (!boot_cpu_has(X86_BUG_L1TF))
+		return 0;
+
 	/*
 	 * Has vmx_init() run already? If not then this is the pre init
 	 * parameter parsing. In that case just store the value and let
@@ -323,6 +326,9 @@ static int vmentry_l1d_flush_set(const c
 
 static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
 {
+	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
+		return sprintf(s, "???\n");
+
 	return sprintf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
 }
 


