Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F893C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A5218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626873;
	bh=aRZtew1b8pQgjvOv9v10uhcBd62aZYLACOWXGRjOtgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ajwt1tHITnU9wPQVP0YxZGC/qg+EWpUl+BCVR6bbe8psH+8dbJg316xwbePuVP2Zx
	 kgHUrXYIb7/PpPMgBiuOrfTNWVir+snDBbVpSS8SDW5cv46q2G9omiOOGlSYjCzZLA
	 evFso/L4OJdts93Dw1fTqbTbYxlcZoiOj3k+qHqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfADSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfADSe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:28 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEA5218FD;
        Fri,  4 Jan 2019 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626866;
        bh=aRZtew1b8pQgjvOv9v10uhcBd62aZYLACOWXGRjOtgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo1o6pTqjKsauZyJV5c3rheETh4JTvqj4HLkKKep+bsuZ2tKJl6dOiZuIjxxjxg5C
         xRselzkZO1CT9HzWrkdiyidxUnxAMGzdhI1B5+jRNm5ZNvfk0M5t79h2jEh5DzWmkP
         DYK4WD2WP315wgPd7TsSe8ZaiWhtMzosMzdEM+MI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 09/16] tools headers uapi: Sync linux/kvm.h with the kernel sources
Date:   Fri,  4 Jan 2019 15:33:30 -0300
Message-Id: <20190104183337.12771-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes from these csets:

  2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
  2a31b9db1535 ("kvm: introduce manual dirty log reprotect")

That results in these new KVM IOCTLs being supported in 'perf trace'
when beautifying the cmd ioctl syscall argument:

  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh > after
  $ diff -u before after
  --- before	2019-01-04 11:44:23.506605301 -0300
  +++ after	2019-01-04 11:44:36.878730583 -0300
  @@ -86,6 +86,8 @@
        [0xbd] = "HYPERV_EVENTFD",
        [0xbe] = "GET_NESTED_STATE",
        [0xbf] = "SET_NESTED_STATE",
  +     [0xc0] = "CLEAR_DIRTY_LOG",
  +     [0xc1] = "GET_SUPPORTED_HV_CPUID",
        [0xe0] = "CREATE_DEVICE",
        [0xe1] = "SET_DEVICE_ATTR",
        [0xe2] = "GET_DEVICE_ATTR",
  $

At some point we should be able to do something:

  # perf trace -e ioctl(cmd == KVM_CLEAR_DIRTY_LOG)

And have just those ioctls, optionally with callchains, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lkml.kernel.org/n/tip-konm3iigl2os6ritt7d2bori@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 2b7a652c9fa4..6d4ea4b6c922 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -492,6 +492,17 @@ struct kvm_dirty_log {
 	};
 };
 
+/* for KVM_CLEAR_DIRTY_LOG */
+struct kvm_clear_dirty_log {
+	__u32 slot;
+	__u32 num_pages;
+	__u64 first_page;
+	union {
+		void __user *dirty_bitmap; /* one bit per page */
+		__u64 padding2;
+	};
+};
+
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
@@ -975,6 +986,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_HYPERV_CPUID 167
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1421,6 +1434,12 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+#define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
+
+/* Available with KVM_CAP_HYPERV_CPUID */
+#define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.20.1

