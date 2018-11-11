Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CA2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x0DahykE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9CA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbeKLIU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388727AbeKLIU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E713B21707;
        Sun, 11 Nov 2018 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975432;
        bh=NiAhzOHqXLlB74m1aEJONICXsKnJ02HOh2N5kiURdO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0DahykEI1rl33gpaYp3nlJ/QZK1rLoEA4KoDqCk1J8+EnnDoY6LU4qIw1ZeFJKnK
         sYt9bUNAnAWMwjc88P0adFWfnAHbtBMr2kKnSH7XQzmJOfDbCmYEKTN9ZH9SMihQmN
         qFauk3xtpPyyr3X1DHEfhqQwo1Op+sqgGp0N+EEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 175/350] firmware: coreboot: Unmap ioregion after device population
Date:   Sun, 11 Nov 2018 14:20:39 -0800
Message-Id: <20181111221715.350825684@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 20edec388277b62ddfddb8b2b376a937a2cd6d1b ]

Both callers of coreboot_table_init() ioremap the pointer that comes in
but they don't unmap the memory on failure. Both of them also fail probe
immediately with the return value of coreboot_table_init(), leaking a
mapping when it fails. The mapping isn't necessary at all after devices
are populated either, so we can just drop the mapping here when we exit
the function. Let's do that to simplify the code a bit and plug the leak.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/google/coreboot_table.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -110,7 +110,8 @@ int coreboot_table_init(struct device *d
 
 	if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
 		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	ptr_entry = (void *)ptr_header + header.header_bytes;
@@ -137,7 +138,8 @@ int coreboot_table_init(struct device *d
 
 		ptr_entry += entry.size;
 	}
-
+out:
+	iounmap(ptr);
 	return ret;
 }
 EXPORT_SYMBOL(coreboot_table_init);
@@ -146,7 +148,6 @@ int coreboot_table_exit(void)
 {
 	if (ptr_header) {
 		bus_unregister(&coreboot_bus_type);
-		iounmap(ptr_header);
 		ptr_header = NULL;
 	}
 


