Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732879-1521003830-2-3239671150940555172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521003830; b=nC4YOTmYfvBTEtC/ox03u0Y33fMgK5lHv6qUO5L1i/SFi8B
    YolSbyRh9/fKCZycXTzhOgyqFLRsDUkTI5TYsNxt5UJ0SE5vjNa2SzRwJUG3C2ue
    AfDof2O7anZJS95m32tFbwj5H75ehV4MD06uCVUrBcJBxvO3PLoNtualS63S3OZR
    8WyFBrQx2PnFdJhoWmC/CsiwwOkN1MXKqVtaKPSR3L7rUEAZaeEtiXhT2dcbE4ge
    AKV4vKhOBGBP5bSRaWXZSgQVyfNCn/XN09Vt9vrKMQXbpmPfQg8/U4Md2TxnbG9n
    WXhvI746PvUC2j0q0ogE+AMx2d8LbF8jJfzup6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521003830; bh=ZyEtJzkGUUlEwixQb9y/d36sq4imjAU2z42
    OxXEshUE=; b=u/bHi3tzbD1Z984Jwd+MA7hbCokYN4aeDDVmf0FdUBXEIDqTxJW
    PW/RZfJ8pito6WB+smfOBSVlCuX3LWW4wkCUQvw5J5upwID48Ze73LjmdTIpCPHW
    gt2J3gw0KLW791SVaMGd62fhbhBG1o098iAqbzfJWE8bRmv0QruqaK6EVsl8Bb+z
    MKcnNvNjOoxZQotzYn9WDq3lmn5MNNoYW18S71CPSm6YUBSHue/c4x88Sr8eWHsH
    vdEqxe18f1ymUGphELo2i4guO6OLKuASTRWzjB1rcHTB1yJnssjZi0rT1le2MwFB
    8j4M4a09i5+Nb5HEIC7LbaK5fn9JZv+CBqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750758AbeCNFDe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 01:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753246AbeCNFDT (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 01:03:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263E21796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Stas Sergeev <stsp@list.ru>,
        bartoldeman@gmail.com, Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 3/3] x86/vm86/32: Fix POPF emulation
Date: Tue, 13 Mar 2018 22:03:12 -0700
Message-Id: <ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

POPF would trap if VIP was set regardless of whether IF was set.  Fix it.

Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Suggested-by: Stas Sergeev <stsp@list.ru>
Cc: stable@vger.kernel.org
Fixes: 5ed92a8ab71f ("x86/vm86: Use the normal pt_regs area for vm86")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/vm86_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 5edb27f1a2c4..9d0b5af7db91 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -727,7 +727,8 @@ void handle_vm86_fault(struct kernel_vm86_regs *regs, long error_code)
 	return;
 
 check_vip:
-	if (VEFLAGS & X86_EFLAGS_VIP) {
+	if ((VEFLAGS & (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) ==
+	    (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) {
 		save_v86_state(regs, VM86_STI);
 		return;
 	}
-- 
2.14.3
