Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF37CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D9A217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864647;
	bh=n7pF/pYRTEG6sjkZiq2CkrP0y3hm29Qq/EZNgrghJ4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gx73njXgIxPzg9HWdr+0d/nfu8BqqyN94TyTImn86LXHJlqyvT6aoO+9vd79v5aWL
	 /Qgkx9y/63xpuZPDqXCeEZsKIxo+LVWiwRlcm+PSE2wAeIUlHAmiminmp32MB2A4OU
	 82YLROVC9iezdz5lzbNeC/2TkBqMhjbKAy+cXrxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfAGMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82077206BB;
        Mon,  7 Jan 2019 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864643;
        bh=n7pF/pYRTEG6sjkZiq2CkrP0y3hm29Qq/EZNgrghJ4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vhshWVN1+E43gPQRT+xhQH0CaQxPu2FcxKaAWBcyWjiIlis+bOZ5HtUPtpVbMh32Z
         BvhLVPDz0GvD8XZOAPrnn+DY9i9UiDMA6vEF/4V37qh3bxpqXGnuHeE2cf/fDRe7BC
         cl3Cyc5aJx6maNywlvClrOx3Yic1IWZjED9fH01c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanjeev Chugh <sanjeev_chugh@mentor.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.20 052/145] Input: atmel_mxt_ts - dont try to free unallocated kernel memory
Date:   Mon,  7 Jan 2019 13:31:29 +0100
Message-Id: <20190107104444.152728846@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjeev Chugh <sanjeev_chugh@mentor.com>

commit 1e3c336ad8f40f88a8961c434640920fe35cc08b upstream.

If the user attempts to update Atmel device with an invalid configuration
cfg file, error handling code is trying to free cfg file memory which is
not allocated yet hence results into kernel crash.

This patch fixes the order of memory free operations.

Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Fixes: a4891f105837 ("Input: atmel_mxt_ts - zero terminate config firmware file")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/atmel_mxt_ts.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1585,10 +1585,10 @@ static int mxt_update_cfg(struct mxt_dat
 	/* T7 config may have changed */
 	mxt_init_t7_power_cfg(data);
 
-release_raw:
-	kfree(cfg.raw);
 release_mem:
 	kfree(cfg.mem);
+release_raw:
+	kfree(cfg.raw);
 	return ret;
 }
 


