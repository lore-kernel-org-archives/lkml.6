Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411602-2-1850211408705230049
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
    t=1519411601; b=OPFItQuJSDUW1FQ0cPA9Do5pOSv+cM+meB69B94m9xNw1E7
    5li7kILAzS47wvzjeDEnkbvsjy6CoJOr4U1jwqk7ooqPdmF2sPHALbV6X4VhV6KA
    OQJhOe699kv52kUJSyMS4ydN3JUPSNcGnvkCKDPO/wWeNUzWWAYZhBDgBeLlZKX4
    yae4wQBCPpLz6ZiAJbus90pfu4IpQVcO2n9LKyk+9hJBcqtcvIhCCVBO2gmiQdUN
    yASIfBeX4qiD0FilSee4eyY2GEpVQ4gTDVfX041BCyHW6pv7X6SWWDQxIYZuvHpa
    5SoJrwKdicJtrhr5TsZEyQBcWt50cDptNyGUUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411601; bh=bQ3dxiZjRB1iqxm/+ZF2UbXsco
    xDx15XhNDC9KxpVCg=; b=aBo3iLtqC/SbD34gqaOa+PaTwpXhv+NdYTmgb4Gv0i
    DTtZBcZGBwXNsAq1RSWIyJCtuoq0NPy3t9F+FHh2+J8z+KJejLC6/XoenuPKgmTP
    NAKH3PJuOeJ/zMZRVdtbziZ3lookS/4VxNpnb2brGiqTxKSy+/Imzy+0TOXsbsnY
    bYBsJptS8B3cytGjhg9NpWxLyJW9P/lafpZbFj5cdP0+TfTw9ijgYxnZKAi6iZ/V
    8gjXGNfn8zdG+97W1V7sgcrI8uvOxr4ux/bVDo045bG/AgRmDJKhP1zzW2QqrKG+
    W5Sw2YJ2j41tgrANLtAYzoN29s+4k1ziBi5NULRVl1Bw==
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
        id S934017AbeBWSq1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933989AbeBWSqZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 094/145] vmxnet3: prevent building with 64K pages
Date: Fri, 23 Feb 2018 19:26:40 +0100
Message-Id: <20180223170736.973004784@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit fbdf0e28d061708cf18ba0f8e0db5360dc9a15b9 upstream.

I got a warning about broken code on ARM64 with 64K pages:

drivers/net/vmxnet3/vmxnet3_drv.c: In function 'vmxnet3_rq_init':
drivers/net/vmxnet3/vmxnet3_drv.c:1679:29: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
    rq->buf_info[0][i].len = PAGE_SIZE;

'len' here is a 16-bit integer, so this clearly won't work. I don't think
this driver is used much on anything other than x86, so there is no need
to fix this properly and we can work around it with a Kconfig dependency
to forbid known-broken configurations. qemu in theory supports it on
other architectures too, but presumably only for compatibility with x86
guests that also run on vmware.

CONFIG_PAGE_SIZE_64KB is used on hexagon, mips, sh and tile, the other
symbols are architecture-specific names for the same thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -437,6 +437,9 @@ config XEN_NETDEV_BACKEND
 config VMXNET3
 	tristate "VMware VMXNET3 ethernet driver"
 	depends on PCI && INET
+	depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
+		     IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
+		     PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES)
 	help
 	  This driver supports VMware's vmxnet3 virtual ethernet NIC.
 	  To compile this driver as a module, choose M here: the
