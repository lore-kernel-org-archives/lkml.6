Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45302070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgroByBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfAGWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:43:30 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33271 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:43:30 -0500
Received: by mail-pf1-f177.google.com with SMTP id c123so891028pfb.0;
        Mon, 07 Jan 2019 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oN+orXtG10b0JCzbMkxy50k1S0E95LkRNUAr7zyAGk=;
        b=mgroByBQz1oeidtr4rMvUhq18aBD1iP9D5A7O/zo26y95zRTZOGH1BSjrN7qmT+9Uw
         qzTNxX+tHaQju2mxnOwoAIP2PUhW1j41JkVWh4rqfD5UDo88Wl9NkXgjBsmqIyWTMv8x
         RiKoXqx76OhziOIwfrFipTWcbDeAidfEsiO7I+kBRMf6yXy3oH7wro+EiTVcTAjPVeob
         DR5kcWzweUf2C9Nj9KsIE9psaUQgffpES65c0YT/DlQ06Di83O0WX1qrOi8cQoDwFNfy
         7z+6nX1XTfOqgi+nzqi6IFEdgniMY4H0fc/Gdf52PwxwHLQZF/MYHb1ngRR84DTCzw8n
         elLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oN+orXtG10b0JCzbMkxy50k1S0E95LkRNUAr7zyAGk=;
        b=MrISEWzSnc/DWzybGutCjpBYfMfhUqqMy79B9SGpMYbyNVAlrEFX0nIgUkXZ+DbA6i
         0CqnAir+avHwqWXW3hm2qWFJZM6JtU4mp5ZRslemjXGwbLoGcSo42RRYV03l3PBRIW0S
         OmAYncBL7WXn80gHkmveD2EM/y2kOMwxJyvik9OHAnqcf73gBz2KRg6nO/a28OXp1OOM
         q3aCuiZS9lY6Y1vprY1zdJ6aABVzV+tGRzLNxURNQXt10vRmt+HuLyu+lL7kfRT8TtGN
         lhA2fw83kJUFVRY1f7jb0bYbpanZr1iHSNwzA5cRgTxO/unbSo5aa3e53Q7rvPZhiLS1
         bXog==
X-Gm-Message-State: AJcUukdrNXZkHj6r98eeZveimPL08c5r56QnGrcZgi2zzfTce9IYOeTL
        dHNExYMXIETlT0fz3cyXWpPtngnluGvuTBCO1wc=
X-Google-Smtp-Source: AFSGD/WqXWeeLI7fqhB8BvKZ6Nx4g+e4l+b07qAkJamQBPOnHyE7prH2TzX3vzBKqLxKJ+hF5sfVVaXyyj5DdOvrIiU=
X-Received: by 2002:a62:8a51:: with SMTP id y78mr64224219pfd.35.1546901009318;
 Mon, 07 Jan 2019 14:43:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a7904f057e772492@google.com> <0000000000002ddfbe057ed0ffc9@google.com>
In-Reply-To: <0000000000002ddfbe057ed0ffc9@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 7 Jan 2019 14:43:17 -0800
Message-ID: <CAM_iQpW8xgf1cfX-nCtoGfbvHBSucm4j3pctu1gUoR6qLBmk-A@mail.gmail.com>
Subject: Re: possible deadlock in nr_destroy_socket
To:     syzbot <syzbot+acfc1713819b146ae4b2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, linux-hams@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ralf@linux-mips.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot confirmed the latest net tree is fine, so:

#syz fix: netrom: fix locking in nr_find_socket()
