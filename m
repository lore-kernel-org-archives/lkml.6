Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720295-2-6950305259897949571
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
    t=1518720294; b=R45zw+ClhHlCKCu/s3RqQOXQKXmQFSmJhtyXz/uDGqzjFnD
    Vlq3qrLIo78kibX9A5UCDedsXqbPiTxEUcx5k/b45TapXSs2k69ylhnSe+y3vrUS
    0LIdeTqgKBkxzIAfkK+OTempn/Wieu7CvZDVuvJ4w7oPi3U4kww1f4Tc7JiI4Ixr
    I6SiTR/LZ0QDWSyBJKakrim1a/3m8MPJxiUrAhuJtSG+yZzIzjfB2/IpuVIKQRUO
    6E8z/KV/H9avrIalg9yAZvnhcKLBdbB4A7ly8PjDtQb6RMbtHaruLKVy/KbNS0F1
    BArUJjC3Pua3Jt4jwZ8I28FXszh7f6/j24WxD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720294; bh=W434HqLNjxqYGO/9T3OiuXUo4H
    6gC5DU3Bkh4lgG+XQ=; b=ZfYQoerbskUqjJgvoNLC5jx/28+31ix6Wzd8zhQsXx
    cHqn+tIUAp/OsKaBV24DNMKK/uX9viZwWs+N8Qi1xWDNxsdpJW307/PW6DzQpPkJ
    YeNZVjJvG3qBpr32/B/UNYS9z4k2nz1sYwUJtwsfZladIpSQU4IYWhP72FQUw1A7
    UFG6yxLzv0HULs5iL/ytAXEQwTIUfw5xZwyv1SgI1Gqq3yX4dCzYTWyoqFCEUBKv
    bRf6Ab7e4Kugvo4uyu+l0h1RGpCHGFS9egh7Uu2IJH/PTp0TrZl7kKrAA287gBny
    S2XvCFLiizKkAy9HDzPXmqtLjPvM37iZlkq5I9QppxOw==
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
        id S1162529AbeBOPXC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPXA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 014/108] powerpc/powernv: Check device-tree for RFI flush settings
Date: Thu, 15 Feb 2018 16:16:11 +0100
Message-Id: <20180215151224.462003315@linuxfoundation.org>
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

From: Oliver O'Halloran <oohall@gmail.com>

commit 6e032b350cd1fdb830f18f8320ef0e13b4e24094 upstream.

New device-tree properties are available which tell the hypervisor
settings related to the RFI flush. Use them to determine the
appropriate flush instruction to use, and whether the flush is
required.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/setup.c |   50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -35,13 +35,63 @@
 #include <asm/opal.h>
 #include <asm/kexec.h>
 #include <asm/smp.h>
+#include <asm/tm.h>
+#include <asm/setup.h>
 
 #include "powernv.h"
 
+static void pnv_setup_rfi_flush(void)
+{
+	struct device_node *np, *fw_features;
+	enum l1d_flush_type type;
+	int enable;
+
+	/* Default to fallback in case fw-features are not available */
+	type = L1D_FLUSH_FALLBACK;
+	enable = 1;
+
+	np = of_find_node_by_name(NULL, "ibm,opal");
+	fw_features = of_get_child_by_name(np, "fw-features");
+	of_node_put(np);
+
+	if (fw_features) {
+		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
+		if (np && of_property_read_bool(np, "enabled"))
+			type = L1D_FLUSH_MTTRIG;
+
+		of_node_put(np);
+
+		np = of_get_child_by_name(fw_features, "inst-l1d-flush-ori30,30,0");
+		if (np && of_property_read_bool(np, "enabled"))
+			type = L1D_FLUSH_ORI;
+
+		of_node_put(np);
+
+		/* Enable unless firmware says NOT to */
+		enable = 2;
+		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-hv-1-to-0");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable--;
+
+		of_node_put(np);
+
+		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-pr-0-to-1");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable--;
+
+		of_node_put(np);
+		of_node_put(fw_features);
+	}
+
+	setup_rfi_flush(type, enable > 0);
+}
+
 static void __init pnv_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
 
+	pnv_setup_rfi_flush();
+
 	/* Initialize SMP */
 	pnv_smp_init();
 
