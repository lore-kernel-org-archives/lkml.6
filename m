Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeBUJHV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:07:21 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34728 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeBUJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:07:17 -0500
X-Google-Smtp-Source: AH8x225F531BYdEgDjio1ByW1TraB8gaEqpZV2be71DWW/q2VWYKrv9P7v9nsGa8bmsn9Mi/LSbUBg==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: stop crashing in pci_release_resource v2
Date: Wed, 21 Feb 2018 10:07:15 +0100
Message-Id: <20180221090715.2853-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it entirely possible that the BIOS wasn't able to assign resources to
a device. In this case don't crash in pci_release_resource() when we try
to resize the resource.

v2: keep printing the info that we try to release the BAR

Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/pci/setup-res.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e815111f3f81..c0f091614805 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 	struct resource *res = dev->resource + resno;
 
 	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
+
+	if (!res->parent)
+		return;
+
 	release_resource(res);
 	res->end = resource_size(res) - 1;
 	res->start = 0;
-- 
2.14.1
