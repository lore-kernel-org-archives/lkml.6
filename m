Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518709798-2-15810624686752801503
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
    t=1518709797; b=aya11QzJYwh20SgcKBWSwELpXybFpf/N7Bk/xRceydl2fBH
    0keEw/Vu2rpr/K/OrvGr50XBwhK2uMQexAGJCVB+V7SwzH1dg4sotTLE0PR+avJ7
    ypXDtS13NuB5IV/8b/DaBHhIoEr7/uc3AEC+f3/aqUK/7OYtrSIa3BwRZkV2wOYH
    NcU4SQ0NCROXkWw5daer0Iyid1OHMC5zj/9N8K0vZV911T2TMWx+6PqQLKrMDgi+
    EAdG4zrB5GrYc0VxBv7lVCfRPnletPDeGdu5hUX4y944IRj4ukiAW9OUpQiNs26F
    7WZH/IrEnbNx9/c5ERy4SqVrg5/C8u8woUBAmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709797; bh=kFOi4dntau2/CnUz5QHL265wZ/
    yJOerAnXSJ+HKOE+Y=; b=k5PBt1lKomXrNdvnY1/ahseEMp3RL3atvQLFH1UXx7
    zbFbq8pus32+ZyQFqSnUyP9E6OxDrFHXHJ9UhzRjCcyM0IMOvEIG7rWJzC/AG92e
    baGYbJc9652YXEBf5U4Lir0SbbT6uH3yB40btE7Lr7W415vHSra0lr+MNxLISADO
    irxN/tNcoPHnuqbuogAustqRrK20RkcEUc/7WS5MjoQBzBygrJ2AOuj/aEeMJ34H
    zT+GpRkCbbi8TiiUd2BYvQUPrlbVF6FXP1LWAu31651nCGy5Lb3JfgYXXVxOiugb
    Ie+HD67rb9QYpw4sfN7FMw9csF3wOa5ZCnLs/JNWWxzw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425031AbeBOPsI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:48:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425009AbeBOPsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:48:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.15 171/202] alpha: fix reboot on Avanti platform
Date: Thu, 15 Feb 2018 16:17:51 +0100
Message-Id: <20180215151721.806148164@linuxfoundation.org>
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
@@ -144,7 +144,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
