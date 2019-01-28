Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4520663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693222;
	bh=xKk2ajnw615Lc0Vmp02x7t5/cILihl9hycWyoUrHBJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyaGVN8aNT87uitSf/eYBeSg3DPGPAPqyxUyHFV6rgE+rA/9TKCyDTrIn8+okrBn7
	 0GIlyoO+r24guoTxE3Uvgrq9cN/WOwJujM508aG3zqwU1ryfl0NdTE4Lx7Ipf0k27c
	 M5oznFIEVUnsgd2SO1aa9bGNyz7nTP5X+HrFOEaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbfA1Qdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390175AbfA1Q0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B231C20879;
        Mon, 28 Jan 2019 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692782;
        bh=xKk2ajnw615Lc0Vmp02x7t5/cILihl9hycWyoUrHBJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtHc1AbxitRinrAoxX9Rla3CE4lasZwAJnO7gFjR8VbO1PWXi1sokakFpAFYXGYwI
         5kiq14bLGGV6CExwX9QKTqMn34NkAyhFF6oYPb7SeOncyUD5VzMuzhhD63cExIhQpn
         yvG3Ib3QVTifIhNpuakcMtn4OXwfgRsnM5YGQ4t8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 80/80] exec: load_script: don't blindly truncate shebang string
Date:   Mon, 28 Jan 2019 11:24:01 -0500
Message-Id: <20190128162401.58841-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index afdf4e3cafc2..634bdbb23851 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -43,10 +43,14 @@ static int load_script(struct linux_binprm *bprm)
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

