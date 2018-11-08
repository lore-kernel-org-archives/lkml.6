Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D42720883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOr7Rfoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D42720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeKIHw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbeKIHpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:51 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB18214DB;
        Thu,  8 Nov 2018 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714899;
        bh=3d8cX+Qe8YjRXHoQKwdH4sd+HREwbrQ4/0i//LI/vNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOr7RfoqtPLCSqZ+hYigb10BdG2x1a3UVXkeiR8vjretlrfq7T0GgMpQcTMwb+Y6X
         fjRBL+fLpCQAEN1FnGtOilDXd9wyzjpkI3prLgwJ6S7QY+oqE14MzZjKEu0Infh8lY
         PJm9p9BUigb1GvX+s1kaaHKjOjW7Y6WUkq34+iKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 16/31] RDMA/ucma: Fix Spectre v1 vulnerability
Date:   Thu,  8 Nov 2018 13:52:40 -0800
Message-Id: <20181108215131.032974539@linuxfoundation.org>
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

commit a3671a4f973ee9d9621d60166cc3b037c397d604 upstream.

hdr.cmd can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/infiniband/core/ucma.c:1686 ucma_write() warn: potential
spectre issue 'ucma_cmd_table' [r] (local cap)

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
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -44,6 +44,8 @@
 #include <linux/module.h>
 #include <linux/nsproxy.h>
 
+#include <linux/nospec.h>
+
 #include <rdma/rdma_user_cm.h>
 #include <rdma/ib_marshall.h>
 #include <rdma/rdma_cm.h>
@@ -1659,6 +1661,7 @@ static ssize_t ucma_write(struct file *f
 
 	if (hdr.cmd >= ARRAY_SIZE(ucma_cmd_table))
 		return -EINVAL;
+	hdr.cmd = array_index_nospec(hdr.cmd, ARRAY_SIZE(ucma_cmd_table));
 
 	if (hdr.in + sizeof(hdr) > len)
 		return -EINVAL;


