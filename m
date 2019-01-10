Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D627C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4295220665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfAJM0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:26:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41267 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfAJM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:26:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so12293406qtf.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMaczRLZuY7tddOmSul8f/HtY4zML1PqsSt1bdAC76E=;
        b=RASyQ4GOuHJQ3u/9RBkPH62jW9pyuU3AbWiwHtmh4+G7ao4sF8KkqTG0R0qGjofa/O
         sxdaClrWzSB3kvcBfXsk4eBCh8+oEW2t+VrKw0gk69N8MUfV8Tcjo7updG9U76ibg7xZ
         gr49MTIXsmLSpIgXMqurSoXL16Ud9qj2iQ9KEikVl8DntFvbXSYLQw5POMtzuEm0NGot
         bIdJoaqN7fLOEeRqYmSQ2ZTdTK4ak2vWU5eBMjUH1BUWwiZlPYkJJUnmv4cV/f1biEUB
         BR3TfNFbpor1OvFIGDphHnXbk3kdpi/1saPCqKudrpaJJ2hqgIAZIY1zr8clZvtQAsb9
         2KCw==
X-Gm-Message-State: AJcUukdzY2bxIeaJtTiIFt++6rCiqed0aSPnpjhej/AqfYHwSMU3GFHe
        HBqW2HB9YpgO3ZAO9XJPoz5GNNgJSlnEkVsSYI0=
X-Google-Smtp-Source: ALg8bN58Vt3fNw4HeN0DarFXNenvDb0yu54L2tHhiDy3MidFntMnEZG/SFEnZa1OTDJbQM9/ymV5jWQCkobMoglwU+A=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr9276973qtl.343.1547123176135;
 Thu, 10 Jan 2019 04:26:16 -0800 (PST)
MIME-Version: 1.0
References: <000000000000449587057e1e6f8b@google.com> <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <62FAC6A3-AC41-44CD-8ABC-79F404BF8CB1@microgate.com> <F23DE81F-C976-4AED-8990-84A6ADC1BF1F@microgate.com>
 <d351e662-0087-9cd7-46b2-ef49134c639c@i-love.sakura.ne.jp>
In-Reply-To: <d351e662-0087-9cd7-46b2-ef49134c639c@i-love.sakura.ne.jp>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 13:25:59 +0100
Message-ID: <CAK8P3a39t3pDjL9yqS6T9JQM-nGej7gvZibhya5qkC1JDHj5tw@mail.gmail.com>
Subject: Re: [PATCH] tty/n_hdlc: fix __might_sleep warning
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Paul Fulghum <paulkf@microgate.com>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:39 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2019/01/02 5:28, Paul Fulghum wrote:
> > Fix __might_sleep warning in tty/n_hdlc.c read due to copy_to_user call while current is TASK_INTERRUPTIBLE.
> > This is a false positive since the code path does not depend on current state remaining TASK_INTERRUPTIBLE.
> > The loop breaks out and sets TASK_RUNNING after calling copy_to_user.
> > This patch supresses the warning by setting TASK_RUNNING before calling copy_to_user.
> >
> > [1] https://syzkaller.appspot.com/bug?id=17d5de7f1fcab794cb8c40032f893f52de899324
> >
> > Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> > Reported-by: syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

This version looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
