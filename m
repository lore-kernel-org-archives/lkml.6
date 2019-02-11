Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439052081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896497;
	bh=bLOf+838cYiInnQSu+NptXv71VgFyEVywf4ObhvSQqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aT8ixIpvBQeaK0ZFhkTT+Zqf5IYx+RN1WKOzaxBRJw2Qmg/xDQXD32A9h0zeEIfev
	 IfLgv+EkM7q0n2TMdOuirPQMJLKtdFXlAD20Qgewuz+jJ4rAYvW9Ho7nrhl7+OAZ6Y
	 KPX5HTg/w0GkE/TejV2Os4wBwfVX2KihFHBd6jUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfBKOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732594AbfBKOsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:48:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE9C20700;
        Mon, 11 Feb 2019 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896487;
        bh=bLOf+838cYiInnQSu+NptXv71VgFyEVywf4ObhvSQqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhDBisOXqQXcznRC8deV0OlUPwYJyj911vRDWSQCJ18sZQ2gs3FD7abLWOsY5UMaw
         GMH8pZY4JSl0fI31qNLvwh2SzuxKHDG1/Tk3liRlZ5Os4F/BwiQmPDlY45bPLYtHKM
         qfVp+JDLLu+LWvMcsaiI7nc3p63F8e9+FohPZ6ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Tyler Baicar <baicar.tyler@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 201/313] ACPI/APEI: Clear GHES block_status before panic()
Date:   Mon, 11 Feb 2019 15:18:01 +0100
Message-Id: <20190211141906.616010079@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



