Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A4ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC9921479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r659rqmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC9921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJJCof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeJJCoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:44:34 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF23221479
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539113166;
        bh=zwObxeASxgUn2wmwmnptCg2jXqGRpAdTlCkHTIHfk3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r659rqmY4MWyMInf4QGwx7+21u23GJkEtXzYNJH0WdajOn9r36l9F69GuSgS8Ruzm
         ecNkgz2lLRp44LcwuoYqF3tXL8v7XdM83Klo69M0A/YyPcdHMXY81CtYRHrhGsclsd
         +F2loglkJPeAifSGgDRqT2Xudx7AtAjzxMUjqgnw=
Received: by mail-wm1-f52.google.com with SMTP id a8-v6so3203104wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 12:26:05 -0700 (PDT)
X-Gm-Message-State: ABuFfojZjWcVH09yi28xR5Xuyh7K23DL+7CZFHWI+zmSLIzggKQxcIM/
        2bAbs7+2uuHJjpzdxpRfBjbvaxerAVq8EG+PkWNlMg==
X-Google-Smtp-Source: ACcGV63H0m2zm/ETU8TXJNYTgjKTxIxbavbvzmHSnc/fgKFcavrz/TU81YKXcEQj2ppQVvGJ5SlQNV8vYZizIXni0RQ=
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr3070990wma.82.1539113164148;
 Tue, 09 Oct 2018 12:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181009065300.11053-1-cyphar@cyphar.com> <20181009065300.11053-3-cyphar@cyphar.com>
In-Reply-To: <20181009065300.11053-3-cyphar@cyphar.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Oct 2018 12:25:52 -0700
X-Gmail-Original-Message-ID: <CALCETrUZAYw-g+75WAijS+fmRA_DrTahpv156WrxgYuX3KX2xw@mail.gmail.com>
Message-ID: <CALCETrUZAYw-g+75WAijS+fmRA_DrTahpv156WrxgYuX3KX2xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
>   specific restriction, and it exists because /proc/$pid/fd/...
>   "symlinks" allow for access outside nd->root and pose risk to
>   container runtimes that don't want to be tricked into accessing a host
>   path (but do want to allow no-funny-business symlink resolution).

Can you elaborate on the use case?

If I'm set up a container namespace and walk it for real (through the
outside /proc/PID/root or otherwise starting from an fd that points
into that namespace), and I walk through that namespace's /proc, I'm
going to see the same thing that the processes in the namespace would
see.  So what's the issue?

Similarly, if I somehow manage to walk into the outside /proc, then
I've pretty much lost regardless of the links.

--Andy
