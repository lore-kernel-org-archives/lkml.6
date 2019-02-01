Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9E9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CDF2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJnwSD8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfBAIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:31:11 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44404 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfBAIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:31:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so3665058vsp.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgjcUiq7Q/kVIYOW2+NCgq5Wl/YZD+sGBjyn3lsn6I8=;
        b=BJnwSD8aKy+luMs2zp25mOU+7mcBT2QjQnl7SFmMrMBGNoTV7EInDNgiVxq1ohGWQz
         BtftcwGBGgo7Dt07ia9+S8MJj9U64qNTMiSTWsuQlFHU/e7ftAaIvSR5zlMkExmvRj97
         yGP9yFyEkb1QeSfr2nTvKT+q9Ujf5Il+ewoq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgjcUiq7Q/kVIYOW2+NCgq5Wl/YZD+sGBjyn3lsn6I8=;
        b=C3BZgKUDJy41rZUkp2aQiZSkqUVicIAkFgKQzR+6pyqmJHPsGofX5aOyMgAf7McNWA
         gX0zCdkR7GTE8RsfSro6ppZ37bcuBttK3DN9DrpM8stqsjlncoeOoSmIJoY79UrrhJoA
         mR7SlxyePcviufiMrJJvXW28dsPuR4YbS5SsprXfqPro68Bvmx9TOsgyNrplGCCGcf33
         xBVvvbedX93NUruNyWGGSCdQQAa4JlzN/xG/J1VqlVE9gJfhDDmN9Mtbl8THj/m3KhJK
         sQmXL+cXe2yN5OKs54xg8sjKDdJMc6p6QM8cUZSlidnxBx+kaWl4Egqunt3MjGAt5ZES
         1UHA==
X-Gm-Message-State: AJcUukfhoanoK1giNVsuxH5waeWi50fDp1HpMamheiGRxLlsXJqDqi4u
        4e7+2KOpTouK3zQA1kGJa4qkN+xB9bQ=
X-Google-Smtp-Source: ALg8bN7s0Mtn61KBM7p64EqPnH7chr4/Yd/asLdnng4c9M0Cr/+OSEEUya9uMbHlbuoBev4WPHXbDQ==
X-Received: by 2002:a67:f696:: with SMTP id n22mr17265547vso.175.1549009868189;
        Fri, 01 Feb 2019 00:31:08 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id l197sm8612412vke.18.2019.02.01.00.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 00:31:07 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id c12so1953134uas.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:31:07 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr16133921uac.122.1549009866601;
 Fri, 01 Feb 2019 00:31:06 -0800 (PST)
MIME-Version: 1.0
References: <000000000000784c000580b16bdd@google.com>
In-Reply-To: <000000000000784c000580b16bdd@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 1 Feb 2019 21:30:54 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+TTQPGZC3QR1MzX16LT9rypAzMjm15DU39Kfz+jx-p7A@mail.gmail.com>
Message-ID: <CAGXu5j+TTQPGZC3QR1MzX16LT9rypAzMjm15DU39Kfz+jx-p7A@mail.gmail.com>
Subject: Re: general protection fault in debugfs_create_files
To:     syzbot <syzbot+a9d09761be47db706560@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 7:53 AM syzbot
<syzbot+a9d09761be47db706560@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=172ed528c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9d09761be47db706560
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149209ef400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e00c2f400000

#syz fix: blk-mq: protect debugfs_create_files() from failures

-- 
Kees Cook
