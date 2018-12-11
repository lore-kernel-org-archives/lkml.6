Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6EBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878AF208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543211;
	bh=LtE0N+9Br/zOevKM8nOtBH6a6VW+TdTNwi4bYBW/TAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJicbz9p+YctmYC3wtbODnxYo3EsxEk8r8CCwmV2XCixChmzIE0Bw1/LVTr42p4Tt
	 T2Pqve7iEJ93IZ1Ld+xfWYgtbzqJFvJK9Ki9Wzkxj9F1jz9t7zoOtLP1Xzz8wRB+pu
	 nzINontx5JNIKw+oy/2cG6ZhaaEKRYkpkbO1WTck=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878AF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeLKPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbeLKPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5597A2087F;
        Tue, 11 Dec 2018 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543206;
        bh=LtE0N+9Br/zOevKM8nOtBH6a6VW+TdTNwi4bYBW/TAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ra7FLk4FjO0O1r4P8I8m/mbffwEqNZWrqyZeXNQxIgHH2Sd1O4ZI7RHxBMpqE7h4R
         kOxMlITJwSVc13gzPWhpOpQMPiMNMpQV+WWoh4btRLfw+iS2cdReI8OPHhr0CNQsEz
         RyqK1cOtstYsaCsMprEPSwg/m2LUKJQ8GXYCSo+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 4.4 20/91] misc: mic/scif: fix copy-paste error in scif_create_remote_lookup
Date:   Tue, 11 Dec 2018 16:40:39 +0100
Message-Id: <20181211151607.457147313@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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
@@ -414,7 +414,7 @@ static int scif_create_remote_lookup(str
 		if (err)
 			goto error_window;
 		err = scif_map_page(&window->num_pages_lookup.lookup[j],
-				    vmalloc_dma_phys ?
+				    vmalloc_num_pages ?
 				    vmalloc_to_page(&window->num_pages[i]) :
 				    virt_to_page(&window->num_pages[i]),
 				    remote_dev);


