Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSTjeo30cA+R579ImJOogdMJbJ1+Ds4Zj668QKezFLRXGMdzW/KL841WdD4S/so9MQl6oT
ARC-Seal: i=1; a=rsa-sha256; t=1521214976; cv=none;
        d=google.com; s=arc-20160816;
        b=KPU294/+MZvvVMjGLdHzhr4pwxDTFKC5oxONGZEt5NLw3qwU26rh+kx7q+giXcsCdN
         ys7V7B1eoPe5+5d3FKJAXaaNr0WsngLK/Xs2fv8FqZz7tH+XHwuKXcPIYLk0KBum1iLA
         zIQlhkJkc0mVM6sJsvxgwSdAvlvc0RDGC05xS4KK/rYLq/q7eMOj7SDPHykKcwDifROE
         w+uC2AaNFR+tLlsNpQxeu3/J6WV6LTQ4YUv14sIxqSK74Li9hfRXHproFMkREL+VKtfi
         vlLB9MwJfNcPBL4tBvWD0ask5r5DNC3ykBN5o/gIkoh5qVmKNGJ2cRKruwCQv1JyB2zd
         mrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=91xT3N4YWPpYiOdnCj/2Nwpxzfg4RQXgdXIESJLk7wI=;
        b=Lmev4492M+xRMG69JRLe4rPorviWNbZFyUPk1NxBRwiFIrnPGQR+R65TlnloHVZgGy
         r5ArWoZemGXJq5vheSvQ1XKWY/SG4evsPB7fJnveDO3K72nk9MtbE2KfY0CpeiwI7aJL
         8NqDi4NG8CHsDW+4PJclad88e+Mf/SoRls7wipbr5BOQsNrczskFu0pumQRQMmWv51oO
         nfbK2z9NZwHRphHQBhLSgcLf4fLlbd6dcXvGLnpLovr89iQQWZdvS63CROVrUcT9KGeA
         f/DHFCXL/tObqbzuQRYIn03quhcfv8BaYttyTIcVF7bpeLFf5hmPPmKbrAQwwiG+WENr
         5OCg==
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
Subject: [PATCH 4.15 077/128] dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
Date: Fri, 16 Mar 2018 16:23:38 +0100
Message-Id: <20180316152340.510759247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109144645401566?=
X-GMAIL-MSGID: =?utf-8?q?1595109515623850536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
