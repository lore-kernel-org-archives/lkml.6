Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28952C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC836218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499150;
	bh=2HRHOGVX+8DkSDQn5tPZIWWN6TTaRK/2Htpo5gysnOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eqESsuQSTA/tdZE62WDRupPN2ewrojGDmmI7NHK2MQaip4jFz8fTFVfSdC/91BooK
	 JPk1eYTtdyCDfqUGQLapbBO6D4EW3fT5hpkFGlCLyDno9L+sxDB1NaU680s70t19gk
	 +SIMm13MPK/wkKxLWtJE/vHSBiOGju2SnJHaBFqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392071AbfBROM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392055AbfBROMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41AD021901;
        Mon, 18 Feb 2019 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499144;
        bh=2HRHOGVX+8DkSDQn5tPZIWWN6TTaRK/2Htpo5gysnOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8hrzIsn2/RcAhoqqn8dSrH1mGO5oR/gpOtxazgkYMM4atKPA5YCihY8VEfCUKPX8
         SCEZiBellsxm2rw9wVx6rdGOKHrU+YSLDrctXLElLFgny9jxVze6IvhV3flwvGmZKP
         r4xlln8RW1pgxQRGAn5JPLYjccbJffDKwRFieKdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 091/108] Revert "exec: load_script: dont blindly truncate shebang string"
Date:   Mon, 18 Feb 2019 14:44:27 +0100
Message-Id: <20190218133523.791288493@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit cb5b020a8d38f77209d0472a0fea755299a8ec78 upstream.

This reverts commit 8099b047ecc431518b9bb6bdbba3549bbecdc343.

It turns out that people do actually depend on the shebang string being
truncated, and on the fact that an interpreter (like perl) will often
just re-interpret it entirely to get the full argument list.

Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/binfmt_script.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -33,14 +33,10 @@ static int load_script(struct linux_binp
 	fput(bprm->file);
 	bprm->file = NULL;
 
-	for (cp = bprm->buf+2;; cp++) {
-		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
-			return -ENOEXEC;
-		if (!*cp || (*cp == '\n'))
-			break;
-	}
+	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
+	if ((cp = strchr(bprm->buf, '\n')) == NULL)
+		cp = bprm->buf+BINPRM_BUF_SIZE-1;
 	*cp = '\0';
-
 	while (cp > bprm->buf) {
 		cp--;
 		if ((*cp == ' ') || (*cp == '\t'))


