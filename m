Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB91D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n44RVWJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB91D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeKTC6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeKTC6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0E821104;
        Mon, 19 Nov 2018 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645250;
        bh=Vdlx8izv4ocnXcY50CEFj+8t5KSGAmnGn0snHYEcXlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n44RVWJVec0aBwhHbvZG6zsm+RBppAncc7jBbNNSFUPClt5UlA9I2/YkBFY7z2muI
         xY0FA8fntABo0qIeGGA03EUPoaM60JMh8Wd/tAJw84qw5HmIy5Rt/rJwV95hwQt7W9
         /oXj9x5MdQMkfc5IxFIFufJUn3jAjo/zrQaYAVWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Zloch <jacek.zloch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 092/205] acpi, nfit: Fix ARS overflow continuation
Date:   Mon, 19 Nov 2018 17:26:39 +0100
Message-Id: <20181119162632.332651855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2845,9 +2845,9 @@ static int acpi_nfit_query_poison(struct
 		return rc;
 
 	if (ars_status_process_records(acpi_desc))
-		return -ENOMEM;
+		dev_err(acpi_desc->dev, "Failed to process ARS records\n");
 
-	return 0;
+	return rc;
 }
 
 static int ars_register(struct acpi_nfit_desc *acpi_desc,


