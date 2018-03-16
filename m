Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeCPNYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:24:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCPNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:24:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DF186030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
From: Ritesh Harjani <riteshh@codeaurora.org>
To: jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: stummala@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH-Review] f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read
Date: Fri, 16 Mar 2018 18:53:52 +0530
Message-Id: <1521206633-21378-1-git-send-email-riteshh@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Observed below deadlock with quota enabled on f2fs during low memory situation.
I think during f2fs_quota_enable -> which is doing read_cache_page with __GFP_FS
flag set, due to low memory this is causing shrinker to get invoked
and thus going into a deadlock due to mutex lock in dquota. Commit details
in next patch contains the call stack.

Since I did not had the quota enabled on f2fs configuration, I could not test
this on my setup yet.

Could the community kindly review and let me know if the patch
is correct or not ?


Ritesh Harjani (1):
  f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
