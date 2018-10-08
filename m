Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F02C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B72145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj88gPeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1B72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJIBqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbeJIBqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790A52145D;
        Mon,  8 Oct 2018 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023615;
        bh=DP1O8OgbXQJEl0mQY3umTj/IX1qylcPDe1nYacozShw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj88gPeUzPCsQlNtZhxxqAVbdg2y/eIhO+8ar8YL+iwYVHDWh5osKiwaD0fiMc10R
         /gooKmJ6wfjsYxhGs5P+UhbQzwANvCtE/23a6Pksk2q1yHM+GJCFsXCIfucpzc+ZJj
         FUXpmj5ywzs2VwJpfDcMw3587PHVUbB/RnPHji50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 006/113] uwb: hwa-rc: fix memory leak at probe
Date:   Mon,  8 Oct 2018 20:30:07 +0200
Message-Id: <20181008175531.171527299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 11b71782c1d10d9bccc31825cf84291cd7588a1e ]

hwarc_probe() allocates memory for hwarc, but does not free it
if uwb_rc_add() or hwarc_get_version() fail.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uwb/hwa-rc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/uwb/hwa-rc.c
+++ b/drivers/uwb/hwa-rc.c
@@ -875,6 +875,7 @@ error_get_version:
 error_rc_add:
 	usb_put_intf(iface);
 	usb_put_dev(hwarc->usb_dev);
+	kfree(hwarc);
 error_alloc:
 	uwb_rc_put(uwb_rc);
 error_rc_alloc:


