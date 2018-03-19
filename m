Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBgTlEwe2mN62oWogbKkjmwhOnbO0IQtFwTOQ4gXh9WCXkNNCYHXV48+7SBiTsjuja1ExB
ARC-Seal: i=1; a=rsa-sha256; t=1521483198; cv=none;
        d=google.com; s=arc-20160816;
        b=T1YKP0M6CsSXDILsUEBMIVXExfoECBZNwnljt6JyYUnPhwtisZcTy0oLoj0nLjdgzZ
         7F/fyHnSECMrr+fcmv7q4nA/rxSQZfBdqUIMCMZPF3wgNjUEAuI9IicsF9s75gBkMIvE
         oMERG65druXFVeA1tgzMxpkvRRKUzcYIggrRhnqXH9n74O5lp7GNnUjf/g2vFmPOsO1C
         mBYt/p04u2faHFWoz4r9WHNr6C9FaNvK5tq6zC5ON9xidtHjw0FB/WARzf6oV1By0D1X
         Kv8jPELba24nt3++AKX1KAxMDMLbr9GbhGKkwqHzU4Dpithokm3CUR8/Z/zzwzPUhRg0
         1SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QiQh2sd0Z2du9XOiwc4pPFE1Bch8WB/DvtHDS+RX+hY=;
        b=A67CF6OFDfO5Ubf/GYGOVslPF29XXou7W4aUnNlEDwPjm/ARf9Zy9JhahNgL96eHTu
         clyXKQ6H0xi4pensqLtOi3Zc338+laPREPa9Dq0JRNDaBnHEw+Vt2UO6XMG7d1yYvN4t
         VitXWV1XbumVrwyqb3HPj6m8hx9tkYusiv2Kb72IzFdjmFwnwjxoFTZVkWpk6rdzIPGI
         bRVsTO1lAi2opUgKvsGCSrJy5JCyYrAh64Tgnh/8NViJW6XOvURzDVKb68a+eq2vv5ym
         O5mUtn1YdRnogOkRoJuS7f43+OmXYFdQYBeIRtEKHgR+ldvvgAgZkM1HemvT3YD4QUdH
         z4tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiada Wang <jiada_wang@mentor.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 034/134] dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped
Date: Mon, 19 Mar 2018 19:05:17 +0100
Message-Id: <20180319171854.214890247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390766580958175?=
X-GMAIL-MSGID: =?utf-8?q?1595390766580958175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiada Wang <jiada_wang@mentor.com>


[ Upstream commit 7f3ff14b7eb1ffad132117f08a1973b48e653d43 ]

sdma_disable_channel() cannot ensure dma is stopped to access
module's FIFOs. There is chance SDMA core is running and accessing
BD when disable of corresponding channel, this may cause sometimes
even after call of .sdma_disable_channel(), SDMA core still be
running and accessing module's FIFOs.

According to NXP R&D team a delay of one BD SDMA cost time (maximum
is 1ms) should be added after disable of the channel bit, to ensure
SDMA core has really been stopped after SDMA clients call
.device_terminate_all.

This patch introduces adds a new function sdma_disable_channel_with_delay()
which simply adds 1ms delay after call sdma_disable_channel(),
and set it as .device_terminate_all.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/imx-sdma.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -911,6 +911,21 @@ static int sdma_disable_channel(struct d
 	return 0;
 }
 
+static int sdma_disable_channel_with_delay(struct dma_chan *chan)
+{
+	sdma_disable_channel(chan);
+
+	/*
+	 * According to NXP R&D team a delay of one BD SDMA cost time
+	 * (maximum is 1ms) should be added after disable of the channel
+	 * bit, to ensure SDMA core has really been stopped after SDMA
+	 * clients call .device_terminate_all.
+	 */
+	mdelay(1);
+
+	return 0;
+}
+
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
@@ -1793,7 +1808,7 @@ static int sdma_probe(struct platform_de
 	sdma->dma_device.device_prep_slave_sg = sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
-	sdma->dma_device.device_terminate_all = sdma_disable_channel;
+	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
 	sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdma->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
