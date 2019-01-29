Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705521873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762333;
	bh=fGDkwQGhGqzn1maz9TOU/oI8unXySvt4eWGmLqA7f1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v24v4mHChZ08pzJA0EDav9c4HtaZCPukgpBIaVeaP7jWb8pFP0hsFBbf1mVx/06Mh
	 zxunGYSMeREahnQrE6YqjLA+DN9wzROeR3mVTb4A2rn0hnxYZxaI7PApVS885dhuGW
	 JAoeS8kJjnl52flNLhldON5BssZMndTXSBU2nuWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfA2Lpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbfA2Lp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C570214DA;
        Tue, 29 Jan 2019 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762327;
        bh=fGDkwQGhGqzn1maz9TOU/oI8unXySvt4eWGmLqA7f1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPNExKtsyz1pGSUH8eagtQAeGoHx0gKd7RPkdWTwuLeJXTyMfns246ObxT3bI4oZ1
         YooLJHAeTtVfydJxhfZs8SSeUSI4H0CwTgJKeczWEnjn9BdYF3f4vqyE31u5Jgb3Zm
         Zj0KeRWQuh/W0OWKCD/M6gTTy55h7YMitKv8ow/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com,
        Tom Roeder <tmroeder@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 070/103] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Date:   Tue, 29 Jan 2019 12:35:47 +0100
Message-Id: <20190129113204.848390406@linuxfoundation.org>
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

From: Tom Roeder <tmroeder@google.com>

commit 3a33d030daaa7c507e1c12d5adcf828248429593 upstream.

This changes the allocation of cached_vmcs12 to use kzalloc instead of
kmalloc. This removes the information leak found by Syzkaller (see
Reported-by) in this case and prevents similar leaks from happening
based on cached_vmcs12.

It also changes vmx_get_nested_state to copy out the full 4k VMCS12_SIZE
in copy_to_user rather than only the size of the struct.

Tested: rebuilt against head, booted, and ran the syszkaller repro
  https://syzkaller.appspot.com/text?tag=ReproC&x=174efca3400000 without
  observing any problems.

Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Fixes: 8fcc4b5923af5de58b80b53a069453b135693304
Cc: stable@vger.kernel.org
Signed-off-by: Tom Roeder <tmroeder@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8290,11 +8290,11 @@ static int enter_vmx_operation(struct kv
 	if (r < 0)
 		goto out_vmcs02;
 
-	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_vmcs12)
 		goto out_cached_vmcs12;
 
-	vmx->nested.cached_shadow_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_shadow_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_shadow_vmcs12)
 		goto out_cached_shadow_vmcs12;
 
@@ -13984,13 +13984,17 @@ static int vmx_get_nested_state(struct k
 	else if (enable_shadow_vmcs && !vmx->nested.sync_shadow_vmcs)
 		copy_shadow_to_vmcs12(vmx);
 
-	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
+	/*
+	 * Copy over the full allocated size of vmcs12 rather than just the size
+	 * of the struct.
+	 */
+	if (copy_to_user(user_kvm_nested_state->data, vmcs12, VMCS12_SIZE))
 		return -EFAULT;
 
 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != -1ull) {
 		if (copy_to_user(user_kvm_nested_state->data + VMCS12_SIZE,
-				 get_shadow_vmcs12(vcpu), sizeof(*vmcs12)))
+				 get_shadow_vmcs12(vcpu), VMCS12_SIZE))
 			return -EFAULT;
 	}
 


