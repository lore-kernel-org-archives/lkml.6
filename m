Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2F433C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63620839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934486AbeFKVuv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932946AbeFKVuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:50:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2092E285B1;
        Mon, 11 Jun 2018 21:50:50 +0000 (UTC)
Received: from gimli.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE7F6183D2;
        Mon, 11 Jun 2018 21:50:46 +0000 (UTC)
Subject: [PATCH] vfio/pci: Make IGD support a configurable option
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jun 2018 15:50:46 -0600
Message-ID: <20180611215018.21036.69691.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Jun 2018 21:50:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the code which provides extensions to support direct assignment
of Intel IGD (GVT-d) to be compiled out of the kernel if desired.  The
config option for this was previously automatically enabled on X86,
therefore the default remains Y.  This simply provides the option to
disable it even for X86.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/Kconfig |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 24ee2605b9f0..42dc1d3d71cf 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -28,5 +28,13 @@ config VFIO_PCI_INTX
 	def_bool y if !S390
 
 config VFIO_PCI_IGD
-	depends on VFIO_PCI
-	def_bool y if X86
+	bool "VFIO PCI extensions for Intel graphics (GVT-d)"
+	depends on VFIO_PCI && X86
+	default y
+	help
+	  Support for Intel IGD specific extensions to enable direct
+	  assignment to virtual machines.  This includes exposing an IGD
+	  specific firmware table and read-only copies of the host bridge
+	  and LPC bridge config space.
+
+	  To enable Intel IGD assignment through vfio-pci, say Y.

