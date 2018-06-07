Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EHw+FOFHGVuIQQAAmS7hNA
	; Thu, 07 Jun 2018 14:59:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D41F6608BF; Thu,  7 Jun 2018 14:59:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6912B606DD;
	Thu,  7 Jun 2018 14:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6912B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935600AbeFGO7B (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41235 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935471AbeFGO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:57 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbs-0005Zm-N7; Thu, 07 Jun 2018 15:09:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pb-Hl; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Zhouyi Zhou" <zhouzhouyi@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.76482324@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 104/410] ext4: save error to disk in __ext4_grp_locked_error()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

commit 06f29cc81f0350261f59643a505010531130eea0 upstream.

In the function __ext4_grp_locked_error(), __save_error_info()
is called to save error info in super block block, but does not sync
that information to disk to info the subsequence fsck after reboot.

This patch writes the error information to disk.  After this patch,
I think there is no obvious EXT4 error handle branches which leads to
"Remounting filesystem read-only" will leave the disk partition miss
the subsequence fsck.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -678,6 +678,7 @@ __acquires(bitlock)
 	}
 
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
