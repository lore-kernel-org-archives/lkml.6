Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3931C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7DC2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YNRjzrPJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="juQUm9B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7DC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeGISQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:16:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44893 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbeGISQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:16:19 -0400
Received: by mail-yw0-f193.google.com with SMTP id k18-v6so6867317ywm.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tjPTdSDiN5DpCGVwUC7Qw0PEH0Tq1xlKH6CyHYvXmsA=;
        b=YNRjzrPJt4Z4KlIG3u+fr1KTNmUfktwJ7gdo5Ex98mbmeweiZEp8gWkLQNUSx20nZN
         za7r2YZsyyOe6tA/G6XdUuaykq8ti8w2TxOI6JmbDMxzrxlL8aNFihMDjwVInca+Tb7Z
         m6+M9UEfV1FDtHrm3oPQROJ1GIEU3T0ZPCwyefWypGK4qOV0tDiYqD2osFNt7yM6A/YU
         kQd0A5rZTJCduHCwBAEkW7gPHx9AIEmHrjfgZX/BMzk5DnAnMKPpmm1CrUvfvsggV/jc
         eQ/zT5eGptS7ADRi/t/RLerDISZzHCQ8gIEocLc0NQ0qXWMVB4qfF8dJp/GJtIIjpd0/
         J7fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tjPTdSDiN5DpCGVwUC7Qw0PEH0Tq1xlKH6CyHYvXmsA=;
        b=juQUm9B0sR1jfZqnfcyMNg4W+a1kSfseGMSgkuuQ7V+Tou1tniLHyhlRYcAEP3bfdH
         x7xzABMgSXQV0BMTt50nKVnstZLTQznaPxWzoUEmmsT/vlcTobGXy0UX4IgMh8AZne3l
         ElLdHMPNxjFgc/o0XuOOwT/8EfUFw4y9tho+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tjPTdSDiN5DpCGVwUC7Qw0PEH0Tq1xlKH6CyHYvXmsA=;
        b=UcFo8PN/sWenHJlUr0hEdfmKMZt5g6Zcqjz3nh3nMlNTvQ7SIAqQFOZgIonKka4SY2
         HQsK2m0uW+BCVMdDvsQry7FKpJJ8r5kSOpugVpFmDbWCzZHKfTbQC9YFmZZbPcc+MBHe
         sFJu8pm0NiWBcF+QxawGKocre6z5gLagxbBD8y6NmplTh7lOe8uUiky/sTg/Msroyosj
         n+B4FUQlM9laADbA2gZghkXZYJRuunmZ9oT+bFfMHzf3W1hVkW0Rjd0SoRJxb3zmG4Ns
         ku0xrkV73u8IFY5FClvVKHlVk10XczcU3myiBf34Osi6EvckZMjB0qUH+n53wotoQlq9
         w8oA==
X-Gm-Message-State: APt69E2L6ABHxUOBzHgLJsYDMb1x1am/qMJwJ5W3IaeHTcctCfbLQ+vs
        NTZa+JZw+PcgfMZF+WErgKtdGwIkuFkSiYH1LD8AIw==
X-Google-Smtp-Source: AAOMgpdrwm3z0PgxpsKb5euo3wzS1iCX/3TKlUpjCJ4si0o+kMiO1EmZjUvuSxzdktiPKIgDxhu7J9V7Jn6HC13jdbI=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr10149544ywn.88.1531160178263;
 Mon, 09 Jul 2018 11:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 11:16:17 -0700 (PDT)
In-Reply-To: <87601ryb8a.fsf@notabene.neil.brown.name>
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name>
 <874lintqa6.fsf@notabene.neil.brown.name> <87y3fcegnn.fsf@notabene.neil.brown.name>
 <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com>
 <878t6nybj7.fsf@notabene.neil.brown.name> <87601ryb8a.fsf@notabene.neil.brown.name>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 11:16:17 -0700
X-Google-Sender-Auth: j0f2Z5NR6r4A7IXxLHk0vtkRFZs
Message-ID: <CAGXu5j+F3zUZ6+8cKuurq2fV8L5Piy5dvYrYXeFVG0kVmpZMRw@mail.gmail.com>
Subject: Re: [PATCH mm] VFS: seq_file: ensure ->from is valid.
To:     NeilBrown <neilb@suse.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 8:29 PM, NeilBrown <neilb@suse.com> wrote:
>
> Previous patch ("VFS: simplify seq_file iteration code and interface")
> removed code to set ->from to zero when ->count is zero, as ->from is
> dead at that time.  However it didn't ensure ->from was set properly
> whenever ->count becomes non-zero.
> This can only happen when ->show() is called.  Of the three places it
> is called one already has ->from set to zero.  The other two are
> fixed by setting from to zero after fully flushing the buffer (at which
> point ->count will also be zero).
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: NeilBrown <neilb@suse.com>

I *think* this solves this report, which looks very much like Jann's reproducer:

https://syzkaller.appspot.com/bug?extid=4b712dce5cbce6700f27

-Kees

-- 
Kees Cook
Pixel Security
