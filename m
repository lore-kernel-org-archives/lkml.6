Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F94A21508
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yXKu2umX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F94A21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeLDLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeLDLH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:07:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35DD2146D;
        Tue,  4 Dec 2018 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921647;
        bh=2nrFfrwBBuqQQUyuln6HPQft5E3LWI1C13z6fRarh0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXKu2umXLf/r0HvR+MUXoNrNMGdnaf0YxVWK7jTWHBsKGrVmncJDR3JGXtFJTUr0Q
         3vewTnlA8G2sgxUI2Ghlgp2zma0yCWlKvlCfcxeszKWiffFFayGZUywPCXhKOpaF16
         ++bfV/4w3QQVs+YZJZaogq11ZZp0RkTlEH+NkFQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 4.14 145/146] misc: mic/scif: fix copy-paste error in scif_create_remote_lookup
Date:   Tue,  4 Dec 2018 11:50:31 +0100
Message-Id: <20181204103732.664054156@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit 6484a677294aa5d08c0210f2f387ebb9be646115 upstream.

gcc '-Wunused-but-set-variable' warning:

drivers/misc/mic/scif/scif_rma.c: In function 'scif_create_remote_lookup':
drivers/misc/mic/scif/scif_rma.c:373:25: warning:
 variable 'vmalloc_num_pages' set but not used [-Wunused-but-set-variable]

'vmalloc_num_pages' should be used to determine if the address is
within the vmalloc range.

Fixes: ba612aa8b487 ("misc: mic: SCIF memory registration and unregistration")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mic/scif/scif_rma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -417,7 +417,7 @@ static int scif_create_remote_lookup(str
 		if (err)
 			goto error_window;
 		err = scif_map_page(&window->num_pages_lookup.lookup[j],
-				    vmalloc_dma_phys ?
+				    vmalloc_num_pages ?
 				    vmalloc_to_page(&window->num_pages[i]) :
 				    virt_to_page(&window->num_pages[i]),
 				    remote_dev);


