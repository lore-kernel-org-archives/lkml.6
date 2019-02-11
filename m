Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B24C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FE221B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896626;
	bh=GWMwgqbzc4BrsWRYe9EQvtYtLe5CR+Tl6TakHshmz4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DdEshiq+onkoIBeshClq8gBG4MuLJeVUtE8bdm3w07zv/DX847n5WBr7h1lto/gJU
	 5xQWCrkKyOvAslvgU1SI/50CadpnOW03J+1PWqmiiSMIftBUKOmYxVfrSXorny2WMT
	 qH4i0B/tcK9WvMR/kRy+FhKGjD7svWuVy2LccTXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfBKOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388050AbfBKOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A7220844;
        Mon, 11 Feb 2019 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896621;
        bh=GWMwgqbzc4BrsWRYe9EQvtYtLe5CR+Tl6TakHshmz4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saEipXxvSmgH1MyTqXh5DzwJ3C+aI9f5MI64nF2Uh8ezUND7XwD9+b2gO+nng8yQt
         7thiIvUrrWCf7YJxsdMkPr/TYG9NsjKlLQz6zynYj7WysFjnOnNR4WPBdhhbPWDNyu
         lgstytM058af2+s5UWMjoVEXRFVhcbZ1GVMOFh+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 245/313] exec: load_script: dont blindly truncate shebang string
Date:   Mon, 11 Feb 2019 15:18:45 +0100
Message-Id: <20190211141909.749786684@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



