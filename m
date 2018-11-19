Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BBAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BDA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmqXANOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BDA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeKTCzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbeKTCzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FEA20831;
        Mon, 19 Nov 2018 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645101;
        bh=PGGfyXZ18cFDdEqeDf503jCN9mIbyUYxkVqp3pNU7KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmqXANOlM7blm2ZqfWYjS1TT1yn2yE6hyG1omPTxUBAYVxNnvPC+Lb8SvoDLm+ipR
         ztEpKgorInZh4WfTysRSvhrNtrVwzkJDVE+hvfD54tHPgfP/s1k19j1AMBJd5O/Ywj
         j2UCq04Mzx+SYkll1wCv6FYjwtldEfp3QOMjVQUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/205] staging: most: video: fix registration of an empty comp core_component
Date:   Mon, 19 Nov 2018 17:25:44 +0100
Message-Id: <20181119162623.989063093@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/most/video/video.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -530,7 +530,7 @@ static int comp_disconnect_channel(struc
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
 


