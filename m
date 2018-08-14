Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5EB21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5EB21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbeHNUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389765AbeHNUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:48 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E8E640B;
        Tue, 14 Aug 2018 17:31:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.17 68/97] x86/kvm: Serialize L1D flush parameter setter
Date:   Tue, 14 Aug 2018 19:17:20 +0200
Message-Id: <20180814171435.733143468@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit dd4bfa739a72508b75760b393d129ed7b431daab upstream

Writes to the parameter files are not serialized at the sysfs core
level, so local serialization is required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.873642605@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -193,6 +193,7 @@ extern const ulong vmx_return;
 
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_always);
+static DEFINE_MUTEX(vmx_l1d_flush_mutex);
 
 /* Storage for pre module init parameter parsing */
 static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush_param = VMENTER_L1D_FLUSH_AUTO;
@@ -257,7 +258,7 @@ static int vmentry_l1d_flush_parse(const
 
 static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
 {
-	int l1tf;
+	int l1tf, ret;
 
 	if (!boot_cpu_has(X86_BUG_L1TF))
 		return 0;
@@ -277,7 +278,10 @@ static int vmentry_l1d_flush_set(const c
 		return 0;
 	}
 
-	return vmx_setup_l1d_flush(l1tf);
+	mutex_lock(&vmx_l1d_flush_mutex);
+	ret = vmx_setup_l1d_flush(l1tf);
+	mutex_unlock(&vmx_l1d_flush_mutex);
+	return ret;
 }
 
 static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)


