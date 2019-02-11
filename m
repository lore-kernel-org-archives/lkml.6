Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7838204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895643;
	bh=yyUylN4xcwBqmaik1W2T4pY5Lg6XQO75ZYDXQMZRNV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5ju2Er/2XXAgF5NpZigTll1kIZW4hgkIJzZpRWY9TxEuI0nbNanlRRjrsCo6N+az
	 hPCmRSVlS0+iTJgPfR1x0yBeYlNEmvNpCmx13nOsRWDVuYQ2KK4C+jZjRMf+KUmcSD
	 OpFd/3RAOvWcaXXHNoTB8VrE9T6bKbsPBzaLOJJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfBKOeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730732AbfBKOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77698204EC;
        Mon, 11 Feb 2019 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895636;
        bh=yyUylN4xcwBqmaik1W2T4pY5Lg6XQO75ZYDXQMZRNV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqAZ7qTE2ANh2vLNuWENnku2vfm12HCz6IP6TufXUgDigJ6HeXg+uMDtUDMtZDhUM
         GGb5eG0siAan/3ImoiVUgkumGeMcmhDxlMgySnY5Cemvh9vRVYpdzxNeahvtQu1RVo
         BW0OB55OnZBzNHk0Pqq54PtiuxEhXbVCC+ReN+DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 271/352] gdrom: fix a memory leak bug
Date:   Mon, 11 Feb 2019 15:18:18 +0100
Message-Id: <20190211141904.232262469@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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
index a5b8afe3609c..f8b7345fe1cb 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -873,6 +873,7 @@ static void __exit exit_gdrom(void)
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
 	kfree(gd.toc);
+	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);
-- 
2.19.1



