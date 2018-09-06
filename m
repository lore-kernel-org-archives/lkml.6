Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7382C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEFB20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/y1GBZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEFB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeIFUKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:10:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45763 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728047AbeIFUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:10:49 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6010521B42;
        Thu,  6 Sep 2018 11:34:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Sep 2018 11:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=zpnhvWLsawef7DJwqfgCQ0RfdzZSB
        96sDgV9EVgXfBg=; b=m/y1GBZKxPRP3vCTNFIoY85AXBbmrUtgKTd0TuI0QlfTl
        jxiBcGOl/931srhMaUuP/VvwQDtz2DAXIihme3gHIf3R3OZZpJt79rXfDasGnVc9
        AynwCRi9VOcUBBBruxeG38Xy4AOMEpCLxOsjkDN68/tkUEiCzi+nFC22irXtONuB
        Bbnvp0/0G5ihaGL/zEn/A5Q058985SpLjCJXUqgTKO6e5HGy4MpQ9rte7rNfQcaF
        pHUn1VS0/xWOLJoSyjjNx4lG4ychoS55BH8YsRlGRkbMjSWTP5POi/QSykq+Pxh6
        T2jxHqZfJorzwmvSnfbndbifLctvgEW84ij51eWKA==
X-ME-Proxy: <xmx:FEmRW4lbEcoRN5hzozeBK7C9lbjcmkPb868FOlER8AHiPGqu7hPTFg>
    <xmx:FEmRWxRFLn9BlhCtnYHaodG66cR0pWaXg4SVLKRSNHJB64ZT8rqQwg>
    <xmx:FEmRW2OvyQ3_n8XWphFaIpkGmj5BfXNGVotsUP-pH-nv36OJTCczXQ>
    <xmx:FEmRW6WyoSNl-M6qapj3tL-HY1RxfBmvZFd4wq1E8RqmKef9EcGoTQ>
    <xmx:FEmRW9c0olMpBuAqBEhF-fAu2S3tqfcCDChedwgj0i7xRh8fA06j2g>
    <xmx:FUmRWwV0iLTGR5x36UtMhlVBAvXJ5drq7fgAvw3W68SJhI7Q7mBYsg>
X-ME-Sender: <xms:FEmRW9FuFLN2dUMvFsDRh9f-tR4Sdrsbg9zS0Lpk4VR4IdhYxkSiZw>
Received: from localhost.localdomain (ip5b40bfaa.dynamic.kabel-deutschland.de [91.64.191.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79D0710292;
        Thu,  6 Sep 2018 11:34:43 -0400 (EDT)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xen/balloon: add runtime control for scrubbing ballooned out pages
Date:   Thu,  6 Sep 2018 17:33:55 +0200
Message-Id: <20180906153355.25363-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scrubbing pages on initial balloon down can take some time, especially
in nested virtualization case (nested EPT is slow). When HVM/PVH guest is
started with memory= significantly lower than maxmem=, all the extra
pages will be scrubbed before returning to Xen. But since most of them
weren't used at all at that point, Xen needs to populate them first
(from populate-on-demand pool). In nested virt case (Xen inside KVM)
this slows down the guest boot by 15-30s with just 1.5GB needed to be
returned to Xen.

Add runtime parameter to enable/disable it, to allow initially disabling
scrubbing, then enable it back during boot (for example in initramfs).
Such usage relies on assumption that a) most pages ballooned out during
initial boot weren't used at all, and b) even if they were, very few
secrets are in the guest at that time (before any serious userspace
kicks in).

Default behaviour is unchanged.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

---
Is module_param() a good thing for this? Other xen-balloon parameters are
in /sys/devices/system/xen_memory, so maybe it would make sense to put
this one there too? But then, cmdline parameter would need to be added
separately and comment about core_param() suggests it shouldn't be used
if not absolutely necessary (is it?).
---
 drivers/xen/Kconfig           |  5 ++++-
 drivers/xen/mem-reservation.c |  7 +++++++
 include/xen/mem-reservation.h | 11 ++++++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b459edfacff3..7b2c771e1813 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -87,7 +87,10 @@ config XEN_SCRUB_PAGES
 	  Scrub pages before returning them to the system for reuse by
 	  other domains.  This makes sure that any confidential data
 	  is not accidentally visible to other domains.  Is it more
-	  secure, but slightly less efficient.
+	  secure, but slightly less efficient. It can be disabled with
+	  mem_reservation.xen_scrub_pages=0 and also controlled at runtime with
+	  /sys/module/mem_reservation/parameters/xen_scrub_pages.
+
 	  If in doubt, say yes.
 
 config XEN_DEV_EVTCHN
diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
index 084799c6180e..5f08e19b6139 100644
--- a/drivers/xen/mem-reservation.c
+++ b/drivers/xen/mem-reservation.c
@@ -14,6 +14,13 @@
 
 #include <xen/interface/memory.h>
 #include <xen/mem-reservation.h>
+#include <linux/moduleparam.h>
+
+#ifdef CONFIG_XEN_SCRUB_PAGES
+bool __read_mostly xen_scrub_pages = true;
+module_param(xen_scrub_pages, bool, 0644);
+MODULE_PARM_DESC(xen_scrub_pages, "Scrub ballooned pages before giving them back to Xen");
+#endif
 
 /*
  * Use one extent per PAGE_SIZE to avoid to break down the page into
diff --git a/include/xen/mem-reservation.h b/include/xen/mem-reservation.h
index 80b52b4945e9..70c08f95bc84 100644
--- a/include/xen/mem-reservation.h
+++ b/include/xen/mem-reservation.h
@@ -17,12 +17,17 @@
 
 #include <xen/page.h>
 
+#ifdef CONFIG_XEN_SCRUB_PAGES
+extern bool xen_scrub_pages;
+
 static inline void xenmem_reservation_scrub_page(struct page *page)
 {
-#ifdef CONFIG_XEN_SCRUB_PAGES
-	clear_highpage(page);
-#endif
+	if (xen_scrub_pages)
+		clear_highpage(page);
 }
+#else
+static inline void xenmem_reservation_scrub_page(struct page *page) { }
+#endif
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
 void __xenmem_reservation_va_mapping_update(unsigned long count,
-- 
2.17.1

