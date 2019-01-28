Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B29C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3A72183F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690975;
	bh=kpG2va2UuuVIoujxQaCdO0RvF2LF3QJtU3l2Y8G7nN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1hNKxfz9RC9wTRcXCS3FeVTg+bUXDm2G+fHIoFZKhCE0dKd06S6lFu65XcVY2ERQ
	 3WOjjDVu8Pp2Fu8oEhdOOp/1X2wPR1Ll6Ya3sThhflxwx4/zL6lp3JfmRkZi0U0v6+
	 QA/Z/zMl3mKft+PxqPD9IVo/lBQNdDQDBNCRSM5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfA1P4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbfA1P4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCCB2183F;
        Mon, 28 Jan 2019 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690969;
        bh=kpG2va2UuuVIoujxQaCdO0RvF2LF3QJtU3l2Y8G7nN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2na0IEsUKs1oWYkpPHsIGqUpxpIvjNVjBBQXiqoQnK4ePZUEHya3a/aoYlb0/TYZw
         t/PkjDAE7kt7jIyzK2m2nJtCPREt5ywgGa4vHjc4lHlHZ60reDD4Qf8cwLUh+Kf41T
         OUqSZQXQ3tKg6lTDCxZ9+FbL7t20j/mbONzX653M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        David Arcari <darcari@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 250/304] ACPI/APEI: Clear GHES block_status before panic()
Date:   Mon, 28 Jan 2019 10:42:47 -0500
Message-Id: <20190128154341.47195-250-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

