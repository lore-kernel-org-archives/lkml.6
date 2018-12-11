Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE89C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E712205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544021;
	bh=Xyfca/CGoim0hp7a989KvW0h8QCwNDjbdXoZlDSN6ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djqW9aME7nrrmu6v4sjh8/Xg5e2v7rQ74dB8vUHp2CPV6VbILCamO2CMmdEd8pXzd
	 1H4jg+2+GMEisMQpOvH0/AaixlAhZQKry6OvDd/9CdVje1SFHm1/SjaMAyTp+9byqq
	 n5FQ1FzOBjgITZDXnUMC3qlzRADiXbZyDFLmMDfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E712205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeLKP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbeLKP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5070C2086D;
        Tue, 11 Dec 2018 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543899;
        bh=Xyfca/CGoim0hp7a989KvW0h8QCwNDjbdXoZlDSN6ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npeJZkB5rHw3GIstdjq7RLMOeEzHxLn58aBQq5+VLmIF2UnxjNhlokHBanY5eb2ID
         kdNsvRixD17tB9OzcAKVWL3SMUddyD61rtVEIlCmdXemh91T3372qEn8AoLHPfPzb1
         MeTJXLdN16uvFrHmDfp7t4ylStQPPbmB51LcFu24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Shih <pihsun@chromium.org>
Subject: [PATCH 4.19 106/118] tty: serial: 8250_mtk: always resume the device in probe.
Date:   Tue, 11 Dec 2018 16:42:05 +0100
Message-Id: <20181211151648.546276320@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -213,17 +213,17 @@ static int mtk8250_probe(struct platform
 
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
 
@@ -234,13 +234,11 @@ static int mtk8250_remove(struct platfor
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
 


