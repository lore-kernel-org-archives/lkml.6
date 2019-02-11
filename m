Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A985C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBE4222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899259;
	bh=LAXLaIDuFNyna3RLYEU4apQAQ6UxTwyqMJlkAlnUSa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7UiBGYMNH6AqlbFRK+bnAXVsT6XMfp35qtxY9GKeoBKThYt0OFMyu0QE1OsKdZWu
	 ZFO+dgWrMbFlEceCaxGq4CC5AVXSUKlP0SX1dh0VVw878Hc6b3svpIzYVyOXb1vinB
	 sDHzlgI828NaX4I2QijIiP6D0X5pm26x+346/W7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfBKOxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfBKOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78C520844;
        Mon, 11 Feb 2019 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896787;
        bh=LAXLaIDuFNyna3RLYEU4apQAQ6UxTwyqMJlkAlnUSa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9mtaMEsguwGSMU9WzdXSaLHKGgeNjlvNgg5atnk+FqSS5d7SoF/NhPvN7r/s2+qp
         nkx190Q0r94zB7SwVSkg7lqSnuo1RijKJoStd7K3zFcL8XBK2eTy2iyM3sEUZ1vW1v
         JLyQCEtjy6mZPR8J4C7eflPiEVxamVd5vYGP6D7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Felix Wilhelm <fwilhelm@google.com>, stable@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 302/313] KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)
Date:   Mon, 11 Feb 2019 15:19:42 +0100
Message-Id: <20190211141913.047459385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
@@ -8469,6 +8469,7 @@ static void free_nested(struct vcpu_vmx
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	free_vpid(vmx->nested.vpid02);


