Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C9520838
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222764;
	bh=rwzun44yCEo1SGqlBUqugRn+8ClwW/7H5HhVXfiumBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ULdwq8T2Lkip5yP8DT+Xft/2XKlBB4pHDNt0TWUw2ygBwBT4IbL2Sp2EVahjmzaBP
	 Ur+FJp0Xy1VSK90qMEjaRYa29Tt//e51UOpc1D0BkdxzVCL51tF+xKjEUe+Uac3Uzs
	 y96croK+2+Xv9QUyhzAbVOIuZWUc72DkySKXc5AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392685AbfBOJZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392338AbfBOJZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:25:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD6021B18;
        Fri, 15 Feb 2019 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222748;
        bh=rwzun44yCEo1SGqlBUqugRn+8ClwW/7H5HhVXfiumBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1hqsq5mSHrl013ONI+Gro93QY8fz2n14w7jmxQFu+fc63x+l3wzNO+5UppzCnT+7
         EyTRBQxjtdgvC94Y9vQ7qwOzSFEOfeJYDN0ju5AhELfdlxLGOlGTzcgn2nbitRE5u9
         dvAPB50LAFK/7IJwEPVroVirkjOqjUBWuGww3tjQ=
Date:   Fri, 15 Feb 2019 10:25:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.20.10
Message-ID: <20190215092504.GB1536@kroah.com>
References: <20190215092459.GA1536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215092459.GA1536@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index c9b831f5e873..6f7a8172de44 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 20
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Shy Crocodile
 
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
