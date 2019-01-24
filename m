Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC5BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9C21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360520;
	bh=+cq7yby8HefikrryJt6H3MjqqtHkZaMNV91qcwT8onE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lw1M3XobPOGX6lN0FDb1+LQ2zgqtIcWs2365WCyfb4wN/GIE4q+iyrEsSZVeCXn9u
	 rwZaPzRtTfnPkXYJwQAD52LTn4LVdvr+X1hD8BLUSYlpr9JaHxLJJdggPOUYzw/8cf
	 3dKkrbh46dfQ+6BMRZwtRRMt6Vh5xh3kzIDBDl1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfAXUIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbfAXT3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A621218F0;
        Thu, 24 Jan 2019 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358141;
        bh=+cq7yby8HefikrryJt6H3MjqqtHkZaMNV91qcwT8onE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYtrq7rMMtjs6+EXquF+YelvZA5hePoY9GmEKQ0cmCtIswHvCsHuFqYPwSsJuF31t
         xw251fdt4e6+iWXTJx5vuybxMZhe1p95wbCyaTKo+PV5xPwrbaPWbF14wE0V1gV/I/
         osSP4YR/iUM8gKe3haWffFh4XKVVBouFDKDbvUAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 079/104] writeback: dont decrement wb->refcnt if !wb->bdi
Date:   Thu, 24 Jan 2019 20:20:08 +0100
Message-Id: <20190124190204.015211499@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a307c37c2e6c..072501a0ac86 100644
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



