Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161833AbeE1KeB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161791AbeE1Kdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Idan Burstein <idanb@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 168/329] nvmet: fix PSDT field check in command format
Date: Mon, 28 May 2018 12:01:37 +0200
Message-Id: <20180528100256.391337205@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit bffd2b61670feef18d2535e9b53364d270a1c991 ]

PSDT field section according to NVM_Express-1.3:
"This field specifies whether PRPs or SGLs are used for any data
transfer associated with the command. PRPs shall be used for all
Admin commands for NVMe over PCIe. SGLs shall be used for all Admin
and I/O commands for NVMe over Fabrics. This field shall be set to
01b for NVMe over Fabrics 1.0 implementations.

Suggested-by: Idan Burstein <idanb@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -491,9 +491,12 @@ bool nvmet_req_init(struct nvmet_req *re
 		goto fail;
 	}
 
-	/* either variant of SGLs is fine, as we don't support metadata */
-	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF &&
-		     (flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METASEG)) {
+	/*
+	 * For fabrics, PSDT field shall describe metadata pointer (MPTR) that
+	 * contains an address of a single contiguous physical buffer that is
+	 * byte aligned.
+	 */
+	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
