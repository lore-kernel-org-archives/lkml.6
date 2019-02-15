Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD92192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222584;
	bh=JGtLg0h0yIcErFEiRPwuIySlqGClg1xJ8/uXvoF7FoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=om/odXLdHFYV+YrOTOokrCMay3K6dkwb7Yp+Zgt1pQQEPabF1U2czNDazKpxmpjqD
	 iLJgjR9lxWxKW1sqpu9FqimjRiznvAO76mqxt1YmOgaQKW9094VkpMxonsrRQgp9bc
	 gpNeMNiEDH2VVilEyakDER4YDRix82Zq+b+0oB8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404604AbfBOJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfBOJWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:22:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4898521917;
        Fri, 15 Feb 2019 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222569;
        bh=JGtLg0h0yIcErFEiRPwuIySlqGClg1xJ8/uXvoF7FoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5Kvg+lpQZRCifePK2+WO+nGyXsvxxnYKyfibs8dINDCfkdkpIx6jwj0iMIONVHRh
         7IdZWJxFagE5TKeisV7W6Y2+q67vmwnGxfjn4+OW9C2s0PYVQhkeUVOAbbozfpUUxm
         h54Z8FDhc4nEK30XwbmOw40orBM0sLDxqz9Q0asA=
Date:   Fri, 15 Feb 2019 10:22:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.9.158
Message-ID: <20190215092216.GB961@kroah.com>
References: <20190215092210.GA961@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215092210.GA961@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4eb7a17e18f1..2b8434aaeece 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 157
+SUBLEVEL = 158
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 634bdbb23851..afdf4e3cafc2 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -43,14 +43,10 @@ static int load_script(struct linux_binprm *bprm)
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
