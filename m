Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711296-2-8875920880934259568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711295; b=DZ+TfsrM1B6tcfhAyqg/YaW0jC3dvHcrUcAL1yjyrOuchDW
    qIQ7IlZasSND1DmO3lWWcWPeLOWf6h3FT4u6vLwNYvUyUdh4oBCsycayumxx3AjZ
    U0W4e/32BGwCgHUxa7UmE5xlcp94Xj6tTWFgrYTFoEaMO9kAa6OCyOiYoLguzVs5
    D/jcC0a0l2WkgY+xxGLM92dTc6ChYo072AvHwqzHmFKT9sCkfe3YJZYmCxqYRU94
    JJUi5d+spMebjLHNgH1eA//rsVG4ANGjG1+SkkYCeXm5wv7TAFgNXZaB1Z1yTZAi
    KtqobGNdhio1AcaGN48OF9d+khN57bgjeFN8qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711295; bh=DGurBcl+cwZ7eULoDrMv1kMuhc
    t74mSMOSDiD/y5sRU=; b=Gt7LDbATleZ5piI4sNRkbzDCUaFicFzr6NXb6yo3VF
    HTxjclANhAVjVgC7pOBtyOb1v1XLTZL83ZtliLMvGi3STq809bT0BvvaIobrHPMl
    TfAjriAvKY7P9NPouMKamKB2PJyZIrt9xBvJcyUABs+nAeTaOuviL1TRtsbn+HY3
    HujOmdMeHO4k6TCxJmsgLT6HFkIPZZRUN2otBc4gEgCkvXcRMdAN18/djFaBUXxj
    vrMvtS+WpfDfZGR+C1JKE7VpryvgzVMS+inimXtrqRoI4wy001uB3yZ3eIylalvJ
    9CuFuJS5AOsUyYHUolKMyk4fYiFJuHAnIfxqN1Btru5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424332AbeBOPor (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423899AbeBOPoq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 4.15 135/202] KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED
Date: Thu, 15 Feb 2018 16:17:15 +0100
Message-Id: <20180215151720.202055192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 58d6b15e9da5042a99c9c30ad725792e4569150e upstream.

cpu_pm_enter() calls the pm notifier chain with CPU_PM_ENTER, then if
there is a failure: CPU_PM_ENTER_FAILED.

When KVM receives CPU_PM_ENTER it calls cpu_hyp_reset() which will
return us to the hyp-stub. If we subsequently get a CPU_PM_ENTER_FAILED,
KVM does nothing, leaving the CPU running with the hyp-stub, at odds
with kvm_arm_hardware_enabled.

Add CPU_PM_ENTER_FAILED as a fallthrough for CPU_PM_EXIT, this reloads
KVM based on kvm_arm_hardware_enabled. This is safe even if CPU_PM_ENTER
never gets as far as KVM, as cpu_hyp_reinit() calls cpu_hyp_reset()
to make sure the hyp-stub is loaded before reloading KVM.

Fixes: 67f691976662 ("arm64: kvm: allows kvm cpu hotplug")
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1239,6 +1239,7 @@ static int hyp_init_cpu_pm_notifier(stru
 			cpu_hyp_reset();
 
 		return NOTIFY_OK;
+	case CPU_PM_ENTER_FAILED:
 	case CPU_PM_EXIT:
 		if (__this_cpu_read(kvm_arm_hardware_enabled))
 			/* The hardware was enabled before suspend. */
