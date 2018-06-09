Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GhQAObwaG1sGXgAAmS7hNA
	; Sat, 09 Jun 2018 00:09:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D8D436089E; Sat,  9 Jun 2018 00:09:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68C81602FC;
	Sat,  9 Jun 2018 00:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68C81602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeFIAJb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:09:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60570 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753094AbeFIAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:08:27 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQd-00043n-2R; Fri, 08 Jun 2018 18:08:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQb-0003cn-HY; Fri, 08 Jun 2018 18:08:21 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:11 -0600
Message-Id: <20180609000819.13883-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/8] NTB: ntb_tool: reading the link file should not end in a NULL byte
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running ntb_test this warning is issued:

./ntb_test.sh: line 200: warning: command substitution: ignored null
byte in input

This is caused by the kernel returning one more byte than is necessary
when reading the link file.

Reduce the number of bytes read back to 2 as it was before the
commit that regressed this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_tool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0ffbd19..ec5cf095cdb9 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -504,7 +504,7 @@ static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
 	buf[1] = '\n';
 	buf[2] = '\0';
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, 3);
+	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
 }
 
 static TOOL_FOPS_RDWR(tool_peer_link_fops,
@@ -1690,4 +1690,3 @@ static void __exit tool_exit(void)
 	debugfs_remove_recursive(tool_dbgfs_topdir);
 }
 module_exit(tool_exit);
-
-- 
2.11.0
