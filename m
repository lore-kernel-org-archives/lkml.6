Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC772C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340020663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692387;
	bh=INfw3x0PEw8wjZIATFrl5hYnvIK3kjLWHAWkKeZkh2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJ5M6MHSd2BQNR+VGul22xUFzkCmNyEYipPTc8Uu6kVjkw6ftbYD7j7aLZL9nXAAI
	 /6N4Wa5kPxbbtxaizLXxNiMqPZTYAq9cgoD1RWsxzQxXEdqBj1axr0j0N4ohpnWFuh
	 rm6DTo47WIp2w1oMDhnVd8+M6X8UVx35Rlur+9wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfA1QTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388650AbfA1QTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B5F2171F;
        Mon, 28 Jan 2019 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692382;
        bh=INfw3x0PEw8wjZIATFrl5hYnvIK3kjLWHAWkKeZkh2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSpqWJ128+Vhzc4WTX1UFWB/M9Pz1X3qhOEQbJsh+34IL2V1V/BxiXWEzk4M6ftnV
         sgHHNz9f9/xnPCs4ESeAgDOmEV/gX0QmV9uQazLuoyNOCjaBRto5EElKcdlgBG/U5u
         i4m9gw5wOUoZ8BHPFYBjvghqjXQkxckrWhjAM0Mk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 169/170] exec: load_script: don't blindly truncate shebang string
Date:   Mon, 28 Jan 2019 11:11:59 -0500
Message-Id: <20190128161200.55107-169-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 8099b047ecc431518b9bb6bdbba3549bbecdc343 ]

load_script() simply truncates bprm->buf and this is very wrong if the
length of shebang string exceeds BINPRM_BUF_SIZE-2.  This can silently
truncate i_arg or (worse) we can execute the wrong binary if buf[2:126]
happens to be the valid executable path.

Change load_script() to return ENOEXEC if it can't find '\n' or zero in
bprm->buf.  Note that '\0' can come from either
prepare_binprm()->memset() or from kernel_read(), we do not care.

Link: http://lkml.kernel.org/r/20181112160931.GA28463@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Ben Woodard <woodard@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..d0078cbb718b 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -42,10 +42,14 @@ static int load_script(struct linux_binprm *bprm)
 	fput(bprm->file);
 	bprm->file = NULL;
 
-	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-	if ((cp = strchr(bprm->buf, '\n')) == NULL)
-		cp = bprm->buf+BINPRM_BUF_SIZE-1;
+	for (cp = bprm->buf+2;; cp++) {
+		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
+			return -ENOEXEC;
+		if (!*cp || (*cp == '\n'))
+			break;
+	}
 	*cp = '\0';
+
 	while (cp > bprm->buf) {
 		cp--;
 		if ((*cp == ' ') || (*cp == '\t'))
-- 
2.19.1

