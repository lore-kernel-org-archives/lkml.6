Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719582-2-7588484105324166263
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
    t=1518719582; b=Jxi9ndQZIF0SabUy57Fu+o+k7EDgVrjL6ILLlOrCJBLRKW4
    b9KCx8YCTQCnLMXkiAWJSsYaCdupYBJ9L9ijn0Yy+Oqp/GgbpaN5pbEupwN3Sl/Q
    ZxXC101O/ci2Wo2Ig36Gm3zbqHNbW1xscYxoCTXGM1wNGHB0FNU7fmP4AjGqGKsx
    GrV/TwPW5ms2QLPqShhxsXo7f4uhypwaJrk7B8Qb76dmikM+n1TtqMHeSWA0/suv
    Qq1ajRqjrdaYTEvbxg6s1f4Vy117B0hJwvvRLiB4KDVCNwUi/OdemOYlRHqTARW4
    bs/B91Nm73+nNfnxq7PMUlLOOoCriBZIhgEYLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719582; bh=w0jbiV1NzUHUAymhdRXvlA3+o4
    WxFWJdzZYI9m2pC0c=; b=FEtnxjFDMjDwCQzXP8cROIxt4hkBLdqM5OK7J553mz
    tl+KMVimZjWsvguYbgBRD+jJYdzvO6bg13YMnCYpuMK24/gFDHr1HeU/Jg9jpILU
    3+ETIUph+4XBnvDVHE66McX8Tl/pDjyr7zKQfuUGocOW2u2DZ3Bt96HsBHRF1qn0
    hspqGYz5jDWH2Ulk1uoLJyjp5ZejthBCIDwORQaOGnhTW/DvClx6Cb4cp42N3bjf
    ZibJtOU96Kgp+OKzvxM7y1DqpVw1y9GKAXy9NyQ89BMALNO+oAjI5oiVpg3Vhg7E
    GCmRYx2XLWqwsJ1eVc1vuXxD7L8mugfzE6kJCJ+BbBNA==
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
        id S1166335AbeBOScP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:32:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033560AbeBOPYv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.4 099/108] alpha: fix reboot on Avanti platform
Date: Thu, 15 Feb 2018 16:17:36 +0100
Message-Id: <20180215151236.171975012@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 55fc633c41a08ce9244ff5f528f420b16b1e04d6 upstream.

We need to define NEED_SRM_SAVE_RESTORE on the Avanti, otherwise we get
machine check exception when attempting to reboot the machine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/pci_impl.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
