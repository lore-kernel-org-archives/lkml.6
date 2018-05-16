Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeEPKWb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:22:31 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:49558 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeEPKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:22:28 -0400
Date: Wed, 16 May 2018 12:22:04 +0200
From: Emil Goode <emil.fsw@goode.io>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Fix compiler errors by converting to
 dma_addr_t
Message-ID: <20180516102204.stviarlxgrz3k2nh@lianli>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is complaining with the following errors:

drivers/gpu/host1x/cdma.c:94:48: error:
	passing argument 3 of ‘dma_alloc_wc’ from incompatible pointer type
	[-Werror=incompatible-pointer-types]

drivers/gpu/host1x/cdma.c:113:48: error:
	passing argument 3 of ‘dma_alloc_wc’ from incompatible pointer type
	[-Werror=incompatible-pointer-types]

The expected pointer type of the third argument to dma_alloc_wc() is
dma_addr_t but phys_addr_t is passed.

Change the phys member of struct push_buffer to be dma_addr_t so that we
pass the correct type to dma_alloc_wc().
Also check pb->mapped for non-NULL in the destroy function as that is the
right way of checking if dma_alloc_wc() was successful.

Signed-off-by: Emil Goode <emil.fsw@goode.io>
---
v2: - Change the phys member type instead of adding casts.
    - Check pb->mapped in the destroy function as 0 is a valid value
      for dma_addr_t.

 drivers/gpu/host1x/cdma.c | 2 +-
 drivers/gpu/host1x/cdma.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 28541b280739..02a0b61be18f 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -51,7 +51,7 @@ static void host1x_pushbuffer_destroy(struct push_buffer *pb)
 	struct host1x_cdma *cdma = pb_to_cdma(pb);
 	struct host1x *host1x = cdma_to_host1x(cdma);
 
-	if (!pb->phys)
+	if (!pb->mapped)
 		return;
 
 	if (host1x->domain) {
diff --git a/drivers/gpu/host1x/cdma.h b/drivers/gpu/host1x/cdma.h
index 286d49386be9..446ee1a84969 100644
--- a/drivers/gpu/host1x/cdma.h
+++ b/drivers/gpu/host1x/cdma.h
@@ -44,7 +44,7 @@ struct host1x_job;
 struct push_buffer {
 	void *mapped;			/* mapped pushbuffer memory */
 	dma_addr_t dma;			/* device address of pushbuffer */
-	phys_addr_t phys;		/* physical address of pushbuffer */
+	dma_addr_t phys;		/* physical address of pushbuffer */
 	u32 fence;			/* index we've written */
 	u32 pos;			/* index to write to */
 	u32 size;
-- 
2.11.0
