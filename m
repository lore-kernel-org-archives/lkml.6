Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89D21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeJIvy0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeKTDIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388298AbeKTDIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FAA121104;
        Mon, 19 Nov 2018 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645873;
        bh=BUfWc2/RGjDjYy9pvX9edPfXpTdAikBjaeqoCyo8PO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeJIvy0waWbCz7+dJsejuuBr1a6Vao0ylrytDqcKkVmrleEU5fXJ9nrybGL+5e6UF
         9Jmmk98bkNRj3UIhqCeWYZOW0xeCcxVu4PtB/asw1GoeVUSGAjgKWCzTJ3HNP5zp8n
         G9HkY15ojxOQwq+CgyFo9mimVRWuSt9F0N9f6Wd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Zloch <jacek.zloch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.18 075/171] acpi, nfit: Fix ARS overflow continuation
Date:   Mon, 19 Nov 2018 17:27:51 +0100
Message-Id: <20181119162631.749501182@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 3fa58dcab50a0aa16817f16a8d38aee869eb3fb9 upstream.

When the platform BIOS is unable to report all the media error records
it requires the OS to restart the scrub at a prescribed location. The
driver detects the overflow condition, but then fails to report it to
the ARS state machine after reaping the records. Propagate -ENOSPC
correctly to continue the ARS operation.

Cc: <stable@vger.kernel.org>
Fixes: 1cf03c00e7c1 ("nfit: scrub and register regions in a workqueue")
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2835,9 +2835,9 @@ static int acpi_nfit_query_poison(struct
 		return rc;
 
 	if (ars_status_process_records(acpi_desc))
-		return -ENOMEM;
+		dev_err(acpi_desc->dev, "Failed to process ARS records\n");
 
-	return 0;
+	return rc;
 }
 
 static int ars_register(struct acpi_nfit_desc *acpi_desc,


