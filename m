Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181EAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2720870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543418;
	bh=LzMcxHg4yUGSzX6tFhogy4xeZ+EF1VTe/SLr6WrihKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Twk8Vdaqxo2fu5TBXqHLhXchDGy2d9sjm+opiI7JryD+WjbBrpylSfR7t/+jHvNm4
	 3RcRLkOT48uNmVIyJwbQhUohfYJQqBamfK8kEHaq0LyJC2qNpiad9Mtb/KLOLqdUFF
	 nUJ4L89Qod5FoatFx8tdlX+jTg8/B2w7wBs2vfXw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeLKPuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbeLKPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DE220870;
        Tue, 11 Dec 2018 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543414;
        bh=LzMcxHg4yUGSzX6tFhogy4xeZ+EF1VTe/SLr6WrihKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHrBjTGED779kL26Tc43LRjFYj3ZJYyQFxmta+MY+GfsvNTZaRyawpiaeImTTmtXC
         AGVLqwufOzIx5wGR+t1sFNXnC5FWQJTwKx6oMs+6crpCJwJqhAB2r3s0TOe7aTvlJ7
         3K8ME7fIA+RRvk6JKO7K68GZ9Snd0QN5UgfPhfLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Shih <pihsun@chromium.org>
Subject: [PATCH 4.9 42/51] tty: serial: 8250_mtk: always resume the device in probe.
Date:   Tue, 11 Dec 2018 16:41:50 +0100
Message-Id: <20181211151617.458090354@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Shih <pihsun@chromium.org>

commit 100bc3e2bebf95506da57cbdf5f26b25f6da4c81 upstream.

serial8250_register_8250_port calls uart_config_port, which calls
config_port on the port before it tries to power on the port. So we need
the port to be on before calling serial8250_register_8250_port. Change
the code to always do a runtime resume in probe before registering port,
and always do a runtime suspend in remove.

This basically reverts the change in commit 68e5fc4a255a ("tty: serial:
8250_mtk: use pm_runtime callbacks for enabling"), but still use
pm_runtime callbacks.

Fixes: 68e5fc4a255a ("tty: serial: 8250_mtk: use pm_runtime callbacks for enabling")
Signed-off-by: Peter Shih <pihsun@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_mtk.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -225,17 +225,17 @@ static int mtk8250_probe(struct platform
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		err = mtk8250_runtime_resume(&pdev->dev);
-		if (err)
-			return err;
-	}
+	err = mtk8250_runtime_resume(&pdev->dev);
+	if (err)
+		return err;
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 }
 
@@ -246,13 +246,11 @@ static int mtk8250_remove(struct platfor
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
+	mtk8250_runtime_suspend(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk8250_runtime_suspend(&pdev->dev);
-
 	return 0;
 }
 


