Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F0BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B1214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHp9WsV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B1214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeLDLAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbeLDLAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A638C214C1;
        Tue,  4 Dec 2018 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921249;
        bh=csUc1xsszE95nH9qJjoUZIYnGPq1qSd6STtJxYffx/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHp9WsV0AYtr+N/k9cMnMNIuHYNoJUYtkfgDFDYcBF1OzlPdzEESBmXmmSz/8BsTX
         QaBb71rREhbPOik+FH2gW0vRDR3ezw+HVZxWEl97OcYhqiokLrYVAlEIlAEe+f3Kak
         OGZ3To+rTzKKcupewAo2rbihf7CDXiDjDg2adXhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4.19 138/139] Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()
Date:   Tue,  4 Dec 2018 11:50:19 +0100
Message-Id: <20181204103656.546768798@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Dexuan Cui <decui@microsoft.com>

commit eceb05965489784f24bbf4d61ba60e475a983016 upstream.

This is a longstanding issue: if the vmbus upper-layer drivers try to
consume too many GPADLs, the host may return with an error
0xC0000044 (STATUS_QUOTA_EXCEEDED), but currently we forget to check
the creation_status, and hence we can pass an invalid GPADL handle
into the OPEN_CHANNEL message, and get an error code 0xc0000225 in
open_info->response.open_result.status, and finally we hang in
vmbus_open() -> "goto error_free_info" -> vmbus_teardown_gpadl().

With this patch, we can exit gracefully on STATUS_QUOTA_EXCEEDED.

Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/channel.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -482,6 +482,14 @@ int vmbus_establish_gpadl(struct vmbus_c
 	}
 	wait_for_completion(&msginfo->waitevent);
 
+	if (msginfo->response.gpadl_created.creation_status != 0) {
+		pr_err("Failed to establish GPADL: err = 0x%x\n",
+		       msginfo->response.gpadl_created.creation_status);
+
+		ret = -EDQUOT;
+		goto cleanup;
+	}
+
 	if (channel->rescind) {
 		ret = -ENODEV;
 		goto cleanup;


