Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBDC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B04520883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcpI0IBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B04520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeKIHw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbeKIHpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:51 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7190E21019;
        Thu,  8 Nov 2018 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714900;
        bh=qFaSgKlw9dIcFjf9ttffpe3f7VBUhuVCfTSQG6OwGiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcpI0IBCnU2sFYfUCM9bBfOg5vEnofM2cYBRDssUiRACbVx85Z7Oe1SmwTHuSLqGx
         c4EOL8zhulc2rBqgqYulolg5njOK2PSvhc9lU6LrX89jZbTmsappoZqiVdmxogij/O
         +UzAMuUCEqyKxCcBZGi9BeIvyo7wHIJa3u88mHvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 17/31] IB/ucm: Fix Spectre v1 vulnerability
Date:   Thu,  8 Nov 2018 13:52:41 -0800
Message-Id: <20181108215131.106849673@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 0295e39595e1146522f2722715dba7f7fba42217 upstream.

hdr.cmd can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/infiniband/core/ucm.c:1127 ib_ucm_write() warn: potential
spectre issue 'ucm_cmd_table' [r] (local cap)

Fix this by sanitizing hdr.cmd before using it to index
ucm_cmd_table.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -46,6 +46,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
+#include <linux/nospec.h>
+
 #include <linux/uaccess.h>
 
 #include <rdma/ib.h>
@@ -1118,6 +1120,7 @@ static ssize_t ib_ucm_write(struct file
 
 	if (hdr.cmd >= ARRAY_SIZE(ucm_cmd_table))
 		return -EINVAL;
+	hdr.cmd = array_index_nospec(hdr.cmd, ARRAY_SIZE(ucm_cmd_table));
 
 	if (hdr.in + sizeof(hdr) > len)
 		return -EINVAL;


