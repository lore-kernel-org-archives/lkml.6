Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqSvxpwyr8cZLTtXER+o7vOSJKy9lVX8ntO+mO7UKS+hQcdMWxN/LP1Q3nL2fOw0jHRhpcl
ARC-Seal: i=1; a=rsa-sha256; t=1527155983; cv=none;
        d=google.com; s=arc-20160816;
        b=mrRugDwgX7x+FquhQyTQfwAtPVHyEwUbTCCirNLoUDKr3pRli7x4xZsyGgMxt5tpVX
         SagELkgiPZ5BL6CG+K5EQlwGb1WNtzsqw9/Jn8uokudQRyR6AFxd6MNjzV8t+WW1p0kz
         79vxBNe08c4pKaeuKLhzHkvCGNQGa6XGmfh/dH+FIOliuwzxmLNwDOAgctG8r9LiwST5
         jDgV8TR+QUDrAsckNR5CEPmed/B6tQP6A8Y/VFyojrdN8noQ+hMVMduDBoCnv0QZBCXI
         JMyPGUgBVreQ4NFfxGLDEM+o+PqvUsjKuMhs6RoH0ioJtXymqPOzlbxWxhs7lDaVm/m5
         O8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=M1UKdTDKG9u/DDxF2t6Ab9UFFHeB47OTMQ3JCdcA1xU=;
        b=tfThThzmwRbJaqeoVDHV0MRE08B0kIBNR4oW80OSPnEWabTBows0VyMTPG7sWs/dsz
         OlU18rIk4nrmZj4zrfGH7erA3GhFBKfA2IvjiCehGVy0fq6u96OdTg3Zpc0WbY3goEeM
         IFo+m1hQ9OVwR3QLZK72vPlh8HIzyRiicKwe2CZVoOI99KwKcbIFXcFKI5tiGob4z4B1
         UQ/qYLDquVh3xlh9fI43Z71yPRE/DJcB2EYQVyHD54b2AVzDXPxzxm9JmuPNKaQKk6LG
         DMAN43lryi05lVcynQJxTuwnMxFfksHQtKDLMQGvxt72WFy7iEnIMLx7qOfvJzzoalv5
         /0Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IiUMOI/E;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IiUMOI/E;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Regis Duchesne <hpreg@vmware.com>,
	Ronak Doshi <doshir@vmware.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 021/161] vmxnet3: use DMA memory barriers where required
Date: Thu, 24 May 2018 11:37:26 +0200
Message-Id: <20180524093020.868537445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338372705205544?=
X-GMAIL-MSGID: =?utf-8?q?1601339112166893965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "hpreg@vmware.com" <hpreg@vmware.com>

[ Upstream commit f3002c1374fb2367c9d8dbb28852791ef90d2bac ]

The gen bits must be read first from (resp. written last to) DMA memory.
The proper way to enforce this on Linux is to call dma_rmb() (resp.
dma_wmb()).

Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |   22 ++++++++++++++++++++++
 drivers/net/vmxnet3/vmxnet3_int.h |    4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -369,6 +369,11 @@ vmxnet3_tq_tx_complete(struct vmxnet3_tx
 
 	gdesc = tq->comp_ring.base + tq->comp_ring.next2proc;
 	while (VMXNET3_TCD_GET_GEN(&gdesc->tcd) == tq->comp_ring.gen) {
+		/* Prevent any &gdesc->tcd field from being (speculatively)
+		 * read before (&gdesc->tcd)->gen is read.
+		 */
+		dma_rmb();
+
 		completed += vmxnet3_unmap_pkt(VMXNET3_TCD_GET_TXIDX(
 					       &gdesc->tcd), tq, adapter->pdev,
 					       adapter);
@@ -1103,6 +1108,11 @@ vmxnet3_tq_xmit(struct sk_buff *skb, str
 		gdesc->txd.tci = skb_vlan_tag_get(skb);
 	}
 
+	/* Ensure that the write to (&gdesc->txd)->gen will be observed after
+	 * all other writes to &gdesc->txd.
+	 */
+	dma_wmb();
+
 	/* finally flips the GEN bit of the SOP desc. */
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
@@ -1298,6 +1308,12 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 			 */
 			break;
 		}
+
+		/* Prevent any rcd field from being (speculatively) read before
+		 * rcd->gen is read.
+		 */
+		dma_rmb();
+
 		BUG_ON(rcd->rqID != rq->qid && rcd->rqID != rq->qid2 &&
 		       rcd->rqID != rq->dataRingQid);
 		idx = rcd->rxdIdx;
@@ -1528,6 +1544,12 @@ rcd_done:
 		ring->next2comp = idx;
 		num_to_alloc = vmxnet3_cmd_ring_desc_avail(ring);
 		ring = rq->rx_ring + ring_idx;
+
+		/* Ensure that the writes to rxd->gen bits will be observed
+		 * after all other writes to rxd objects.
+		 */
+		dma_wmb();
+
 		while (num_to_alloc) {
 			vmxnet3_getRxDesc(rxd, &ring->base[ring->next2fill].rxd,
 					  &rxCmdDesc);
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.15.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.16.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040f00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01041000
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
