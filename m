Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cVyP2RxkM2Ie/YSSEq8rEUykS8NTYQJmqDo8lZPS+wCplY0Lg1TT4FODdxQ6xmlgq2M03
ARC-Seal: i=1; a=rsa-sha256; t=1523473173; cv=none;
        d=google.com; s=arc-20160816;
        b=JmgbaoZeV26ojkrxCq7J/I9Z+3MQ0vJZLHSywdLNpDS7wnYpUwOC3sAjm+kN1Yy+53
         VkXNMs4hF8g5xrt1vWuLY/JyDf+zVunetHWZaDMxEAcz5/ghlXg+UglXSv88o4jvzIFN
         TXg/l5hpgkJxekYFLbvnptqXpAz076O/7SMz87RYSfxV0oTyFtrTD1paNV/+hTVtr/9t
         Xv0ftnBXesTC4meKGpA1wjCebQ1SdF/xqRcdHqDVsbPEUJGK0QZUnHzdWVV6C6Py8UH7
         +Tc7UG1WtdYskG6F9jLkGowJvhRZHyPyrhztvl4MDdERdbFQys0su3FstBrUb+37w6Zw
         ynLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aOp/T1vF9Efv/p1xSLFal++Z/DcLT4kE3fpLemBYPFo=;
        b=sseIcX3RTfnBch7OnPjMmtV/ZjG3NXa0NPVvK4h0llrOaRlvpBftTfywTCMBITSXDP
         m91F6gA8QQ2LNkR7/Wqqqzi7/Uxv6gTmgKbaCUPFaidwUULRE/AJdQk+c0WusAgN/Dlq
         QzEEuUOlZgGkw/2QvjW0XYTH4WlJ1OwymvWcM0o+XnKOgerGOyiFbVfQ2BatKM8Ezb7/
         S4ukKVKBN9ORj4oR0zY8a//iQDyddzX5XsRIb0r5UTM7vrecXNb2XsWYT0k8STRnWjIw
         8KkP2RlbS+jbucrKzEMRlZrBzi0422phxhNWD+mP8/vuWxlxnHXeSEB6UwtOeqhKeXKl
         FyPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 154/310] dmaengine: imx-sdma: Handle return value of clk_prepare_enable
Date: Wed, 11 Apr 2018 20:34:53 +0200
Message-Id: <20180411183629.045699949@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476686845601396?=
X-GMAIL-MSGID: =?utf-8?q?1597477405952328189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit fb9caf370f4d0457789d13a1a1b110a8db846e5e ]

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/imx-sdma.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1755,19 +1755,26 @@ static int sdma_probe(struct platform_de
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	clk_prepare(sdma->clk_ipg);
-	clk_prepare(sdma->clk_ahb);
+	ret = clk_prepare(sdma->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare(sdma->clk_ahb);
+	if (ret)
+		goto err_clk;
 
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0, "sdma",
 			       sdma);
 	if (ret)
-		return ret;
+		goto err_irq;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
-	if (!sdma->script_addrs)
-		return -ENOMEM;
+	if (!sdma->script_addrs) {
+		ret = -ENOMEM;
+		goto err_irq;
+	}
 
 	/* initially no scripts available */
 	saddr_arr = (s32 *)sdma->script_addrs;
@@ -1882,6 +1889,10 @@ err_register:
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
+err_irq:
+	clk_unprepare(sdma->clk_ahb);
+err_clk:
+	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -1893,6 +1904,8 @@ static int sdma_remove(struct platform_d
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
+	clk_unprepare(sdma->clk_ahb);
+	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
