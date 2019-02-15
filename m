Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB611C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BA4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222705;
	bh=zPPkXhFcv76wL+MvTlI11gLje2x6+IQk2RrbWVVeo7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M0YLCFKhEnBBJvpGykNapdK8YgoxHEaXVToZezpqAtCsuamDC2fvtp7wbk0uASIgh
	 WU/d4SdVhZAGQ9kGcb0INOrVjaJraDgSn8siTf8kvEeXGtH6ed1dQGt9nhN0qxFz96
	 PXQeIxla1q2A1xHa6uAe1ydABogkCtRcqdZcvu+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392550AbfBOJY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392353AbfBOJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:24:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C27A206B7;
        Fri, 15 Feb 2019 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222691;
        bh=zPPkXhFcv76wL+MvTlI11gLje2x6+IQk2RrbWVVeo7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2N2Ncd2ho0qdFSw8TiqNtxM5VyyIXSwfjaKjIvxXdUBYLJrWusGw2JrnW+u43fIJs
         wT7D1aCItej/ciIKnOhFyq+XDoJU9U+VNm4qYAmO/PRs5dq04rQNy6vLnipbR6N6Pd
         r9saDhAf32cBN1ZxnjQCR9i/KqHw1qqxfgz9TWVE=
Date:   Fri, 15 Feb 2019 10:24:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.19.23
Message-ID: <20190215092415.GB1387@kroah.com>
References: <20190215092410.GA1387@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215092410.GA1387@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 8cfcb01fcd7b..3dcf3f2363c1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 22
+SUBLEVEL = 23
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index d0078cbb718b..7cde3f46ad26 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -42,14 +42,10 @@ static int load_script(struct linux_binprm *bprm)
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
