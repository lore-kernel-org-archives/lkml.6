Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ADC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F6A2174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F6A2174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeHUJqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:46:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:46:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61974AD8;
        Tue, 21 Aug 2018 06:27:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 26/29] misc: sram: fix resource leaks in probe error path
Date:   Tue, 21 Aug 2018 08:21:19 +0200
Message-Id: <20180821055109.440124266@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit f294d00961d1d869ecffa60e280eeeee1ccf9a49 upstream.

Make sure to disable clocks and deregister any exported partitions
before returning on late probe errors.

Note that since commit ee895ccdf776 ("misc: sram: fix enabled clock leak
on error path"), partitions are deliberately exported before enabling
the clock so we stick to that logic here. A follow up patch will address
this.

Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/sram.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -407,13 +407,20 @@ static int sram_probe(struct platform_de
 	if (init_func) {
 		ret = init_func();
 		if (ret)
-			return ret;
+			goto err_disable_clk;
 	}
 
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 		gen_pool_size(sram->pool) / 1024, sram->virt_base);
 
 	return 0;
+
+err_disable_clk:
+	if (sram->clk)
+		clk_disable_unprepare(sram->clk);
+	sram_free_partitions(sram);
+
+	return ret;
 }
 
 static int sram_remove(struct platform_device *pdev)


