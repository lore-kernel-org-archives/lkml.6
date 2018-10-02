Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349EC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F232083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F232083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeJBUNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbeJBUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:35 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4593FBF0;
        Tue,  2 Oct 2018 13:30:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 179/228] mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion
Date:   Tue,  2 Oct 2018 06:24:36 -0700
Message-Id: <20181002132510.597423600@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit 17e96d8516e31c3cb52cb8e2ee79d1d2e6948c11 ]

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(dest, host->virt_base, data->sg->length) where
dest is the virtual address of the SG. Same for sg_copy_from_buffer
but in the opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 53d7e098ba08 ("mmc: android-goldfish: use sg_copy_{from,to}_buffer")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/android-goldfish.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -217,7 +217,7 @@ static void goldfish_mmc_xfer_done(struc
 			 * We don't really have DMA, so we need
 			 * to copy from our platform driver buffer
 			 */
-			sg_copy_to_buffer(data->sg, 1, host->virt_base,
+			sg_copy_from_buffer(data->sg, 1, host->virt_base,
 					data->sg->length);
 		}
 		host->data->bytes_xfered += data->sg->length;
@@ -393,7 +393,7 @@ static void goldfish_mmc_prepare_data(st
 		 * We don't really have DMA, so we need to copy to our
 		 * platform driver buffer
 		 */
-		sg_copy_from_buffer(data->sg, 1, host->virt_base,
+		sg_copy_to_buffer(data->sg, 1, host->virt_base,
 				data->sg->length);
 	}
 }


