Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76957C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480042175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692277;
	bh=23Bs3OEWO07nuGLtd8xOUw84hR/iKgs3D+IwmJnj9Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBZtu4Fw0P9U9BL/bMA2RSTIsBhBx4wS7ZwgIPiGL2ts6m4XfnZYGfQPCbahfswUr
	 TQ7m123F5w3z+kmNMAzjc9xO7BGdd4/xVJPgB1R3RdPgkbtWNkWmxH+ChLhuqotwh8
	 jZn41ixjhEeIoZzT6k+DD8tuf+MuRi8A+ZJjFfCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbfA1QRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbfA1QRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7192175B;
        Mon, 28 Jan 2019 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692265;
        bh=23Bs3OEWO07nuGLtd8xOUw84hR/iKgs3D+IwmJnj9Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOf/3aXFxXqGanTTi+sBaVBg4ytlcNgI7MQd3bj+XbDG69DlHI9VDI9jh3hb1XRzn
         ACdPfAEk+2oemqWSWLNdDWw3Uai0gcu049TIrotQ8dT7F9Ex8SpMyBPc1mP+W+e+PR
         YLnptx1bgIDIXuS65ZglKnmDrh62sbBoarXELjMw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        David Arcari <darcari@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 132/170] ACPI/APEI: Clear GHES block_status before panic()
Date:   Mon, 28 Jan 2019 11:11:22 -0500
Message-Id: <20190128161200.55107-132-sashal@kernel.org>
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
index f14695e744d0..5889f6407fea 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -675,6 +675,8 @@ static void __ghes_panic(struct ghes *ghes)
 {
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
 
+	ghes_clear_estatus(ghes);
+
 	/* reboot to log the error! */
 	if (!panic_timeout)
 		panic_timeout = ghes_panic_timeout;
-- 
2.19.1

