Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF344C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6846206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865518;
	bh=nNYdC8DDkHMMuFdsOEtaSnhV0cKaPdzCaiiiNOVmOFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sMmNKh/3pbBQnHawlGCqncD8tlXk9tFeYQVWBmtM4eFXGXBjDU/ImPt0+78GCZRA9
	 Y7aI9ZkSygQ2Mdo2fK6VWTM84rzADIDL6UgwMM2auh3opwb8tANDY55ljePxe1tqyX
	 LriUh4Nutx7htcbTUzH3uuWkhhtw0ggb98NuTiNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfAGMv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfAGMv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15C620651;
        Mon,  7 Jan 2019 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865515;
        bh=nNYdC8DDkHMMuFdsOEtaSnhV0cKaPdzCaiiiNOVmOFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fC6dkIrHADEGV0GEjJ6/M0OVuJk7cqQuLgXoT5zMkfTENwcs46eeqH698hlNapPOc
         /7Y6MgaWp7l2NEK18SD6pkcmPae4+s37zZ5LCUHXiboPV7nTuKmepT7r8jFFTlDMc5
         FQ9ugE7klHCvmf0aQ4pXSjfuRAHPqaNFI+EyeeOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanjeev Chugh <sanjeev_chugh@mentor.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 088/170] Input: atmel_mxt_ts - dont try to free unallocated kernel memory
Date:   Mon,  7 Jan 2019 13:31:55 +0100
Message-Id: <20190107104503.409459142@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -1586,10 +1586,10 @@ static int mxt_update_cfg(struct mxt_dat
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
 


