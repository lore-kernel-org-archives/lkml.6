Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeFDHFP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbeFDHFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:05:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.16 20/47] nvme: fix extended data LBA supported setting
Date: Mon,  4 Jun 2018 08:58:32 +0200
Message-Id: <20180604065550.343547377@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>

commit c97f414c54a255f4f05a50a2625efaeee406e134 upstream.

This value depands on the metadata support value, so reorder the
initialization to fit.

Fixes: b5be3b392 ("nvme: always unregister the integrity profile in __nvme_revalidate_disk")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1446,8 +1446,8 @@ static void __nvme_revalidate_disk(struc
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 	ns->noiob = le16_to_cpu(id->noiob);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
