Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A05C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67C72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SRmBl/C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67C72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbeIXUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:47:29 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53521 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeIXUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:47:28 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so2284023itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/bZt5l0ZZGg7iG+3jPLSvGhO/WjTu84sSszDGnGeW+U=;
        b=SRmBl/C+sETgXYc+9rwL+QTqqPhG0BwT6Z0W3/ZTm2mkjKdk+qa776v0GXTztRPqej
         RQGNQhprc8uk5Ku/7yO6Gj/J3aSr7mlwJ4wRKyk6OykkTSsh9sZjqSXEG1gg9g+ns+Zf
         z316hA069AJZV7hTJbaJ/R/Fnj5Tl0ma4jNAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/bZt5l0ZZGg7iG+3jPLSvGhO/WjTu84sSszDGnGeW+U=;
        b=U6FChLXMOC8dJZTfp/EkoJJGglI0+FOX+/69ZQuzmZBQegjnSmGycuEXeGJDnbBZ2y
         Z/F6D/DsMh99nuWWw2VzAMGRLxQ5ziOSnQSL+x1YAgzbIu6gEEOixAn09LZp6Tat5mX1
         z8JN2UMwJR3DQfMvhfuhcRn51JRk0uktOgE3B8l8ZeHeqKv2RiVsOPrLY+L+pVNBnUud
         xw0dH/tBIJA/TN63rw5EgKzxgCib9h58CsIwVZGgUH5BwiUmh2eYt35Oma9BvdWYBPfR
         LHXOYUvP5TPxXPk5VHTVi5Cc/25cPy+pCQy5hxNtSDIXmrSaZ1DSiiDVAAsy+Uy/I/xJ
         1Nrg==
X-Gm-Message-State: ABuFfogP+Fo7naDTx2PPct3zIwX3kAU50aYA7MKv6xP9z11ltYP1SK4j
        empOGM1Oi79m8WiHEQboxtQiBLNwxhtyJTNS0qBRdQ==
X-Google-Smtp-Source: ACcGV63Hq/yQkEmQlbG/mrZDN6R3tGFhI7wFVgeuxI02aeHw2S4o32i+ZZVcjzLyiXgT991PveOp3Wc9GlqtMSGoFuU=
X-Received: by 2002:a24:4f8b:: with SMTP id c133-v6mr2713570itb.106.1537800299180;
 Mon, 24 Sep 2018 07:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 07:44:58
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <0000000000006971fa05769d22f6@google.com>
References: <0000000000006971fa05769d22f6@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Sep 2018 16:44:58 +0200
Message-ID: <CAJfpegu9hZjJOUa7wHAj9KiTpcUuitsqnEMYvQzp6Mha2Yat-g@mail.gmail.com>
Subject: Re: WARNING in request_end
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:29 PM, syzbot
<syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6bf4ca7fbc85 Linux 4.19-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=159149c6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
>
> WARNING: CPU: 0 PID: 9445 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0

And  there we have the bug likely caused by the set_bit(FR_SENT, ...)
not being inside the fpq->lock-ed region.

So that needs to be fixed anyway, apparently.

Thanks,
Miklos
