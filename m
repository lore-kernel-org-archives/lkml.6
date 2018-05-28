Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938336AbeE1LkG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937621AbeE1LMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 181/272] f2fs: fix to clear CP_TRIMMED_FLAG
Date: Mon, 28 May 2018 12:03:34 +0200
Message-Id: <20180528100255.903245056@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit cd36d7a17f9da68be9aa67185ba3ad7969934a19 ]

Once CP_TRIMMED_FLAG is set, after a reboot, we will never issue discard
before LBA becomes invalid again, fix it by clearing the flag in
checkpoint without CP_TRIMMED reason.

Fixes: 1f43e2ad7bff ("f2fs: introduce CP_TRIMMED_FLAG to avoid unneeded discard")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1136,6 +1136,8 @@ static void update_ckpt_flags(struct f2f
 
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
 
 	if (cpc->reason & CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
