Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6C208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6C208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeHWJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 05:47:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:12859 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeHWJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 05:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 23:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,277,1531810800"; 
   d="scan'208";a="226988659"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2018 23:19:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc for 4.19] mei: fix use-after-free in mei_cl_write
Date:   Thu, 23 Aug 2018 09:16:58 +0300
Message-Id: <20180823061658.28578-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

KASAN reports a use-after-free during startup, in mei_cl_write:

    BUG: KASAN: use-after-free in mei_cl_write+0x601/0x870 [mei]
       (drivers/misc/mei/client.c:1770)

This is caused by commit 98e70866aacb ("mei: add support for variable
length mei headers."), which changed the return value from len, to
buf->size. That ends up using a stale buf pointer, because blocking
call, the cb (callback) is deleted in me_cl_complete() function.

However, fortunately, len remains unchanged throughout the function
(and I don't see anything else that would require re-reading buf->size
either), so the fix is to simply revert the change, and return len, as
before.

Fixes: 98e70866aacb ("mei: add support for variable length mei headers.")
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: 1. Add better explaination in the commit message.
    2. Add Fixes: marker

BTW: The usage len is changed in furhter patches that were not
yet merged.

 drivers/misc/mei/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 4ab6251d418e..ebdcf0b450e2 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1767,7 +1767,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		}
 	}
 
-	rets = buf->size;
+	rets = len;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-- 
2.14.4

