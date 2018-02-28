Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965248AbeB1Xl3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:41:29 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60166 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965036AbeB1XkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:40:25 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 28 Feb 2018 16:39:58 -0700
Message-Id: <20180228234006.21093-3-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180228234006.21093-1-logang@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 02/10] PCI/P2PDMA: Add sysfs group to display p2pmem stats
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes display the total amount of P2P memory, the amount available
and whether it is published or not.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 25 +++++++++++++++++
 drivers/pci/p2pdma.c                    | 50 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 44d4b2be92fd..f5656dae21be 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -323,3 +323,28 @@ Description:
 
 		This is similar to /sys/bus/pci/drivers_autoprobe, but
 		affects only the VFs associated with a specific PF.
+
+What:		/sys/bus/pci/devices/.../p2pmem/available
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the amount of memory that has not been
+		allocated (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/size
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the total ammount of memory that the device
+		provides (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/published
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains a '1' if the memory has been published for
+		use inside the kernel or a '0' if it is only intended
+		for use within the driver that published it.
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ec0a6cb9e500..a57df78f6a32 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -29,6 +29,53 @@ struct pci_p2pdma {
 	bool published;
 };
 
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t size = 0;
+
+	if (pdev->p2pdma->pool)
+		size = gen_pool_size(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", size);
+}
+static DEVICE_ATTR_RO(size);
+
+static ssize_t available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t avail = 0;
+
+	if (pdev->p2pdma->pool)
+		avail = gen_pool_avail(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", avail);
+}
+static DEVICE_ATTR_RO(available);
+
+static ssize_t published_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", pdev->p2pdma->published);
+}
+static DEVICE_ATTR_RO(published);
+
+static struct attribute *p2pmem_attrs[] = {
+	&dev_attr_size.attr,
+	&dev_attr_available.attr,
+	&dev_attr_published.attr,
+	NULL,
+};
+
+static const struct attribute_group p2pmem_group = {
+	.attrs = p2pmem_attrs,
+	.name = "p2pmem",
+};
+
 static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 {
 	struct pci_p2pdma *p2p =
@@ -55,6 +102,7 @@ static void pci_p2pdma_release(void *data)
 	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
 
 	gen_pool_destroy(pdev->p2pdma->pool);
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 	pdev->p2pdma = NULL;
 }
 
@@ -83,6 +131,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (error)
 		goto out_pool_destroy;
 
+	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
+
 	pdev->p2pdma = p2p;
 
 	return 0;
-- 
2.11.0
