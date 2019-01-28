Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD87C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130C42173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691774;
	bh=kpG2va2UuuVIoujxQaCdO0RvF2LF3QJtU3l2Y8G7nN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQrMJT81ocP/PcKJKrgO47HULxWm5NmZkX7BufFLf6slOoniYOhBU4nTLuTWPlRi4
	 wnnIWvdq86USjwV0peO7uwcluQx8j3f2/cGm90/yXzDfWbVObvf5wvSa1QhKIDSOVk
	 MScF8HtDMAogupPD+YMokRKPK0ZAML73M2a5HyIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfA1QJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732601AbfA1QJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3502084A;
        Mon, 28 Jan 2019 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691766;
        bh=kpG2va2UuuVIoujxQaCdO0RvF2LF3QJtU3l2Y8G7nN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wh2GzGuoHMzHLFxqdtIGFj80239s7LZGqiO0ASuKO55fRVf1+NpRpxEAUX0+ajC5k
         tF99FmCItcxAUKd2AyuIHsxPs9qbYypwFtS6v0I83gDudhe8NK8zv3KO6qdeJ7jqJD
         SRuCoCE/0/WK7TH+IVPmhWGPzbh0db15CawqnwLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        David Arcari <darcari@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 210/258] ACPI/APEI: Clear GHES block_status before panic()
Date:   Mon, 28 Jan 2019 10:58:36 -0500
Message-Id: <20190128155924.51521-210-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lenny Szubowicz <lszubowi@redhat.com>

[ Upstream commit 98cff8b23ed1c763a029ee81ea300df0d153d07d ]

In __ghes_panic() clear the block status in the APEI generic
error status block for that generic hardware error source before
calling panic() to prevent a second panic() in the crash kernel
for exactly the same fatal error.

Otherwise ghes_probe(), running in the crash kernel, would see
an unhandled error in the APEI generic error status block and
panic again, thereby precluding any crash dump.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Signed-off-by: David Arcari <darcari@redhat.com>
Tested-by: Tyler Baicar <baicar.tyler@gmail.com>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 02c6fd9caff7..f008ba7c9ced 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
 {
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
 
+	ghes_clear_estatus(ghes);
+
 	/* reboot to log the error! */
 	if (!panic_timeout)
 		panic_timeout = ghes_panic_timeout;
-- 
2.19.1

