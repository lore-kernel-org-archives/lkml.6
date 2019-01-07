Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454982147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vADPUMep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfAGTCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:02:22 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36189 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfAGTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:02:21 -0500
Received: by mail-pg1-f175.google.com with SMTP id n2so541483pgm.3;
        Mon, 07 Jan 2019 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AH9VpkMRBNmXPNdtI74G0Mk3aIffXeCFTmKG77tkhA=;
        b=vADPUMepm2klM+fdJUXr2t1dobIdIMvQiD20cL2mZNtzbll3cVYq6Ua0t5Yx5MGX2l
         ppx4rO0zx/tPlnPUeEzSX4WfYpHAsEB7a9jzXROzglLDWVmxkKTqpl3mb9aUMCXAas/B
         Lhchyvq+XPtUjJ9vjmoBpV48N2TIQL+qVtGszKrnXxy4wQPLTvdFuPHR/xwB2nslQJ7Q
         Eio7n7VEXnLiI2+JZ7VqMlP/DOllavScnuOw/zkw+0C8nE9wO0nfZZLCMafJv33hYCaI
         azu9UlzxISq3WAY2LwdxogCjlbbX35lmi0pA5ccTjYLpEp+QTlMlWFbS13Jo1K7675GZ
         x7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AH9VpkMRBNmXPNdtI74G0Mk3aIffXeCFTmKG77tkhA=;
        b=MqN4V01I6kWk5u1v7EQNjvUvI+pmltS+Vpwv2Ew1VAgGBMpHBpWVAX2Ki5HrkxmFs6
         yNJALCcu8HbxnQuyjk+3bBhLGSdHs8VkD2vXcVNIwjBWUHtfHes1dQRulSh1/AlhezNj
         Pxcl0V5yiZhwUybNLNyveP3UOBVa7aRCiJ2mWh0VzD532K2RYbXmL+eMJooqFPtibdJY
         60z/UxbdM+QORZuX0/qQQ+TNzHhn6qVJNTFF7xOXgQmikG3zQ26l9GczL2maqbwcZWyh
         BQ1PZ7BTpDSpQstqOslTouspQykr8tCQKKN5Cok75w8u/Oblezr7dQR8svigNINvL0QU
         rcyg==
X-Gm-Message-State: AA+aEWbvux3d/iW3E7oO6eeBClJGbLelSqzPRsH5dyd3tQouGDkCxxMX
        DpVf9jmgG8vctKcyXJuCf69KHjsbTTVRW6pvh6c=
X-Google-Smtp-Source: ALg8bN5lS5nnKNiBSaidkrvQeQP7cQAbhrFLQ7qv3XkU3MS1Y3jO2A7Ax2gJkiMAwRIgOG3Rd9rj7BaF0BGTpXYm7+k=
X-Received: by 2002:a62:870e:: with SMTP id i14mr65497481pfe.41.1546887740907;
 Mon, 07 Jan 2019 11:02:20 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c8d239057e77004f@google.com>
In-Reply-To: <000000000000c8d239057e77004f@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 7 Jan 2019 11:02:08 -0800
Message-ID: <CAM_iQpW-Kx1okkDwcz=NVgm54PbNKOffCANML4Y-SuocpsjFiA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in nr_rx_frame
To:     syzbot <syzbot+72f911fa716e011378ae@syzkaller.appspotmail.com>
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

#syz fix: netrom: fix locking in nr_find_socket()
