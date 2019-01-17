Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84311C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfAQRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:12:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfAQRMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:12:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 517FC5D67E;
        Thu, 17 Jan 2019 17:12:23 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8FC5ED24;
        Thu, 17 Jan 2019 17:12:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 2/2] KVM: selftests: check returned evmcs version range
Date:   Thu, 17 Jan 2019 18:12:10 +0100
Message-Id: <20190117171210.9493-3-vkuznets@redhat.com>
In-Reply-To: <20190117171210.9493-1-vkuznets@redhat.com>
References: <20190117171210.9493-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Jan 2019 17:12:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that KVM_CAP_HYPERV_ENLIGHTENED_VMCS returns correct version range.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index ea3c73e8f4f6..c49c2a28b0eb 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -103,6 +103,12 @@ int main(int argc, char *argv[])
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
 
+	/* KVM should return supported EVMCS version range */
+	TEST_ASSERT(((evmcs_ver >> 8) >= (evmcs_ver & 0xff)) &&
+		    (evmcs_ver & 0xff) > 0,
+		    "Incorrect EVMCS version range: %x:%x\n",
+		    evmcs_ver & 0xff, evmcs_ver >> 8);
+
 	run = vcpu_state(vm, VCPU_ID);
 
 	vcpu_regs_get(vm, VCPU_ID, &regs1);
-- 
2.20.1

