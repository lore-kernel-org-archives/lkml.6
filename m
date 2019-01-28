Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B717DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8CB2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692349;
	bh=Cjnvp5qGsnXsNBP0R+FoSvIo9939kgzQkp72htoFvEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqlA8eLxfi6QnkZ5EGjgzXd7VsZtzm8YyaQXIzt5Gc0Z8UXCO9PVPsKgswFuYALwq
	 AcHEMZ8ZUCZSaiUR8zjgYgQBeeJfoGD+Qk751qNwax5m6/wp5tDXf6L7ROf86B6rYR
	 NERwAt46ddEAUvylENiPERxJwlOgTID+SVvPXS6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfA1QTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387835AbfA1QTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C429E2084A;
        Mon, 28 Jan 2019 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692343;
        bh=Cjnvp5qGsnXsNBP0R+FoSvIo9939kgzQkp72htoFvEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgPdY09W49ih/IBVoPCPqnlqMoLAsnggdD4Mgx9oEPIgffDFmVgPyLOE1hqUXvttU
         65fWcYJULFrj9BOhiogz9Nwm5A8gnDzO6N9IjI1J5BLapHs7FH7KWuc78dI1iuuf61
         pS/YAiCriun/pXpD9SseYdCiTQLxdsyPKHxLUZ20=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 157/170] gdrom: fix a memory leak bug
Date:   Mon, 28 Jan 2019 11:11:47 -0500
Message-Id: <20190128161200.55107-157-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index ae3a7537cf0f..72cd96a8eb19 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -889,6 +889,7 @@ static void __exit exit_gdrom(void)
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
 	kfree(gd.toc);
+	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);
-- 
2.19.1

