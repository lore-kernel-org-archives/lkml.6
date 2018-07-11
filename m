Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83096C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2F208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1HueN9Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A2F208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeGKBf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbeGKBf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:35:26 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFB420C0B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 01:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531272818;
        bh=+au7OntvqVVuVHhw5ec4CQ5+HFIy9XBFAh1TdysroFU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1HueN9LrIVfD16HH+HWWhc4pX9d5QnG7A+nFud98ZVK53uwabuS7SsTH/jTWvULgO
         L32gVvotuwQhANVc6OUkrplJXNleoAg/J0gtsk2OnHSp6Dc7YxNSFJnPPpRmAmKRqC
         Ipl0QXBCYu5AEe+8/B2uS7BwPAP5rqr6HrPNeZOk=
Received: by mail-wm0-f41.google.com with SMTP id 69-v6so790556wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 18:33:38 -0700 (PDT)
X-Gm-Message-State: APt69E0dSDexqmOFuX+51KUhiWvmSexPDeVZHbJYO1Pq9BoE+dpktRwY
        lKa5IZuuKGT3xSXJWGOyct7e8YnEa10mQ5K66sYHsQ==
X-Google-Smtp-Source: AAOMgpcYMTBeZogwqxRLXRghHWZhPighcu3qy2eYznDh/BZlIWd6EzYR4LLu4UwufsB2qvSkPEeKadAdmnuxyq5Aj+g=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr16964990wma.21.1531272816921;
 Tue, 10 Jul 2018 18:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 18:33:16
 -0700 (PDT)
In-Reply-To: <20180711011520.GL30522@ZenIV.linux.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com>
 <20180711011520.GL30522@ZenIV.linux.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Jul 2018 18:33:16 -0700
X-Gmail-Original-Message-ID: <CALCETrXWZJfBq-HnQ0vnGUBsDW75d4XFp1aQfTSqrFobQtFfbQ@mail.gmail.com>
Message-ID: <CALCETrXWZJfBq-HnQ0vnGUBsDW75d4XFp1aQfTSqrFobQtFfbQ@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 6:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jul 10, 2018 at 06:05:49PM -0700, Linus Torvalds wrote:
>> Yeah, Andy is right that we should *not* make "write()" have side effect=
s.
>>
>> Use it to queue things by all means, but not "do" things. Not unless
>> there's a very sane security model.
>>
>> On Tue, Jul 10, 2018 at 4:59 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>> >
>> > I think the right solution is one of:
>> >
>> > (a) Pass a netlink-formatted blob to fsopen() and do the whole thing i=
n one syscall. I don=E2=80=99t mean using netlink sockets =E2=80=94 just th=
e nlattr format.  Or you could use a different format. The part that matter=
s is using just one syscall to do the whole thing.
>>
>> Please no. Not another nasty marshalling thing.
>>
>> > (b) Keep the current structure but use a new syscall instead of write(=
).
>> >
>> > (c) Keep using write() but literally just buffer the data. Then have a=
 new syscall to commit it.  In other words, replace =E2=80=9Cx=E2=80=9D wit=
h a syscall and call all the fs_context_operations helpers in that context =
instead of from write().
>>
>> But yeah, b-or-c sounds fine.
>
> Umm...  How about "use credentials of opener for everything"?

If you want to audit every single filesystem for any code that uses
credentials for anything and add all the right kernel APIs and make
sure the filesystem uses them and somehow keep screwups from getting
added down the line, then okay I guess.  As far as I know, we don't
even *have* an API for "open this device node using this struct cred
*".

I kind of want to add a hack to set some poison bit in current->cred
in sys_write() and clear it on the way out.  Sigh.

--Andy
