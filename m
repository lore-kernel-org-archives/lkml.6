Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeCaHXa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:23:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752466AbeCaHX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:23:28 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <jcm@redhat.com>, <toshi.kani@hpe.com>, <tanxiaojun@huawei.com>,
        <wangzhou1@hisilicon.com>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2 2/2] PCI: Check phys_addr for pci_remap_iospace
Date: Sat, 31 Mar 2018 15:12:23 +0800
Message-ID: <1522480343-37669-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1522480343-37669-1-git-send-email-xieyisheng1@huawei.com>
References: <1522480343-37669-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If phys_addr is not page aligned, ioremap_page_range() will align down it
when get pfn by phys_addr >> PAGE_SHIFT. An example in arm64 system with
64KB page size:

 phys_addr:  0xefff8000
 res->start: 0x0
 res->end:   0x0ffff
 PCI_IOBASE: 0xffff7fdffee00000

This will remap virtual address 0xffff7fdffee00000 to phys_addr 0xefff0000,
but what we really want is 0xefff8000, which makes later IO access to a
mess. And users may even donot know this until find some odd phenemenon.

This patch checks whether phys_addr is PAGE_ALIGNED or not to find the
primary scene.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..deb91f0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3576,6 +3576,9 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	if (res->end > IO_SPACE_LIMIT)
 		return -EINVAL;
 
+	if (!PAGE_ALIGNED(phys_addr))
+		return -EINVAL;
+
 	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
 				  pgprot_device(PAGE_KERNEL));
 #else
-- 
1.7.12.4
