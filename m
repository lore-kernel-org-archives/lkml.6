Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851A0205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851A0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIEOPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:15:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:15:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxUNx-0004CD-Hk; Wed, 05 Sep 2018 09:46:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: video: fix registration of an empty comp core_component
Date:   Wed,  5 Sep 2018 10:46:05 +0100
Message-Id: <20180905094605.14827-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently we have structrues comp (which is empty) and comp_info being
used to register and deregister the component.  This mismatch in naming
occurred from a previous commit that renamed aim_info to comp. Fix this
to use consistent component naming in line with most/net, most/sound etc.

This fixes the message two issues, one with a null empty name when
loading the module:

[ 1485.269515] most_core: registered new core component (null)

and an Oops when removing the module:

[ 1485.277971] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 1485.278648] PGD 0 P4D 0
[ 1485.279253] Oops: 0002 [#2] SMP PTI
[ 1485.279847] CPU: 1 PID: 32629 Comm: modprobe Tainted: P      D WC OE     4.18.0-8-generic #9
[ 1485.280442] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[ 1485.281040] RIP: 0010:most_deregister_component+0x3c/0x70 [most_core]
.. etc

Fixes: 1b10a0316e2d ("staging: most: video: remove aim designators")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/most/video/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index cf342eb58e10..ad7e28ab9a4f 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -530,7 +530,7 @@ static int comp_disconnect_channel(struct most_interface *iface,
 	return 0;
 }
 
-static struct core_component comp_info = {
+static struct core_component comp = {
 	.name = "video",
 	.probe_channel = comp_probe_channel,
 	.disconnect_channel = comp_disconnect_channel,
@@ -565,7 +565,7 @@ static void __exit comp_exit(void)
 	}
 	spin_unlock_irq(&list_lock);
 
-	most_deregister_component(&comp_info);
+	most_deregister_component(&comp);
 	BUG_ON(!list_empty(&video_devices));
 }
 
-- 
2.17.1

