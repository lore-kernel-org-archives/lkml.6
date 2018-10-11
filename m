Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E8C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCL5TNci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeJKXFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C77620652;
        Thu, 11 Oct 2018 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272274;
        bh=pg61y1vWR/1ahl1uXkEVw9fxFAPo5Q35kncDCyP2Y5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCL5TNcizK9H1CvghyY7qeVBXOktQHtB2XQ/Z3HIjxRTi2uh/YjANkcYQMZdYM9Pz
         gp7oOeKB+nuF6y4NQpoTH0qSCpTnW/WiqC0tudjgW6Hj8/sFkKUoRQDonlZqo+MQ6k
         GL/AhufSr4iI+O+fsWv6dvuL0QvHwT/9Fy1nvK9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 023/120] uwb: hwa-rc: fix memory leak at probe
Date:   Thu, 11 Oct 2018 17:33:24 +0200
Message-Id: <20181011152550.602859665@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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


