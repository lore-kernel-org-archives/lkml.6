Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFADC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF352086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJCZNVVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF352086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJLImI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbeJLImH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:42:07 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6DC213A2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539306734;
        bh=1PA4k92Ei1i11cqZCfZvT70a1VCx/S3BpQ5IUfKNjxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nJCZNVVj0afsTPmP53H/IjReGacwUcaFJ2D/jNC2TW7Ju3mdZuYXRP1IOI4C0dq6z
         z2emt3vL5PJAo0LBw50vsfTVNy/tTsGbPV01n8eWm8DIVwy5XbiQejlHxn8SR6w/cH
         F6/K7BSyiYtSkrxLR44dQDubBlW7ZWRexjFrWcaw=
Received: by mail-wr1-f45.google.com with SMTP id e4-v6so11630472wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 18:12:14 -0700 (PDT)
X-Gm-Message-State: ABuFfoiZNkKkmT87uq8voKj2q/dYHGNoIRRCchTeBXMvSnjEGjVc0D7l
        dq+SrOTP7CfckQoqKn5uJEt0oonxG82sS9p8GuA2CA==
X-Google-Smtp-Source: ACcGV623uGwWe6d3Hmj84fleyLogjjFg+U6/9ZFB4bUbg1zjFfo0MONlX/JNo92Jw4Mdv3fPO1NhGFqD+QCDOYSZZy8=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr3454358wra.95.1539306732837;
 Thu, 11 Oct 2018 18:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181009065300.11053-1-cyphar@cyphar.com> <20181009065300.11053-3-cyphar@cyphar.com>
 <CALCETrUZAYw-g+75WAijS+fmRA_DrTahpv156WrxgYuX3KX2xw@mail.gmail.com> <20181010070747.byi2itbi4j42gynq@ryuk>
In-Reply-To: <20181010070747.byi2itbi4j42gynq@ryuk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 18:12:01 -0700
X-Gmail-Original-Message-ID: <CALCETrX_T9CF=UHHiTnb9b06R_uDt4XnZ2sSej-c82ptZ3Lbjw@mail.gmail.com>
Message-ID: <CALCETrX_T9CF=UHHiTnb9b06R_uDt4XnZ2sSej-c82ptZ3Lbjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Oct 10, 2018 at 12:08 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2018-10-09, Andy Lutomirski <luto@kernel.org> wrote:
> > On Mon, Oct 8, 2018 at 11:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
> > >   specific restriction, and it exists because /proc/$pid/fd/...
> > >   "symlinks" allow for access outside nd->root and pose risk to
> > >   container runtimes that don't want to be tricked into accessing a host
> > >   path (but do want to allow no-funny-business symlink resolution).
> >
> > Can you elaborate on the use case?
> >
> > If I'm set up a container namespace and walk it for real (through the
> > outside /proc/PID/root or otherwise starting from an fd that points
> > into that namespace), and I walk through that namespace's /proc, I'm
> > going to see the same thing that the processes in the namespace would
> > see.  So what's the issue?
> >
> > Similarly, if I somehow manage to walk into the outside /proc, then
> > I've pretty much lost regardless of the links.
>
> Well, there's a couple of reasons:
>
> * The original AT_NO_JUMPS patchset similarly disabled "proclinks" but
>   it was sort of all contained within AT_NO_JUMPS. In order to have a
>   precise 1:1 feature mapping we need this in *some* form (and in v1 the
>   only way to get it was to add a separate flag). According to the
>   original O_BENEATH changelog, both you and Al pushed for this to be
>   part of O_BENEATH. :P

:)

Now that you mention it, I *think* my reasoning involved a rather
different use case: sandboxing.  If a task is Capsicum-ified or
seccomp()ed such that it can *only* use O_BENEATH or AT_BENEATH, this
restriction considerably strengthens the resulting security.
