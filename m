Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88647C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C30521104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz76pYbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C30521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbeK3Bfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388157AbeK3Bfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C842145D;
        Thu, 29 Nov 2018 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501805;
        bh=oLjM75amQRPULmyTgBhtd2jAUdjrMLnuYTaKYG8slN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gz76pYbdWUQXbbtvO2Z5uY4+o3jw/l5fkzjucS+8CcA0dB0/Z0VxbU8OYoc40xlwS
         ks1QYSXDun3VOZyHTW1CIlOANvSlC3oAGpu4aZiK6SYQW8VilhmZy32dwMdsrGApFI
         iCTfzKi+nsCLlouWsImI13MsZQb61yP4LaRV8HQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Jean Delvare <jdelvare@suse.de>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.19 047/110] drm/ast: Remove existing framebuffers before loading driver
Date:   Thu, 29 Nov 2018 15:12:18 +0100
Message-Id: <20181129135923.165699106@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 5478ad10e7850ce3d8b7056db05ddfa3c9ddad9a upstream.

If vesafb attaches to the AST device, it configures the framebuffer memory
for uncached access by default. When ast.ko later tries to attach itself to
the device, it wants to use write-combining on the framebuffer memory, but
vesefb's existing configuration for uncached access takes precedence. This
results in reduced performance.

Removing the framebuffer's configuration before loding the AST driver fixes
the problem. Other DRM drivers already contain equivalent code.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1112963
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org>
Tested-by: Y.C. Chen <yc_chen@aspeedtech.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ast/ast_drv.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -60,8 +60,29 @@ static const struct pci_device_id pciidl
 
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+static void ast_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+	bool primary = false;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 0);
+	ap->ranges[0].size = pci_resource_len(pdev, 0);
+
+#ifdef CONFIG_X86
+	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
+#endif
+	drm_fb_helper_remove_conflicting_framebuffers(ap, "astdrmfb", primary);
+	kfree(ap);
+}
+
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	ast_kick_out_firmware_fb(pdev);
+
 	return drm_get_pci_dev(pdev, ent, &driver);
 }
 


