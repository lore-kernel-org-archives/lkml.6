Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184929-2-10107372190582160922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184928; b=cwxwkognd6jjSoAHPdVYTbYQ3VQvmRkBDEa1QY8YLtLM0in
    Uahzbc0iuWz4Zd7ORFIkK6KtkQq2Dj7EgIRML24AI3nMx/+ot4wKReHHfQJglHCV
    wI7n6Of0F3mC7TDNPWuhDgrW3fmFERqoxldi6bYdwPBMNvf01TwsdHzNZClb0DHr
    OZK3Lk9JWk+ZqzcnYppb2YLMmKCghMpTSxlaMr30ARrHWWcmbDo/AH8dutFmeB/i
    epO4+3rIG15cJ+6upXqu4+bZvBwiRi1SouUjFxOa9NqZDyFMeSa9d6NjWKfw6HfE
    uTZjhrwJ+GUsTKw+VPsK9VZY6ruuubEx6y86uFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184928; bh=BCx3sRTJLEyWNqUzY6Yzm3ktLr
    9M5h3k/ox89elNWY4=; b=dgmcNn7qAMRjyAW0eGXhcfjcJiPRcWVu06ILN3cJ/o
    Fv7GEX92uHaH8onM+jTK5QAuw6zSXEblfLydlSBBfAvm1oYqs6KHNMB9/IbCxyOm
    iTwaiIH9bzNhZEr3tauwG6rA6GDb1ADJKZmEJk0sahQQbINiQylwW7eNGoG6Pq9y
    RKzq3ZCl42IUn76E5PACBTdJvoJuc7onw6rlFrJ2/pXCt5i4fgS/ZdDM55eckP5y
    qv9NCxaossTaYlTZwUPnAOIvKjKeRcsRQ/cAoLKqnTwwuZDHVtmk3U4n+t2jxe5I
    TOK4+qNxac+B3OqBi3sJ0IHAVdDV2J6+Fz6G1dDH2oRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBINnw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:43:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeBINnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 76/92] KVM: nVMX: kmap() cant fail
Date: Fri,  9 Feb 2018 14:39:45 +0100
Message-Id: <20180209133936.717041802@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 42cf014d38d8822cce63703a467e00f65d000952 upstream.

kmap() can't fail, therefore it will always return a valid pointer. Let's
just get rid of the unnecessary checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4756,10 +4756,6 @@ static int vmx_complete_nested_posted_in
 			return 0;
 
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
-		if (!vapic_page) {
-			WARN_ON(1);
-			return -ENOMEM;
-		}
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
 		kunmap(vmx->nested.virtual_apic_page);
 
@@ -9584,11 +9580,6 @@ static inline bool nested_vmx_merge_msr_
 	if (!page)
 		return false;
 	msr_bitmap_l1 = (unsigned long *)kmap(page);
-	if (!msr_bitmap_l1) {
-		nested_release_page_clean(page);
-		WARN_ON(1);
-		return false;
-	}
 
 	memset(msr_bitmap_l0, 0xff, PAGE_SIZE);
 
