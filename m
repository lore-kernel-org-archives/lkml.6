Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A527C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E514D2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976563;
	bh=toWdBheG5KtciX3HmlO/y2a8Msu+2LdJVNFybnMKa4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqaSbWnV3ACH2Q2hE34JZuUXy0bEh8e9e68eYTJALYtu/WArkNRaIkQdD5/Bz7Gu8
	 qpZ2aZL4U2PLZSdUoZc2/4bpHgROM9sPaoak1kZuJSjxytfZrlszd8HVbeVeyVDeGR
	 9mrvy5I4BDsHI82Zbfbadltk2dmsalH9NCDpV/jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfAHTd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbfAHTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0697F20645;
        Tue,  8 Jan 2019 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976033;
        bh=toWdBheG5KtciX3HmlO/y2a8Msu+2LdJVNFybnMKa4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eurkBny4nT78srlCi1In0yQkytOSnlIv+/51yBfSjA8kYBzV2SoHt4bhh5Qf1G73u
         ydi2ZmavIFOkin3oM61rgVCZOU2pvndP4rtEnB2ieE8tzg9TupTikste+Ize211chp
         m6QEAwv52xpAGGIUNMGvYmRDnm/BRPrc08OYKW9g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/36] writeback: don't decrement wb->refcnt if !wb->bdi
Date:   Tue,  8 Jan 2019 14:33:15 -0500
Message-Id: <20190108193348.123880-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 347a28b586802d09604a149c1a1f6de5dccbe6fa ]

This happened while running in qemu-system-aarch64, the AMBA PL011 UART
driver when enabling CONFIG_DEBUG_TEST_DRIVER_REMOVE.
arch_initcall(pl011_init) came before subsys_initcall(default_bdi_init),
devtmpfs' handle_remove() crashes because the reference count is a NULL
pointer only because wb->bdi hasn't been initialized yet.

Rework so that wb_put have an extra check if wb->bdi before decrement
wb->refcnt and also add a WARN_ON_ONCE to get a warning if it happens again
in other drivers.

Fixes: 52ebea749aae ("writeback: make backing_dev_info host cgroup-specific bdi_writebacks")
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/backing-dev-defs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 32728ff8095c..4ea779b25a51 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -225,6 +225,14 @@ static inline void wb_get(struct bdi_writeback *wb)
  */
 static inline void wb_put(struct bdi_writeback *wb)
 {
+	if (WARN_ON_ONCE(!wb->bdi)) {
+		/*
+		 * A driver bug might cause a file to be removed before bdi was
+		 * initialized.
+		 */
+		return;
+	}
+
 	if (wb != &wb->bdi->wb)
 		percpu_ref_put(&wb->refcnt);
 }
-- 
2.19.1

