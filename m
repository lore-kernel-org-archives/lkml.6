Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B666ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E802085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsOGwCC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E802085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeKDXI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbeKDXI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517F42085A;
        Sun,  4 Nov 2018 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339601;
        bh=1CN6w0LMiAAka87nLPGdlFyExAMWTmiCUZntxeeBbHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsOGwCC8wAFS7/bPDKrj0DeGxOw93gy/5rSUJp8aOWRjgl492B9mHVLEtpLu2vqIX
         ofbmlp5spclF82jurwjhu/ElgCA1d1jsqnLEZR5s1OoLjIWS3uYgt36EQcnYyAsK/x
         dafVqm4ZJ1uJ924nKhDScsLsxOil8fb7gFtiPchw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 41/45] staging: most: video: fix registration of an empty comp core_component
Date:   Sun,  4 Nov 2018 08:52:36 -0500
Message-Id: <20181104135240.88431-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 1f447e51c0b9e8beeec0917ea5f51930f55e17c9 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

