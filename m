Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060B320645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="atMMzeMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060B320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbeJICGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbeJICGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4E6204FD;
        Mon,  8 Oct 2018 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024785;
        bh=xcOoiDSiWjaV57vzMPQTMGab1X+3cwHU6eHzDKhHkT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atMMzeMrQ/M1utv3PSF52Qk0fthgV3/LHH6bVMEAsqAJ1q42uoEs7H2wZYUJDQhCR
         zWSZAqu7dy4PisJGLAhHttQPCOuuEmyaMOnFT4G2hXS026vwPDx+hNsG0iRWJaf+b0
         LV5bb6nvnNB73P034ZxOLdRl+Y0+MT3OigkMULvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 153/168] firmware: Always initialize the fw_priv list object
Date:   Mon,  8 Oct 2018 20:32:13 +0200
Message-Id: <20181008175625.856811105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 7012040576c6ae25a47035659ee48673612c2c27 upstream.

When freeing the fw_priv the item is taken off the list. This causes an
oops in the FW_OPT_NOCACHE case as the list object is not initialized.

Make sure to initialize the list object regardless of this flag.

Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
Cc: stable@vger.kernel.org
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/firmware_loader/main.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -226,8 +226,11 @@ static int alloc_lookup_fw_priv(const ch
 	}
 
 	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
-	if (tmp && !(opt_flags & FW_OPT_NOCACHE))
-		list_add(&tmp->list, &fwc->head);
+	if (tmp) {
+		INIT_LIST_HEAD(&tmp->list);
+		if (!(opt_flags & FW_OPT_NOCACHE))
+			list_add(&tmp->list, &fwc->head);
+	}
 	spin_unlock(&fwc->lock);
 
 	*fw_priv = tmp;


