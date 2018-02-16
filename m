Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeBPWuZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeBPWuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:50:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE60217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 2/2] PCI: Remove redundant probes for device reset support
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jayachandran Nair <Jayachandran.Nair@cavium.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>
Date: Fri, 16 Feb 2018 16:50:18 -0600
Message-ID: <20180216225018.67295.36860.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We probe every device for whether it supports reset so we can tell whether
to create a sysfs "reset" file for it.  We do that probe in
pci_init_capabilities() during enumeration and save the result in
dev->reset_fn.  The result doesn't depend on any other devices on the bus
and shouldn't change after boot, so we don't need to do the probe again.

Remove the pci_probe_reset_function() calls and rely on the dev->reset_fn
we found during enumeration.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..4db740e4f50a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4450,9 +4450,8 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_probe_reset_function(dev);
-	if (rc)
-		return rc;
+	if (!dev->reset_fn)
+		return -ENOTTY;
 
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
@@ -4487,9 +4486,8 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_probe_reset_function(dev);
-	if (rc)
-		return rc;
+	if (!dev->reset_fn)
+		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
 
@@ -4511,9 +4509,8 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_probe_reset_function(dev);
-	if (rc)
-		return rc;
+	if (!dev->reset_fn)
+		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
