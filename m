Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7990C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B57F2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfBMKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:14:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbfBMKOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:14:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33B0413CE3;
        Wed, 13 Feb 2019 10:14:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B3DB5D6B3;
        Wed, 13 Feb 2019 10:14:11 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        alex.williamson@redhat.com
Subject: [PATCH] vfio_pci: Enable memory accesses before calling pci_map_rom
Date:   Wed, 13 Feb 2019 11:14:06 +0100
Message-Id: <20190213101406.3934-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 13 Feb 2019 10:14:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
In case the Memory Space accesses were disabled, readw() is likely to
crash the host with a synchronous external abort (aarch64).

In case memory accesses were disabled, re-enable them before the call
and disable them back again just after.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index ff60bd1ea587..96b8bbd909d7 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -706,8 +706,10 @@ static long vfio_pci_ioctl(void *device_data,
 			break;
 		case VFIO_PCI_ROM_REGION_INDEX:
 		{
+			bool mem_access_disabled;
 			void __iomem *io;
 			size_t size;
+			u16 cmd;
 
 			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
 			info.flags = 0;
@@ -723,6 +725,13 @@ static long vfio_pci_ioctl(void *device_data,
 					break;
 			}
 
+			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+			mem_access_disabled = !(cmd & PCI_COMMAND_MEMORY);
+			if (mem_access_disabled) {
+				cmd |= PCI_COMMAND_MEMORY;
+				pci_write_config_word(pdev, PCI_COMMAND, cmd);
+			}
+
 			/* Is it really there? */
 			io = pci_map_rom(pdev, &size);
 			if (!io || !size) {
@@ -731,6 +740,11 @@ static long vfio_pci_ioctl(void *device_data,
 			}
 			pci_unmap_rom(pdev, io);
 
+			if (mem_access_disabled) {
+				cmd &= ~PCI_COMMAND_MEMORY;
+				pci_write_config_word(pdev, PCI_COMMAND, cmd);
+			}
+
 			info.flags = VFIO_REGION_INFO_FLAG_READ;
 			break;
 		}
-- 
2.20.1

