Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8718C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A663320645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A663320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeIHB75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIHB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84D19FA4;
        Fri,  7 Sep 2018 21:17:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihua Yao <ylhuajnu@163.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 091/145] ALSA: ac97: fix unbalanced pm_runtime_enable
Date:   Fri,  7 Sep 2018 23:09:17 +0200
Message-Id: <20180907210911.509395008@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lihua Yao <ylhuajnu@163.com>

commit 250ea7c5f56e350cdafebe6b87478b00db4f7af8 upstream.

Runtime PM is enabled at ac97_bus_probe() and should be disabled
at ac97_bus_remove().

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Lihua Yao <ylhuajnu@163.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/ac97/bus.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -511,6 +511,8 @@ static int ac97_bus_remove(struct device
 	if (ret == 0)
 		ac97_put_disable_clk(adev);
 
+	pm_runtime_disable(dev);
+
 	return ret;
 }
 


