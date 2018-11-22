Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB411C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677FB20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MIkl0Rat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677FB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbeKVT7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:59:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbeKVT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:59:46 -0500
Received: by mail-io1-f67.google.com with SMTP id n9so6134152ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 01:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXnqHa/rXlk/USgNZGU7Vkeor6TAXn/UCV2g1aq79j8=;
        b=MIkl0Rat01cnIvTtP6iLXLIAHP2C2cErDocaEiTlFGkgeF637k0X6xBnHNyKAPO0AL
         DG/rLHAOY8ordAzxg4dIP42cFNm+pjyxXnsUoXMLe6oEhesOtwJmhyYInCc/1lIqayjd
         cNEPxe8coXlwStZN5wK3i1BGu5sMch63F6QAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXnqHa/rXlk/USgNZGU7Vkeor6TAXn/UCV2g1aq79j8=;
        b=uQ0obmy+dg9NQ7Y3BOypWNMkYfthZz7FH1+JXyfxpJ2pfGfWjQIz8H127/X4XVj1ky
         2CdC0FBHUc0nhkjJCLQGG9gFfQxuNlzKaJfCsOP7X0iNMDWX2Ps5UMEUXCJlp2CGijx8
         2AQlqSQ+6uVaf/sd/lnR6JHz/1ftWE4+5t9Q7EW38+bB0UfMgW5v1OIOw7xrFUmdLS4v
         zKoRRSobdL9WWn3+6PRkNxofel2aFu7IESXD9RbSOLbWafU9ET5cAbd3HSx8PHzfiloR
         g5kOpD3zyZT1zhBBfdmZD0U9sbYP9v0Wkbv0Sk38o1ZayTxPxp6GH2n4tnWOJiIEQ1F2
         kSAg==
X-Gm-Message-State: AA+aEWbGFcvjBTkNqJMyKCIM75cf+Hyrbu76ybTH6859LkS1hj9dSKNc
        YikLZp1mzLjdL12U8+E1Z2d97HS3xuBblj1tQDWwCg==
X-Google-Smtp-Source: AFSGD/VEgEiK1r8rnDiU8UYPeemUSB48tVUWTcXFj3yt38j0mtIV/lUZYY2zu6mL+6lrfyOlOwNa4lEzAss7FCPaMTo=
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr6412154iok.144.1542878468713;
 Thu, 22 Nov 2018 01:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20181121231827.GA9573@myunghoj-Precision-5530>
In-Reply-To: <20181121231827.GA9573@myunghoj-Precision-5530>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 22 Nov 2018 10:20:56 +0100
Message-ID: <CAJfpegv8sfny0FG=DAb4AU3ecBYDG_WqVTVBCOt9HTVeQFNeaQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add bad inode check in fuse_destroy_inode()
To:     mhjungk@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:18 AM Myungho Jung <mhjungk@gmail.com> wrote:
>
> make_bad_inode() sets inode->i_mode to S_IFREG if I/O error is detected
> in fuse_do_getattr()/fuse_do_setattr(). If the inode is not a regular
> file, write_files and queued_writes in fuse_inode are not initialized
> and have NULL or invalid pointers written by other members in a union.
> So, list_empty() returns false in fuse_destroy_inode(). Add
> is_bad_inode() to check if make_bad_inode() was called.
>
> Reported-by: syzbot+b9c89b84423073226299@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>

Thanks, applied.

Miklos
