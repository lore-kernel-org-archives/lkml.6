Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9AA21908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498709;
	bh=qxD00eVOTwlxzrWWWXt5NQ+DrtKBx7w2zQjBkdz+Rxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJiNNEFbQ87oyxoLr+b8KJkKvtr+oJ7D/9R6g/TASoNJ3GbfhDyYgp22oyjjrU9PA
	 +oGWKIWbTHISsRQmGypOpKmISF4mGXO31hR/XoccyvB8LR/S75w1JZUM3AnjFJLXcL
	 udFEtvuw9p2hLdqgSME2dt6PFTXmjHe6zAJ29qsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfBROFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbfBROFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C97B21902;
        Mon, 18 Feb 2019 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498702;
        bh=qxD00eVOTwlxzrWWWXt5NQ+DrtKBx7w2zQjBkdz+Rxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYbmtv9jFd4RGnD1iz9RccCDWt4mJzD3fmW0QF6/F+cHmld3gyzAnno+yaI7vlaEC
         k7WrccQLIdYiRTw3nNE1MIwyPk+Im3pEmVmlIiKTjba2BE3fBhtD/6vaJg1j+B2c0I
         Qx3YmWhgnWYXKGU3J/PO4EAPEEOneD4fSsm+NFq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Felix Wilhelm <fwilhelm@google.com>, stable@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 093/143] KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)
Date:   Mon, 18 Feb 2019 14:43:41 +0100
Message-Id: <20190218133532.453490941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Shier <pshier@google.com>

commit ecec76885bcfe3294685dc363fd1273df0d5d65f upstream.

Bugzilla: 1671904

There are multiple code paths where an hrtimer may have been started to
emulate an L1 VMX preemption timer that can result in a call to free_nested
without an intervening L2 exit where the hrtimer is normally
cancelled. Unconditionally cancel in free_nested to cover all cases.

Embargoed until Feb 7th 2019.

Signed-off-by: Peter Shier <pshier@google.com>
Reported-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reported-by: Felix Wilhelm <fwilhelm@google.com>
Cc: stable@kernel.org
Message-Id: <20181011184646.154065-1-pshier@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6965,6 +6965,7 @@ static void free_nested(struct vcpu_vmx
 	if (!vmx->nested.vmxon)
 		return;
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon = false;
 	free_vpid(vmx->nested.vpid02);
 	nested_release_vmcs12(vmx);


