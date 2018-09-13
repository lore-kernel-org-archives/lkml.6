Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CAA20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CAA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeIMTJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:09:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeIMTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:09:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5464D15;
        Thu, 13 Sep 2018 14:00:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 131/197] kvm: nVMX: Fix fault vector for VMX operation at CPL > 0
Date:   Thu, 13 Sep 2018 15:31:20 +0200
Message-Id: <20180913131846.798471542@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 36090bf43a6b835a42f515cb515ff6fa293a25fe ]

The fault that should be raised for a privilege level violation is #GP
rather than #UD.

Fixes: 727ba748e110b4 ("kvm: nVMX: Enforce cpl=0 for VMX instructions")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8123,7 +8123,7 @@ static int handle_vmon(struct kvm_vcpu *
 
 	/* CPL=0 must be checked manually. */
 	if (vmx_get_cpl(vcpu)) {
-		kvm_queue_exception(vcpu, UD_VECTOR);
+		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
 
@@ -8187,7 +8187,7 @@ static int handle_vmon(struct kvm_vcpu *
 static int nested_vmx_check_permission(struct kvm_vcpu *vcpu)
 {
 	if (vmx_get_cpl(vcpu)) {
-		kvm_queue_exception(vcpu, UD_VECTOR);
+		kvm_inject_gp(vcpu, 0);
 		return 0;
 	}
 


