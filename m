Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0816C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876BD20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfARQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:24:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfARQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:24:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so15782167qtt.4;
        Fri, 18 Jan 2019 08:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zek6jJKDDH7kV0HiEfV9PpOOQrrlkfQW2PJnAw8E3/U=;
        b=e0IZ0v9sdY5sYO8HV9kQ52Rl8sXeQr7e0ka7Ovu+eAz/CboTJ0JXtJWIqb7W440JW2
         xAhsxEsKeIb3dib0WXt6rqGLzac3bwdoZkLFFSWXCdExT8RQOYCF3l4ebT7X97SWMFK5
         8u6lXZVvpVCJB7CJ/GyHO9mVm0zs1b5skgcR2xoxeEemCt/ZqsYxkbvmHCqZQNNmbSyy
         TxSQs9toHfsJ+mh9cQwSMuWt4+I5Lq0DqPKuI/qkHEE7Xnzqj8RoqH/3XVzRT7eQtLZM
         sVnS0WsZRMwpjSQLOVM9c/ssiOJmWeEBKnyHcVJwD8/qT2inDM1HEe/aSW7qJTwSdKZu
         jWSA==
X-Gm-Message-State: AJcUukd93wsj5IWkAqptJUYMFCB70cKgSIltzNwXjha6ZE67fdGNCqt4
        NJ2O7wxnVE4VMB5tqJ4/cFUvCN12PzxxzXBthjqcAA==
X-Google-Smtp-Source: ALg8bN44o4dW37vsZoE+Dgoiswnj+GMIo9WC5WC0AzaGRdomAkk95Ytxf34LL5SyJAQka8uL7ZrN/owks/j3qPG2nMY=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr16805104qta.152.1547828638627;
 Fri, 18 Jan 2019 08:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118161440.220134-1-jannh@google.com>
In-Reply-To: <20190118161440.220134-1-jannh@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 17:23:42 +0100
Message-ID: <CAK8P3a1o2EbMD6LnD78MFSD_VN5W64MACv-28P9ojPJT4k7i5Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:15 PM Jann Horn <jannh@google.com> wrote:
>
> Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> however, so far, definitions of EFSCORRUPTED were in filesystem-private
> headers.
>
> I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> Dave Chinner says that I should instead hoist the definitions of
> EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
>
> This patch is marked for stable backport because it is a prerequisite for
> the following patch.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/ext2/ext2.h                   | 1 -
>  fs/ext4/ext4.h                   | 1 -
>  fs/xfs/xfs_linux.h               | 1 -
>  include/linux/jbd2.h             | 1 -
>  include/uapi/asm-generic/errno.h | 1 +
>  5 files changed, 1 insertion(+), 4 deletions(-)


For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
