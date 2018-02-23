Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413545-2-6947316987410675792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413545; b=YEv2mU2wlEd0NhsjWx61Zp0x7ONnaA7+7BqbXTEqeen5WxN
    YwS9frSD428RTkb4USzz5duyVCbR1D4CULZwm0nUlaw9HXy2F2lLiuXUaq/L0HMe
    CUtDQ+K0rNZyIYHeo68L59X1XNrS4W3FwWp/Jw/JqU53GuvvUGVgwcX/GkC28EJ1
    8Ex5iAPFlpQDks8xy5Iql9i528cqfRqy0NheKKouBe5vko//dq6f8j1Fd7jM2U4p
    WJc4YrqaU9dqDuB/n8CgaGZ1uw2Pak2ygOk2HZmsxuTUHYLdhKk0JtQzeId4S6+T
    5gbIjpa3QeL+LMbjEIV3bfCUDQNmSjmHU//xPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413545; bh=xZNotAfUDq1G5KmpNgBwgjBT8T
    iHMqUPF8fKAUIJpis=; b=ocKzcF6YthdtBsk07qwN2IprN9ypBUDtwXfhrsyWq8
    CG4V/CycXl6KUcPl2um4xtN76DWFjJY9Los6DYHqoIQ5/jy634/SS/rlNs73FLjq
    jAxM+Jt/v7vxxJ1a36j5EVS709/yaind9BjVhOKO2CpyigeMncreFRxqVteMEL1U
    f2bcLufcBMk7TjQfmb22K+R2TR+lp/VuQ7Lg0b29YkHDKrCHoRKf0ToFEyOhnYt/
    juAGLvzKYNzFwWK3tcXg13LEC2CI9vT6Xt/EvSb41Yg6NyKi9Gc+zHWY/L17wQFv
    n2aNeK26pdwQ+QnR9GSJjeNWBBIEzaITlbcQ+BiIaHvQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964920AbeBWSya (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeBWSy3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 077/159] kvm: arm: dont treat unavailable HYP mode as an error
Date: Fri, 23 Feb 2018 19:26:25 +0100
Message-Id: <20180223170752.908581453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>


[ Upstream commit 58d0d19a204604ca0da26058828a53558b265da3 ]

Since it is perfectly legal to run the kernel at EL1, it is not
actually an error if HYP mode is not available when attempting to
initialize KVM, given that KVM support cannot be built as a module.
So demote the kvm_err() to kvm_info(), which prevents the error from
appearing on an otherwise 'quiet' console.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1453,7 +1453,7 @@ int kvm_arch_init(void *opaque)
 	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
-		kvm_err("HYP mode not available\n");
+		kvm_info("HYP mode not available\n");
 		return -ENODEV;
 	}
 
