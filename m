Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E0ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5792154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Lqsn9b6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5792154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbeIVBk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:40:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42373 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391350AbeIVBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:40:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so12889981ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+2Nu52suz81zToLayLp0T4UWugCYlbfaQmvkmLxOzc=;
        b=Lqsn9b6vzieyQxYqE/rycU76dE2keg5s1I2RS10Hey4L/DdwmbNHnSqgkQ9Gibv2PN
         pn+HN2WZGjBGLby7GOS8oPi4g5laUkAYtXj7YH3whexUJVoxiaMtwTdxN/K5F+cDNEzj
         XnNL2YWF6f0BJFiBMVlvwW5NVicGA1HMRD9u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+2Nu52suz81zToLayLp0T4UWugCYlbfaQmvkmLxOzc=;
        b=XIejgcb2FnX1ALkJdFAImVw0ZIIciDjTH64VwpBMm5vTjVAsSJOuXmVLzHHLAN+zyc
         sBvT6oUAvo39OiLrKC4+WZvo2aFMFi0KX4E8TNpg8YUmhzJVhu0EngAhjCbqrSIq9Rxz
         rC2t+F8NetUBw4VXQ8xF/q40yRAd28eaPN4ASpiXtiiSw928VMf/uRoxQ9lfNlOeuIEg
         3TbX0o8JmHLHx0oWuQeOZCqP4d03J4HSUtfKSdMjC0kpxy1ad7U7Ihm+qcwd5mMqbo55
         l+FoAL0mpgSQRdFKZE1XJpj9ulyTgoNRSmWQ18W1u2TvxSTZ1hh+ajGkCB2vlD4abBQB
         inaQ==
X-Gm-Message-State: ABuFfoiOMlGeBsmdg7quP7Gd0cSE8OaJ5ilvF/3y91hoOG4qHqHQkLk8
        yiiy4OiEiFnoxV7QVCMZnTySGA==
X-Google-Smtp-Source: ACcGV60wfQTlmoa20ZKcj5peZpD2SelzKHQ0uaisQ9kpEZnGkbQz/E7ZlxWXyl2pVz1iBCz/m9cICQ==
X-Received: by 2002:a2e:9198:: with SMTP id f24-v6mr3262655ljg.64.1537559434458;
        Fri, 21 Sep 2018 12:50:34 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id k4-v6sm5067312ljc.6.2018.09.21.12.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:50:34 -0700 (PDT)
Subject: Re: [PATCH 0/5] VFS: Introduce filesystem information query syscall
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f3646774-ee9e-d5b7-8a11-670012034d59@rasmusvillemoes.dk>
Date:   Fri, 21 Sep 2018 21:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-21 18:37, David Howells wrote:

> 
>  arch/x86/entry/syscalls/syscall_32.tbl |    1 
>  arch/x86/entry/syscalls/syscall_64.tbl |    1 
>  fs/afs/internal.h                      |    1 
>  fs/afs/super.c                         |  168 +++++++++
>  fs/hugetlbfs/inode.c                   |   66 ++++
>  fs/kernfs/mount.c                      |   16 +
>  fs/statfs.c                            |  587 ++++++++++++++++++++++++++++++++
>  include/linux/fs.h                     |    4 
>  include/linux/fsinfo.h                 |   41 ++
>  include/linux/kernfs.h                 |    2 
>  include/linux/syscalls.h               |    4 
>  include/uapi/linux/fsinfo.h            |  303 ++++++++++++++++
>  kernel/cgroup/cgroup-v1.c              |   72 ++++
>  kernel/cgroup/cgroup.c                 |   31 ++
>  samples/vfs/Makefile                   |    6 
>  samples/vfs/test-fs-query.c            |  138 +++++++
>  samples/vfs/test-fsinfo.c              |  589 ++++++++++++++++++++++++++++++++
>  17 files changed, 2028 insertions(+), 2 deletions(-)

Would you consider adding a Kconfig knob to not include all this (and
all the extra tricks that syscall might learn down the road)?

Rasmus
