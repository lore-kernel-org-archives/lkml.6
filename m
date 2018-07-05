Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA9120883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ5nqc7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA9120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeGEUoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:44:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42225 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeGEUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:44:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id u202-v6so8029814lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o07kadG9xphJ8hLhznqUES4JElpzXAxjeqhQTz0hIzg=;
        b=KJ5nqc7KUZQflSZuLp4z3yyfyUktYRrZuZtEJCz6/rdFRkZNatVj9/VkwC6rk6r8vg
         fb0oWK/RNUpVNfahDQWxl/aqF93XEzJ0wq+NEcWsUwVEaDiGBHLaP91dNCipjhUgJI/o
         ZstjnI0348YtnLY9MrMNNVXFgar6MrSbYI8LxQyT8ILgAYIEKjk8MAjiAQ7tvhI6u+2t
         bA/szKFn8QqZB5MHzL2GNr/jxLQ29VeE4gqTOgDZ3zfuk448xMP4jzZiWCelN5Ae+Twp
         IzpUC3mKfsxVPJ0K6LRpsU+tKiZujquVrQ1wKUYf+dwV1dIe8w/HpihGB9VLMb6i8wsC
         RHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o07kadG9xphJ8hLhznqUES4JElpzXAxjeqhQTz0hIzg=;
        b=ahLvlIzmsaxpsvCxcD32Gxp2jLU2y5OSDBKaS/0QcDlil4WK5gtz+2u9B9xqc6NWs4
         7mU9hozmH1xCNcm3I92wlmfzwsm/j+hvKsCBR3dp7OsMjYr0/IHFui2s2ktRasVnOgAz
         G6Tx+bsQJmjfG8QT4gPIT6em5ssKrmnfwvKHsFqK13VzTGFFP1hStipGI0VO8u5eG8E6
         NS0YrtozP+yDA3C0lG+vCdFlCkdTJXyG/jUbpS4BbhE6ODGMbTykBG48Xtulo2wChulZ
         aNGmubtNT0Uy8OWpc1ivfCe6uAdRP6LK0Ozzyi0MJSf9KepbpM90ggWcXDhRWx+kAPI8
         FI1A==
X-Gm-Message-State: APt69E1qHxA2qaJcz8fC+PyBdngTKPMidpX6hrE2IKuVJhh5mMHH1Qwh
        t1ORWeTzsCcOXRO4R+8TXhs9ifqpGuINvieJgB8=
X-Google-Smtp-Source: AAOMgpdPZ5c8r9fhj66ofYFW7zw/r8IVPfbt8KHBXjg3bEKXiHoqKCiqY1/i+l7zcZFpWtSr27vtaSfIIHXtwxiUTwE=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr5222749lff.11.1530823450670;
 Thu, 05 Jul 2018 13:44:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 13:44:09 -0700 (PDT)
In-Reply-To: <20180626172909.41453-2-keescook@chromium.org>
References: <20180626172909.41453-1-keescook@chromium.org> <20180626172909.41453-2-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Jul 2018 22:44:09 +0200
X-Google-Sender-Auth: 4S3-fs4mPQSCXgr3uuSKK-REv8g
Message-ID: <CAK8P3a1r41cbLmWrd3fLfYfX4NRekDSS2P1N7xV-zYQ-2P0x0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] NTFS: aops: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:29 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum size needed on the stack and adds a sanity check for
> robustness: index.block_size cannot be larger than PAGE_SIZE nor less
> than NTFS_BLOCK_SIZE.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: linux-ntfs-dev@lists.sourceforge.net
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/ntfs/aops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 3a2e509c77c5..58dadff3e0e0 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -926,7 +926,7 @@ static int ntfs_write_mst_block(struct page *page,
>         ntfs_volume *vol = ni->vol;
>         u8 *kaddr;
>         unsigned int rec_size = ni->itype.index.block_size;
> -       ntfs_inode *locked_nis[PAGE_SIZE / rec_size];
> +       ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
>         struct buffer_head *bh, *head, *tbh, *rec_start_bh;
>         struct buffer_head *bhs[MAX_BUF_PER_PAGE];
>         runlist_element *rl;

This has uncovered what looks like a preexisting bug on architectures
with large page size, this is what I get with 64K pages on arm64:

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1328:1: error: the frame size of 2432 bytes is larger
than 2048 bytes [-Werror=frame-larger-than=]

Since both ntfs and 64k pages are fairly obscure features, we might
get away with just disabling the combination of the two in Kconfig.

Using dynamic allocation might be tricky here, since I assume this
could be called during writeback in order to free memory, and I can't
immediately see any better fix.

        Arnd
