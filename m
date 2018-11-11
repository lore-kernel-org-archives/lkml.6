Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56720866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyce76yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D56720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeKLJvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732255AbeKLIR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1003F223CA;
        Sun, 11 Nov 2018 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975284;
        bh=CY7S1lRzubXHb9rrMbx9cAUpUmp0ZQuwaaCaxgUxxfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dyce76yt+MvEclW/eelBfyB19ymasdGkARQo4CENldLmwtYupZffysYl6X7JHQ9v3
         ErktdsOK0daBW2DeJdc6+HsRhgedG9UEzetnq4W5mnc6td9TtPHU66C9X5NNNIsk2T
         haDLTf0J/ekx50A80W7nYvU/pXdN37CqXzwYamuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 177/361] firmware: coreboot: Unmap ioregion after device population
Date:   Sun, 11 Nov 2018 14:18:44 -0800
Message-Id: <20181111221645.074251635@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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
 


