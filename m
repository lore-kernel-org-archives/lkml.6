Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424968AbeE1LzH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423641AbeE1LIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 104/272] intel_th: Use correct method of finding hub
Date: Mon, 28 May 2018 12:02:17 +0200
Message-Id: <20180528100249.852867420@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 9ad577087165478c9d9be82b15ed9bf2db5835f5 ]

Since commit 8edc514b01e9 ("intel_th: Make SOURCE devices children of the
root device") the hub is not the parent of SOURCE devices any more, so the
new helper function should be used for that instead of always using the
parent. The intel_th_set_output() path, however, still uses the old
logic, leading to the hub driver structure being aliased with something
else, like struct pci_driver or struct acpi_driver, and an incorrect call
to an address inferred from that, potentially resulting in a crash.

Fixes: 8edc514b01e9 ("intel_th: Make SOURCE devices children of the root device")
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -935,7 +935,7 @@ EXPORT_SYMBOL_GPL(intel_th_trace_disable
 int intel_th_set_output(struct intel_th_device *thdev,
 			unsigned int master)
 {
-	struct intel_th_device *hub = to_intel_th_device(thdev->dev.parent);
+	struct intel_th_device *hub = to_intel_th_hub(thdev);
 	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
 
 	if (!hubdrv->set_output)
