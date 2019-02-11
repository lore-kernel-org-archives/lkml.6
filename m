Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8060C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784B7222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898055;
	bh=uGtmWpC0VLJ1fhdJH8NEumbpfQnumNwyWYoxf14uDUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IKjJO8RKb5428khgYWowOWYnGypm/ywGi1kEptvi8auGo5meoa+LXvcrGjqd8lfXy
	 TTfgJc7DOCtx6E1O3Wxac5dALFyNlvX+VSEY5ZlO1X0ThFdsNKY2nEs0891PDjmlWP
	 /j8zOWBZ9gjKdjDl55tIpWWbulKGUU5kuunLBP20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbfBKPIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403877AbfBKPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:08:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E28A217D9;
        Mon, 11 Feb 2019 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897721;
        bh=uGtmWpC0VLJ1fhdJH8NEumbpfQnumNwyWYoxf14uDUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAJ77Dj4T07uW6FoQISxigLonTozUbrIh7WvjeE/bPrgyR/J0xciY6Sx1/xtNSCKp
         VIdWToj2JqXN3uKOEQH4wvX9ksuKaofuV01AMpykTHhMNDH4JUnT+mIzBxR2m+r0fh
         5Wf8W3FZHAsfAY0b0cnyF03FpkkrhBxICTaq0YA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 094/137] gdrom: fix a memory leak bug
Date:   Mon, 11 Feb 2019 15:19:35 +0100
Message-Id: <20190211141820.763284668@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017 ]

In probe_gdrom(), the buffer pointed by 'gd.cd_info' is allocated through
kzalloc() and is used to hold the information of the gdrom device. To
register and unregister the device, the pointer 'gd.cd_info' is passed to
the functions register_cdrom() and unregister_cdrom(), respectively.
However, this buffer is not freed after it is used, which can cause a
memory leak bug.

This patch simply frees the buffer 'gd.cd_info' in exit_gdrom() to fix the
above issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdrom/gdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index e2808fefbb78..1852d19d0d7b 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -882,6 +882,7 @@ static void __exit exit_gdrom(void)
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
 	kfree(gd.toc);
+	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);
-- 
2.19.1



