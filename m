Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB420866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzQb+SN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BB420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbeKLJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbeKLIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:29 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87472154B;
        Sun, 11 Nov 2018 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975313;
        bh=J96VVGLQjMXD9T/phyAh4y6CgvOgCmptSGnOLTZJdr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzQb+SN98QxV465eZx6UJWZxoQZUfeoqf+B4qUMwkHtAtjDGCn8GF/wRHqJ78iats
         fRBIjAh9l35/XkjruXN6VnAOmMQ+BAEvZkGcm7tTlscp7i5jmNt255ic7izFTM6py/
         rQMZpEYLnr3nDDedkoLenWaJjXE+8C9J23zGL8Z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.19 296/361] remoteproc: qcom: q6v5: Propagate EPROBE_DEFER
Date:   Sun, 11 Nov 2018 14:20:43 -0800
Message-Id: <20181111221657.100871905@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d5269c4553a64b6882f2c019ae21b783a0984a83 upstream.

In the case that the interrupts fail to result because of the
interrupt-controller not yet being registered the
platform_get_irq_byname() call will fail with -EPROBE_DEFER, but passing
this into devm_request_threaded_irq() will result in -EINVAL being
returned, the driver is therefor not reprobed later.

Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Cc: stable@vger.kernel.org
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -198,6 +198,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
+	if (q6v5->fatal_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -208,6 +211,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
+	if (q6v5->ready_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -218,6 +224,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
+	if (q6v5->handover_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -229,6 +238,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
+	if (q6v5->stop_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,


