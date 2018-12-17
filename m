Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C821473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeLQWFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:05:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40033 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:05:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so8319448qki.7;
        Mon, 17 Dec 2018 14:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoEFmcIp57BMTkHKTfBNzPfhkMo8Ej0Qg4qsoSumWLs=;
        b=rCx0Fup0GW1k7F80pHEpe3Z15DVro7F798OcKQLU2vlPlk1ABfZvNYWTH8Mdw6v7uf
         RjWSUcf2PXlt4vi5GiniKguO/MWerN17ybAla+wt9Uij/MSVEu0Ap1NdVkRCD0mnkbMN
         OG/QdUUZxOzryRrQbjgGqJRCa5NCw8BInqtObcwY8wG7n7MSzpjnybrg5Sbvv5zmmcyV
         S0K63FXHkYcrdGIKNxjsfpDMq8jb7MvTXKBlrTK8vt9w1O3QHrbc+hBYJZI1UmS3Ulxe
         qpelL7hq/Uu8vrkF9HtRZR4F+0Qsl9cvS8lFdE0qmIg8XAvanWhDvTOX9EvShd5bZ7ii
         fPxg==
X-Gm-Message-State: AA+aEWYmy5LeQmTFHtPCL754mObcnan6/zPb/PN4cULZFQpNUGS8A2jP
        QRnHn93wh3rwGRKLYzYnweUhJdC/hzjIKQ2pqYrPrpnuMF4=
X-Google-Smtp-Source: AFSGD/WuDTQpTE8cgO5wJj7nB9vOa+HV2WI4BYESZ61MWE2GfIux+iVqK++qJxVOMHDQA5UPe7rEOkFnSqlqEoMENqQ=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr13587024qkf.330.1545084323693;
 Mon, 17 Dec 2018 14:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20181217130646.GB3560@osiris> <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
In-Reply-To: <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Dec 2018 23:05:06 +0100
Message-ID: <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com>
Subject: Re: [-next] strace tests fail because of "y2038: socket: Add compat_sys_recvmmsg_time64"
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Dec 17, 2018 at 2:06 PM Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> >
> > Hi Arnd,
> >
> > in linux-next as of today 16 strace self tests fail on s390. I could
> > bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").
> >
> > The following tests fail:
>
> Hi Heiko,
>
> Thanks for the report and sorry I broke things. I'll have a closer look
> tomorrow if I don't find it right away. I suppose the regression was in
> native system calls, not the compat syscalls with 31-bit user space,
> right?

I found a bug in my patch by inspection. Can you try if the patch
below makes it all work (apologies for the garbled whitespace),
I'm considering a rewrite of that function now (to split it into two
again), but want to make sure there isn't another problem in my
original patch.

     Arnd

----
diff --git a/net/socket.c b/net/socket.c
index 3bb2ee083f97..7f9f225d0b6c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2486,12 +2486,12 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
         return -EFAULT;

     if (!timeout && !timeout32)
-        do_recvmmsg(fd, mmsg, vlen, flags, NULL);
+        return do_recvmmsg(fd, mmsg, vlen, flags, NULL);

     datagrams = do_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);

-    if (!datagrams)
-        return 0;
+    if (datagrams <= 0)
+        return datagrams;

     if (timeout && put_timespec64(&timeout_sys, timeout))
         datagrams = -EFAULT;
