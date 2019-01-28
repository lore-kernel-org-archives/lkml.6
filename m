Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8067821738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692628;
	bh=CUhsIb/Rcezh3hqxk9oVOpXk6KMo5uI8+8fEERLhdw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6wSDDL7VQo3LkSzxpLEsqbAFQISWl1Pm/J/k/UCkhma9w8BY3liG9AKzkpkYYCd1
	 Qmz9PjlkRlxYm+JQfyLoul9QfZpFBLZBPhEbWUCbr6zMYaHR8+gw98pJWyRRKFDF0p
	 lpOWwgfexDZgSMYmjoBzqnMP5fCQnkKMZTiNNF98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbfA1QXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfA1QXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F5462084A;
        Mon, 28 Jan 2019 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692624;
        bh=CUhsIb/Rcezh3hqxk9oVOpXk6KMo5uI8+8fEERLhdw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdbjT0BPWUfjMkCEg46HuS9lSRuPLSwcBmMUTiGEjihoXIzCgzgrbtUWNcB6V5F6e
         8ah99+bR7FgcWlNXLzYSrR4HbSUU/G+3Y29PK+n9UvLyzZ/eAeadKb3Uz8pOiEd3/w
         i8vQjx2YOmooAcnPwTa04xsFJiN+6Hsh+9lCobfk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 098/107] gdrom: fix a memory leak bug
Date:   Mon, 28 Jan 2019 11:19:38 -0500
Message-Id: <20190128161947.57405-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

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

