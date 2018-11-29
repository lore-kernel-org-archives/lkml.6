Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51820C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EF42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e183oMQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EF42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeK3EBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:01:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42332 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeK3EBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:01:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so2616917wrx.9;
        Thu, 29 Nov 2018 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GhSWSWsa2gx7CnePR3wBjVGqId0IKSnMfdxMhmjV7I=;
        b=e183oMQyGwc4QjJY1crs5GQSC/XL9NjOw1ICfX3HG7sHSfs1SKY9QCuWAwQMNOP0us
         +hmpkGfeN8eOseK0ZuqPWy/0G20I26oXUp8qLUYDZPgozE1HfkP4CIIakCD2WxnS9tzu
         8su9gQjoh5cHAOt1k4ZHV+Rdx63Kg6pr5rv9x6lrFJvcAtrsfZyKmiCRXg4EbVax0/Nx
         2X+Izne3THm5YHCx3R6iV9IPaxLf/Evts1xFkGKZ/ENwhdLwYxbU1+yXasDU3WZyiJta
         g/ItDcy0/3SeX6kRYDviGkITJYPx3DVSDMZzsO5XFpoQMLcQqmlwmDEwmb/kO3zr8V+7
         awig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GhSWSWsa2gx7CnePR3wBjVGqId0IKSnMfdxMhmjV7I=;
        b=sd0Yo8o2ySwTEFovVsWrDAYVeoLN/XQrfyBWN7CD3IWoKpd7YMYZHhePNgP01DaSai
         fsq1rmgSrRi4Bvi3O654QJmULtIobZZQC4SzrpDptv9tpQvDZ89j1E3rpdQ44h6/fjQz
         EH6sBnqsJwmfmXC/CTtDrNKz6f/JeSr9Q1KgeqiVgffoSK39mYedJkIdxVo83TP/qtpI
         799AXD62/mxrHUKKqf29+qB0ltMNdZO85GuiStUnCt8eYgoHK4qwJzOjfkr40FfY6yfj
         TXczsrFRreRkgLtxgoLNcxIeH6HRNRza6zJiqVNjTg5eNcmJes881ET8BRQdMvZiv6X9
         oruQ==
X-Gm-Message-State: AA+aEWb6u4HY9p0+wC4ZGBm2oAHKCfoK8FDJnhVOWWFrwo8ZusY5Kw62
        v/ui/yU90ej5BkNX/wuw/QHTK53acmSVVH8L0Io=
X-Google-Smtp-Source: AFSGD/XwPqSjPTm3izxVSjF3HT42O75wtUvlcwySJxlmKSixU3ZrIDlYma2Va80wTBNXLrPWKPsCbJ1z7BdR9N2lmyc=
X-Received: by 2002:adf:b783:: with SMTP id s3mr2184512wre.274.1543510532163;
 Thu, 29 Nov 2018 08:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20181129135921.231283053@linuxfoundation.org> <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com> <20181129160722.GA31919@kroah.com>
In-Reply-To: <20181129160722.GA31919@kroah.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Thu, 29 Nov 2018 16:55:20 +0000
Message-ID: <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
Subject: Re: [PATCH 4.19 033/110] bfs: add sanity check at bfs_fill_super()
To:     gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 16:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Nov 29, 2018 at 03:23:00PM +0000, Tigran Aivazian wrote:
> > Yes, of course I object to it.
> I can not apply a patch to the stable trees that are not in Linus's tree
> first.  So there's nothing I can do here with this.

Ok, we can wait until my patch propagates into Linus' tree, but I
would have thought it would be a waste of your time to apply a patch
which is waiting to be inevitably superseded by a different one. I can
see there are 238 PRs at Linus' tree on github and I am very glad that
I looked into one of them --- it contained a long comment explaining
that I should NOT do what I was just about to do, i.e. make a PR
against Linus' tree! :)

And, besides, in the email conversation Linus approved my version of
the patch anyway.

Kind regards,
Tigran
