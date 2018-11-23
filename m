Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B84920824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwPXdpST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B84920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632819AbeKXCwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632803AbeKXCwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:52:05 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FB6208A3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542989237;
        bh=QJp/lkBgIyFFh9nuuDPMgSaJkrwqVtsa5gMOqP1UyIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pwPXdpSTk4sFbZm4Pna31BvSQnE5s63+iMlqZije2mUJ3f873WWt+XzzgIIyxsuDi
         e5sF6kbTeFPqZm4HoTSu1sYFDQDaoGf+SArh4A9VcEdYzjUyUppbHJUlywi7NF9akX
         GuTY+haaiG/9j9uf+Bqp9rV+jShLqSXB8iAcwspQ=
Received: by mail-wm1-f47.google.com with SMTP id y139so12294617wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:07:17 -0800 (PST)
X-Gm-Message-State: AGRZ1gLF8ZUOn+XZwDoP4ItqPu4cYtRdxD49FikyZOPKzzy31YNVEilt
        +6qXfg8ekjlx9UZQCk4QiIKu1mezvBrDOzq40D0aYA==
X-Google-Smtp-Source: AJdET5eRtBIB3wgTUKzJ+vNKLGTQ7NUHVuGz09CbEXrxIU6l25vMl/Gqm9mS8Nn0bbctlMg8szNO+n+Lmm7v5kFzBy4=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr13729808wmh.83.1542989235720;
 Fri, 23 Nov 2018 08:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20181112142654.341-1-cyphar@cyphar.com> <20181112142654.341-3-cyphar@cyphar.com>
 <1ce83cdf6e3168350b69f98f08aaa202bbaa682d.camel@bitron.ch>
In-Reply-To: <1ce83cdf6e3168350b69f98f08aaa202bbaa682d.camel@bitron.ch>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 23 Nov 2018 08:07:03 -0800
X-Gmail-Original-Message-ID: <CALCETrURCXjNMBR6DjujVc6HHHS=CbET81kHS+odur+Bm-z7Tg@mail.gmail.com>
Message-ID: <CALCETrURCXjNMBR6DjujVc6HHHS=CbET81kHS+odur+Bm-z7Tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] namei: O_BENEATH-style path resolution flags
To:     j@bitron.ch
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        David Drysdale <drysdale@google.com>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 23, 2018, at 5:10 AM, J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> Hi Aleksa,
>
>> On Tue, 2018-11-13 at 01:26 +1100, Aleksa Sarai wrote:
>> * O_BENEATH: Disallow "escapes" from the starting point of the
>>  filesystem tree during resolution (you must stay "beneath" the
>>  starting point at all times). Currently this is done by disallowing
>>  ".." and absolute paths (either in the given path or found during
>>  symlink resolution) entirely, as well as all "magic link" jumping.
>
> With open_tree(2) and OPEN_TREE_CLONE, will O_BENEATH still be
> necessary?

This discussion reminds me of something I=E2=80=99m uncomfortable with in t=
he
current patches: currently, most of the O_ flags determine some
property of the returned opened file.  The new O_ flags you're adding
don't -- instead, they affect the lookup of the file.  So O_BENEATH
doesn't return a descriptor that can only be used to loop up files
beneath it -- it just controls whether open(2) succeeds or fails.  It
might be nice for the naming of the flags to reflect this.  I also
don't love that we have some magic AT_ flags that work with some
syscalls and some magic O_ flags that work with others.

In this regard, I liked the AT_ naming better.  Although I don't love
adding AT_ flags because the restrict our ability to usefully use the
high bits of the fd in the future.

--Andy
