Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F646ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71020892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="biNgziEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA71020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeKIHma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbeKIHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5122208E3;
        Thu,  8 Nov 2018 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714699;
        bh=vyGYesc0dt+9pf0eNefoniaTpCXdtNVJLjvAuAEkHI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biNgziEbdzeSklYz5jomrmfjgVlm1OdFKJcG6tt8bioToz9BsLj4rhDRFv0XvN7pp
         G21VjtRtIgZD+6qOjB+q7cgw9G1jMRTov9UNH9NJQfGFFjl1HwpT29iLZSLibOsvsC
         vCcmvwyyR+4UWA49qwH/2dxLBE7StiWYmEQ4NaY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 069/171] elevator: fix truncation of icq_cache_name
Date:   Thu,  8 Nov 2018 13:50:39 -0800
Message-Id: <20181108215132.604328413@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9bd2bbc01d17ddd567cc0f81f77fe1163e497462 ]

gcc 7.1 reports the following warning:

    block/elevator.c: In function ‘elv_register’:
    block/elevator.c:898:5: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
         "%s_io_cq", e->elevator_name);
         ^~~~~~~~~~
    block/elevator.c:897:3: note: ‘snprintf’ output between 7 and 22 bytes into a destination of size 21
       snprintf(e->icq_cache_name, sizeof(e->icq_cache_name),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "%s_io_cq", e->elevator_name);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bug is that the name of the icq_cache is 6 characters longer than
the elevator name, but only ELV_NAME_MAX + 5 characters were reserved
for it --- so in the case of a maximum-length elevator name, the 'q'
character in "_io_cq" would be truncated by snprintf().  Fix it by
reserving ELV_NAME_MAX + 6 characters instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/elevator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index e7f358d2e5fc..eaa58c0f894b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -102,7 +102,7 @@ struct elevator_type
 	struct module *elevator_owner;
 
 	/* managed by elevator core */
-	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
+	char icq_cache_name[ELV_NAME_MAX + 6];	/* elvname + "_io_cq" */
 	struct list_head list;
 };
 
-- 
2.17.1



