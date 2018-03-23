Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804818-2-12935964075302245540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804817; b=Y6VzxMWIEioypC5EeK7UW9Plwlu2pePOnjEwQyTH6esmQsh
    38ZXdMETvC2SVzxMWNwQR0fIM+bp8LMA9PuxHiCxi2JuAMG8ZEO1izBsGrUkx0eY
    ALUzI0wUwqxQV7nXGWMEfzk5R2m2FOs5lhOPKBwyultueVAJEHWjhPCPNd3G+rwR
    dI1sSZXav6uLI+5ll9jBHGv23lfWsd8uGczZ5+5EljxXfOjZ+twdfgqm6zgYrKhd
    J1MdpIE2kA+RiKvtfFlOvgYcgVyGuBC16PnCfpr/U1AfTboO3QuoaxFhos+ro1Nn
    vt+VlBIkR+89g1Sswe1q8iEQwsjLoi8RH2yb6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804817; bh=VGRbTcCGSIergrd3b+dbU+N/sW
    73tGsPv0FG5meewVk=; b=pl3Wg0ooDeb/XBVuPWjks9nz6831edVgaH96qHUqri
    TQddm4+hGos3eQF8DJGJqVyv6m3P9XGHZG85Dvi78/k9ralmWtg1vcafA6aYUS0Y
    YF2cLwzriP14vDgopu7hrjp/8nL7u0Lgg/S/L7mo1++YFgFk1MAmEvQ4E+QCzf49
    wfu48bxpBrgqTxjObE7jjsuD7igb3dS/icORMZ4obgL38FqefGlJBjn44DRRuPMx
    UZUtNLkRWQTJlJrI8OlT58zfUjQx5FVXIDODhWmA+IraKxglGCTy/SOEfz7c3WK0
    svYi+vLpncO6r/8NKF26P/sJMjWmGXewdlmsQD0KUEuw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeCWKFg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbeCWKFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 038/177] iommu/omap: Register driver before setting IOMMU ops
Date: Fri, 23 Mar 2018 10:52:46 +0100
Message-Id: <20180323094206.830518180@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Suman Anna <s-anna@ti.com>


[ Upstream commit abaa7e5b054aae567861628b74dbc7fbf8ed79e8 ]

Move the registration of the OMAP IOMMU platform driver before
setting the IOMMU callbacks on the platform bus. This causes
the IOMMU devices to be probed first before the .add_device()
callback is invoked for all registered devices, and allows
the iommu_group support to be added to the OMAP IOMMU driver.

While at this, also check for the return status from bus_set_iommu.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/omap-iommu.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1299,6 +1299,7 @@ static int __init omap_iommu_init(void)
 	const unsigned long flags = SLAB_HWCACHE_ALIGN;
 	size_t align = 1 << 10; /* L2 pagetable alignement */
 	struct device_node *np;
+	int ret;
 
 	np = of_find_matching_node(NULL, omap_iommu_of_match);
 	if (!np)
@@ -1312,11 +1313,25 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep = p;
 
-	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
-
 	omap_iommu_debugfs_init();
 
-	return platform_driver_register(&omap_iommu_driver);
+	ret = platform_driver_register(&omap_iommu_driver);
+	if (ret) {
+		pr_err("%s: failed to register driver\n", __func__);
+		goto fail_driver;
+	}
+
+	ret = bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
+	if (ret)
+		goto fail_bus;
+
+	return 0;
+
+fail_bus:
+	platform_driver_unregister(&omap_iommu_driver);
+fail_driver:
+	kmem_cache_destroy(iopte_cachep);
+	return ret;
 }
 subsys_initcall(omap_iommu_init);
 /* must be ready before omap3isp is probed */
