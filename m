Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsS0F2DyAbYWatMCj/ZJvlH6manNCgN2KW1I3bGghd+WXK8+4UKdQ+wn232QjvpeIit8u4A
ARC-Seal: i=1; a=rsa-sha256; t=1521214662; cv=none;
        d=google.com; s=arc-20160816;
        b=fpVUvwg4NKqoR159HgRSpD1xLDF0FLoDamv4pA5/xeLUrwH/NaB5ENyF44ZFIRdVRJ
         7gWD6vsA8Reh8SgAuDxNnnIokvkyrwfl/1ycq/IT041xfceouM5GaipKd2HLAjEb3jYg
         mIwvhHhZbUvwupfVCtXWLA9+Lxf2WjnPrZrV/YD7yA9fISnb724/jT3PwBxdPQO1FgY6
         lvGUJTM2rJd6QS5QYzOqNx1ytw9PUIpGJW3FfaDupg8j8GwMvc7MqWfr1UWCPbGavSyy
         bsu+daEc97prfX7jXFGi8/ca82+ksU0S84bjG9tJAI2KUKsMKODqzY0+4ADkttwd0x3b
         ifUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nx409yigX7xTWSvWWDyp5yQV0/6z1WBNRiktLiXwL8c=;
        b=as8QvJnqqxxVP7TPQL+jaxN7w3IV3mnnSH/9/NFQxinbs+cFSGBmVP70pGnMGOu/dP
         m6GTBmnAgUEj5ozKRJlJFR1e8tYf+7tY2qEhWLfxGx6skQLZPVWHVvuBF9yHY2Z15v5j
         DM4j6aHT+3A2GzGJ8UOYQXTbc1Ror4JLHlMm6KUxvNJNGzuu+R1WrJNQlO4/snDm+dQO
         SNeY9R9F+s7TFHLTEUJdkBdsVcH+JujtCGc5RUo07Jbo5J+LIIHJ0LHXpYBkZDK6KV+w
         nf0maPXufKQyhpng1QO5Wzikmx28kKW3U4SBKRK8qqGVXLTRyEp67i6WpkZlioa8pahQ
         fLuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 065/109] dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free
Date: Fri, 16 Mar 2018 16:23:34 +0100
Message-Id: <20180316152333.519781666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109185262445571?=
X-GMAIL-MSGID: =?utf-8?q?1595109185262445571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit 47d71bc75d072ce25c1063aa629e55e1cfb961b2 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/amba-pl08x.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2182,7 +2182,7 @@ static int pl08x_terminate_all(struct dm
 	}
 	/* Dequeue jobs and free LLIs */
 	if (plchan->at) {
-		pl08x_desc_free(&plchan->at->vd);
+		vchan_terminate_vdesc(&plchan->at->vd);
 		plchan->at = NULL;
 	}
 	/* Dequeue jobs not yet fired as well */
@@ -2193,6 +2193,13 @@ static int pl08x_terminate_all(struct dm
 	return 0;
 }
 
+static void pl08x_synchronize(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	vchan_synchronize(&plchan->vc);
+}
+
 static int pl08x_pause(struct dma_chan *chan)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
@@ -2773,6 +2780,7 @@ static int pl08x_probe(struct amba_devic
 	pl08x->memcpy.device_pause = pl08x_pause;
 	pl08x->memcpy.device_resume = pl08x_resume;
 	pl08x->memcpy.device_terminate_all = pl08x_terminate_all;
+	pl08x->memcpy.device_synchronize = pl08x_synchronize;
 	pl08x->memcpy.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.directions = BIT(DMA_MEM_TO_MEM);
@@ -2802,6 +2810,7 @@ static int pl08x_probe(struct amba_devic
 		pl08x->slave.device_pause = pl08x_pause;
 		pl08x->slave.device_resume = pl08x_resume;
 		pl08x->slave.device_terminate_all = pl08x_terminate_all;
+		pl08x->slave.device_synchronize = pl08x_synchronize;
 		pl08x->slave.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.directions =
