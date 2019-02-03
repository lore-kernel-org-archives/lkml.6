Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBDCC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435AE218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfBCN42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:56:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbfBCNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003wN-Br; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9i-0007E9-Eq; Sun, 03 Feb 2019 14:49:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Y.C. Chen" <yc_chen@aspeedtech.com>,
        "Dave Airlie" <airlied@redhat.com>,
        "Jean Delvare" <jdelvare@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.119109687@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 210/305] drm/ast: Remove existing framebuffers before
 loading driver
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Tested-by: Y.C. Chen <yc_chen@aspeedtech.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Dave Airlie <airlied@redhat.com>
[bwh: Backported to 3.16: Use remove_conflicting_framebuffers()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/ast/ast_drv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -60,8 +60,29 @@ static DEFINE_PCI_DEVICE_TABLE(pciidlist
 
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
+	remove_conflicting_framebuffers(ap, "astdrmfb", primary);
+	kfree(ap);
+}
+
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	ast_kick_out_firmware_fb(pdev);
+
 	return drm_get_pci_dev(pdev, ent, &driver);
 }
 

