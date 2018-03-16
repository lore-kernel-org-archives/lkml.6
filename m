Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTPaXwFOjqxxxT3Vj1879DTWyhkxgI7xdVvTOaE0HuAgyuT9QSKeL09z83yQbjl9cJE5v7
ARC-Seal: i=1; a=rsa-sha256; t=1521214623; cv=none;
        d=google.com; s=arc-20160816;
        b=CtHWGtw7+ro4+8i2ow3xpc+l2pBDN6YlzyTlFZlAINlYdTX9IRWOVtdTImRnjBOEEc
         BwcBhaP4Tt/SfDgm2kPYonL/NB8dEJOhmDIkJGp8O+teCXFka2+3Lx58Og/2UllNqHzn
         M3x+MpWCjD5Np7Nhy6qRVopWUUSnmRd+yKFbSAh9IW5CzDvXf7R1+BzG+NDYl83Mk9Oe
         l/dpVYsy6jBskBgNXD2aoNGsoho9A6vzPHKuBdHZYSjC11vHzYgg+EDloYjbAa5hlnaE
         D/Ywqc9HB3d/qRgeTHG92KHqr0ItrZsBZg4E2gZ6SatB2ZDMPjFZI/okNC8doHYwCDdB
         S62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QiDlWsAiug0qfahJeLO09wR3Z6LXc0QrtGgy2uHdVxE=;
        b=KSqXbTiYYNzKtGVaihxJBn4TvGUPy0fBeF1VnA4zE0XAgv9x17oe4qWlPeo8QgRiDG
         xtVTBeVnRH6nKBcgTQ0FhPztXEZms1+TZLvc0lTVcqa5kSK4Kc7LIvrJG/DmfbyHfhGP
         Yo3xtJTOgMlemqzOYJYfSMZa54YwgR3qGq3YxRtjdULbkkdJTSZAEypW6Thf9ANEnfsS
         OcHS/aRl8EMgo/Hp3wYWn6yuTcYvYFL5Um6vb6noXn+RWcQOWMxLRxlb+845hKx9vxXV
         l06iV4WYrjzZMoJXLVVzON5QMwwtali5z5eN/cPFvHqPWusiAVBWDYv4D0yhQuaixueS
         Zt7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Eric Anholt <eric@anholt.net>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
Date: Fri, 16 Mar 2018 16:23:33 +0100
Message-Id: <20180316152333.462064800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109144645401566?=
X-GMAIL-MSGID: =?utf-8?q?1595109144645401566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit de92436ac40ffe9933230aa503e24dbb5ede9201 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/bcm2835-dma.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -812,7 +812,7 @@ static int bcm2835_dma_terminate_all(str
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
-		bcm2835_dma_desc_free(&c->desc->vd);
+		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c->chan_base);
 
@@ -836,6 +836,13 @@ static int bcm2835_dma_terminate_all(str
 	return 0;
 }
 
+static void bcm2835_dma_synchronize(struct dma_chan *chan)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+
+	vchan_synchronize(&c->vc);
+}
+
 static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 				 int irq, unsigned int irq_flags)
 {
@@ -942,6 +949,7 @@ static int bcm2835_dma_probe(struct plat
 	od->ddev.device_prep_dma_memcpy = bcm2835_dma_prep_dma_memcpy;
 	od->ddev.device_config = bcm2835_dma_slave_config;
 	od->ddev.device_terminate_all = bcm2835_dma_terminate_all;
+	od->ddev.device_synchronize = bcm2835_dma_synchronize;
 	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
